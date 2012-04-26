Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 16:35:56 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org, marcel@holtmann.org,
    pkrystad@codeaurora.org
Subject: Re: [RFC 1/8] Bluetooth: Improve ERTM sequence number offset
 calculation
In-Reply-To: <20120426071002.GB2659@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1204261504510.13179@mathewm-linux>
References: <1335396979-11692-1-git-send-email-mathewm@codeaurora.org> <1335396979-11692-2-git-send-email-mathewm@codeaurora.org> <20120426071002.GB2659@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei -

On Thu, 26 Apr 2012, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Wed, Apr 25, 2012 at 04:36:12PM -0700, Mat Martineau wrote:
>> Instead of using modular division, the offset can be calculated using
>> only addition and subtraction.  The previous calculation did not work
>> as intended and was more difficult to understand, involving unsigned
>> integer underflow and a check for a negative value where one was not
>> possible.
>
> BTW: in what cases this was not working?

"offset" was always positive, because "x % y" always gives a positive 
result if y is a positive number.  The 'if' clause was dead code, 
which was obviously not intended.

If seq2 > seq1, then the value would wrap back around to a large 
positive integer because both seq1 and seq2 are unsigned, so the value 
of (seq1 - seq2) is also unsigned.  Suppose seq1 is 0 and seq2 is 1. 
In unsigned 16-bit integer math, 0 - 1 == 65535 due to underflow.

65535 % (63+1) is 63: luckily, the right answer for the most common tx 
window (63).

65535 % (163+1) is 99: but the offset should be 163

>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |   11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 22e9ec9..92c0423 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -724,13 +724,10 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>>
>>  static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)
>>  {
>> -	int offset;
>> -
>> -	offset = (seq1 - seq2) % (chan->tx_win_max + 1);
>> -	if (offset < 0)
>> -		offset += (chan->tx_win_max + 1);
>> -
>> -	return offset;
>> +	if (seq1 >= seq2)
>> +		return seq1 - seq2;
>> +	else
>> +		return chan->tx_win_max + 1 - seq2 + seq1;
>>  }
>
> You seems are changing logic, not improving as you patch states. 
> Your offset might be bigger then tx_win_max. Was this intended?

The new code is correct.

Here's a python test program for all possible inputs with
tx_win_max == 63:

<code>
#!/usr/bin/env python
def seq_offset(tx_win_max, seq1, seq2):
     if (seq1 >= seq2):
         return seq1 - seq2
     else:
         return tx_win_max + 1 - seq2 + seq1

tx_win_max = 63
max_offset = -1
min_offset = tx_win_max + 1

for i in range(tx_win_max+1):
     for j in range(tx_win_max+1):
         offset = seq_offset(tx_win_max, i, j)
         min_offset = min(offset, min_offset)
         max_offset = max(offset, max_offset)

print "min: %d, max: %d" % (min_offset, max_offset)
</code>

It prints:
min: 0, max: 63


--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
