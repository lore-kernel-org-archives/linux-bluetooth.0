Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Feb 2013 14:41:01 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/3] Bluetooth: Rename hci_acl_disconn
Message-ID: <20130220174101.GA6820@joana>
References: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
 <1359557457-10199-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359557457-10199-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2013-01-30 11:50:56 -0300]:

> As hci_acl_disconn function basically sends the HCI Disconnect Command
> and it is used to disconnect ACL, SCO and LE links, renaming it to
> hci_disconnect is more suitable.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h | 2 +-
>  net/bluetooth/hci_conn.c         | 4 ++--
>  net/bluetooth/hci_core.c         | 2 +-
>  net/bluetooth/hci_event.c        | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
