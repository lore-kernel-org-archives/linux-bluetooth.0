Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Apr 2011 18:49:05 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] Bluetooth: Add mgmt_device_found event
Message-ID: <20110404214905.GE2230@joana>
References: <AANLkTinxPChXddNN_8Qzv4xxBBhvhpzgFD=qk4eKhcVS@mail.gmail.com>
 <1301518636-25086-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301518636-25086-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2011-03-30 23:57:16 +0300]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> This patch adds a device_found event to the Management interface. For
> now the event only maps to BR/EDR inquiry result HCI events, but in the
> future the plan is to also use it for the LE device discovery process.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
> v2: comments from Lizardo taken into account
> 
>  include/net/bluetooth/hci_core.h |    2 ++
>  include/net/bluetooth/mgmt.h     |    8 ++++++++
>  net/bluetooth/hci_event.c        |   22 ++++++++++++++--------
>  net/bluetooth/mgmt.c             |   17 +++++++++++++++++
>  4 files changed, 41 insertions(+), 8 deletions(-)

Both patches were applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
