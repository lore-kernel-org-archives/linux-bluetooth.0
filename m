Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Nov 2013 17:15:11 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/ipc: Fix receiving file descriptors
Message-ID: <20131107151511.GF23283@x220.p-661hnu-f1>
References: <1383835898-30110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383835898-30110-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Nov 07, 2013, Andrei Emeltchenko wrote:
> It does make sense iterate over !NULL controll headers. This fixes
> the bug that file descriptors cannot be send over IPC.
> ---
>  android/hal-ipc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
