Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120419140308.GA4127@joana>
References: <1334724874-3086-1-git-send-email-hemant.gupta@stericsson.com>
	<20120419140308.GA4127@joana>
Date: Thu, 19 Apr 2012 21:11:08 +0530
Message-ID: <CACj007kbqo8FpvDieOMauBzMw4K7coH-qsy=+w6f6+91PsgHeA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Update L2CAP Channel State for LE Link during Pairing
From: Hemant Gupta <hemantgupta.ste@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Hemant Gupta <hemant.gupta@stericsson.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Thu, Apr 19, 2012 at 7:33 PM, Gustavo Padovan <gustavo@padovan.org> wrote:
> Hi Hemant,
>
> * Hemant Gupta <hemant.gupta@stericsson.com> [2012-04-18 10:24:34 +0530]:
>
>> This patch updates the L2CAP Channel state to Connected when LE Link
>> is established, so that data transmission can start on CID 4.
>> Without this fix if remote side sends data on CID 4 immidiately after
>> LE Link was established, data was being discarded in l2cap_att_channel()
>> API because channel state was still BT_CONNECT when SMP pairing is in
>> progress. This was resulting in disconnection from remote side after 30 seconds
>> since ATT request was not answered by user space as data was discarded.
>
> I'm not too familiar with all LE specifications, but doesn't this initial
> data need to be secured? If the channel is not secure (the pairing has
> not finished yet) and we may be transmitting in a not secure enough place.

Actually for LE, L2CAP has fixed CID's, so data transmission can start
as soon as
LE Link is established. Remote side can send data on CID 4 as soon as
LE Link is created,
even though we might have initiated pairing on SMP channnel 06 which
can continue parallely.
Problem in this case arise, if we receive data from remote side when
we are performing SMP
pairing, so L2CAP state would be BT_CONNECT, and in
l2cap_att_channel() API, we will discard
that packet from remote side, resulting in no response to that
particular packet from remote side.
This could result in disconnection from remote side because ATT
command was not answered
by us for more than 30 seconds..

I will send new version of patch for comments, because I think it is
better to call l2cap_chan_ready(chan)
which will update the state as well has proper locks before updating
the state, which was not the case with the above patch.

>        Gustavo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Hemant Gupta
ST-Ericsson India
