Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Fredrik Noring <noring@nocrew.org>
To: Edd Dumbill <edd@usefulinc.com>
In-Reply-To: <1067906859.15607.48.camel@saag>
References: <1064593223.12843.127.camel@saag>
	<1067882864.15593.326.camel@dhcp-116.surrey.redhat.com>
	<1067906859.15607.48.camel@saag>
Message-Id: <1075331039.553.80.camel@akka.yeti.nocrew.org>
Mime-Version: 1.0
Date: Thu, 29 Jan 2004 00:04:00 +0100
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

Edd,

tis 2003-11-04 klockan 01.47 skrev Edd Dumbill:
> We need a way of finding out for which bdaddrs it has a key.  Currently 
> this information is stored in /etc/bluetooth/link_key and readable only 
> by root, so we've some progress to make there.

I believe it would be helpful to change the link_key binary file format
to ascii.

This would make the file more accessible and also simplify debugging,
manual recovery, endianess compatibility, future data type compatibility
and compiler issues such as the size of "time_t". Current format is:

	struct link_key {
		bdaddr_t sba;
		bdaddr_t dba;
		uint8_t	 key[16];
		uint8_t	 type;
		time_t	 time;
	};

An ascii version could be row based. What about like this?

00:11:22:33:44:55   66:77:88:99:00:11   6d450822cf944dcedd7a5b2e347e606f   key_type   1075330902

Works with grep, awk, perl, emacs and so on too. :)

Fredrik



_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
