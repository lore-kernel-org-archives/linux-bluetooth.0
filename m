Return-Path: <noring@nocrew.org>
Subject: Re: [gnome-bluetooth] What stuff in gnome-bluetooth does, and
	ideas for its future
From: Fredrik Noring <noring@nocrew.org>
To: Edd Dumbill <edd@usefulinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
   GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
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
Message-Id: <1075400074.22564.26.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 19:14:34 +0100
List-ID: <bluez-devel.lists.sourceforge.net>

Edd,

tor 2004-01-29 klockan 16.32 skrev Edd Dumbill:
> OK, I can see this.  But it wouldn't be a violation if hcid maintained a
> file with a list of devices with which it was paired?  That's really the
> information we're after.

That's a good approach I think. We can have /etc/bluetooth/keytab and
/etc/bluetooth/keytab.shadow (similar to /etc/passwd and /etc/shadow)
where /etc/bluetooth/keytab is readable by all.

> Well, that, and the ability to delete a link key.

By invoking /sbin/hcid with a special unlink argument?

Fredrik
