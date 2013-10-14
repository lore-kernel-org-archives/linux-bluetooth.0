Return-Path: <cyrus@holtmann.org>
Date: Mon, 14 Oct 2013 19:32:22 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Read current IAC LAP on controller setup
Message-ID: <20131014223222.GD2305@joana>
References: <1381784796-52321-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1381784796-52321-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-10-14 Marcel Holtmann <marcel@holtmann.org>:

> Read the current IAC LAP values when initializing the controller. The
> values are not used, but it is good to have them in the trace files
> for debugging purposes.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h | 2 ++
>  net/bluetooth/hci_core.c    | 3 +++
>  2 files changed, 5 insertions(+)

Both patches have been pushed to bluetooth-next. Thanks.

	Gustavo
