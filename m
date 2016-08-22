Return-Path: <luiz.dentz@gmail.com>
MIME-Version: 1.0
In-Reply-To: <8CD08159-2E3B-4663-9C49-56131BB77AFA@holtmann.org>
References: <CAOsEZohrTsrZuLxpfRQ37mVcXGDqO+rV6TzfzR1ELbSHe0jtng@mail.gmail.com>
 <8CD08159-2E3B-4663-9C49-56131BB77AFA@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 22 Aug 2016 13:57:59 +0300
Message-ID: <CABBYNZ+cLHkDYH+L78oAr1P6Uua_TrbA02DE_tE0LoNq7wv=7A@mail.gmail.com>
Subject: Re: BLE Hexiwear connection fail
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Jay Aurabind <jay.aurabind@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jay, Marcel,

On Mon, Aug 22, 2016 at 11:51 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Jay,
>
>> I have the IoT device Hexiwear[1], which connects through BLE. They
>> have an android app which can take data from it. I want to use from my
>> linux machine. Its BLE API is provided at their github[2] page.
>
> does it work on Android? If so, then enable Bluetooth HCI tracing/logging in Android and send around the /sdcard/btsnoop_hci.log file. You can read that wit btmon by yourself and compare.
>
> I would also propose you start using btmon instead of hcidump.

The D-Bus GATT should be able to handle those, if we are able to
connect, but there seems to be something wrong with the specification
as it does seems to use UUID range reserved by the SIG instead of
using proper 128 bits UUIDs.

-- 
Luiz Augusto von Dentz
