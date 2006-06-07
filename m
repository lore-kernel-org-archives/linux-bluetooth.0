Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
Date: Thu, 08 Jun 2006 00:11:28 +0200
Message-Id: <1149718288.22472.71.camel@localhost>
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

> > and second, are you sure. The SDP code is
> > actually messy and some stuff is in there that actually works, but is
> > not quite obvious. Can you provide a simple test program?
> 
> I found the bug while running a mid sized program in valgrind. The
> relevant part of the log is
> ==26360== Invalid read of size 1
> ==26360==    at 0x4A1BAA0: memcpy (mac_replace_strmem.c:394)
> ==26360==    by 0x523124D: sdp_gen_pdu (in /usr/lib/libbluetooth.so.1.0.24)
> ==26360==    by 0x5231D18: sdp_append_to_pdu (in
> /usr/lib/libbluetooth.so.1.0.24)
> ==26360==    by 0x522E46B: sdp_gen_record_pdu (in
> /usr/lib/libbluetooth.so.1.0.24)
> ==26360==    by 0x52305D2: sdp_device_record_register (in
> /usr/lib/libbluetooth.so.1.0.24)
> .....
> ==26360==    at 0x4A19A16: malloc (vg_replace_malloc.c:149)
> ==26360==    by 0x522DE07: sdp_data_alloc_with_length (in
> /usr/lib/libbluetooth.so.1.0.24)
> ==26360==    by 0x523078D: sdp_attr_add_new (in /usr/lib/libbluetooth.so.1.0.24)
> ==26360==    by 0x52309A2: sdp_set_info_attr (in
> /usr/lib/libbluetooth.so.1.0.24)
> --------------------------------------------------
> 
> If it is really necessary I can try to build a "small" test program.

it would help a lot. I am a little bit worried of such off-by-one
errors, because as I said, the SDP code is a strange code. You might
break some other part of the code that rely on this being wrong. Don't
get me wrong, it is still a bug, but we need to take care to fix both
places. And I have seen such stuff in the SDP code before. This is why I
am extra careful.

> > Never looked at it actually, but you might be right. However again,
> > there might be a really strange reason for it.
> For dead code?

Send in a patch. I will check it.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
