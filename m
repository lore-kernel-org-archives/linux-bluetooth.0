Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Marcel Holtmann <marcel@holtmann.org>
To: Fredrik Noring <noring@nocrew.org>
In-Reply-To: <1075484759.14644.10.camel@akka.yeti.nocrew.org>
References: <1064593223.12843.127.camel@saag>
	<1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	<1067906859.15607.48.camel@saag>
	<1075331039.553.80.camel@akka.yeti.nocrew.org>
	<1075337441.553.97.camel@akka.yeti.nocrew.org>
	<1075374586.29731.86.camel@saag>  <1075389771.26729.95.camel@pegasus>
	<1075390320.1269.6.camel@nova>
	<1075484759.14644.10.camel@akka.yeti.nocrew.org>
Message-Id: <1075486723.26729.183.camel@pegasus>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 19:18:43 +0100
Subject: Re: [gnome-bluetooth] What stuff in gnome-bluetooth does, and
	ideas for its future
Content-Type: text/plain
Cc: GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
List-Unsubscribe: <http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth>,
	<mailto:gnome-bluetooth-request@usefulinc.com?subject=unsubscribe>
List-Archive: <http://lists.usefulinc.com/pipermail/gnome-bluetooth>
List-Post: <mailto:gnome-bluetooth@usefulinc.com>
List-Help: <mailto:gnome-bluetooth-request@usefulinc.com?subject=help>
List-Subscribe: <http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth>,
	<mailto:gnome-bluetooth-request@usefulinc.com?subject=subscribe>
Sender: gnome-bluetooth-bounces@usefulinc.com
Errors-To: gnome-bluetooth-bounces@usefulinc.com
List-ID: <bluez-devel.lists.sourceforge.net>

Hi Fredrik,

> Make hcid create a socket in /etc/bluetooth/keytab.socket. Preferably,
> having the same group membership as the socket (for examle "bluetooth")
> enables a user to send commands like:
> 
>     DELETE <sba> <dba>
> 
> This makes hcid delete the link and update /etc/bluetooth/keytab and
> /etc/bluetooth/keytab.shadow accordingly. These are ASCII files of
> course and can also be maintained with Emacs or whatever tool although
> this is not as safe because of race conditions.
> 
> Then we'll extend hcitool with the ability to connect to this socket
> and do this stuff too.
> 
> The protocol can be extended in the future. Like for example initiating
> pairing procedures and so on.

I had some similar ideas some time ago and the idea of accessing the
Bluetooth databases through a Unix socket with our own protocol is one
of my favourites. This makes you independent from the database format (I
prefer Berkeley DB at the moment) and you don't need to have database
code in the Bluetooth library. But when we design it this way, we must
make sure that we have the highest security for the link key
transactions.

Additional commands can be NAME or ISPAIRED, but I am also not sure if a
binary protocol would be better. Maybe we can use D-BUS for it.

Some other comments from me. I am not going to include such big changes
into hcid. This is development work for the new security manager or call
it device manager which is going to replace hcid.

Fredrik, would you please start a new post on the bluez-devel mailing
list, so we have a new thread for it. This is not really GNOME related
and I am not a big friend of cross-posting.

Regards

Marcel



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
