Return-Path: <cyrus@holtmann.org>
From: Ting Chou <Ting.Chou@iaSolution.net>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Wed, 12 Dec 2012 19:30:59 +0800
Subject: RE: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABFC@Luna.iaSolution.net>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
	<20121212075201.GA14256@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
	<20121212092537.GA5371@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
	<20121212100737.GA6620@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
 <CAJdJm_Nb-W=ua7aUr7O578jJwLDGaC2-uC=vv0P2zdZOaXWUPg@mail.gmail.com>
In-Reply-To: <CAJdJm_Nb-W=ua7aUr7O578jJwLDGaC2-uC=vv0P2zdZOaXWUPg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> -----Original Message-----
> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
> Sent: Wednesday, December 12, 2012 6:53 PM
> To: Ting Chou
> Cc: Johan Hedberg; linux-bluetooth@vger.kernel.org
> Subject: Re: [BLE] org.bluez.Device1.Connect() returns
> org.bluez.Error.NotAvailable
> 
> Hi Ting,
> 
> On Wed, Dec 12, 2012 at 6:21 AM, Ting Chou <Ting.Chou@iasolution.net>
> wrote:
> > Do you mean once a LE device with internally supported profiles is
> > discovered, it will be connected automatically? Which means I cannot
> > connect manually, at the timing I prefer?
> >
> > Since with my BT 4.0 dongle, Adpater.StartDiscovery discover also LE
> > devices, I thought I should use Device.Connect to connect to the
> device.
> 
> According to the General Connection Establishment procedure (GCEP, see
> Core spec page 1716 for details), the host shall start scanning and:
> 
> "When the Host discovers a device to which the Host may attempt to
> connect, the Host shall stop the scanning, and initiate a connection
> using the direct con- nection establishment procedure."
> 
> That's exactly what BlueZ does for LE devices. For paired devices whose
> profile is supported internally by BlueZ (e.g. a LE thermometer), the
> GCEP will keep trying to connect to them, where "connect" means using
> LE active/passive scan, followed by the procedure above.
> 

Does this mean the "User selects a device to connect" in Figure 9.6 (Page 1715,
Flow chart for a device performing the general connection establishment
procedure) is not needed for supported devices?

> For unsupported devices, IIRC there will be not attempt to keep re-
> connecting to it (or even keep the connection up after service
> discovery). This should be addressed by the generic GATT API in
> attrib/client.c, but the current implementation has several limitations
> and is not implementing a consistent API, therefore it will probably be
> removed for first BlueZ 5.0 release, and a replacement (which should
> probably address reconnection for external/proprietary GATT services)
> will be implemented.
> 

I'm not sure if I understand correctly. But do you mean the GCEP you mentioned
above is applied while "reconnecting" to a supported device?

Thanks,
Ting
