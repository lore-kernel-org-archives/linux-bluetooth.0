Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1308147687.2196.3.camel@aeonflux>
References: <1308110046-5704-1-git-send-email-nami.li@atheros.com>
	<1308136632.2518.11.camel@aeonflux>
	<1AFE20D16950C745A2A83986B72E87480132148C3622@EMEXM3131.dir.svc.accenture.com>
	<1308147687.2196.3.camel@aeonflux>
Date: Wed, 15 Jun 2011 16:01:43 +0100
Message-ID: <BANLkTinWVSVxXQoFW9rtXaTbQQD-XYpvRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: FTP and OPP over L2CAP
From: =?ISO-8859-1?Q?Piotr_Zg=F3recki?= <pzgorecki@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, tim.howes@accenture.com
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

Allow me to quote GOEP this time :)
"
>From 7.1 L2CAP Interoperability Requirements
7.1.1 MTU option
According to [1], OBEX packets must fit completely within a single
L2CAP SDU, so an implementation shall either configure the L2CAP MTU
to be large enough to hold the largest OBEX packet or configure the
OBEX packet size to be small enough to fit within the L2CAP MTU. In
any case the OBEX packet size should be set as large as possible,
especially in the case that the Single Response Mode feature of IrOBEX
is not supported. By definition:
=95 The L2CAP MTU refers to the SDU size
=95 The SDU is the application packet (OBEX packet in GOEP)
"

So you can't hide the MTUs from OBEX. What is the point of using a
streaming socket then ?
I think it's a good illustration of the point I was trying to make in
my previous email. L2CAP uses SDUs, which unlike e.g. segments in TCP
_are_ exposed to the upper layers, and you'll find running away from
them rather difficult :)

Cheers,
Piotr

On 15 June 2011 15:21, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Tim,
>
>> > +enum obex_transport_format{
>> > + =A0 =A0 =A0OBEX_MT_STREAM ,
>> > + =A0 =A0 =A0OBEX_MT_SEQPACKET
>> > +};
>> > +
>> > And more important, I have no idea why are you doing this anyway. Even
>> > with L2CAP this should run over SOCK_STREAM.
>>
>> Is that really so? =A0I expect exposing L2CAP ERTM as a stream could bre=
ak protocols above that expect datagram-boundary preservation (eg RTP). =A0=
Or can break protocols that mandate that only one higher-layer packet exist=
s in each L2CAP SDU. =A0For these the socket needs to be packet based.
>>
>> So, my surprise is that ERTM is exposed as SOCK_STREAM. =A0So I do have =
an idea why the patch mentions sequenced packet...
>
> you can do both for ERTM actually. You can create SOCK_SEQPACKET and
> have it negotiate ERTM. However you can not run SOCK_STREAM on a Basic
> Mode connection.
>
> But the real benefit for higher layer protocols is if you become a
> SOCK_STREAM. Because you are MTU free now. Using SOCK_SEQPACKET with
> ERTM or Basic Mode is not really much of a difference.
>
> Especially with OBEX that has its own MTU anyway in the first place has
> always been run on SOCK_STREAM so far, what is the different that you
> expect by running it of SOCK_SEQPACKET with ERTM?
>
> Regards
>
> Marcel
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
