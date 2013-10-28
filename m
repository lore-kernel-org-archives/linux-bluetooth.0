Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Oct 2013 17:18:13 -0200
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: Kevin Wilson <wkevils@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluetooth tools
Message-ID: <20131028191813.GA31254@molly.amr.corp.intel.com>
References: <CAGXs5wULS_dYYCCyimg3y9Fv6smMp8kOQbN3BfYJ+=bBhbhHxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGXs5wULS_dYYCCyimg3y9Fv6smMp8kOQbN3BfYJ+=bBhbhHxQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kevin,

On 09:40 Sat 26 Oct, Kevin Wilson wrote:
> Hello,
> 
> I saw that bluetoothctl and btmon are the newer tool of Bluetooth.
> 
> What are the advantages of bluetoothctl over hciconfig/hcitool?

I would not say advantages, as they have very different aims, bluetoothctl is
meant to be used in the day-to-day (think scanning for a device, pairing
with it, changing the discoverability, etc); hciconfig/hcitool are more for
development/debugging (think disabling SSP mode, enabling periodic inquiry,
etc), they are more similar to btmgmt than to bluetoothctl.

> 
> What are the advantages of btmon over hcidump ?

btmon also tracks events from the Management interface. And colors ;-)

> 
> 
> Regards,
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
-- 
Vinicius
