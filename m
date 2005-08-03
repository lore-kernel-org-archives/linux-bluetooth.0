Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <7aa80ced050803021744cb6e7d@mail.gmail.com>
From: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <7aa80ced05080301443cd355cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <7aa80ced05080301443cd355cd@mail.gmail.com>
Subject: [Bluez-users] Re: Bluetooth dongle not working under extended USB2.0 host
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
Date: Wed, 3 Aug 2005 14:47:42 +0530

Note:
We have extended using a USB 2.0 hub. while connecting the bluetooth
USB dongle on the USB 2.0 hub, the device is getting detected but hci0
is not getting up. In hte kernel messages it is showing as follows:

usb 1-4.2: new full speed USB device using address 76
ehci_hcd 0000:00:10.3: qh cced8780 (#0) state 1
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c60a0bf4 err -28
hci_usb_intr_rx_submit: hci0 intr rx submit failed urb c60a0bf4 err -28

Please advice.

Thanks,
Mohan

On 8/3/05, Mohan K <kmohangda@gmail.com> wrote:
> Hi All,
> We are using a VIA mother board with FC3(kernel2.6.12) installed.  We
> have extended one of the USB port using a USB controller.
> When I plugged a mouse it is working fine. But if I plug and use a
> bluetooth dongle it is not working. The kernel is detecting the USB.
> I tried to use "hcitool scan",but it fails with an error message "No
> route to host".
>=20
> Can anyone tell me why this is happening? Advanced thanks for your sugges=
tions.
>=20
> Thanks & Regards,
> Mohan
>


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
