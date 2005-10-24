Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Link Quality between 2 Bluetooth USB Dongles
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
References: <94e407f00510240734x12c64714qc791a991ddcd1426@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1130164983.19317.54.camel@blade>
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
Date: Mon, 24 Oct 2005 16:43:03 +0200

Hi Arpit,

> I've installed Linux(Fedore Core 4) on my comp and the Bluez Protocol
> Stack to get the value of the signal strength between two Bluetooth
> USB dongles. I've connected two Bluetooth USB dongles to one
> computer(have the USB extension cables to increase the distance
> between the two dongles).When I run the command 'hcitool lq <bdaddr>'
> to get the value of the link quality between the two dongles,it is
> always 255.Even if I increase or decrease the distance between the two
> dongles,the LQ remains constant at 255.The RSSI value changes but this
> change is abrupt and does not seem like a good measure of the signal
> strength. Any idea as to what could be the possible problem with the
> LQ and any solutions?

the link quality is vendor specific. Look at my pages to find out how
CSR implemented it.
 
> The adaptors I'm using are: Billionton Version 1.2 Bluetooth USB
> Adaptors (P/N: USBBT02 (UBTBR2-B)).

What does "hciconfig hci0 version" tells you?

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
