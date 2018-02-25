Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH 1/4] Bluetooth: hci_bcm: Make shutdown and device wake
 GPIO optional
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
Date: Sun, 25 Feb 2018 21:17:27 +0100
Cc: Loic Poulain <loic.poulain@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Eric Anholt <eric@anholt.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lukas Wunner <lukas@wunner.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel@lists.infradead.org, devicetree@vger.kernel.org
Message-Id: <F4CD11EC-CEC2-4294-9895-0204269086FA@holtmann.org>
References: <1519567855-26105-1-git-send-email-stefan.wahren@i2se.com>
 <1519567855-26105-2-git-send-email-stefan.wahren@i2se.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> According to the devicetree binding the shutdown and device wake
> GPIOs are optional. Since commit 3e81a4ca51a1 ("Bluetooth: hci_bcm:
> Mandate presence of shutdown and device wake GPIO") this driver
> won't probe anymore on Raspberry Pi 3 and Zero W (no device wake GPIO
> connected). So fix this regression by reverting this commit partially.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Fixes: 3e81a4ca51a1 ("Bluetooth: hci_bcm: Mandate presence of shutdown and device wake GPIO")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
> drivers/bluetooth/hci_bcm.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel

