Return-Path: <cyrus@holtmann.org>
Date: Wed, 12 Dec 2012 12:36:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Ting Chou <Ting.Chou@iaSolution.net>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BLE] org.bluez.Device1.Connect() returns
 org.bluez.Error.NotAvailable
Message-ID: <20121212103614.GA7669@x220>
References: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65AB92@Luna.iaSolution.net>
 <20121212075201.GA14256@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABCC@Luna.iaSolution.net>
 <20121212092537.GA5371@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABDA@Luna.iaSolution.net>
 <20121212100737.GA6620@x220>
 <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ADCBF04BB97EBF4AAE65663F8478B61CA99E65ABED@Luna.iaSolution.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ting,

On Wed, Dec 12, 2012, Ting Chou wrote:
> Do you mean once a LE device with internally supported profiles is
> discovered, it will be connected automatically? Which means I cannot
> connect manually, at the timing I prefer?

Correct. In many ways one could consider the peripheral (advertising
device) to be the one that "initiates" the connection by starting to do
connectable advertising. We are merely reacting to this "request" by
sending a HCI_LE_Create_Connection command.

> Since with my BT 4.0 dongle, Adpater.StartDiscovery discover also LE
> devices, I thought I should use Device.Connect to connect to the
> device.

I agree that Device.Connect should at least work on devices that have
been discovered but on whom we haven't completed service discovery yet.
This would be analogous to the old Adapter.CreateDevice and it'd allow
us to implement proper support for devices not supporting SMP (i.e.
devices you can't call Device.Pair on). What remains to be discussed is
whether Device.Connect is useful for LE devices in some more extended
sense. Maybe it could at least force calling device_set_auto_connect().

Johan
