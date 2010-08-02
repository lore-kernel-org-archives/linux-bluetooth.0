Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1280764595.12579.19.camel@localhost.localdomain>
References: <AANLkTimA4dnDeoZVX1N4c=2sR1JkgAFWb4d0-0K+8S1C@mail.gmail.com>
	<1280764595.12579.19.camel@localhost.localdomain>
Date: Mon, 2 Aug 2010 18:34:10 +0200
Message-ID: <AANLkTimQeQ-XoM5yuWQYx5_1-xWf1H0ax_J=BbtDfG2T@mail.gmail.com>
Subject: Re: Getting link quality or RSSI
From: Davide Pesavento <davidepesa@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 2, 2010 at 17:56, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Davide,
>
>> I'm writing an application to retrieve the current link quality (or
>> RSSI) between my laptop's Bluetooth adapter and a specific remote
>> device (my mobile phone). In order to do that I'm of course using the
>> latest version of BlueZ, but I've encountered several issues so far.
>>
>> The dbus API exposed by bluetoothd doesn't have any GetRSSI or
>> GetLinkQuality methods. Would it be possible to export these methods
>> in the public API?
>
> the link quality is vendor specific according to the specification and
> the RSSI of an existing connection is rather useless. So we don't bother
> to export those.
>

Does this mean you're going to reject a patch which adds those methods
to the dbus API?

>> Then I looked at the bluetooth HCI library that comes with bluez.
>> First of all, is there any reasons why it's totally undocumented?
>> Anyway, I noticed hci_read_link_quality() and hci_read_rssi() in
>> hci_lib.h and tried using them. Since they seem to require an
>> established connection, I also used hci_create_connection(). However I
>> soon discovered that creating a connection requires root privileges,
>> is that right or did I do something wrong?
>>
>> Furthermore, even when running the program as root, the connection
>> gets established only for a few seconds and then it disconnects from
>> the remote device. Is this behaviour intended? How can I specify to
>> keep the connection alive indefinitely?
>
> If you don't have an active connection that is used, the kernel will
> terminate any idle ones. So using hcitool for this is rather pointless
> unless you have a profile already using that connection.
>

"using a connection" means pushing some traffic over it?
Is there no other way to prevent the kernel from terminating idle connections?

By the way, I've read in the Bluetooth specs that there exists an
extended inquiry mode which allows the host to gather the RSSI of
available devices too. How can I perform such kind of inquiry from my
application using bluez?

Thanks,
Davide
