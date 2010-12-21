Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Dec 2010 17:02:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: Fix __hci_request synchronization for
 hci_open_dev
Message-ID: <20101221150258.GA25824@jh-x301>
References: <1292590111-6564-1-git-send-email-johan.hedberg@gmail.com>
 <1292942802.2658.49.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1292942802.2658.49.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Dec 21, 2010, Marcel Holtmann wrote:
> just for style consistency add an empty line before this command.

Sure.

> And actually hci_init_req is not the only function where you would need
> to add hdev->req_last_cmd entries. There are hci_reset_req and some
> others. Without that, the rest of your patch makes hci_req_complete a
> non functional operation.

Actually no, if req_last_cmd is 0 (which it is in all cases except
hci_init_req) then the comparison is not done:

> +	if (hdev->req_last_cmd && cmd != hdev->req_last_cmd)
> +		return;

I did this to keep the patch simple and to not have to change all the
single HCI command cases. I.e. only multi-HCI command requests need to
set this variable.

Johan
