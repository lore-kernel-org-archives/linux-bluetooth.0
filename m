Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/3] Bluetooth: Pass initiator/acceptor information to hci_conn_security()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 14:42:28 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C2A380EF-B277-4939-AC50-E244BC01AB32@holtmann.org>
References: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We're interested in whether an authentication request is because of a
> remote or local action. So far hci_conn_security() has been used both
> for incoming and outgoing actions (e.g. RFCOMM or L2CAP connect
> requests) so without some modifications it cannot know which peer is
> responsible for requesting authentication.
> 
> This patch adds a new "bool initiator" parameter to hci_conn_security()
> to indicate which side is responsible for the request and updates the
> current users to pass this information correspondingly.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  3 ++-
> include/net/bluetooth/l2cap.h    |  2 +-
> net/bluetooth/hci_conn.c         |  3 ++-
> net/bluetooth/l2cap_core.c       | 15 ++++++++-------
> net/bluetooth/l2cap_sock.c       |  2 +-
> net/bluetooth/mgmt.c             |  2 +-
> net/bluetooth/rfcomm/core.c      |  3 ++-
> 7 files changed, 17 insertions(+), 13 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

