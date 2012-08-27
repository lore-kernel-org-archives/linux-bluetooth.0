Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Aug 2012 08:12:56 -0700
From: Gustavo Padovan <gustavo@padovan.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Fix sending a HCI Authorization Request
 over LE links
Message-ID: <20120827151256.GA8934@joana>
References: <1345768364-9546-1-git-send-email-vinicius.gomes@openbossa.org>
 <1345768364-9546-2-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1345768364-9546-2-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-08-23 21:32:44 -0300]:

> In the case that the link is already in the connected state and a
> Pairing request arrives from the mgmt interface, hci_conn_security()
> would be called but it was not considering LE links.
> 
> Reported-by: João Paulo Rechi Vita <jprvita@openbossa.org>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 4 ++++
>  1 file changed, 4 insertions(+)

Both patches have been applied to the bluetooth.git tree. Thanks.

	Gustavo
