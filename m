Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Jan 2011 14:44:44 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com
Subject: Re: [PATCH 5/5] Bluetooth: Fix race condition with conn->sec_level
Message-ID: <20110119164444.GC11083@joana>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
 <1295419012-25717-6-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295419012-25717-6-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-01-19 12:06:52 +0530]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> The conn->sec_level value is supposed to represent the current level of
> security that the connection has. However, by assigning to it before
> requesting authentication it will have the wrong value during the
> authentication procedure. To fix this a pending_sec_level variable is
> added which is used to track the desired security level while making
> sure that sec_level always represents the current level of security.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_conn.c         |    8 ++++++--
>  net/bluetooth/hci_event.c        |    9 +++++----
>  3 files changed, 12 insertions(+), 6 deletions(-)

I rebased my tree and now this patches applies. It is there now. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
