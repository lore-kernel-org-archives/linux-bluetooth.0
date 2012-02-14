Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120214154141.GA14503@joana>
References: <1329227796-22609-1-git-send-email-szymon.janc@tieto.com>
	<20120214154141.GA14503@joana>
Date: Tue, 14 Feb 2012 15:26:37 -0200
Message-ID: <CAA37ika=K8jSmApcTscm2ay+A95SgkJ3Lj4TQ-qErLduK2jU_g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Drop frames without F-bit set when in WAIT_F state
From: Ulisses Furquim <ulisses@profusion.mobi>
To: Szymon Janc <szymon.janc@tieto.com>,
	linux-bluetooth@vger.kernel.org, kanak.gupta@stericsson.com
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi everybody,

On Tue, Feb 14, 2012 at 1:41 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> Hi Szymon,
>
> * Szymon Janc <szymon.janc@tieto.com> [2012-02-14 14:56:36 +0100]:
>
>> When transmitter is in WAIT_F state any frames received without F-bit=1
>> should not be processed (With-Valid-F-bit condition is not true).
>>
>> This was affecting TP/ERM/BI-05-C PTS test.
>>
>> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
>> ---
>>  net/bluetooth/l2cap_core.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
>> index 8efac78..1a724c6 100644
>> --- a/net/bluetooth/l2cap_core.c
>> +++ b/net/bluetooth/l2cap_core.c
>> @@ -4190,6 +4190,11 @@ static int l2cap_ertm_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
>>               goto drop;
>>       }
>>
>> +     /* drop frame without F-bit set when in WAIT_F state */
>> +     if (test_bit(CONN_WAIT_F, &chan->conn_state) &&
>> +                     !__is_ctrl_final(chan, control))
>> +             goto drop;
>> +
>
> I think this is wrong, you are completely dropping frames here while you
> should at least process the reqseq received. Check the spec, the WAIT_F table.
> Another point is that the WAIT_F state belongs belongs to the transmit side,
> and you are checking for it in the receive side. This also seems wrong to me.
>
> Also I never find problem to pass this test in PTS with the following l2test
> line:
>
> l2test -P 17 -X 3 -b 48 -w -D 1 -N 2
>
> Please tell the problem you have in PTS so we can try to find a better
> solution for this.

That reminds me of one thing. I'd very much like to have these l2test
lines somewhere in a repository and with reference for which PTS test
it's meant. This way we stop testing things differently and even
improve these little "scripts".

Regards,

-- 
Ulisses Furquim
ProFUSION embedded systems
http://profusion.mobi
Mobile: +55 19 9250 0942
Skype: ulissesffs
