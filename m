Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 13 Jun 2013 10:08:08 +0200
Message-ID: <CANT-zCUJ8nn+=X3DdviN=yw52ogWgzO2fFnDP4+vCZQb=oyOzQ@mail.gmail.com>
Subject: Re: [RFC v2 0/2] SSP MITM protection for General Bonding
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 30, 2013 at 11:26 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> I'm reworking Timo's patch originally submitted as "[RFC] Bluetooth: Fix missing MITM protection when being responding LM".
>
> The proposal is to use MITM protection for General Bonding exactly as for Dedicated Bonding (patch 2/2). I can't think of any reason why the current implementation has different policies, leading to not using MITM protection for General Bonding even if the I/O capabilities make it possible.
>
> The proposal is therefore to make both bonding types equal.
>
> Another alternative would be to toggle this behavior through a mgmt API setting.
>
> Mikel Astiz (1):
>   Bluetooth: Use defines instead of integer literals
>
> Timo Mueller (1):
>   Bluetooth: Use MITM protection when responding LM
>
>  net/bluetooth/hci_event.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
>
> --
> 1.8.1.4
>

Ping.
