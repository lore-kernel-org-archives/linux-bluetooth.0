Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Nov 2013 12:33:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/daemon: Save adapter name on complete event
Message-ID: <20131105103331.GC5001@x220.p-661hnu-f1>
References: <1383646128-8077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383646128-8077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tue, Nov 05, 2013, Andrei Emeltchenko wrote:
> Saving adapter name was missing from set name complete event.
> Refactor code to function and reuse it in both places where
> name is changed.
> ---
>  android/adapter.c |   21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)

Applied. Thanks.

Johan
