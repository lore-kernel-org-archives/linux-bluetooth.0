Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Dec 2013 10:52:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix possible NULL dereference
Message-ID: <20131223085258.GA11122@x220.p-661hnu-f1>
References: <1387787331-8405-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387787331-8405-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Dec 23, 2013, Andrei Emeltchenko wrote:
> value is checked for NULL and later is dereferenced if we do not return.
> ---
>  android/android-tester.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied. Thanks.

Johan
