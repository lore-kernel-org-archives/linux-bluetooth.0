Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Feb 2012 11:09:51 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Getting L2CAP ERTM support into better upstream state
Message-ID: <20120208090945.GB5917@aemeltch-MOBL1>
References: <1328678855.28848.6.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1328678855.28848.6.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Feb 08, 2012 at 06:27:35AM +0100, Marcel Holtmann wrote:
> Hello everyone,
> 
> we currently have the problem on our hand that our upstream L2CAP
> support is not as good as it should be. And many Android products start
> deviating from it to fix issues with. That is of course something we can
> not have. Fragmentation on this level is not useful for anyone. It will
> hurt everybody in the longterm. So I asked Mat to port over the QUIC
> code to the latest upstream so we can start a discussion here.
> 
> https://www.codeaurora.org/gitweb/quic/bluetooth/?p=bluetooth-next.git;a=commit;h=d02ef660d1ec9e9312798561fd688a4c717d339e
> 
> To make one thing perfectly clear here. I want that our upstream code
> reflects the state machine transition from the L2CAP specification. I
> know that historically this was not the case and that was for a reason.
> All early specification where pretty unclear in this area, but with the
> introduction of ERTM the Bluetooth SIG got this fixed and now it is our
> time to get this clearly into our code as well.
> 
> With the separation of L2CAP channels from L2CAP sockets this should
> make it even more easier to use since we do not need and should not to
> use socket states anymore anyway.

I think this would be good to send as patch series so that people can
comment. What comes to my mind is that the patch might be reduced if it
does not change order of functions and defines like:

<------8<-----------------------------------------------------------------
|  -#define L2CAP_EXT_CTRL_TXSEQ           0xFFFC0000
|   #define L2CAP_EXT_CTRL_SAR             0x00030000
|  -#define L2CAP_EXT_CTRL_SUPERVISE       0x00030000
|   #define L2CAP_EXT_CTRL_REQSEQ          0x0000FFFC
|  -
|  -#define L2CAP_EXT_CTRL_POLL            0x00040000
|  +#define L2CAP_EXT_CTRL_TXSEQ         0xFFFC0000
|   #define L2CAP_EXT_CTRL_FINAL           0x00000002
|  +#define L2CAP_EXT_CTRL_POLL          0x00040000
|  +#define L2CAP_EXT_CTRL_SUPERVISE     0x00030000
|   #define L2CAP_EXT_CTRL_FRAME_TYPE      0x00000001 /* I- or S-Frame */
<------8<-----------------------------------------------------------------

and I don't like this kind of change:

<------8<--------------------------------------------------------------------
|  -       if (__is_sar_start(chan, control) && !__is_sframe(chan, control))
|  -               len -= L2CAP_SDULEN_SIZE;
|  +       if ((control->frame_type == 'i') &&
|  +           (control->sar == L2CAP_SAR_START))
|  +               len -= 2;
|
|          if (chan->fcs == L2CAP_FCS_CRC16)
|  -               len -= L2CAP_FCS_SIZE;
|  +               len -= 2;
<------8<--------------------------------------------------------------------

why not to use macros and defines for magic numbers?

the same below:

<------8<----------------------------------------------------------------
|  +       if (test_bit(FLAG_EXT_CTRL, &chan->flags)) {
|  +               __get_extended_control(get_unaligned_le32(skb->data),
|  +                                      control);
|  +               skb_pull(skb, 4);
|  +       } else {
|  +               __get_enhanced_control(get_unaligned_le16(skb->data),
|  +                                      control);
|  +               skb_pull(skb, 2);
|  +       }
|
|  -       control = __get_control(chan, skb->data);
|  -       skb_pull(skb, __ctrl_size(chan));
<------8<----------------------------------------------------------------

those magic number does not look nice IMO and the code is not looking any
better.

Best regards 
Andrei Emeltchenko 
