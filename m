Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Marcel Holtmann <marcel@holtmann.org>
To: Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075374586.29731.86.camel@saag>
References: <1064593223.12843.127.camel@saag>
	<1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	<1067906859.15607.48.camel@saag>
	<1075331039.553.80.camel@akka.yeti.nocrew.org>
	<1075337441.553.97.camel@akka.yeti.nocrew.org>
	<1075374586.29731.86.camel@saag>
Message-Id: <1075389771.26729.95.camel@pegasus>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 16:22:52 +0100
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

Hi Edd,

> Well, these changes would definitely make me much happier.  From a user
> interface level the user needs some visual feedback whether they're
> paired or not.  Often "permission denied" means they've forgotten to
> pair, but we need to find a nice way to tell the user this when it
> happens.

but you can't use the link key database for it. The link keys must be
stored with the highest possible security and this means that they
should only be readable and writable by root.

Regards

Marcel



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
