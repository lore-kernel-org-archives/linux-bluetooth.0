Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix dmesg errors about hid2hci not claiming interface
 before usage.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A0DFB63.8060006@dell.com>
References: <4A0DFB63.8060006@dell.com>
Content-Type: text/plain
Date: Sat, 16 May 2009 06:38:44 -0700
Message-Id: <1242481124.3446.36.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> These errors were caused from trying to detach the kernel driver from
>  the interface, which was unnecessary.  A simple usb_claim_interface
>  is all that is necessary.  It is however, important to ensure the
>  interface claim is successful.
> 
> ---
>  tools/hid2hci.c |   12 ++++--------
>  1 files changed, 4 insertions(+), 8 deletions(-)

patch has been applied. Again, please line-break your commit messages
properly.

Regards

Marcel


