Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Sep 2010 17:51:33 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Briglia <anderson.briglia@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Bluetooth: Implement LE Set Scan Enable cmd
Message-ID: <20100927205133.GG5489@vigoh>
References: <1284384122-8393-1-git-send-email-anderson.briglia@openbossa.org>
 <1284384122-8393-2-git-send-email-anderson.briglia@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284384122-8393-2-git-send-email-anderson.briglia@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

* Anderson Briglia <anderson.briglia@openbossa.org> [2010-09-13 09:22:02 -0400]:

> This patch implements LE Set Scan Enable command for dual
> mode and Low Energy hci controllers. It also adds new HCI flags
> in order to indicate the LE Scanning state for userland applications
> and kernel itself.
> 
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci.h |    5 +++++
>  net/bluetooth/hci_event.c   |   27 +++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+), 0 deletions(-)

Both patches have been applied to my bluetooth-next-2.6 tree.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
