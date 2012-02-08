Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120208090945.GB5917@aemeltch-MOBL1>
References: <1328678855.28848.6.camel@aeonflux>
	<20120208090945.GB5917@aemeltch-MOBL1>
Date: Wed, 8 Feb 2012 11:32:50 +0200
Message-ID: <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
Subject: Re: Getting L2CAP ERTM support into better upstream state
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Feb 8, 2012 at 11:09 AM, Andrei Emeltchenko
<andrei.emeltchenko.news@gmail.com> wrote:
>
> I think this would be good to send as patch series so that people can
> comment. What comes to my mind is that the patch might be reduced if it
> does not change order of functions and defines like:
>
> <------8<----------------------------------------------------------------=
-
> | =A0-#define L2CAP_EXT_CTRL_TXSEQ =A0 =A0 =A0 =A0 =A0 0xFFFC0000
> | =A0 #define L2CAP_EXT_CTRL_SAR =A0 =A0 =A0 =A0 =A0 =A0 0x00030000
> | =A0-#define L2CAP_EXT_CTRL_SUPERVISE =A0 =A0 =A0 0x00030000
> | =A0 #define L2CAP_EXT_CTRL_REQSEQ =A0 =A0 =A0 =A0 =A00x0000FFFC
> | =A0-
> | =A0-#define L2CAP_EXT_CTRL_POLL =A0 =A0 =A0 =A0 =A0 =A00x00040000
> | =A0+#define L2CAP_EXT_CTRL_TXSEQ =A0 =A0 =A0 =A0 0xFFFC0000
> | =A0 #define L2CAP_EXT_CTRL_FINAL =A0 =A0 =A0 =A0 =A0 0x00000002
> | =A0+#define L2CAP_EXT_CTRL_POLL =A0 =A0 =A0 =A0 =A00x00040000
> | =A0+#define L2CAP_EXT_CTRL_SUPERVISE =A0 =A0 0x00030000
> | =A0 #define L2CAP_EXT_CTRL_FRAME_TYPE =A0 =A0 =A00x00000001 /* I- or S-=
Frame */
> <------8<----------------------------------------------------------------=
-
>
> and I don't like this kind of change:
>
> <------8<----------------------------------------------------------------=
----
> | =A0- =A0 =A0 =A0 if (__is_sar_start(chan, control) && !__is_sframe(chan=
, control))
> | =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D L2CAP_SDULEN_SIZE;
> | =A0+ =A0 =A0 =A0 if ((control->frame_type =3D=3D 'i') &&
> | =A0+ =A0 =A0 =A0 =A0 =A0 (control->sar =3D=3D L2CAP_SAR_START))
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D 2;
> |
> | =A0 =A0 =A0 =A0 =A0if (chan->fcs =3D=3D L2CAP_FCS_CRC16)
> | =A0- =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D L2CAP_FCS_SIZE;
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 len -=3D 2;
> <------8<----------------------------------------------------------------=
----
>
> why not to use macros and defines for magic numbers?
>
> the same below:
>
> <------8<----------------------------------------------------------------
> | =A0+ =A0 =A0 =A0 if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_extended_control(get_unaligned_l=
e32(skb->data),
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0control);
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 4);
> | =A0+ =A0 =A0 =A0 } else {
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 __get_enhanced_control(get_unaligned_l=
e16(skb->data),
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0control);
> | =A0+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb_pull(skb, 2);
> | =A0+ =A0 =A0 =A0 }
> |
> | =A0- =A0 =A0 =A0 control =3D __get_control(chan, skb->data);
> | =A0- =A0 =A0 =A0 skb_pull(skb, __ctrl_size(chan));
> <------8<----------------------------------------------------------------
>
> those magic number does not look nice IMO and the code is not looking any
> better.

In this aspect perhaps, but we don't need to take the code as it is,
but the point here is following the states defined by the spec and
that is IMO much better.

--=20
Luiz Augusto von Dentz
