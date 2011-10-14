Return-Path: <cyrus@holtmann.org>
Date: Fri, 14 Oct 2011 15:39:57 -0700 (PDT)
From: Mat Martineau <mathewm@codeaurora.org>
To: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
	pkrystad@codeaurora.org
Subject: Re: [PATCH 2/9] Bluetooth: Add AMP policy information to
 l2cap_chan
In-Reply-To: <20111014112037.GC32656@aemeltch-MOBL1>
Message-ID: <alpine.DEB.2.02.1110141538480.9993@mathewm-linux>
References: <1318543247-27130-1-git-send-email-mathewm@codeaurora.org> <1318543247-27130-3-git-send-email-mathewm@codeaurora.org> <20111014112037.GC32656@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Fri, 14 Oct 2011, Andrei Emeltchenko wrote:

> Hi Mat,
>
> On Thu, Oct 13, 2011 at 03:00:40PM -0700, Mat Martineau wrote:
>> Each channel has an active AMP policy to require BR/EDR (the default),
>> prefer AMP, or prefer BR/EDR.
>>
>> Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
>> ---
>>  include/net/bluetooth/l2cap.h |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
>> index 806b950..e77d39f 100644
>> --- a/include/net/bluetooth/l2cap.h
>> +++ b/include/net/bluetooth/l2cap.h
>> @@ -357,6 +357,7 @@ struct l2cap_chan {
>>  	__u8		num_conf_rsp;
>>
>>  	__u8		fcs;
>> +	__u8		amp_policy;
>
> I would merge this patch with following one since this is only one line.

Sure.  I've seen a lot of requests to split up header changes in to 
separate commits, but I agree that doing it for one line is a little 
extreme.

>>
>>  	__u16		tx_win;
>>  	__u8		max_tx;
>> --
>> 1.7.7
>>

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

