Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems setting up an SPP profile connection
From: Marcel Holtmann <marcel@holtmann.org>
To: Christian.Lessig@t-online.de
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   lessig@uni-weimar.de
In-Reply-To: <1AbdUK-1W3pE80@cmpmail03.bbul.t-online.de>
References: <1AbdUK-1W3pE80@cmpmail03.bbul.t-online.de>
Content-Type: text/plain
Message-Id: <1072869365.2949.3.camel@pegasus>
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
Date: Wed, 31 Dec 2003 12:16:05 +0100

Hi Christian,

> I've got problems to set up an SPP (serial port profile) connection. I
> can connect and bind to the second device (a bluetooth chip for
> industrial purpose) but I don't know how to receive messages. In the
> assumption that rfcomm0 behaves like ttyS0 I wrote a little C programm
> where I open the rfcomm0-file, set the parameter, write something and
> wait for response. But I don't receive anything.

you can look at attest.c for an example. It demonstrates how to use the
RFCOMM socket and also the RFCOMM TTY to send AT commands.

> I also tried to use the rfcommd. I thought propably I need the daemon to
> receive messages, but direct after starting it exits. I found nowhere a
> appropriate config file for rfcommd so I used this:

The rfcommd is deprecated and replaced by our kernel RFCOMM
implementation.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
