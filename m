Return-Path: <linux-wireless-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 2/8] rsi: add bluetooth rx endpoint
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1510730444-3237-3-git-send-email-amitkarwar@gmail.com>
Date: Wed, 15 Nov 2017 16:23:49 +0100
Cc: Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        Amitkumar Karwar <amit.karwar@redpinesignals.com>,
        Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Siva Rebbagondla <siva.rebbagondla@redpinesignals.com>
Message-Id: <440EED52-0556-4919-9727-078B2A7192D6@holtmann.org>
References: <1510730444-3237-1-git-send-email-amitkarwar@gmail.com>
 <1510730444-3237-3-git-send-email-amitkarwar@gmail.com>
To: Amitkumar Karwar <amitkarwar@gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> USB endpoint 1 is used for WLAN which is presently in use.
> USB endpoint 2 is introduced for BT Rx traffic. Enumeration
> of Rx BT endpoint and submitting Rx BT URB are added.

wouldn’t it be good to include the /sys/kernel/debug/usb/devices part here that shows how the USB device’s layout.

Regards

Marcel
