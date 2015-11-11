Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v3 2/2] Bluetooth: Move Stop Discovery to req_workqueue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447223445-11635-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 11 Nov 2015 15:32:59 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C3475AEF-4CC0-4B5B-A849-A5803E438191@holtmann.org>
References: <1447223445-11635-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Since discovery also deals with LE scanning it makes sense to move it
> behind the same req_workqueue as other LE scanning changes. This also
> simplifies the logic since we do many of the actions in a synchronous
> manner.
> 
> Part of this refactoring is moving hci_req_stop_discovery() to
> hci_request.c. At the same time the function receives support for
> properly handling the STOPPING state since that's the state we'll be
> in when stopping through the req_workqueue.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_request.c      | 62 ++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.h      |  3 ++
> net/bluetooth/mgmt.c             | 72 +++-------------------------------------
> 4 files changed, 71 insertions(+), 67 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

