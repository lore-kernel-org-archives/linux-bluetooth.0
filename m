Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC v3 2/4] Bluetooth: Move LE event mask setting into init3 phase
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404249011-23645-2-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 1 Jul 2014 23:36:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B29F21FD-BDB9-4CCB-A19A-08B434B0D628@holtmann.org>
References: <1404249011-23645-1-git-send-email-andre.guedes@openbossa.org> <1404249011-23645-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> During init2 phase, the LE local features have not be read yet so
> we aren't able to rely on hdev->le_features to determine if the
> controller supports the Connection Parameters Request Procedure.
> 
> For that reason, this patch moves LE event mask setting from init2
> into init3 initialization phase.
> 
> The hdev->le_features mask will be checked by the next patch in order
> to know if "LE Remote Connection Parameter Request Event" should be
> enabled.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_core.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

