Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 3/3] Launch hid2hci from udev rules dynamically.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A0DE7F0.3090803@dell.com>
References: <4A0DE7F0.3090803@dell.com>
Content-Type: text/plain
Date: Sat, 16 May 2009 06:37:00 -0700
Message-Id: <1242481020.3446.35.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> Rather than launching hid2hci upon every boot even when the user
>  doesn't have hardware that needs it installed, launch it from
>  a set of udev rules that matches the hardware by attributes.
> 
> ---
>  scripts/Makefile.am       |    9 ++++++++-
>  scripts/bluetooth.default |    3 ---
>  scripts/bluetooth.init    |    7 -------
>  scripts/hid2hci.rules     |   38 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 11 deletions(-)
>  create mode 100644 scripts/hid2hci.rules

I had to redo the whole thing, but should be working :)

Regards

Marcel


