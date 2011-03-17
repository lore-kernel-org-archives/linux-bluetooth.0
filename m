Return-Path: <cyrus@holtmann.org>
Date: Thu, 17 Mar 2011 15:38:39 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/4] Bluetooth: mgmt: Add support for setting the local
 name
Message-ID: <20110317183839.GG2214@joana>
References: <1300278577-23068-1-git-send-email-johan.hedberg@gmail.com>
 <1300278577-23068-4-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1300278577-23068-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-03-16 14:29:37 +0200]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds a new set_local_name management command as well as a
> local_name_changed management event. With these user space can both
> change the local name as well as monitor changes to it by others.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  include/net/bluetooth/mgmt.h     |   10 +++++
>  net/bluetooth/hci_event.c        |    9 +++--
>  net/bluetooth/mgmt.c             |   75 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 92 insertions(+), 3 deletions(-)

Patch 3 and 4 applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
