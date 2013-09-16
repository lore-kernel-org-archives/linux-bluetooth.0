Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v5 5/8] Bluetooth: Fix L2CAP command reject reason
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1379325919-19003-6-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 16 Sep 2013 09:11:08 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7EDE5489-018A-4FE9-941F-41BF8841944E@holtmann.org>
References: <1379325919-19003-1-git-send-email-johan.hedberg@gmail.com> <1379325919-19003-6-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> There are several possible reason codes that can be sent in the command
> reject L2CAP packet. Before this patch the code has used a hard-coded
> single response code ("command not understood"). This patch adds a
> helper function to map the return value of an L2CAP handler function to
> the correct command reject reason.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 20 ++++++++++++++++----
> 1 file changed, 16 insertions(+), 4 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

