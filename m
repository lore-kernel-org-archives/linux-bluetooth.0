Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jun 2011 14:29:29 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Fix L2CAP security check
Message-ID: <20110613172929.GB2661@joana>
References: <1307968655-11289-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1307968655-11289-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-06-13 15:37:35 +0300]:

> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> With older userspace versions (using hciops) it might not have the
> key type to check if the key has sufficient security for any security
> level so it is necessary to check the return of hci_conn_auth to make
> sure the connection is authenticated
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Acked-by: Johan Hedberg <johan.hedberg@intel.com>

Applied, thanks.

	Gustavo
