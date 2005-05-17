Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] HCI-Uart Driver & Kernel 2.4.25 ,
	Headset/Handsfree Profile
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <OF9A811F48.3D259B3A-ONC1257004.002BB233-C1257004.002F049A@telemotive.de>
References: 
	 <OF9A811F48.3D259B3A-ONC1257004.002BB233-C1257004.002F049A@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1116329143.10063.38.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 17 May 2005 13:25:42 +0200

Hi Markus,

> I=B4m trying to get the Handsfree/Headset-Profile running on an embedde=
d
> power pc-platform using the 2.4.25 kernel and a bluetooth module=20
> which is connected to the host processor via UART-Interface. =20

first of all, about what kind of Bluetooth chip are we talking here?
What speed is the UART running?

> The strange thing is that all other profiles work fine (OBEX, DUN
> etc.)=20
> but when it comes to transfer synchronous data in both directions like
> the handsfree profile does, I got an error message from=20
> the kernel like "unkown HCI packet type 00 received".=20

The ACL link is protected by the HCI flow control and the SCO link is
not by default if I remember correctly.

> Although there were no additional error messages from the kernel like
> buffer overruns of the UART interface, the first thing I thought
> about =20
> was that there might by something wrong with the hardware handshake of
> the UART interface, but I managed to connect the bluetooth module =20
> via RS232 to a normal PC running linux kernel 2.6 even without RTS and
> CTS lines of the UART interface connected (only RXD & TXD). =20
> Here everything works fine, so the problem is surely not caused by a
> missing/buggy hardware handshake.=20

Don't mix 2.4 with 2.6 results on different hardware platforms. This
means nothing and the serial subsystem has been reworked within the 2.6
kernel series.

> It would be a hard work to upgrade from kernel 2.4  to 2.6 on our
> platform since we already applied many changes to the kernel (not
> concerning bluez),=20

You should really check if it is so hard to upgrade and if not all of
your applied patches are already merged into the 2.6 kernel. Sticking
with a 2.4 kernel is a bad idea. Even for the Bluetooth part, since I
stopped backporting things.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
