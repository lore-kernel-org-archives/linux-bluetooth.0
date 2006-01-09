Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Henryk =?ISO-8859-15?Q?Pl=F6tz?= <henryk@ploetzli.ch>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Browsing web on cell my phone through bluetooth
 connection to Linux desktop
Message-Id: <20060109063602.04d7dfe0.henryk@ploetzli.ch>
In-Reply-To: <20060109052519.14547.qmail@web37009.mail.mud.yahoo.com>
References: <20060109052519.14547.qmail@web37009.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 9 Jan 2006 06:36:02 +0100

Moin,

Am Sun, 8 Jan 2006 21:25:19 -0800 (PST) schrieb Blue Hammer:

> However, I could not find any clue on the Internet about how can I
> browse web on my cell phone using the bluetooth connection to my
> linux desktop. My cell phone has a built in web browser that works
> with GSM Carrier's web service (not enabled in my plan) and I would
> like to use this browser and bluetooth connection to linux desktop to
> browse the web.

Your question is severly lacking in detail. Especially it would be
important to know _which_ cell phone you are talking about.

The basic direction is to set up PAN and/or DUN on your linux box and
then connect your cell phone to that. Information on this is easily
found (http://www.holtmann.org/linux/bluetooth/ for example, although
some of the links are dead by now), but if this works for your phone
can not be generally answered. Read The Fine Manual of your phone.

(Most of the phones, especially the less fancy ones, will not support
such usage of course. Your carrier wants you to use his service after
all. For some phones there are some hints to make this possible
circulating on the internet which may or may not work and are best
found through google.)

--=20
Henryk Pl=F6tz
Gr=FC=DFe aus Berlin
~~~~~~~ Un-CDs, nein danke! http://www.heise.de/ct/cd-register/ ~~~~~~~
~ Help Microsoft fight software piracy: Give Linux to a friend today! ~


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
