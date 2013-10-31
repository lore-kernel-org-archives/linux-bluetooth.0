Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 Oct 2013 15:46:17 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC] android/daemon: Fix not reporting scan mode to Java
Message-ID: <20131031134617.GB21600@x220.p-661hnu-f1>
References: <1383223355-4628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1383223355-4628-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Thu, Oct 31, 2013, Andrei Emeltchenko wrote:
> After set_adapter_property() higher layer expects callback to be returned
> even if property is not changes. Otherwise Java timeouts and reset Bluetooth
> enetring to the loop.
> ...
> BluetoothAdapterState( 2850): Timeout will setting scan mode..
>   Continuing with disable...
> ...
> ---
>  android/adapter.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
