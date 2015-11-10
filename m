Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 2/3] Bluetooth: Move synchronous request handling into hci_request.c
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1447141495-31126-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 10 Nov 2015 18:16:05 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8A969970-4B13-4714-99D5-BCEEB7BA40A0@holtmann.org>
References: <1447141495-31126-1-git-send-email-johan.hedberg@gmail.com> <1447141495-31126-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> hci_request.c is a more natural place for the synchronous request
> handling. Furthermore, we will soon need access to some of the
> previously private-to-hci_core.c functions from hci_request.c.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_core.c    | 193 --------------------------------------------
> net/bluetooth/hci_request.c | 184 +++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.h |  11 +++
> 3 files changed, 195 insertions(+), 193 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

