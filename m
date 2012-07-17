Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 17 Jul 2012 17:34:32 +0800
Message-ID: <CADX0rsZBLixOvNLhpoSH6PuP3m8LWP6w6CkDKB+cvhBAnwyT0g@mail.gmail.com>
Subject: HCI Remote Name Request error "Page Timeout"
From: victor yeo <victoryeo1974@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The hcidump program shows a remote name request "Page Timeout" error.
I do not understand the reason. The Bluez stack requests for remote
name, the device replied with 'Nonin_Medical_Inc._359443' twice, Then
Bluez stack requests again, got "Page Timeout" error, and connection
stops. What is the reason of this behavior?

Thanks,
Victor

< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x04 bdaddr 00:1C:05:00:70:44 name ''
    Error: Page Timeout
