Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH v4 1/3] Bluetooth: Introduce hci_req helper to abort a connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 22 Oct 2015 11:38:15 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B1F453DE-B737-4FE7-85BE-81521B88E4DD@holtmann.org>
References: <1445500179-5316-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several different places needing to make sure that a
> connection gets disconnected or canceled. The exact action needed
> depends on the connection state, so centralizing this logic can save
> quite a lot of code duplication.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.h |  4 ++
> 2 files changed, 97 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

