Return-Path: <noring@nocrew.org>
Subject: Re: [gnome-bluetooth] What stuff in gnome-bluetooth does, and
	ideas for its future
From: Fredrik Noring <noring@nocrew.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075486723.26729.183.camel@pegasus>
References: <1064593223.12843.127.camel@saag>
	 <1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	 <1067906859.15607.48.camel@saag>
	 <1075331039.553.80.camel@akka.yeti.nocrew.org>
	 <1075337441.553.97.camel@akka.yeti.nocrew.org>
	 <1075374586.29731.86.camel@saag>  <1075389771.26729.95.camel@pegasus>
	 <1075390320.1269.6.camel@nova>
	 <1075484759.14644.10.camel@akka.yeti.nocrew.org>
	 <1075486723.26729.183.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075494705.14644.47.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Fri, 30 Jan 2004 21:31:45 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel,

fre 2004-01-30 klockan 19.18 skrev Marcel Holtmann:
> This makes you independent from the database format (I prefer
> Berkeley DB at the moment) and you don't need to have database
> code in the Bluetooth library. 

A built-in ASCII table format for all (or most) services is important,
I think, because that's extremely lightweight and efficient for the
common cases. It should be the default.

There can be support for various database client libraries as well
(MySQL, LDAP, Oracle, Berkeley and whatever someone likes). Using any
of those is a matter of:

  1. Linking with the appropriate database client library.
  2. Writing a proper configuration in hcid.conf.

> But when we design it this way, we must make sure that we have the 
> highest security for the link key transactions.

Some database clients support SSL, if that's required. I think such
option ought to be decided by the administrator.

> Additional commands can be NAME or ISPAIRED, but I am also not sure if a
> binary protocol would be better. Maybe we can use D-BUS for it.

Yes, maybe.

> Some other comments from me. I am not going to include such big changes
> into hcid. This is development work for the new security manager or call
> it device manager which is going to replace hcid.

Why? (I'm sure all this can be backwards compatible with current hcid.)
I think it's a good idea to work with the current code base in any case.

> Fredrik, would you please start a new post on the bluez-devel mailing
> list, so we have a new thread for it. This is not really GNOME related
> and I am not a big friend of cross-posting.

Sure! This is technical now.

Fredrik
