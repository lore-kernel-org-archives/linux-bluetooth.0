Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
References: <564d96fb0606060325q834360bqe4e9d41cbb28a16f@mail.gmail.com>
	<1149714650.22472.62.camel@localhost>
	<564d96fb0606071459i7367f84fkb7ee645941f84279@mail.gmail.com>
	<1149718288.22472.71.camel@localhost>
	<564d96fb0606081007p3fb8ea42v5926c80eb1cc9657@mail.gmail.com>
Date: Fri, 09 Jun 2006 22:14:02 +0200
Message-Id: <1149884042.3985.6.camel@aeonflux.holtmann.net>
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

> > it would help a lot. I am a little bit worried of such off-by-one
> > errors, because as I said, the SDP code is a strange code. You might
> > break some other part of the code that rely on this being wrong. Don't
> > get me wrong, it is still a bug, but we need to take care to fix both
> > places. And I have seen such stuff in the SDP code before. This is why I
> > am extra careful.
> ok. This is a simple program that has the bug:
> ----------------------------------------------------------
> #include <sdp.h>
> #include <sdp_lib.h>
> 
> int main() {
>         uint8_t     dtd = SDP_URL_STR8;
>         char     *value = "abc";
> 
>         sdp_data_t *d = sdp_data_alloc(dtd, value);
> 
>         sdp_buf_t buf;
>         uint8_t   data[1000];
>         buf.data      = data;
>         buf.buf_size  = sizeof(data);
>         buf.data_size = 0;
> 
>         sdp_gen_pdu(&buf, d);
>         return 0;
> }
> -------------------------------------------------------------------

I applied the patch. Thanks.

> > Send in a patch. I will check it.
> Attached.

Will look into that after the 3.0 release. If I forget it, please remind
me.

Regards

Marcel




_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
