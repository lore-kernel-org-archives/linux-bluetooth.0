Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <34DE67E73839C446B4269BCE8A1F303A01248EE0BC@CAMEUREXM01.EUROPE.ROOT.PRI>
References: <34DE67E73839C446B4269BCE8A1F303A01248EBDD5@CAMEUREXM01.EUROPE.ROOT.PRI>
	<CABBYNZJsbwsT9d5AxpDwtWVZFw60mY5TevGbTJqO_AowV4G2fw@mail.gmail.com>
	<CANq1E4SdffkdwvH1WhjqZ9V0GHLs0TUq-rQRj7tEVvhuzQL-TA@mail.gmail.com>
	<CABBYNZJLdVouwdcCD2zw9UnrcvubwutNGU4qbHJN75Qx3FpEow@mail.gmail.com>
	<34DE67E73839C446B4269BCE8A1F303A01248EE0BC@CAMEUREXM01.EUROPE.ROOT.PRI>
Date: Tue, 5 Aug 2014 15:25:51 +0200
Message-ID: <CANq1E4Rwfq4hNGFLKv9VCkcodW+0V0-8ZjB6EgaKhKdpmG16iA@mail.gmail.com>
Subject: Re: Re: HoG: Support multi output report
From: David Herrmann <dh.herrmann@gmail.com>
To: Aravind Parvathala <Aravind.Parvathala@csr.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Murat Kilivan <Murat.Kilivan@csr.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

>> > Ok, I now took the time to read through the HoG specs. It says:
>> >
>> >     "For data transferred to HID Device from Report Host,
>> >      Report ID is removed from data received from a
>> >      USB HID Class driver before being transmitted to the
>> >      HID Device (usually a write command to a Report
>> >      characteristic value or as a write request to a
>> >      Report characteristic value for HID Service data)."
>> >
>> > Each UHID_OUTPUT message received by BlueZ contains the report-ID as
>> > 1-byte prefix of the message. Therefore, you're supposed to strip it
>> > from the message and forward it to the right target.
>> >
>> > I have no idea how GATT works, but I assume you write to an attribute
>> > that is named after the report-ID of the output report. So you parse
>> > this 1-byte prefix, select the correct attribute based on this
>> > information and then send the message (without the 1-byte prefix) to
>> > the selected attribute.
>
> For each report (note that it is not for each report ID, because you could have an input, an output as well as a feature report all of which are using the same report ID), there is a corresponding characteristic which is discoverable. The report map indicates which are all the report IDs and the corresponding type (purpose). As shown by Murat, the debug logs show that all those report IDs were discovered from the report map.
>
> Each dedicated characteristic for each of the reports, carry a "Report Reference characteristic descriptor" which specifies the report ID and report type associated with that characteristic. Hence I would imagine the blue-z driver would need to keep the mapping of report ID/Type Vs the Characteristic handle.
>
> For an output report, the driver would direct the contents of the report over the corresponding handle as "Write request". This data will not have (and does not need to have) the report ID as the BLE device already knows which report ID is associated with the characteristic handle.
>
> For an input report, it’s the same except that the BLE device will issue a write request to the Blue-z host on the corresponding handle. Again the payload will not have any report ID, because the Blue-z host is expected to be able to map the payload of the originating characteristic handle to the corresponding input report ID.
>
> Same is applicable to the feature report as well but in this case , I imagine it is a read/write request-response type of exchange as you would reading/writing static configuration data rather.
>
>
> So it is not really a Characteristic  attribute named after the report-ID, but mapped to a report ID. As stated earlier, the associated " Report Reference characteristic descriptor " holds the information which is key to translate from the BLE data to the HID data and vice-versa.

Yes, this was really helpful, thanks! The BlueZ code looks almost
right, except for the code that maps UHID_OUTPUT events from the
kernel to the correct attribute. It currently only uses the type
information. I will send a patch to fix this.

Thanks
David
