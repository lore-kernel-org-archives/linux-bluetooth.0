Return-Path: <cyrus@holtmann.org>
Date: Fri, 3 Jan 2014 15:48:22 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix NULL dereference in socket setup
Message-ID: <20140103134822.GB10605@x220.p-661hnu-f1>
References: <1388744774-17418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1388744774-17418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jan 03, 2014, Andrei Emeltchenko wrote:
> Add return statement to avoid NULL dereference in socket setup.
> ---
>  android/android-tester.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied. Thanks.

Johan
