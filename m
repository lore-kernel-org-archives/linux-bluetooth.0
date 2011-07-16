Return-Path: <cyrus@holtmann.org>
Date: Sat, 16 Jul 2011 10:15:18 -0700 (PDT)
Message-Id: <20110716.101518.1007939482226184514.davem@davemloft.net>
To: padovan@profusion.mobi
Cc: linville@tuxdriver.com, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: Fix regressions for 3.0
From: David Miller <davem@davemloft.net>
In-Reply-To: <1310790621-28510-1-git-send-email-padovan@profusion.mobi>
References: <1310790621-28510-1-git-send-email-padovan@profusion.mobi>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>
Date: Sat, 16 Jul 2011 01:30:19 -0300

> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> 
> Gustavo F. Padovan (1):
>   Bluetooth: Fix regression in L2CAP connection procedure
> 
> Ilia Kolomisnky (1):
>   Bluetooth: Fix crash with incoming L2CAP connections
> 
>  net/bluetooth/l2cap_core.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)

John I'm going to apply these directly so I can get them to
Linus in time for 3.0-final.

Thanks Gustavo.
