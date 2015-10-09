Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5617D2FA.1020108@linux.intel.com>
References: <1444136920-17969-1-git-send-email-frederic.danis@linux.intel.com>
	<20151006135503.GA13250@kroah.com>
	<5613D968.7000505@linux.intel.com>
	<5617D2FA.1020108@linux.intel.com>
Date: Fri, 9 Oct 2015 12:09:21 -0300
Message-ID: <CAOMZO5BaXzwMGhdOOLLJU1f37HsmH3309MG5qBEmKubL=kPn_A@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "serial: 8250_dma: don't bother DMA with small transfers"
From: Fabio Estevam <festevam@gmail.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, andriy.shevchenko@linux.intel.com,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>,
	linux-bluetooth@vger.kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Oct 9, 2015 at 11:45 AM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:

> This is first time for me that patch may be applied to previous kernel.
>
> Is there something specific I should do to allow this patch to be applied
> and backported to 4.0 and newer ?

You can find the instructions at Documentation/stable_kernel_rules.txt
