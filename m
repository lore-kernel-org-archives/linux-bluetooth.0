Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <56137272.2040809@ubnt.com>
References: <56137272.2040809@ubnt.com>
Date: Tue, 6 Oct 2015 12:35:17 +0300
Message-ID: <CABBYNZ+HfSJVg3QTkjc7EQh-KRT3q1EZ75U6g4-N+B3zYf7CtQ@mail.gmail.com>
Subject: Re: LE ADV data is lost after first connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrejs Hanins <andrejs.hanins@ubnt.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrejs,

On Tue, Oct 6, 2015 at 10:04 AM, Andrejs Hanins <andrejs.hanins@ubnt.com> wrote:
> Hi,
>
>         I'm on Bluez 5.35 + Kernel 4.1.6 using D-Bus LE Adv Manager to register my own advertisement structure (with service UUID). Everything works fine, I see my UUID is present in scan record (using Android Bluetooth LE Scanner or iOS Light Blue App). But scan record becomes empty (all zeros) after I connect/disconnect to the peripheral.
>
>         This issue, however, only present on Atheros AR3012 Bluetooth chip (USB vendor:product is 0cf3:3004) and not present neither on Broadcom BCM20705 nor on CSR. Based on btmon traces I see that after peripheral is disconnected, LE adv is enabled again using HCI "LE Set Advertising Parameters" and "LE Set Advertise Enable" commands which obviously do not set the adv data again.
>
>         My assumption is that BT chip is expected to keep LE adv data between re-connections, but Atheros AR3012 (at least the revisions we use) has a bug which erases Adv data after the connection is made.
>
>         Can someone confirm that my assumption is correct and workaround/quirk is needed for AR3012 or maybe there is something else may be wrong here?
>

I guess it would be good if you attach the HCI logs, from the
description it looks like the Atheros chip is misbehaving since LE Set
Advertising Data Command is suppose to stay valid unless the
controller is reset.


-- 
Luiz Augusto von Dentz
