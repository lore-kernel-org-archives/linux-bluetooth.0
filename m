Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Date: Tue, 10 Feb 2015 13:42:58 +0200
Message-ID: <CABBYNZ+aUNKiy+PMOq__kw_Xh6=9cVgaocTRK2j42sDjw3+b6w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 00/12] client: Add support for GATT API
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 6, 2015 at 1:03 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds basic support for GATT API, the main idea is that one can
> navigate into the attributes and read and write values to them.
>
> Some of the output of the changes can be found bellow:
>
> [bluetooth]# connect XX:XX:XX:XX:XX:XX
> Attempting to connect to XX:XX:XX:XX:XX:XX
> [CHG] Device XX:XX:XX:XX:XX:XX Connected: yes
> Connection successful
> [CHG] Device XX:XX:XX:XX:XX:XX Paired: yes
> [NEW] Service /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011 Battery Service (Primary)
> [NEW] Characteristic /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Battery Level
> [NEW] Descriptor /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012/desc0014 Client Characteristic Configuration
> [Arc Touch Mouse SE]# select-attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011
> /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011                    /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012           /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012/desc0014
> [Arc Touch Mouse SE]# select-attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011
> [Arc Touch Mouse SE:/service0011]# attribute-info
> Service - Battery Service
>         UUID: 0000180f-0000-1000-8000-00805f9b34fb
>         Primary: yes
>         Characteristics: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012
> [Arc Touch Mouse SE:/service0011]# select-attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012
> [Arc Touch Mouse SE:/service0011/char0012]# attribute-info
> Characteristic - Battery Level
>         UUID: 00002a19-0000-1000-8000-00805f9b34fb
>         Service: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011
>         Notifying: no
>         Flags: read
>         Flags: notify
>         Descriptors: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012/desc0014
> [Arc Touch Mouse SE:/service0011/char0012]# read
> Attempting to read /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Value: 0x63
>   63                                               c
> [Arc Touch Mouse SE:/service0011/char0012]# write 00
> Attempting to write /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012
> Failed to write: org.bluez.Error.NotSupported
> [Arc Touch Mouse SE:/service0011/char0012]# notify on
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Notifying: yes
> Notify started
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Value: 0x55
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Value: 0x56
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Value: 0x57
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Value: 0x58
> [Arc Touch Mouse SE:/service0011/char0012]# notify off
> [CHG] Attribute /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/service0011/char0012 Notifying: no
> Notify stopped
> [Arc Touch Mouse SE:/service0011/char0012]#
>
> Luiz Augusto von Dentz (12):
>   client: Add support for GattService1
>   client: Add support for GattCharacteristic1
>   client: Add support for GattDescriptor1
>   client: Make commands relative to device
>   client: Add command list-attributes
>   client: Add command select-attribute
>   client: Add attribute-info command
>   client/display: Add rl_hexdump
>   client: Add read command
>   client: Add write command
>   client: Add notify command
>   client: Handle attribute notifications
>
>  Makefile.tools   |   1 +
>  client/display.c |  41 +++++
>  client/display.h |   1 +
>  client/gatt.c    | 514 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  client/gatt.h    |  39 +++++
>  client/main.c    | 409 ++++++++++++++++++++++++++++++++++---------
>  6 files changed, 925 insertions(+), 80 deletions(-)
>  create mode 100644 client/gatt.c
>  create mode 100644 client/gatt.h
>
> --
> 2.1.0

Pushed.



-- 
Luiz Augusto von Dentz
