Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v1] Bluetooth: Fix potential memory leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1508909328-14529-1-git-send-email-jaganathx.kanakkassery@intel.com>
Date: Sun, 29 Oct 2017 14:07:39 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Message-Id: <1E0D420A-7A55-4947-BFFF-6547A67B741F@holtmann.org>
References: <1508909328-14529-1-git-send-email-jaganathx.kanakkassery@intel.com>
To: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

> If command is added to req then it should be freed in case if
> hdev is down or HCI_ADVERTISING flag is set.
> 
> This introduces a helper in hci_request to purge the cmd_q
> to make cmd_q internal to hci_request which is used to fix
> the leak.
> 
> This also replace accessing of cmd_q in hci_ccnn with the
> new helper.
> 
> Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
> ---
> net/bluetooth/hci_conn.c    | 2 +-
> net/bluetooth/hci_request.c | 5 +++++
> net/bluetooth/hci_request.h | 1 +
> net/bluetooth/mgmt.c        | 1 +
> 4 files changed, 8 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

