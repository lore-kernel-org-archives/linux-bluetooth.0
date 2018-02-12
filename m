Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: hciattach alternative to change default address after upgrading
 to BlueZ 5.47
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+TC0NqnhXH=jxSoV-XhkDJ05S7evYJhW28peD4LPAnSRn3spw@mail.gmail.com>
Date: Mon, 12 Feb 2018 15:08:28 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B26A4952-B5DC-47BB-B45B-5D95FAEE6D98@holtmann.org>
References: <CA+TC0NqnhXH=jxSoV-XhkDJ05S7evYJhW28peD4LPAnSRn3spw@mail.gmail.com>
To: sudeepta bhuyan <sudeepta.bhuyan@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sudeepta,

> Prior to upgrading BlueZ to 5.47 in my project, I was using hciattach
> to set the UART device's address before starting bluetoothd.
> 
> hciattach /dev/ttyS2 bcm43xx flow nosleep xx:xx:xx:xx:xx
> 
> However since hciattach is deprecated in newer BlueZ, I am now using
> btattach instead to do the same. But btattach does not provide an
> option to set the bluetooth address of the device.
> 
> What is the standard procedure to set the bluetooth address of the
> UART device using newer BlueZ tools?

there is btmgmt public-addr command that will work if your driver supports hdev->set_bdaddr. For Broadcom chips that should be fully supported.

Regards

Marcel

