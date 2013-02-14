Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360767045-26958-9-git-send-email-johan.hedberg@gmail.com>
References: <1360767045-26958-1-git-send-email-johan.hedberg@gmail.com>
	<1360767045-26958-9-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 14 Feb 2013 14:48:47 -0300
Message-ID: <CACJA=fXRr9b1RD6z_3XKpUpPMJ9F-g_yMLTHBjdyU9zwik6vfg@mail.gmail.com>
Subject: Re: [PATCH 08/12] Bluetooth: Enable HCI transaction support
 cmd_status 0
From: Andre Guedes <andre.guedes@openbossa.org>
To: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Wed, Feb 13, 2013 at 11:50 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> Some HCI commands do not result in a command complete event and generate
> an intermediate command status 0 in between. Inquiry is one of these
> procedures and needs to be handled properly since the legacy ioctl for
> it uses hci_request which in turn will make use of the the HCI

Typo: the the/the

Regards,

Andre
