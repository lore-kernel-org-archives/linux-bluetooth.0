Return-Path: <cyrus@holtmann.org>
Subject: Re: second scan timing out, bisected to 314b2381a79c6bfe3ddc4ba3806ecb6aec27a3db
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=iso-8859-1
From: Andre Guedes <andre.guedes@openbossa.org>
In-Reply-To: <201108311616.56297.oneukum@suse.de>
Date: Wed, 31 Aug 2011 11:46:31 -0300
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Message-Id: <29B50A2B-987E-4942-B94B-D15ACD5425F6@openbossa.org>
References: <201108301005.20103.oliver@neukum.org> <201108301552.19010.oliver@neukum.org> <407EE2E8-9841-4A67-B63D-F2084E341C92@openbossa.org> <201108311616.56297.oneukum@suse.de>
To: Oliver Neukum <oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

On Aug 31, 2011, at 11:16 AM, Oliver Neukum wrote:

> Am Dienstag, 30. August 2011, 16:53:04 schrieb Andre Guedes:
>> I'm working on a new version of discovery procedure support and I have
>> the fix for this issue in that patch series (see [PATCH v2 01/16]
>> Bluetooth: Periodic Inquiry and mgmt discovering event).
>> 
>> Soon, I'll send the new version of discovery patches to ML.
> 
> Hi,
> 
> what else does this patch do?

It changes hci_event.c so periodic inquiry don't send
mgmt_discovering events.

The discovery patch series adds support for LE-Only and
BR/EDR/LE discovery procedure through management interface
(BR/EDR is already supported).

BR,

Andre
