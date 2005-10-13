Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Help with Digianswer protocol analyzer
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <000701c5cffd$f4e8cc20$6701a8c0@mainframe>
References: <001901c5cfe1$29a64180$6701a8c0@mainframe>
	 <1129201609.6951.1.camel@localhost.localdomain>
	 <000401c5cff4$d138d620$6701a8c0@mainframe>
	 <1129210251.6308.0.camel@localhost.localdomain>
	 <000701c5cffd$f4e8cc20$6701a8c0@mainframe>
Content-Type: text/plain
Message-Id: <1129212675.6308.9.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 Oct 2005 16:11:15 +0200

Hi Jonathan,

> It should be the BPA-100. According to your website, I reckon it belongs to 
> the first generation (08fd:0001) .
> The device isnt marked Tektronix but Digianswer A/S Bluetooth Protocol 
> Analyzer but shouldn't be much of a difference.

they are all the same. Now they are owned by Frontline.

> The loaded driver is hci_usb instead of bpa10x, maybe the driver was 
> missing? modprobe bpa10x.ko gave me an error.

So it seems we have to change something to adapt it for the BPA-100. I
need that device to really figure out, what is going on and what we have
to do.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
