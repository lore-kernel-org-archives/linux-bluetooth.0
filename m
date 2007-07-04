Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
	<46892FEC.7000705@free.fr>
	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>
	<468A02F2.7030903@free.fr>
	<2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
	<d89ddf300707031408k45227982w72399da69935d0e1@mail.gmail.com>
Date: Wed, 04 Jul 2007 03:57:02 +0200
Message-Id: <1183514223.6351.56.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
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

Hi Brad,

> > stream. Do you guys see any value in having a device connected but not
> > streaming?
> 
> When no device is connected, the plugin will discard or (more
> preferably) send audio to the wired device. We use connected as a cue
> that the user wants to use that device for audio.

no and NO. The Bluetooth plugin is not dealing with any wire connection.
The plugin has to be simple and can actually be stupid. I don't wanna
have any intelligence inside the ALSA plugin.

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
