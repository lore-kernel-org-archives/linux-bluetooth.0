Return-Path: <cyrus@holtmann.org>
Date: Wed, 16 Nov 2011 16:33:17 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Pass all message parameters to
 mgmt_start_discovery
Message-ID: <20111116183317.GH16865@joana>
References: <1321091515-6543-1-git-send-email-johan.hedberg@gmail.com>
 <1321091902-6815-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321091902-6815-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-11-12 11:58:22 +0200]:

> From: Johan Hedberg <johan.hedberg@intel.com>
> 
> The mgmt_start_discovery command contains the type of discovery that
> should be started so this should be passed to the start_discovery
> function. This patch doesn't yet add any action depending on the type of
> the requested discovery.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Fix stupid copy-paste error with the MGMT_OP in case of an invalid
> message length.
> 
>  include/net/bluetooth/mgmt.h |    3 +++
>  net/bluetooth/mgmt.c         |   10 ++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)

Applied, thanks.

	Gustavo
