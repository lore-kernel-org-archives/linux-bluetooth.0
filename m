Return-Path: <cyrus@holtmann.org>
Date: Thu, 3 May 2012 03:43:04 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Bluetooth: Enable Low Energy support by default
Message-ID: <20120503064304.GH16030@joana>
References: <1336021951-19413-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336021951-19413-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2012-05-03 07:12:31 +0200]:

> The Bluetooth Low Energy support so far was disabled by default via
> a module parameter. With this change the module parameter will be removed
> and Low Energy is enabled by default.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  include/net/bluetooth/hci.h |    1 -
>  net/bluetooth/hci_event.c   |    2 +-
>  net/bluetooth/mgmt.c        |   12 +++---------
>  3 files changed, 4 insertions(+), 11 deletions(-)

Patch has been applied to bluetooth-next. thanks.

	Gustavo
