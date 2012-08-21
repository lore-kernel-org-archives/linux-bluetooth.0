Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Aug 2012 14:38:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix establishing ESCO links
Message-ID: <20120821173848.GC17005@joana>
References: <1345250279-32158-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1345250279-32158-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-08-17 21:37:59 -0300]:

> Commit 4cd2d98340b4f03d5532c30fdaeb451b035429cb "Bluetooth: Simplify
> the connection type handling" broke the creation of ESCO links.
> 
> This patch adds a type parameter to hci_connect_sco() so it creates
> the connection of the right kind.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  net/bluetooth/hci_conn.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
