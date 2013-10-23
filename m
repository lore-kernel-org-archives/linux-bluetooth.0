Return-Path: <cyrus@holtmann.org>
Date: Wed, 23 Oct 2013 14:03:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Check that service is started
Message-ID: <20131023110331.GA9685@x220.p-661hnu-f1>
References: <1382523998-30722-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382523998-30722-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Oct 23, 2013, Andrei Emeltchenko wrote:
> Add check that we are able to start Bluetooth service in
> Android. If service is not started we should not try to connect to it.
> ---
>  android/hal-ipc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
