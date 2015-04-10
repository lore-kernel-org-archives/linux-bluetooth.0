Return-Path: <cyrus@holtmann.org>
Message-ID: <5527BE7D.4040303@hurleysoftware.com>
Date: Fri, 10 Apr 2015 08:13:49 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>
CC: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [Patch] tty: Re-add external interface for tty_set_termios()
References: <1428055395-10648-1-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428055395-10648-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/03/2015 06:03 AM, Frederic Danis wrote:
> This is a partial revert of patch "tty: Remove external interface for
> tty_set_termios()" from Peter Hurley (2015-01-25 SHA1 632f32e2107) to
> set tty_set_termios() publicly available.
> 
> This will be needed by Bluetooth hci_uart module to be able to change
> Bluetooth controller and local UART speed during vendor specific
> initialization.

Please resend to tty maintainers (and cc me).
