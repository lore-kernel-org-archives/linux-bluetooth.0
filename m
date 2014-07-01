Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2014 20:47:09 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Do not trigger background scanning when
 HCI_AUTO_OFF is set
Message-ID: <20140701174709.GA24989@t440s.P-661HNU-F1>
References: <1404235704-10483-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404235704-10483-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 01, 2014, Marcel Holtmann wrote:
> When a new controller is initialized, but not powered from userspace
> at the moment, the HCI_AUTO_OFF flag is still set. During this period,
> userspace might program device for auto-connection, but never power
> on the controller. In this case do not try to start background
> scanning and leave it for later to be started.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 1 +
>  1 file changed, 1 insertion(+)

Both patches have been applied to bluetooth-next. Thanks.

Johan
