Return-Path: <cyrus@holtmann.org>
Message-ID: <5527CEFB.5070406@hurleysoftware.com>
Date: Fri, 10 Apr 2015 09:24:11 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>,
	gregkh@linuxfoundation.org
CC: linux-serial@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	jslaby@suse.cz
Subject: Re: [PATCH] tty: Re-add external interface for tty_set_termios()
References: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428671585-13310-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/10/2015 09:13 AM, Frederic Danis wrote:
> This is needed by Bluetooth hci_uart module to be able to change speed
> of Bluetooth controller and local UART.

Because this is the lesser evil right now,

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>

