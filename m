Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Fredrik Noring <noring@nocrew.org>
To: Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1075331039.553.80.camel@akka.yeti.nocrew.org>
References: <1064593223.12843.127.camel@saag>
	<1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	<1067906859.15607.48.camel@saag>
	<1075331039.553.80.camel@akka.yeti.nocrew.org>
Message-Id: <1075337441.553.97.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 01:50:41 +0100
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

Hi

> An ascii version could be row based. What about like this?
> 
> 00:11:22:33:44:55   66:77:88:99:00:11   6d450822cf944dcedd7a5b2e347e606f   key_type   1075330902

What about replacing /etc/bluetooth/link_key with an ASCII version in
/etc/bluetooth/keytab? I'll work on a patch for it..

I'm also thinking about the possibility of making a device name cache 
in /etc/bluetooth/names, somewhat similar to /etc/hosts. And so whenever
someone requests a scan this table can be updated:

# /etc/bluetooth/names
#
# Bluetooth address	Last updated	Device name
00:11:22:33:44:55	1075337039	Some Bluetooth device name
66:77:88:99:00:11	1075337039	Some other Bluetooth device name

The configuration for this service can for example be located in
/etc/bluetooth/names.conf.

Having a device name cache makes it a lot easier to display the names
associated with the addresses in the /etc/bluetooth/keytab file.

Comments?

Fredrik



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
