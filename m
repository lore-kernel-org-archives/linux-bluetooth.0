Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Problems with smart phones when using a "silent"
	kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1137061188.5258.17.camel@localhost.localdomain>
References: <1137061188.5258.17.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1137072442.5013.3.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 12 Jan 2006 14:27:22 +0100

Hi Victor,

> I have a very strange problem here. When using a "silent" kernel
> (CONFIG_CMDLINE="console=/dev/null quiet" instead of
> CONFIG_CMDLINE="console=ttySAC0,115200") It is no longer possible to
> pair with Microsoft smartphones. A phone reports "the connection failed
> or pass key is incorrect". If a phone was already paired everything
> works fine. Other phones work fine too. Any clue what can go wrong. All
> this doesn't make much sence, but it is reality :) I've attached the
> dumps for the same phone for both of the kernels (silent and not). We
> use 2.6.13 with bluez 2.15 and there is no option to switch to something
> more recent. Just wonder what can cause the problem.... From the log I
> see that pairing actually went ok, cause it switched on encryption mode
> and exchanged some AT's, might be something with our application as
> well, but does not seem to be likelly...

I don't see any strange inside the dump and I doubt that it really has
something to do with the console option. Maybe your application can live
if the console is /dev/null.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
