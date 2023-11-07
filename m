Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA0F2D033
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 16:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F7C2122
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 08:16:18 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B21C0E0009;
	Tue,  7 Nov 2023 16:16:16 +0000 (UTC)
Message-ID: <1cfb41d93aa22147e8973f35a37792897b365927.camel@hadess.net>
Subject: Re: Using Laird Connectivity Bluetooth LE PTS dongle with Linux
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Christoph Schweers <christoph.schweers@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Tue, 07 Nov 2023 17:16:16 +0100
In-Reply-To: <CABBYNZLCsBZ5eD+zRMC_YjSYU6C8FS5vw=DVHd947D+eiKY5Tg@mail.gmail.com>
References: <c0df9d614f2a220bc93227eafcc68f73f1751528.camel@hadess.net>
	 <CA+5PdQagTBRK09kMX=npZO9OawqtOp-CHGcYeVmQ5BpC+Uyi5A@mail.gmail.com>
	 <31050102f726a4e89a9ef3d1719d6305de2ee61b.camel@hadess.net>
	 <CABBYNZLCsBZ5eD+zRMC_YjSYU6C8FS5vw=DVHd947D+eiKY5Tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2023-11-07 at 10:04 -0500, Luiz Augusto von Dentz wrote:
<snip>
> > I updated the firmware using the PTS firmware upgrader, and it
> > still
> > doesn't show up as a Bluetooth adapter under Linux:
> >=20
> > Nov 07 15:44:11 classic kernel: usb 1-8: new full-speed USB device
> > number 22 using xhci_hcd
> > Nov 07 15:44:11 classic kernel: usb 1-8: New USB device found,
> > idVendor=3D1915, idProduct=3D521f, bcdDevice=3D 1.00
> > Nov 07 15:44:11 classic kernel: usb 1-8: New USB device strings:
> > Mfr=3D1, Product=3D2, SerialNumber=3D3
> > Nov 07 15:44:11 classic kernel: usb 1-8: Product: nRF52 USB Product
> > Nov 07 15:44:11 classic kernel: usb 1-8: Manufacturer: Nordic
> > Semiconductor
> > Nov 07 15:44:11 classic kernel: usb 1-8: SerialNumber: E1BB9211FA41
> > Nov 07 15:44:11 classic kernel: cdc_acm 1-8:1.0: ttyACM0: USB ACM
> > device
> >=20
> > It shows up as:
> > Bus 001 Device 023: ID 1915:521f Nordic Semiconductor ASA nRF52 USB
> > Product
> > in lsusb.
>=20
> Perhaps it needs to be added to be btusb if it does support a
> standard
> HCI interface. (I'm currently on vacation with limited time to assist
> everyone.)

Ha, that's very possible. This is the lsusb output, but you're only
allowed to look at it when you come back from holidays ;)

I'll give a go at cooking a patch for it once I've checked whether the
interfaces match.

Cheers


Bus 001 Device 024: ID 1915:521f Nordic Semiconductor ASA nRF52 USB
Product
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0=20
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0        64
  idVendor           0x1915 Nordic Semiconductor ASA
  idProduct          0x521f=20
  bcdDevice            1.00
  iManufacturer           1 Nordic Semiconductor
  iProduct                2 nRF52 USB Product
  iSerial                 3 E1BB9211FA41
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x004b
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 Default configuration
    bmAttributes         0xc0
      Self Powered
    MaxPower              100mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass          2 Communications
      bFunctionSubClass       2 Abstract (modem)
      bFunctionProtocol       1 AT-commands (v.25ter)
      iFunction               0=20
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         2 Communications
      bInterfaceSubClass      2 Abstract (modem)
      bInterfaceProtocol      1 AT-commands (v.25ter)
      iInterface              0=20
      CDC Header:
        bcdCDC               1.10
      CDC Call Management:
        bmCapabilities       0x03
          call management
          use DataInterface
        bDataInterface          1
      CDC ACM:
        bmCapabilities       0x02
          line coding and serial state
      CDC Union:
        bMasterInterface        0
        bSlaveInterface         1=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval              16
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass        10 CDC Data
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0001
  Self Powered

