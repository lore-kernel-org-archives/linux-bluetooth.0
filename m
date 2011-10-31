Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 31 Oct 2011 17:46:59 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH 2/2] Bluetooth: Make hci_unregister_dev return void
Message-ID: <20111031194659.GI10164@joana>
References: <1319618599-10938-1-git-send-email-dh.herrmann@googlemail.com>
 <1319618599-10938-2-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319618599-10938-2-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

* David Herrmann <dh.herrmann@googlemail.com> [2011-10-26 10:43:19 +0200]:

> hci_unregister_dev cannot fail and always returns 0. The drivers already ignore
> the return value so we can safely make it return void.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |    4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)

Nice work, both patches have been applied. Thanks.

	Gustavo
