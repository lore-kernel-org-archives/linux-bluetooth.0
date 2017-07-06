Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH v2] Support to change set file via arg
To: C Shapiro <shapiroc@chromium.org>,
        <linux-bluetooth@vger.kernel.org>
References: <20170705161602.95344-1-shapiroc@chromium.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <1c5fb2d7-8671-b5f7-9773-0454ee3ca7da@jp.fujitsu.com>
Date: Thu, 6 Jul 2017 13:21:05 +0900
MIME-Version: 1.0
In-Reply-To: <20170705161602.95344-1-shapiroc@chromium.org>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Charles,

On 07/06/2017 01:16 AM, C Shapiro wrote:
> ChromeOS is currently shifting to a more dynamic build system where a
> single build will be created/managed/deployed to support multiple models
> that were all created based on a single reference board.
> 
> This is being done for general cost/maintenance savings around the sheer
> number of builds that are currently managed for ChromeOS.

I could not understand whether there were any merits except maintenance
of your ChromeOS.
Are there any merits for other software/users (e.g. container, etc.)?

> For the bluetooth stack, models have different product id values in the
> DeviceID field for the main.conf config file.

Why do not you pass DeviceID as an argument instead of a config file?

> E.g.
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-pyro/chromeos-base/chromeos-bsp-pyro/files/main.conf
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-reef/chromeos-base/chromeos-bsp-reef/files/main.conf
> https://chromium.git.corp.google.com/chromiumos/overlays/board-overlays/+/master/overlay-snappy/chromeos-base/chromeos-bsp-snappy/files/main.conf

I could not access without an account.
How can I sign up?

> This change allows the config file to be passed as a runtime argument to
> bluetoothd, which allows the ChromeOS init script to determine the model
> at runtime and then pass the appropriate model specific config file.

Why do not you change only ChromeOS init scirpt?

For example, in ChromeOS init scirpt,
 1. Determine the model.
 2. Run ln command with --force option to link /etc/bluetooth/main.conf to 
    the appropriate config file.


Thank you for reading this to the end :)

Regards,
Eramoto
