Return-Path: <cyrus@holtmann.org>
Date: Wed, 24 Oct 2012 11:22:34 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND net-next] bluetooth: hci_core: Replace
 list_for_each with list_for_each_entry() helper
Message-ID: <20121024132234.GG13884@joana>
References: <1350912121-24171-1-git-send-email-kirjanov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350912121-24171-1-git-send-email-kirjanov@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Denis,

* Denis Kirjanov <kirjanov@gmail.com> [2012-10-22 17:22:01 +0400]:

> Replace list_for_each with list_for_each_entry() helper
> 
> Signed-off-by: Denis Kirjanov <kirjanov@gmail.com>
> ---
>  include/net/bluetooth/hci_core.h |   20 ++++++++------------
>  1 files changed, 8 insertions(+), 12 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
