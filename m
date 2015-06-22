Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <670FEC00-5331-47B5-8434-7642D67779DC@holtmann.org>
References: <CANzaTi7NSBf8iuTC41jBA=732PCZUYkzw_ZTywGM-xNQt68qbw@mail.gmail.com>
	<670FEC00-5331-47B5-8434-7642D67779DC@holtmann.org>
Date: Mon, 22 Jun 2015 14:51:24 +0200
Message-ID: <CANzaTi4pWpho3OfSLGvnZLpiBe==OHXdavypgs=zFsZ_hA4dDQ@mail.gmail.com>
Subject: Re: BLE Advertise and Scan at the same time?
From: dogan yazar <doganyazar@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks for the answer Marcel. I tried this by enabling advertisement
(hciconfig hci0 leadv) and then "btmgmt find" but then hci adapter got
into some weird state. Was not possible to disable scanning anymore.
Same problem when I did bluetoothctl scan on. Probably my chip does
not support it.

I also tried "btmgmt advertising on" rather than hciconfig leadv but
it did not do anything at all. Is "hciconfig hci0 leadv" only way to
enable advertising until we move to kernel 4.1 and do it via DBUS api?

And lastly, still I seem to need hcitool to be able to set the
advertisement data otherwise android ble clients refuse to connect
(they think it is a classic bluetooth I think). It is no longer a
issue after I set GAP_ADTYPE_FLAGS_BREDR_NOT_SUPPORTED via hcitool cmd
i.e. hcitool -i hci0 cmd 0x08 0x0008 3 02 01 05

On Mon, Jun 22, 2015 at 12:22 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Dogan,
>
>> Is it possible to advertise (leadv) and scan (scan on) using the same
>> ble adaper?
>> The moment that I enable scanning (scan on) with bluetoothctl, leadv
>> is disabled.
>
> that depends on the Bluetooth chip you are using. Inside the kernel we cu=
rrently play it safe and disable one when we start the other. It will be ho=
wever re-enabled when the scan finished. You need to use btmgmt and not hci=
tool. Using hcitool messes with raw HCI packets. The kernel logic will alwa=
ys overwrite these as it sees fit.
>
> To allow simultaneous states, someone would have to work on that and figu=
re out which chips support what. Once that is done, there is no problem in =
lifting some of the restrictions we imposed.
>
>> The reason I want is to have a GATT client and server at the same time.
>
> Actually that has never been a problem. You can have a GATT client and se=
rver at the same time and most likely you do already anyway. The question y=
ou are asking is if you can be in central and peripheral role at the same t=
ime.
>
> Regards
>
> Marcel
>
