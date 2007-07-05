Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.62.0707041155540.11471@pademelon.sonytel.be>
References: <18a15270707021204o3ffc0021pc3f0d4b0ec278c39@mail.gmail.com>
	<1183433306.6351.19.camel@aeonflux.holtmann.net>
	<18a15270707031238n2cfe388ay3843e6939b890a8f@mail.gmail.com>
	<Pine.LNX.4.62.0707041155540.11471@pademelon.sonytel.be>
Date: Thu, 05 Jul 2007 10:11:57 +0200
Message-Id: <1183623117.6351.87.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Cc: Ranulf Doswell <ralf@ranulf.net>, cbe-oss-dev@ozlabs.org
Subject: Re: [Bluez-devel] [Cbe-oss-dev] [PATCH] bluetooth: reset	unexpected
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Geert,

> > Do you have any suggestions of an alternative approach to handling this
> > error condition rather than just filling up the syslog? It's definitely a
> > very real DOS possibility - my syslog was growing by about 1Mb per minute
> > with just two regular controllers. Someone who deliberately constructed a
> > device to bombard a linux box with junk bluetooth data could probably fill
> > someone's /var partition in a matter of hours.
> 
> Perhaps you can replace the call to printk() with a call to printk_ratelimit()?

we could. Feel free to send a patch for it.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
