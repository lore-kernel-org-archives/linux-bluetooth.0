Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
Date: Wed, 07 Jun 2006 23:10:50 +0200
Message-Id: <1149714650.22472.62.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bug in sdp_gen_pd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Rafael,

> In sdp_gen_pd when handling SDP_TEXT_STR{8,16,32}, data_size is assumed to be
> "d->unitSize - sizeof(uint8_t)". This is false.
> 
> In sdp_data_alloc_with_length, d->unitSize is defined to be
> sizeof(unit8_t) + length + sizeof(uint8_t) if length <= UCHAR_MAX
> or
> sizeof(unit8_t) + length + sizeof(uint16_t) if length > UCHAR_MAX
> 
> The attached patch fixes sdp_gen_pdu to correctly compute data_size.

first you forgot the patch and second, are you sure. The SDP code is
actually messy and some stuff is in there that actually works, but is
not quite obvious. Can you provide a simple test program?

> Another strange thing in sdp_data_alloc_with_length: after adjusting
> unitSize, the dtd variable is changed from SDP_*_STR8 to SDP_*_STR16
> or the other way around. But this code is dead, since the dtd variable
> is no longer used in this function.

Never looked at it actually, but you might be right. However again,
there might be a really strange reason for it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
