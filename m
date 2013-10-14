Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 18:30:35 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/4] Initial patches splitted
Message-ID: <20131014153035.GA26449@x220.p-661hnu-f1>
References: <1381485723-15898-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381485723-15898-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Oct 11, 2013, Andrei Emeltchenko wrote:
> This is small chunk form my previous patch series splitted for easy review.
> I need to understand what is current coding style for our project, so far it seems
> very different from BlueZ I took as example first. Please comment.
> 
> Changes:
> 	* PATCHv2: removed unused function
> 
> Andrei Emeltchenko (4):
>   android: Add Adapter Bluetooth HAL template
>   android: Add Socket Bluetooth HAL template
>   android: Enable Socket interface
>   android: Start Android Bluetooth daemon
> 
>  android/Android.mk      |   20 +++
>  android/hal.h           |   18 +++
>  android/hal_bluetooth.c |  384 +++++++++++++++++++++++++++++++++++++++++++++++
>  android/hal_bt_sock.c   |   85 +++++++++++
>  4 files changed, 507 insertions(+)
>  create mode 100644 android/hal.h
>  create mode 100644 android/hal_bluetooth.c
>  create mode 100644 android/hal_bt_sock.c

All four patches have been applied to bluez.git.

Johan
