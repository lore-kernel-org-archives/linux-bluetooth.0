Return-Path: <cyrus@holtmann.org>
Date: Mon, 23 Apr 2012 10:05:11 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 2/2] Bluetooth: Add support for reusing the same hci_conn
 for LE links
Message-ID: <20120423130511.GB18564@joana>
References: <1334947568-3437-1-git-send-email-jprvita@openbossa.org>
 <1334947568-3437-2-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1334947568-3437-2-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João,

* João Paulo Rechi Vita <jprvita@openbossa.org> [2012-04-20 15:46:08 -0300]:

> From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> 
> As most LE devices leave advertising mode when they enter the connected
> state, we may want to "pass" that connection to other users.
> 
> The first user will be the pairing procedure, the connection is
> established without an associated socket, after the pairing is
> complete, userspace may want to discover via GATT what services the
> newly bonded device has.
> 
> If userspace establishes the connection while the timeout still
> hasn't expired, the connection will be re-used.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> Tested-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c   |   32 ++++++++++++----------
>  net/bluetooth/l2cap_core.c |   63 ++++++++++++++++++++++++++++----------------
>  2 files changed, 58 insertions(+), 37 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
