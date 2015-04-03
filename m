Return-Path: <cyrus@holtmann.org>
Message-ID: <551E717A.6040500@hurleysoftware.com>
Date: Fri, 03 Apr 2015 06:54:50 -0400
From: Peter Hurley <peter@hurleysoftware.com>
MIME-Version: 1.0
To: Frederic Danis <frederic.danis@linux.intel.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 3/5] Bluetooth: hci_uart: Add HCIUARTSETBAUDRATE ioctl
References: <1427985456-31536-1-git-send-email-frederic.danis@linux.intel.com> <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1427985456-31536-4-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/02/2015 10:37 AM, Frederic Danis wrote:
> This allows user space application to set final speed requested for UART
> device. UART port is open at init speed by user space application.

If userspace opened the tty and knows this is a UART, why can it not
use the for-purpose tty ioctls to change the line rate?

Regards,
Peter Hurley

