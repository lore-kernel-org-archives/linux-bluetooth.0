Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problem with keyboard/mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: Charles Bueche <charles@bueche.ch>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>,
   Dave Sailer <dave.sailer@paytec.com>
In-Reply-To: <20041022152443.251405a6@bluez.bueche.ch>
References: <1098441508.11708.12.camel@dsailer>
	 <1098443444.4704.46.camel@pegasus> <1098447645.11708.17.camel@dsailer>
	 <1098449746.4704.56.camel@pegasus>
	 <20041022152443.251405a6@bluez.bueche.ch>
Content-Type: text/plain
Message-Id: <1098453181.4704.80.camel@pegasus>
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
Date: Fri, 22 Oct 2004 15:53:01 +0200

Hi Charles,

> to add my grain of salt : I run 2.6.9-gentoo with patch-2.6.9-mh1.gz,
> and I see no problem at all. I have however no Microsoft hardware, only 
> a Logitech MX900 mouse.

this is not a hardware problem. I think the kernel source code got
corrupted and the compilation produced bad code. He must start from a
clean kernel source.

However if the HID boot protocol mode is enough, then the 2.6.8 kernel
includes everything you need.

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
