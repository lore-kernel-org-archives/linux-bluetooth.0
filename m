Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 4 Jul 2007 11:56:28 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Ranulf Doswell <ralf@ranulf.net>
In-Reply-To: <18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0707041155540.11471@pademelon.sonytel.be>
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
	<1183433306.6351.19.camel@aeonflux.holtmann.net>
	<18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1293731747-1183542988=:11471"
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        cbe-oss-dev@ozlabs.org
Subject: Re: [Bluez-devel] [Cbe-oss-dev] [PATCH] bluetooth: reset unexpected
 connections
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584337861-1293731747-1183542988=:11471
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 3 Jul 2007, Ranulf Doswell wrote:
> Do you have any suggestions of an alternative approach to handling this
> error condition rather than just filling up the syslog? It's definitely a
> very real DOS possibility - my syslog was growing by about 1Mb per minute
> with just two regular controllers. Someone who deliberately constructed a
> device to bombard a linux box with junk bluetooth data could probably fill
> someone's /var partition in a matter of hours.

Perhaps you can replace the call to printk() with a call to printk_ratelimit()?

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 0413.825.160 · RPR Brussels	
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584337861-1293731747-1183542988=:11471
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
---584337861-1293731747-1183542988=:11471
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

---584337861-1293731747-1183542988=:11471--
