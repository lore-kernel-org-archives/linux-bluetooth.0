Return-Path: <cyrus@holtmann.org>
Date: Wed, 1 Jan 2014 18:30:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/7] android: Add HCI snooping tool
Message-ID: <20140101163017.GA19618@x220.p-661hnu-f1>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Dec 30, 2013, Szymon Janc wrote:
> This tool is intended to be run as Android service. It supports
> writing HCI snoop data in old btsnoop format only. By default traffic
> is stored in /sdcard/btsnoop_hci.log file (can be overridded with
> option - mainly for testing on Linux host). Only index 0 is sniffed.
> ---
>  .gitignore                 |   1 +
>  android/Android.mk         |  23 +++++
>  android/Makefile.am        |   6 ++
>  android/bluetoothd-snoop.c | 219 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 249 insertions(+)
>  create mode 100644 android/bluetoothd-snoop.c

All patches in this set have been applied. Thanks.

Johan
