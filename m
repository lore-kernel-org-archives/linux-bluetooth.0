Return-Path: <cyrus@holtmann.org>
Date: Fri, 8 Jul 2011 18:41:36 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Bluetooth: Add support for returning the
 encryption key size
Message-ID: <20110708214136.GF21343@joana>
References: <1310160706-25913-1-git-send-email-vinicius.gomes@openbossa.org>
 <1310160706-25913-3-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310160706-25913-3-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-07-08 18:31:46 -0300]:

> This will be useful when userspace wants to restrict some kinds of
> operations based on the length of the key size used to encrypt the
> link.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/bluetooth.h |    1 +
>  net/bluetooth/l2cap_sock.c        |    4 ++++
>  2 files changed, 5 insertions(+), 0 deletions(-)

All applied now. Thanks.

	Gustavo
