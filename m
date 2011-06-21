Return-Path: <cyrus@holtmann.org>
Date: Wed, 22 Jun 2011 00:27:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Add extfeatures to struct hci_dev
Message-ID: <20110621205505.GA8124@dell.ger.corp.intel.com>
References: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1308686870-26101-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi André,

On Tue, Jun 21, 2011, Andre Guedes wrote:
> @@ -224,6 +225,11 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
>  	/* Read Local Supported Features */
>  	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
>  
> +	/* Read Local Extended Features */
> +	ext_cp.page = 0x01;
> +	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_EXT_FEATURES, sizeof(ext_cp),
> +								&ext_cp);

Since the extended features command is only available from 1.2 onwards I
don't think it's right to unconditionally send it in hci_init_req.
Instead, you should probably be checking for the feature bit in the
(non-extended) feature mask, i.e. in the command complete callback for
HCI_Read_Local_Features and only send the command if the feature bit is
set.

Johan
