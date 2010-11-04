Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Nov 2010 14:41:34 +0000
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Daniel =?iso-8859-1?Q?=D6rstadius?= <daniel.orstadius@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix Maemo6 MCE: set state variable directly
Message-ID: <20101104144134.GA10230@jh-x301>
References: <AANLkTimpjr1Kc23zn=7uf0WNV5784ccPq8hWtBYrNADh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimpjr1Kc23zn=7uf0WNV5784ccPq8hWtBYrNADh@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Oct 20, 2010, Daniel Örstadius wrote:
> From: Daniel Orstadius <daniel.orstadius@nokia.com>
> Date: Wed, 20 Oct 2010 17:13:17 +0300
> Subject: [PATCH] Fix Maemo6 MCE: set state variable directly
> 
> If the state variable is not updated until mce_signal_callback and
> SetProperty(Powered) is called two times quickly, then the second
> call will not generate a request to change the radio state of the
> MCE if its corresponding call to adapter_powered occurs before the
> first triggering of mce_signal_callback.
> 
> With this patch two calls to the MCE are executed, although there
> might still be an unnecessary power cycle in that
> mce_signal_callback is also triggered twice.
> ---
>  plugins/maemo6.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)

This patch has been pushed upstream after an offline discussion which
concluded that it should be safe to ignore the method reply from MCE in
this case.

Johan
