Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Add support for switching from HCI->HID mode for
 Dell BT adapters.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A0DC53B.4050304@dell.com>
References: <4A0DC53B.4050304@dell.com>
Content-Type: text/plain
Date: Fri, 15 May 2009 13:06:25 -0700
Message-Id: <1242417985.3446.15.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> This allows Dell BT adapters to be able to be switched back to HID mode
> (if users desire to do so).
> 
> ---
>  tools/hid2hci.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> Attaching patch to prevent Exchange mangling.

did you ever tested this patch with --enable-debug compilation? No code
before variable declaration. Please fix that.

Regards

Marcel


