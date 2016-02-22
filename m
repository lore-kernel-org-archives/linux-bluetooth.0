Return-Path: <arend.vanspriel@broadcom.com>
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
Reply-To: arend@broadcom.com
Subject: Re: Broadcom BCM4324(1) rev B5 chipset - Bluetooth support in Linux
 Kernel 4.x ?
References: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
To: =?UTF-8?Q?J=c3=a9r=c3=b4me_de_Bretagne?= <jerome.debretagne@gmail.com>,
 marcel@holtmann.org
Cc: Ilya Faenson <ilya.faenson@broadcom.com>, linux-bluetooth@vger.kernel.org
Message-ID: <56CAD20D.4080609@broadcom.com>
Date: Mon, 22 Feb 2016 10:17:01 +0100
MIME-Version: 1.0
In-Reply-To: <CA+kEDGEHfsODon6aOdLU86E9c0Lfs-4bo=ycEZz3MdEa1qLrKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

+ Ilya
+ bt list

On 21-2-2016 15:17, Jérôme de Bretagne wrote:
> Hi,
>
> Since a commit from last April, the BCM4324(1) rev B5 chipset is
> supported in the Linux kernel and WiFi networking has been working
> like a charm on a Lenovo ThinkPad 8 tablet (running Linux
> 4.3.0-1-amd64 from Debian). A big "Thanks" for that.
>
> On the other hand, the Bluetooth part doesn't show up at all (empty
> result with hciconfig) and doesn't seem active with that same 4.3
> kernel. I don't even see any error message in dmesg about Bluetooth.
>
> bluetooth/btbcm.c mentions quite a few chipsets (UART/USB) but not the
> 4324 rev B5 so I'm not sure of the current Bluetooth status for that
> specific one. Is this chipset enabled for Bluetooth starting with
> Linux 4.4 or in the coming 4.5 version maybe? I couldn't check 4.4
> properly yet as this kernel version locks currently on my tablet (for
> other reasons).
>
> If it is not fully supported yet, feel free to ask any info that could
> help enable Bluetooth for this chipset on the ThinkPad 8 tablet!
>
> Thanks,
>
> Jérôme
>
>
> P.S. I guess the following page
> https://wireless.wiki.kernel.org/en/users/Drivers/brcm80211 could be
> updated to show that Wireless LAN is properly working.
