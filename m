Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4F9B0108.2000007@tu-ilmenau.de>
References: <201204271541.q3RFfVd5006035@imr-da04.mx.aol.com>
	<4F9B0108.2000007@tu-ilmenau.de>
Date: Sun, 29 Apr 2012 14:44:50 +0300
Message-ID: <CABBYNZJ2ygZ42r==cDbBFmtzmOFTA-HnDCWk_XM669pHYtfs5Q@mail.gmail.com>
Subject: Re: main.conf issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: Kal Torak <chronognosis@aim.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Apr 27, 2012 at 11:26 PM, Steffen Becker
<steffen.becker@tu-ilmenau.de> wrote:
> Hello Torak,
>
> I'm not very familiar with BlueZ (also just asking questions on this mailing
> list), but what I can tell is that:
> You have to setup this file:
> /var/lib/bluetooth/<local-bdaddr>/config
> At the moment I can't look up the right syntax for all the configuration,
> but if i remember right, for enabling discoverable mode you have to enter
> something like this in the config-file:
>
> onmode discoverable
> mode discoverable
>
> For changing the name of your device, you have to edit this line in the
> config-file:
>
> name <your-name>

Please no top-posting here, those files are not supposed to be
manually edited, use D-Bus API otherwise you may cause
inconsistencies.

>> Hello, When I setup the main.conf with the values for Name, Class,
>> PairableTimeout and DiscoverableTimeout, and restart the bluetoothd,
>> hciconfig shows that nothing change name still the same, I cant "see"
>> the device from the outside(iscan is disabled), and the class still
>> 0x000100, and I must re-do hciconfig hci name #### class #### and
>> hciconfig hci0 piscan by hand to make the device visible and try
>> streaming support, OTOH I just can't see and/or connect to the device.
>> a ConWise 6622 Bluetooth dongle.
>> I'm using bluez-4.99 and linux 3.2.15.Any information will be usefull...

You don't have to do that in main.conf, except for class, those values
are only used when there is nothing already configured, so to change
this you really should be using D-Bus. You can find under
tests/test-adapter how to set this permanently in the configuration of
the adapter.

Btw, for the class it actually gets updated automatically when you
register the services.

-- 
Luiz Augusto von Dentz
