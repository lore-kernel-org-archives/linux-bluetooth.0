Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH V2 net-next] Bluetooth: fix shadow warning in hci_disconnect()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1414226938-7478-1-git-send-email-fabf@skynet.be>
Date: Sat, 25 Oct 2014 09:57:33 -0700
Cc: linux-kernel@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <336B40DB-747D-40B8-B418-16DF5F9AC619@holtmann.org>
References: <1414226938-7478-1-git-send-email-fabf@skynet.be>
To: Fabian Frederick <fabf@skynet.be>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabian,

> use clkoff_cp for hci_cp_read_clock_offset instead of cp
> (already defined above).
> 
> Suggested-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
> V2: use clkoff_cp instead of cpr (suggested by Marcel Holtmann)
> 
> net/bluetooth/hci_conn.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

