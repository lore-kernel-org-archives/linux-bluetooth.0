Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1364997166-24236-3-git-send-email-johan.hedberg@gmail.com>
References: <1364997166-24236-1-git-send-email-johan.hedberg@gmail.com>
	<1364997166-24236-3-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 3 Apr 2013 13:12:40 -0400
Message-ID: <CAJdJm_PLDq1jh=0iUoUZfTZV_QXOuSCj3pSZWDZvon4tcEzUow@mail.gmail.com>
Subject: Re: [PATCH 2/2] Bluetooth: Add __hci_cmd_sync() helper function
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Apr 3, 2013 at 9:52 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> +       switch (hdev->req_status) {
> +       case HCI_REQ_DONE:
> +               err = -bt_to_errno(hdev->req_result);
> +               break;
> +
> +       case HCI_REQ_CANCELED:
> +               err = -hdev->req_result;
> +               break;
> +
> +       default:
> +               err = -ETIMEDOUT;
> +               break;
> +       }
> +
> +       hdev->req_status = hdev->req_result = 0;
> +
> +       BT_DBG("%s end: err %d", hdev->name, err);
> +
> +       if (err < 0)
> +               return ERR_PTR(err);

Isn't this always true (due to the switch() avove) ?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
