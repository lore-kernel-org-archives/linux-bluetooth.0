Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: Bluetooth is not working on Intel new wifi/bt module 9462NGW
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAB4CAwc9GiF9EdzoZ2wUxvXqaB1y97-7UuitaQV9h2poiXXE3A@mail.gmail.com>
Date: Mon, 4 Dec 2017 07:52:55 +0100
Cc: johannes.berg@intel.com,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Message-Id: <250B08E7-35C8-4DB7-8BCC-85368D6DE6E3@holtmann.org>
References: <CAB4CAwc9GiF9EdzoZ2wUxvXqaB1y97-7UuitaQV9h2poiXXE3A@mail.gmail.com>
To: Chris Chiu <chiu@endlessm.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chris,

>    We just have the Intel new WiFi/BT module 9462NGW from Acer and
> tried to verify if it works on the latest linux kernel. The BT is not
> working because of the missing firmware.
> 
> [   18.249144] Bluetooth: hci0: Bootloader revision 0.1 build 42 week 52 2015
> [   18.250036] Bluetooth: hci0: Device revision is 2
> [   18.250037] Bluetooth: hci0: Secure boot is enabled
> [   18.250038] Bluetooth: hci0: OTP lock is disabled
> [   18.250038] Bluetooth: hci0: API lock is enabled
> [   18.250039] Bluetooth: hci0: Debug lock is disabled
> [   18.250040] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   18.293902] bluetooth hci0: Direct firmware load for
> intel/ibt-17-2.sfi failed with error -2
> [   18.293907] Bluetooth: hci0: Failed to load Intel firmware file (-2)
> 
> I'm not able to find these missing files in linux-firmware.git and any
> other possible place. What's the status of supporting this 9462NGW?
> Please let me know if any more information required. Thanks

there is a pending patch for adopting a new naming schemes for this hardware series firmware files. But even these named firmware files are not in linux-firmware tree either.

Regards

Marcel

