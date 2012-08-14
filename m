Return-Path: <cyrus@holtmann.org>
Date: Tue, 14 Aug 2012 12:13:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jefferson Delfes <jefferson.delfes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFC 4/5] Bluetooth: Add set broadcaster MGMT command
Message-ID: <20120814091317.GA1083@x220>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
 <1344632507-21381-5-git-send-email-jefferson.delfes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1344632507-21381-5-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jefferson,

On Fri, Aug 10, 2012, Jefferson Delfes wrote:
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -379,6 +379,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
>  	settings |= MGMT_SETTING_FAST_CONNECTABLE;
>  	settings |= MGMT_SETTING_DISCOVERABLE;
>  	settings |= MGMT_SETTING_PAIRABLE;
> +	settings |= MGMT_SETTING_BROADCASTER;

Shouldn't this be behind the same conditional as MGMT_SETTING_LE? I.e.
only when hdev->features indicates LE support.

Johan
