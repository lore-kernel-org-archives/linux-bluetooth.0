Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Dec 2011 14:07:58 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Make HCI call directly into SCO and L2CAP
 event functions
Message-ID: <20111222160758.GB2730@joana>
References: <1324469493-1949-1-git-send-email-ulisses@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324469493-1949-1-git-send-email-ulisses@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

* Ulisses Furquim <ulisses@profusion.mobi> [2011-12-21 10:11:33 -0200]:

> The struct hci_proto and all related register/unregister and dispatching
> code was removed. HCI core code now call directly the SCO and L2CAP
> event functions.
> 
> Signed-off-by: Ulisses Furquim <ulisses@profusion.mobi>
> ---
>  include/net/bluetooth/hci_core.h |  138 ++++++++++++++++----------------------
>  net/bluetooth/hci_core.c         |   59 +---------------
>  net/bluetooth/l2cap_core.c       |   51 ++------------
>  net/bluetooth/sco.c              |   38 +---------
>  4 files changed, 74 insertions(+), 212 deletions(-)

Patch has been applied, thanks.

	Gustavo
