Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] [PATCH] Fix some bugs in hcidump.
From: Marcel Holtmann <marcel@holtmann.org>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <40397111.7000903@superbug.demon.co.uk>
References: <40397111.7000903@superbug.demon.co.uk>
Content-Type: text/plain
Message-Id: <1077522140.2832.70.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 23 Feb 2004 08:42:21 +0100

Hi James,

> Attached is a patch to apply to bluez-hcidump-1.5/parser/sdp.c
> 
> It fixes some of the printout.

please always do the diff againts the CVS version.

> --- sdp.c.org	2004-02-23 02:56:03.667767736 +0000
> +++ sdp.c	2004-02-23 03:15:48.787602136 +0000
> @@ -324,6 +324,7 @@
>  	printf("pat");
>  
>  	if (parse_de_hdr(frm, &n1) == SDP_DE_SEQ) {
> +	        len = frm->len;
>  		while (len - frm->len < n1 ) {
>  			if (parse_de_hdr(frm,&n2) == SDP_DE_UUID) {
>  				print_uuid(n2, frm);

Your change means this

		while (n1 > 0) {
			...
		}

If this is what you want then do it this way and remove unneeded
variables. Give me a short description what this changes do and why you
did this change.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
