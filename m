Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] how to recognize whether the connected device is
	a headset
From: Marcel Holtmann <marcel@holtmann.org>
To: Chen Bin <binch@mobilesoft.com.cn>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1098407881.898.5.camel@debian>
References: <1098352217.1912.4.camel@debian>
	 <1098380504.4885.18.camel@pegasus>  <1098407881.898.5.camel@debian>
Content-Type: text/plain
Message-Id: <1098441174.4704.18.camel@pegasus>
Mime-Version: 1.0
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
Date: Fri, 22 Oct 2004 12:32:54 +0200

Hi Chen,

> Below is the infomation I got when I am connecting to a headset and
> using 'sdptool browse 00:0D:18:02:4F:C0' to find out the service
> provided by the headset:
> 
> binch@debian:/new/bt/mBluetooth$ sdptool browse 00:0D:18:02:4F:C0
> Browsing 00:0D:18:02:4F:C0 ...
> binch@debian:/new/bt/mBluetooth$ hcitool con
> Connections:
> 
> BTW: I actually have connected to the headset because when I press some
> key in the headset I can get some reaction on hcidump, I don't know
> whether hcitool con can't see the connection.

according to your dump, you are already disconnected at that time and
you really shouldn't play with "hcitool cc ...", because this creation
of a connection is not really recognized by the kernel. Use the L2CAP or
RFCOMM sockets instead.

In general a headset don't reacts on requests for the public browse
group and so you must search for a specific service.

	sdptool search --bdaddr <bdaddr> {hs|hf}

> The headset is DKH-03.

>>From what company and what does "hcitool info ..." say about this
headset?

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
