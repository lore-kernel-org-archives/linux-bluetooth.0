Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 0/3] Bluetooth: Add HCI init setup stage
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20130404094608.GA4710@x220>
Date: Thu, 4 Apr 2013 08:22:43 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1A69F091-319A-4BBE-8608-295AA304EB64@holtmann.org>
References: <1364923287-25935-1-git-send-email-johan.hedberg@gmail.com> <20130404082436.GA2340@x220> <20130404094608.GA4710@x220>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>> This is a resend of Marcel's patches that were sent in November, rebased
>>> and fixed-up for bluetooth-next. They are a pre-requsite of some
>>> follow-up work I'm doing to have a simple way of doing synchronous
>>> single-command requests that will be needed by some HCI driver setup
>>> routines.
>>> 
>>> Johan
>>> 
>>> ----------------------------------------------------------------
>>> Marcel Holtmann (3):
>>>      Bluetooth: Add driver setup stage for early init
>>>      Bluetooth: Convert BCM92035 support to driver setup callback
>>>      Bluetooth: Remove driver init queue from core
>>> 
>>> drivers/bluetooth/btusb.c        |   28 +++++++++++--------
>>> include/net/bluetooth/hci_core.h |    3 +-
>>> net/bluetooth/hci_core.c         |   56 ++++++++++++++------------------------
>>> 3 files changed, 38 insertions(+), 49 deletions(-)
>> 
>> There patches have now been pushed to the bluetooth-next tree.
> 
> I had to temporarily remove these since they cause build breakage when
> building as modules:
> 
>>> ERROR: "hci_send_cmd" [drivers/bluetooth/btusb.ko] undefined!
> 
> It seems the reason is a missing EXPORT_SYMBOL declaration for
> hci_send_cmd which the attached patch should fix. I'll also send a
> revised patch set of my own function additions since those too will need
> this declaration.

can we just switch over to use __hci_cmd_sync() for this as well. I really like to keep hci_send_cmd() internal.

Regards

Marcel

