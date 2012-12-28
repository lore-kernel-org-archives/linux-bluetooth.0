Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Dec 2012 10:08:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Kamil =?utf-8?B?Sm/FhGNh?= <kjonca@o2.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to pair device from CLI?
Message-ID: <20121228080842.GA28814@x220.P-661HNU-F1>
References: <871uebt47d.fsf@alfa.kjonca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <871uebt47d.fsf@alfa.kjonca>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kamil,

On Fri, Dec 28, 2012, Kamil Jońca wrote:
> I don't know if this is proper list, but I cannot find any (active)
> bluez users list. 
> 
> I tried to pair my phone:
> 
> --8<---------------cut here---------------start------------->8---
> $hcitool scan                         
> Scanning ...
>         D4:E8:B2:AA:15:FA       theta
> 
> $bluez-simple-agent hci0 D4:E8:B2:AA:15:FA
> RequestPasskey (/org/bluez/3086/hci0/dev_D4_E8_B2_AA_15_FA)
> Enter passkey: 0000
> Creating device failed: org.bluez.Error.AuthenticationFailed: Authentication Failed
> --8<---------------cut here---------------end--------------->8---

It's quite odd that you should get RequestPasskey. That's something that
should only happen if you're pretending to be a keyboard in which case
you should enter the passkey displayed on the remote device (your phone
in this case).

> What do I should check? (s)trace?
> 
> Distribution is pretty fresh debian sid.

The most useful too would be hcidump (bluez-hcidump package). The output
of hcidump -X for the full pairing process would be interesting.

Johan

