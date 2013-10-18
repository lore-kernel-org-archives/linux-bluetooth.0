Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v2] Bluetooth: Fix ATT socket backwards compatibility with user space
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382086165-24818-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 18 Oct 2013 10:54:36 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DFBB1BB8-22BD-4E0E-AA9A-B1B786A38370@holtmann.org>
References: <1382086165-24818-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Old user space versions bind the Attribute Protocol socket to
> BDADDR_BREDR when they should be using BDADDR_LE_PUBLIC or
> BDADDR_LE_RANDOM. The kernel recently introduced stricter checks on the
> socket parameters but we need to punch this hole for old user space
> versions to keep them working.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_sock.c | 27 +++++++++++++++++++++++++--
> 1 file changed, 25 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

