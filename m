Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: BT3C_CS broken in kernel 2.6.14? [Also with
	2.6.15]
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <loom.20060104T122021-876@post.gmane.org>
References: <loom.20051107T122754-207@post.gmane.org>
	 <1131371019.5824.123.camel@blade> <loom.20060104T122021-876@post.gmane.org>
Content-Type: text/plain
Message-Id: <1136374995.13931.21.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 04 Jan 2006 12:43:15 +0100

Hi Antti,

> > remember what the real problem or even the solution was when it came up
> > on LKML. Try to do some research on LKML by yourself and also check the
> > latest 2.6.14-git10 kernel.
> 
>   I tried now with 2.6.15 - Still not fixed. Can you point me to these LKML 
> postings? I couldn't find then (tried searching with keywords bt3c, bluetooth 
> and firmware - the latter two were too broad and the first did not give 
> anything useful.)

it must have been something with the atmel_cs and request_firmware(),
because the atmel_cs and bt3c_cs drivers had the same problem.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
