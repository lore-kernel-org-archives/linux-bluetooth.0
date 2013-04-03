Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365016283-25647-2-git-send-email-johan.hedberg@gmail.com>
References: <1365016283-25647-1-git-send-email-johan.hedberg@gmail.com>
	<1365016283-25647-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 3 Apr 2013 15:25:03 -0400
Message-ID: <CAJdJm_OnCu+H0Mrtc+Zo30KxrPEaMcHUha_SRed=gEhaJv3vAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add support for custom event terminated commands
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 3, 2013 at 3:11 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> -       hci_req_cmd_complete(hdev, opcode, ev->status);
> +       if (ev->status ||
> +           ((hdev->sent_cmd && !bt_cb(hdev->sent_cmd)->req.event)))
> +               hci_req_cmd_complete(hdev, opcode, ev->status);

Any reason for the double parenthesis after || ?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
