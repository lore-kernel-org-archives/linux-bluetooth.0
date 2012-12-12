Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABFC@Luna.iaSolution.net>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
	<20121212075201.GA14256@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
	<20121212092537.GA5371@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
	<20121212100737.GA6620@x220>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
	<CAJdJm_Nb-W=ua7aUr7O578jJwLDGaC2-uC=vv0P2zdZOaXWUPg@mail.gmail.com>
	<ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABFC@Luna.iaSolution.net>
Date: Wed, 12 Dec 2012 08:20:23 -0400
Message-ID: <CAJdJm_PPnSmEV0nmjeka6vLa9qG9-FvZTvhypi9mfVyw+KxH+Q@mail.gmail.com>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns org.bluez.Error.NotAvailable
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Ting Chou <Ting.Chou@iasolution.net>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ting,

On Wed, Dec 12, 2012 at 7:30 AM, Ting Chou <Ting.Chou@iasolution.net> wrote:
> Hi Anderson,
>
>> -----Original Message-----
>> From: Anderson Lizardo [mailto:anderson.lizardo@openbossa.org]
>> Sent: Wednesday, December 12, 2012 6:53 PM
>> To: Ting Chou
>> Cc: Johan Hedberg; linux-bluetooth@vger.kernel.org
>> Subject: Re: [BLE] org.bluez.Device1.Connect() returns
>> org.bluez.Error.NotAvailable
>>
>> Hi Ting,
>>
>> On Wed, Dec 12, 2012 at 6:21 AM, Ting Chou <Ting.Chou@iasolution.net>
>> wrote:
>> > Do you mean once a LE device with internally supported profiles is
>> > discovered, it will be connected automatically? Which means I cannot
>> > connect manually, at the timing I prefer?
>> >
>> > Since with my BT 4.0 dongle, Adpater.StartDiscovery discover also LE
>> > devices, I thought I should use Device.Connect to connect to the
>> device.
>>
>> According to the General Connection Establishment procedure (GCEP, see
>> Core spec page 1716 for details), the host shall start scanning and:
>>
>> "When the Host discovers a device to which the Host may attempt to
>> connect, the Host shall stop the scanning, and initiate a connection
>> using the direct con- nection establishment procedure."
>>
>> That's exactly what BlueZ does for LE devices. For paired devices whose
>> profile is supported internally by BlueZ (e.g. a LE thermometer), the
>> GCEP will keep trying to connect to them, where "connect" means using
>> LE active/passive scan, followed by the procedure above.
>>
>
> Does this mean the "User selects a device to connect" in Figure 9.6 (Page 1715,
> Flow chart for a device performing the general connection establishment
> procedure) is not needed for supported devices?

This image is incorrect, and is fixed on ESR06 (see correct image on
page 29 of that document). There is no user interaction for GCEP.

>> For unsupported devices, IIRC there will be not attempt to keep re-
>> connecting to it (or even keep the connection up after service
>> discovery). This should be addressed by the generic GATT API in
>> attrib/client.c, but the current implementation has several limitations
>> and is not implementing a consistent API, therefore it will probably be
>> removed for first BlueZ 5.0 release, and a replacement (which should
>> probably address reconnection for external/proprietary GATT services)
>> will be implemented.
>>
>
> I'm not sure if I understand correctly. But do you mean the GCEP you mentioned
> above is applied while "reconnecting" to a supported device?

Yes, all GAP connection procedures are applicable for re-connection.
There is no "reconnection" procedure as per GAP (as far as I know).
But note that each GATT profile can specify reconnection procedures in
case of disconnection due to link loss (most of those that I read have
this). For instance, in HTP:

"5.2.4 Link Loss Reconnection Procedure
When a connection is terminated due to link loss, a Collector should attempt to
reconnect to the Thermometer using any of the GAP connection procedures with the
parameters in Table 5.2."

This is what BlueZ is doing for profiles implemented internally,
except that the parameters we use are not the ones recommended on the
profile specs (that could be implemented in future, but for now GCEP
uses fixed connection parameters).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
