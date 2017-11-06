Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH V2 BlueZ 0/3] android: Add LE Peripheral role support
Date: Mon, 06 Nov 2017 10:25:38 +0100
Message-ID: <15896219.XAmZNPQUIj@ix>
In-Reply-To: <20171013140204.19524.68439.stgit@localhost>
References: <20171013140204.19524.68439.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Martin,

On Friday, 13 October 2017 16:02:04 CET Martin Fuzzey wrote:
> This series adds a few missing pieces for Peripheral role support on Android
> 5.
> 
> This has been tested in the following configuration:
> - Android 5.1.1
> - Kernel 4.4
> - nRF52 chip running Apache Newt firmware
> 
> Changes for V2:
> - Only load keys if BRDE supported rather than always trying and ignoring
> error - Use the bt_ad_* helper functions rather than open coding
> advertisement data - free_adv_instance() accepts NULL like the other free
> family members - Style fixes
> - Remove SOBs
> 

All patches applied, thanks.
Note that I had to fix last patch to build on Fedora (print formatters).

-- 
pozdrawiam
Szymon Janc
