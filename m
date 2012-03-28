Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120328142601.GB31354@aemeltch-MOBL1>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
	<1332892776-12060-4-git-send-email-andre.guedes@openbossa.org>
	<20120328085638.GC21905@aemeltch-MOBL1>
	<CACJA=fX9WSAqKZfLxp_iY2WiNoUXrGc=ch0DWdFXZvitOXPiZA@mail.gmail.com>
	<20120328142601.GB31354@aemeltch-MOBL1>
Date: Wed, 28 Mar 2012 14:15:12 -0300
Message-ID: <CACJA=fVt4e8jVyzLW4A4mktD=_79XEXTfjGQJyitM+ac219EXw@mail.gmail.com>
Subject: Re: [RFC 3/3] Bluetooth: Use address type info from User-space
From: Andre Guedes <andre.guedes@openbossa.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Mar 28, 2012 at 11:26 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
> Hi Andre,
>
> On Wed, Mar 28, 2012 at 11:05:47AM -0300, Andre Guedes wrote:
>> >> -int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *dst)
>> >> +int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
>> >> +                     bdaddr_t *dst, u8 dst_type)
>> >>  {
>> >>       struct sock *sk = chan->sk;
>> >>       bdaddr_t *src = &bt_sk(sk)->src;
>> >> @@ -1141,8 +1142,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
>> >>       __u8 auth_type;
>> >>       int err;
>> >>
>> >> -     BT_DBG("%s -> %s psm 0x%2.2x", batostr(src), batostr(dst),
>> >> -                                             __le16_to_cpu(chan->psm));
>> >> +     BT_DBG("%s -> %s (type %u) psm 0x%2.2x", batostr(src), batostr(dst),
>> >> +                                     dst_type, __le16_to_cpu(chan->psm));
>> >
>> > If you change style for other functions you might change it here as well.
>>
>> Sorry, didn't follow you here.
>
> In l2cap_chan_connect you seems align second line at "(". Maybe we need
> then align the same for debug statement?

I see now, I guess we are supposed to align debug too. I'll fix this.

Thanks,

Andre
