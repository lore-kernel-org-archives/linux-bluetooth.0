Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH v2 2/2] Bluetooth: Don't treat connection timeout as a failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1449139520-950-2-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 5 Dec 2015 08:18:06 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FD9B6ADA-DAE3-47CD-A5B3-EFBE60717154@holtmann.org>
References: <1449139520-950-1-git-send-email-johan.hedberg@gmail.com> <1449139520-950-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When we're doing background scanning and connection attempts it's
> possible we timeout trying to connect and go back to scanning again.
> The timeout triggers a HCI_LE_Create_Connection_Cancel which will
> trigger a Connection Complete with "Unknown Connection Identifier"
> error status. Since we go back to scanning this isn't really a failure
> and shouldn't be presented as such to user space through mgmt.
> 
> The exception to this is if the connection attempt was due to an
> explicit request on an L2CAP socket (indicated by
> params->explicit_connect being true). Since the socket will get an
> error it's consistent to also notify the failure on mgmt in this case.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 12 ++++++++++--
> 1 file changed, 10 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

