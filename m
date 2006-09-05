Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <loom.20060903T214020-327@post.gmane.org>
References: <loom.20060902T125209-74@post.gmane.org>
	<1157221409.32195.0.camel@aeonflux.holtmann.net>
	<loom.20060902T200908-292@post.gmane.org>
	<loom.20060902T222740-106@post.gmane.org>
	<1157319129.32195.13.camel@aeonflux.holtmann.net>
	<loom.20060903T214020-327@post.gmane.org>
Date: Tue, 05 Sep 2006 12:16:54 +0200
Message-Id: <1157451414.4206.6.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-users] adding a SDP attribute HID_DESCRIPTOR_LIST
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Dick,

> > what are you talking about. I have no idea and it would be better if you
> > send me an example on how to reproduce this segmentation fault.
> 
> try the following patch on bluez-utils-3.4:
> --- tools/sdptool.c      2006-06-17 16:31:37.000000000 +0200
> +++ tools/sdptool.c      2006-09-03 21:54:54.000000000 +0200
> @@ -2139,6 +2139,21 @@
>                 0x75, 0x01,
>                 0x95, 0x04,
>                 0x81, 0x01,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
> +               0x0, 0x0,
>                 0xc0         // end tag
>         };
> 
> (this patch adds 30 zero's to hid_report so it is >128)

the used buffer is from the stack and we end up overwriting the stack.

> and see:
> $ sdptool add keyb
> Segmentation fault
> 
> the following patch on bluez-utils:
> $ sed -i -e 's/\(#define SDP_SEQ_PDUFORM_SIZE\) 128/\1 256/' ${S}/src/sdp.c
> 
> fixes the problem for me... (increasing the PDUFORM_SIZE)
> 
> So my questions are:
> - could you increase the SDP_SEQ_PDUFORM_SIZE

I removed the constant completely and increased the buffer to 256 byte
for now.

> - it would be nice to have some range checking, it's very confusing because the
> segfault occures in sdp_record_register and not in
> sdp_attr_add()/sdp_data_alloc()/sdp_seql_alloc()

The problem is actually in sdp_append_to_pdu() and this needs fixing.
Feel free to propose a patch. And it would be better to not use stack
memory for this.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
