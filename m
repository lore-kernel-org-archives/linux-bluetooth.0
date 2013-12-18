Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 14:53:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/tester: Move Bluetooth HAL functions before
 socket HAL
Message-ID: <20131218125330.GA31383@x220.p-661hnu-f1>
References: <1387367677-8099-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387367677-8099-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, Dec 18, 2013, Grzegorz Kolodziejczyk wrote:
> This patch move bluetooth HAL test functions before socket
> HAL functions. This make it more readable for future test cases growth.
> ---
>  android/android-tester.c | 272 +++++++++++++++++++++++------------------------
>  1 file changed, 136 insertions(+), 136 deletions(-)

Both patches have been applied. Thanks.

Johan
