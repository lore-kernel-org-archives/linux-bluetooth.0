Return-Path: <cyrus@holtmann.org>
Date: Sun, 4 Mar 2012 21:11:00 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jeff Hansen <x@jeffhansen.com>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] [input] Set up uinput device again, if it was previously
 closed.
Message-ID: <20120305051100.GA3721@x220>
References: <1330919059-5493-1-git-send-email-x@jeffhansen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1330919059-5493-1-git-send-email-x@jeffhansen.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jeff,

On Sun, Mar 04, 2012, Jeff Hansen wrote:
> If you connect a PS3 controller to bluetoothd as an input device, then
> take the batteries out of a PS3 controller, then put them back in and
> push a few buttons, it will eventually cause an error which causes the
> uinput socket to be closed. It will then re-connect to bluetoothd, but
> the uinput socket fd will be -1, so it needs to be set up again after
> the re-connect.
> 
> Signed-off-by: Jeff Hansen <x@jeffhansen.com>
> ---
>  input/fakehid.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

Thanks, the patch has been pushed upstream but there were a few minor
fixes I had to do before that. Firstly, we don't use signed-off-by for
user space patches. Then, a few stylistic issues with the code:

> +	if (old == NULL || old->uinput == -1) {

We usually use < 0 for testing for an invalid fd.

> +	if (old == NULL) {
>  		fake_hid->devices = g_list_append(fake_hid->devices, fake);
>  	}

Single-line branches do not need { }

Johan
