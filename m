Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Subject: Re: [Bluez-users] Data across Bluetooth Connection - Not file transfer
Cc: bluez-users <bluez-users@lists.sourceforge.net>
References: <20040318091849.58373.qmail@web40707.mail.yahoo.com>
In-Reply-To: <20040318091849.58373.qmail@web40707.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403181100.21296.pavouk@pavouk.org>
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
Date: Thu, 18 Mar 2004 11:00:21 +0100

Hi,

> I want the server to wait (you cud say listen) for a command to come
> from the client and when that command comes, the server should be able
> to do something, like opening an application.

I have two ideas.
1.  Running server on virtual serial port /dev/rfcomm0 and waiting for 
commands.
2. Running server on IP socket and waiting for commands.

Both solutions are universal for bluetooth, IrDA, serial cable...
You must write daemon, or look on the freshmeat or find something similar with 
Google...

> I think there would be a way out for this. But I am not much of a
> programmer. If you can give me any ideas, I can have our programmer
> implement the same.

I'am not programmer too ;-) Only some perl scripts...

Best regards,

Pavel



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
