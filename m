Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTimJiHhkwb-0PQqc6n3wJwx2WPterQqMCXqzce8z@mail.gmail.com>
References: <1290763257-12382-1-git-send-email-pavan_savoy@ti.com>
	<20101130154654.GE5919@vigoh>
	<AANLkTiktDkjFH=aGbu3f+mkVUgmFDwB6xLW3e1VNXKtz@mail.gmail.com>
	<20101206212326.GI883@vigoh>
	<AANLkTimJiHhkwb-0PQqc6n3wJwx2WPterQqMCXqzce8z@mail.gmail.com>
Date: Thu, 9 Dec 2010 13:17:32 +0530
Message-ID: <AANLkTimewUbJMax-pv+-JSdnbNZvOU8yTVGV-T+BJBo1@mail.gmail.com>
Subject: Re: [PATCH v7] Bluetooth: btwilink driver
From: Pavan Savoy <pavan_savoy@sify.com>
To: Vitaly Wool <vitalywool@gmail.com>, "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Gustavo,

On Tue, Dec 7, 2010 at 3:05 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> Hi Gustavo,
>
> On Mon, Dec 6, 2010 at 10:23 PM, Gustavo F. Padovan
> <padovan@profusion.mobi> wrote:
>
>> Can't you differentiate Bluetooth data in a generic way, withou looking =
if it
>> is ACL, SCO or HCI EVENT? That done, you can just accumulate in a buffer=
 all
>> the Bluetooth data you received in that stream then send it to Bluetooth
>> driver after finish that stream processing.
>
> I'm afraid he can't do this because he needs to route events to the
> appropriate entity (BT/FM/GPS). I'm not sure how it can be done
> without analyzing the incoming packet.

Think of TI-ST driver as a extension to the HCI-H4 driver or HCI-LL
with FM and GPS being the additional protocols, and more protocols
coming in future...
So some driver has to have a knowledge of the protocols which are on chip.
the basic arch can be found @ http://omappedia.org/wiki/Wilink_ST

As Vitaly rightly pointed out, the TI-ST driver needs to peek into all
the protocol's data be it BT, FM or GPS to assemble fragmented data
(say ACL data coming out of TTY in 2 fragments) or fragment multiple
protocol data (say HCI-Event + FM Channel 8 event data)....
Note: we include even the FM and GPS headers to understand protocol
frames, but they lack a standard unlike Bluetooth...

Since there lacks a generic way to differentiate BT, FM or GPS data at
TI-ST driver layer,  please suggest what can be done ...


> Thanks,
> =C2=A0 Vitaly
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>
