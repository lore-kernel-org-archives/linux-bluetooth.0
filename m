Return-Path: <cyrus@holtmann.org>
Date: Wed, 27 Apr 2011 18:54:33 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: anderson.briglia@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: Add discovering event to the
 Management interface
Message-ID: <20110427215433.GB2328@joana>
References: <y>
 <4db82875.624dec0a.70bd.226a@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4db82875.624dec0a.70bd.226a@mx.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* anderson.briglia@openbossa.org <anderson.briglia@openbossa.org> [2011-04-27 10:29:57 -0400]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds a new event to the Management interface to track when
> local adapters are discovering remote devices. For now this only tracks
> BR/EDR discovery procedures.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/mgmt.h     |    2 +
>  net/bluetooth/hci_event.c        |   40 ++++++++++++++++++++++++++++++++-----
>  net/bluetooth/mgmt.c             |    6 +++++
>  4 files changed, 43 insertions(+), 6 deletions(-)

Both applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
