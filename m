Return-Path: <noring@nocrew.org>
Subject: Re: [gnome-bluetooth] What stuff in gnome-bluetooth does, and
	ideas for its future
From: Fredrik Noring <noring@nocrew.org>
To: Edd Dumbill <edd@usefulinc.com>, Marcel Holtmann <marcel@holtmann.org>
Cc: GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075390320.1269.6.camel@nova>
References: <1064593223.12843.127.camel@saag>
	 <1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	 <1067906859.15607.48.camel@saag>
	 <1075331039.553.80.camel@akka.yeti.nocrew.org>
	 <1075337441.553.97.camel@akka.yeti.nocrew.org>
	 <1075374586.29731.86.camel@saag>  <1075389771.26729.95.camel@pegasus>
	 <1075390320.1269.6.camel@nova>
Content-Type: text/plain
Message-Id: <1075484759.14644.10.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 18:45:59 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Edd and Marcel,

tor 2004-01-29 klockan 16.32 skrev Edd Dumbill:
> Well, that, and the ability to delete a link key.

Here's a nice solution I think:

Make hcid create a socket in /etc/bluetooth/keytab.socket. Preferably,
having the same group membership as the socket (for examle "bluetooth")
enables a user to send commands like:

    DELETE <sba> <dba>

This makes hcid delete the link and update /etc/bluetooth/keytab and
/etc/bluetooth/keytab.shadow accordingly. These are ASCII files of
course and can also be maintained with Emacs or whatever tool although
this is not as safe because of race conditions.

Then we'll extend hcitool with the ability to connect to this socket
and do this stuff too.

The protocol can be extended in the future. Like for example initiating
pairing procedures and so on.

What do you think?

Fredrik
