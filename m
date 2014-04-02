Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jim Hollister <jim.hollister@allure-energy.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Need advice: bluez on older Linux kernel?
Date: Wed, 02 Apr 2014 18:27:25 +0200
Message-ID: <4703706.SxBd8VXgKP@athlon>
In-Reply-To: <CF61A08A.5BFD%jim.hollister@allure-energy.com>
References: <CF61A08A.5BFD%jim.hollister@allure-energy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jim,

On Wednesday 02 April 2014 11:10:02 Jim Hollister wrote:
> I need to add Bluetooth Low Energy (BLE) capability to an ARM-based embedded
> system that's currently based on Ubuntu Lucid 11.04 and Linux kernel
> 2.6.35. I've read that BLE support in bluez requires Linux kernel version
> 3.5 or later. At this point, I think this leaves me with four options:
> 
> A) Upgrade the embedded system to a recent Linux kernel >= 3.5
> B) Backport the most recent bluez to run on Linux kernel 2.6.35
> C) Combine both approaches A and C, so that the embedded system and bluez
> meet at a kernel version somewhere between 2.6.35 and 3.5
> D) Find a different BLE stack that will run on Linux kernel 2.6.35. I see a
> number of those described at
> http://en.wikipedia.org/wiki/Bluetooth_stack#Embedded_implementations
> 
> I would much prefer to use bluez, but I'm concerned about the effort
> involved in upgrading the embedded system, and I don't know anything about
> the feasibility of backporting bluez. Would some kind and knowledgeable
> person please give me some advice or an opinion about how I should approach
> this?

I suggest using backports project [1] to update Linux Bluetooth subsystem in 
kernel. Also best would be to use latest available release.

[1] http://backports.wiki.kernel.org

-- 
Szymon K. Janc
szymon.janc@gmail.com
