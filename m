Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex Holland <ah160@student.cs.york.ac.uk>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Compile bluez-bluefw-1.0 fails
References: <200404182321.55431.dvornheder@t-online.de> <200404191822.46586.ah160@student.cs.york.ac.uk> <200404191952.11018.simone.gotti@email.it>
In-Reply-To: <200404191952.11018.simone.gotti@email.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200404192121.31112.ah160@student.cs.york.ac.uk>
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
Date: Mon, 19 Apr 2004 21:21:30 +0100

On Monday 19 Apr 2004 18:52, Simone Gotti wrote:

> # DEBUG=yes export DEBUG
>
> remove the #  and you'll see a lot of debug informations.

Thanks! I uncommented it, and saw nothing new on boot-up or in dmesg - 
looks like it isn't getting called.

So, where to go from here? I presume the problem's with Hotplug, 
somehow.

Thanks for the prompt support, everyone!

Alex Holland


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
