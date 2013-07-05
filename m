Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jul 2013 12:00:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 0/6] emulator: add LE advertising and scanning
 support
Message-ID: <20130705090014.GA2981@x220.p-661hnu-f1>
References: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372884896-11419-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Wed, Jul 03, 2013, Jefferson Delfes wrote:
> In order to write discovery tests for LE, we need some implementation
> on emulator side.
> This patch series basically reports virtual devices in adv mode for
> devices in scan mode.
> 
> This new series was reorganized by merging some commits and removing
> others not related to discovery tests. Note that this is just a first
> set, based on a RFC sent a while ago by Bruna Moreira. Future patches
> will build on these patches.
> 
> Jefferson Delfes (6):
>   emulator: Store LE advertising data length in btdev
>   emulator: Implement basic LE set adv enable command
>   emulator: Store LE scan state of virtual controller
>   emulator: Disallow LE set scan params command when scan is enabled
>   emulator: Dummy LE set advertising parameters
>   emulator: Implement LE advertising report
> 
>  emulator/btdev.c | 102 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  monitor/bt.h     |  13 +++++++
>  2 files changed, 113 insertions(+), 2 deletions(-)

All patches in this set have been applied. Thanks.

Johan
