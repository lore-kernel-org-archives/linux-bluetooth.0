Return-Path: <edd@usefulinc.com>
Subject: Re: [gnome-bluetooth] What stuff in gnome-bluetooth does, and
	ideas for its future
From: Edd Dumbill <edd@usefulinc.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Fredrik Noring <noring@nocrew.org>,
   GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1075389771.26729.95.camel@pegasus>
References: <1064593223.12843.127.camel@saag>
	 <1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	 <1067906859.15607.48.camel@saag>
	 <1075331039.553.80.camel@akka.yeti.nocrew.org>
	 <1075337441.553.97.camel@akka.yeti.nocrew.org>
	 <1075374586.29731.86.camel@saag>  <1075389771.26729.95.camel@pegasus>
Content-Type: text/plain
Message-Id: <1075390320.1269.6.camel@nova>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 15:32:00 +0000
Sender: Edd Dumbill <edd@usefulinc.com>
List-ID: <bluez-devel.lists.sourceforge.net>

On Thu, 2004-01-29 at 15:22, Marcel Holtmann wrote:
> Hi Edd,
> 
> > Well, these changes would definitely make me much happier.  From a user
> > interface level the user needs some visual feedback whether they're
> > paired or not.  Often "permission denied" means they've forgotten to
> > pair, but we need to find a nice way to tell the user this when it
> > happens.
> 
> but you can't use the link key database for it. The link keys must be
> stored with the highest possible security and this means that they
> should only be readable and writable by root.

OK, I can see this.  But it wouldn't be a violation if hcid maintained a
file with a list of devices with which it was paired?  That's really the
information we're after.  Well, that, and the ability to delete a link
key.

-- Edd
