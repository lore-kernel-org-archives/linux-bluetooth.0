Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Jun 2011 14:56:08 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bluetooth-next v5 0/2] SMP Just Works implementation
Message-ID: <20110614175608.GB2613@joana>
References: <1308069462-31697-1-git-send-email-vinicius.gomes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308069462-31697-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-06-14 13:37:40 -0300]:

> Hi Gustavo,
> 
> These are the last two patches (15/16 and 16/16) that needed a
> rebase on top of your latest tree.
> 
> --
> Cheers,
> 
> 
> Vinicius Costa Gomes (2):
>   Bluetooth: Add support for SMP timeout
>   Bluetooth: Add key size checks for SMP
> 
>  include/net/bluetooth/l2cap.h |    3 ++
>  include/net/bluetooth/smp.h   |    3 ++
>  net/bluetooth/l2cap_core.c    |   74 ++++++++++++++++++++++++----------------
>  net/bluetooth/smp.c           |   68 ++++++++++++++++++++++++++++++-------
>  4 files changed, 105 insertions(+), 43 deletions(-)

Both patches applied. Thanks.

	Gustavo
