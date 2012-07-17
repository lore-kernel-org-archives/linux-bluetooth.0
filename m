Return-Path: <cyrus@holtmann.org>
Date: Tue, 17 Jul 2012 15:06:58 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: victor yeo <victoryeo1974@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: HCI Remote Name Request error "Page Timeout"
Message-ID: <20120717180556.GB19582@joana>
References: <CADX0rsZBLixOvNLhpoSH6PuP3m8LWP6w6CkDKB+cvhBAnwyT0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CADX0rsZBLixOvNLhpoSH6PuP3m8LWP6w6CkDKB+cvhBAnwyT0g@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Victor,

* victor yeo <victoryeo1974@gmail.com> [2012-07-17 17:34:32 +0800]:

> Hi,
> 
> The hcidump program shows a remote name request "Page Timeout" error.
> I do not understand the reason. The Bluez stack requests for remote
> name, the device replied with 'Nonin_Medical_Inc._359443' twice, Then
> Bluez stack requests again, got "Page Timeout" error, and connection
> stops. What is the reason of this behavior?
> 
> Thanks,
> Victor
> 
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x00 bdaddr 00:1C:05:00:70:44 name 'Nonin_Medical_Inc._359443'
> < HCI Command: Remote Name Request (0x01|0x0019) plen 10
>     bdaddr 00:1C:05:00:70:44 mode 2 clkoffset 0x0000
> > HCI Event: Command Status (0x0f) plen 4
>     Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> > HCI Event: Remote Name Req Complete (0x07) plen 255
>     status 0x04 bdaddr 00:1C:05:00:70:44 name ''
>     Error: Page Timeout

Can you enable dynamic_debug on your kernel for the bluetooth module and post
those logs to us? I wanna see what HCI is doing here.

	Gustavo
