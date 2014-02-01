Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC v6 00/14] LE auto connection and connection parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Date: Fri, 31 Jan 2014 17:17:32 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Message-Id: <186F0AA5-AF57-4590-B145-E142F0724126@holtmann.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch set implements the minor changes suggested by Johan on the
> previous version.
> 
> The changes are:
>    - Rename fail_conn_attempt() to le_conn_failed()
>    - Create create_le_conn_req() helper to avoid duplicated code
> 
> Regards,
> 
> Andre
> 
> 
> Andre Guedes (14):
>  Bluetooth: Save connection interval parameters in hci_conn
>  Bluetooth: Group list_head fields from strcut hci_dev together
>  Bluetooth: Introduce connection parameters list
>  Bluetooth: Use connection parameters if any
>  Bluetooth: Introduce le_conn_failed() helper
>  Bluetooth: Stop scanning on LE connection
>  Bluetooth: Remove unused function
>  Bluetooth: Introduce hdev->pend_le_conn list
>  Bluetooth: Introduce LE auto connection infrastructure
>  Bluetooth: Re-enable background scan in case of error
>  Bluetooth: Temporarily stop background scanning on discovery
>  Bluetooth: Auto connection and power on
>  Bleutooth: Add support for auto connect options
>  Bluetooth: Add le_auto_conn file on debugfs

I applied patch 1, 2 and 5 out of this series to make some progress and make the overall set of patches smaller.

Regards

Marcel

