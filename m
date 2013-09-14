Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 1/2] Bluetooth: Add synchronization train parameters reading support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379061602-8290-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 13 Sep 2013 18:36:59 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B11CCE59-BB64-4D3F-BFD8-CE2248734B9B@holtmann.org>
References: <1379061602-8290-1-git-send-email-johan.hedberg@gmail.com> <1379061602-8290-2-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds support for reading the synchronization train parameters
> for controllers that support the feature. Since the feature is
> detectable through the local features page 2, which is retreived only in
> stage 3 of the HCI init sequence, there is no other option than to add a
> fourth stage to the init sequence.
> 
> For now the patch doesn't yet add storing of the parameters, but it is
> nevertheless convenient to have around to see what kind of parameters
> various controllers use by default (analyzable e.g. with the btmon user
> space tool).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_core.c    | 15 ++++++++++++++-
> 2 files changed, 16 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

