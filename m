Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Sharing / redirecting a serial port
From: Marcel Holtmann <marcel@holtmann.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <320075ff04102014276d37a74a@mail.gmail.com>
References: <320075ff04102014276d37a74a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1098380977.4885.30.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 21 Oct 2004 19:49:37 +0200

Hi Nigel,

> I have got the BlueZ stuff running nicely, and I can use the rfcomm
> tools to connect a serial port over bluetooth and stuff, but I can't
> figure out how I would do the following.
> 
> I have a serial GPS connected to linuxbox on /dev/ttyS0 which has a
> bluetooth adapter.
> I would like to listen for bluetooth serial connections, and when they
> connect, pipe the output to it. In most instances the connecting
> device will be a bluetooth iPAQ.
> 
> I can't figure out how I can do this from existing tools - is it possible?

sounds like you have to write a small RFCOMM server program for doing
this. Look at rctest and maybe dund for example code.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
