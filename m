Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HIDP backport for 2.4
From: Marcel Holtmann <marcel@holtmann.org>
To: Michael Frey <mfrey@pepper.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com>
References: <1090054739.4558.2.camel@pegasus>
	 <1090759952.4791.91.camel@pegasus>
	 <9A44A69C-DF28-11D8-B83A-00039390D626@pepper.com>
	 <1090864026.29589.1.camel@pegasus>
	 <5F07F140-DF2E-11D8-B83A-00039390D626@pepper.com>
	 <1090865790.29589.5.camel@pegasus>
	 <76F28965-DF34-11D8-B83A-00039390D626@pepper.com>
	 <1090875679.10807.1.camel@pegasus>
	 <4B8C0D08-DF64-11D8-95A4-003065B218E0@pepper.com>
	 <1090916301.4650.9.camel@pegasus>
	 <ABD9E52C-DFDC-11D8-BE76-00039390D626@pepper.com>
	 <1090940516.4845.19.camel@pegasus>
	 <A9BDE398-DFDF-11D8-BE76-00039390D626@pepper.com>
Content-Type: text/plain
Message-Id: <1090941847.4845.29.camel@pegasus>
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
Date: Tue, 27 Jul 2004 17:24:07 +0200

Hi Michael,

> root@(none):/usr/bin# hcitool inq
> Inquiring ...
>          00:02:72:40:8A:97       clock offset: 0x4a58    class: 0x002540

the subclass value is 0x40 which means that this is only a keyboard. The
problem can be that they really only support the keyboard in boot mode
or that they simply set the subclass value wrong. If the kernel things
that this is only a keyboard it don't creates a mouse device. Try this
patch for the hidd to tell the kernel it is also a mouse:

RCS file: /cvsroot/bluez/utils/hidd/sdp.c,v
retrieving revision 1.4
diff -u -r1.4 sdp.c
--- hidd/sdp.c  4 Jul 2004 15:41:53 -0000       1.4
+++ hidd/sdp.c  27 Jul 2004 15:17:34 -0000
@@ -126,6 +126,7 @@
 
        pdlist = sdp_data_get(rec, 0x0202);
        req->subclass = pdlist ? pdlist->val.uint8 : 0;
+       req->subclass = 0x40 | 0x80;
 
        pdlist = sdp_data_get(rec, 0x0203);
        req->country = pdlist ? pdlist->val.uint8 : 0;

To check what is really going on run "hcidump -x" as root and use the
mouse.

Do you ever checked if 2.6.7-mh2 is working for you?

> The website is http://www.bluelogic.co.kr/main_eng.php

Will anyone buy one of these for me so I get one for testing?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
