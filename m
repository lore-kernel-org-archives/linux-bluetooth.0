Return-Path: <gnome-bluetooth-bounces@usefulinc.com>
From: Fred =?utf-8?q?Sch=C3=A4ttgen?= <bluez-devel@schaettgen.de>
To: GNOME Bluetooth Mailing List <gnome-bluetooth@usefulinc.com>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Date: Thu, 29 Jan 2004 12:30:00 +0100
References: <1064593223.12843.127.camel@saag>
	<1075331039.553.80.camel@akka.yeti.nocrew.org>
	<1075337441.553.97.camel@akka.yeti.nocrew.org>
In-Reply-To: <1075337441.553.97.camel@akka.yeti.nocrew.org>
MIME-Version: 1.0
Message-Id: <200401291230.00801.bluez-devel@schaettgen.de>
Subject: Re: [Bluez-devel] Re: [gnome-bluetooth] What stuff in gnome-bluetooth
	does, and ideas for its future
Content-Type: text/plain;
  charset="utf-8"
Cc: 
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

On Thursday 29 January 2004 01:50, Fredrik Noring wrote:
...
> I'm also thinking about the possibility of making a device name cache
> in /etc/bluetooth/names, somewhat similar to /etc/hosts. And so whenever
> someone requests a scan this table can be updated:
>
> # /etc/bluetooth/names
> #
> # Bluetooth address	Last updated	Device name
> 00:11:22:33:44:55	1075337039	Some Bluetooth device name
> 66:77:88:99:00:11	1075337039	Some other Bluetooth device name
>
> The configuration for this service can for example be located in
> /etc/bluetooth/names.conf.
>
> Having a device name cache makes it a lot easier to display the names
> associated with the addresses in the /etc/bluetooth/keytab file.
>
> Comments?

A device name cache makes it not only easier to display names more quickly, 
but also can you use it the other way round to resolve device names. We use 
both for our sdp kioslave for KDE. The nice thing (for us) is that everything 
can be done as a regular user, so the daemon can be started along with KDE 
without suid'ing or similar.
Apart from the date of last name request, we also log when a device was last 
discovered and when we were last connected to it (even though this 
information is not used for anything yet ;)

I wasn't able to follow your whole discussion.. do you think this 
functionality should go into bluez itself or into gnome-bluetooth only? If 
it's the latter, it might be a good idea to use the same data store for both 
gnome and kde.. not sure if it's worth the effort, just a thought.

greetings
Fred


_______________________________________________
gnome-bluetooth mailing list
gnome-bluetooth@usefulinc.com
http://lists.usefulinc.com/mailman/listinfo/gnome-bluetooth
