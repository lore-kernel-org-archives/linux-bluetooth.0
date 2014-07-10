Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Jul 2014 14:59:18 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Mark controller is down when HCI_AUTO_OFF
 is set
Message-ID: <20140710115918.GA10018@t440s.P-661HNU-F1>
References: <1404991057-55075-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404991057-55075-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Jul 10, 2014, Marcel Holtmann wrote:
> During the initial setup phase, the controller is powered on and will
> be powered off again if it is not used within the auto-off timeout.
> 
> Userspace using ioctl does not know about the difference between the
> initial setup phase and a controller being present. It is a bad idea
> to keep the controller powered by just looking at the device list or
> device information. Instead just tell userspace that the controller
> is still down.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 25 +++++++++++++++++++------
>  1 file changed, 19 insertions(+), 6 deletions(-)

Applied to bluetooth-next. Thanks.

Johan
