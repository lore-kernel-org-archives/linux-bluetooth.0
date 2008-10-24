Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Run hid2hci after resuming from suspend
From: Bastien Nocera <hadess@hadess.net>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4900A67C.2050803@dell.com>
References: <48FF92EB.3050007@dell.com>
	 <1224737041.9386.160.camel@californication>  <4900A67C.2050803@dell.com>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 09:06:50 +0100
Message-Id: <1224835610.2895.858.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2008-10-23 at 11:29 -0500, Mario Limonciello wrote:
> 
> +[ -f /etc/default/bluetooth ] || exit $NA
> +
> +. /etc/default/bluetooth

Wrong file to source under Fedora.

> +       if [ "$HID2HCI_ENABLED" = "1" ] && [ -x /usr/sbin/hid2hci ];
> then

$ grep "HID2HCI_ENABLE[D=]" /etc/sysconfig/bluetooth 
#HID2HCI_ENABLE=true

Cheers

