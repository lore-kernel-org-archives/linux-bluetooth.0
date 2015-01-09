Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jan 2015 12:26:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v6 2/3] Bluetooth: Add le_scan_restart
Message-ID: <20150109102628.GA19211@t440s.lan>
References: <1420636254-25626-1-git-send-email-jpawlowski@google.com>
 <1420636254-25626-2-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420636254-25626-2-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wed, Jan 07, 2015, Jakub Pawlowski wrote:
> -		cancel_delayed_work(&hdev->le_scan_disable);
> +		if (!bt_cb(hdev->sent_cmd)->req.marker)
> +			cancel_delayed_work(&hdev->le_scan_disable);
>  
>  		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);

Modifying the generic HCI request framework for this single purpose
doesn't make much sense to me. Also, the details of the bt_cb(skb)->req
struct are considered an implementation detail of the HCI request
specific handling and should not be directly touched by other code.

It looks to me like this marker has the same purpose as the flag you had
in some earlier revision of this set? For such a use-case a flag would
still be the best option. However, I'm wondering whether we can remove
the need for this completely. Can't you just let the code cancel the
delayed work and the re-schedule it again once the scanning gets
re-enabled (with some extra code decrease the timeout some appropriate
amount for each time scanning gets restarted).

Johan
