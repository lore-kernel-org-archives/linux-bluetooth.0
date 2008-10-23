Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Run hid2hci after resuming from suspend
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48FF92EB.3050007@dell.com>
References: <48FF92EB.3050007@dell.com>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 06:44:01 +0200
Message-Id: <1224737041.9386.160.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> This patch adds support for the hid2hci command to be ran upon resuming
> from suspend.  At least the USB adapters I've been operating with that
> need to switch modes need to do so upon resume.

we should not install multiple scripts. Lets only install one "bluez"
file for pm-utils. So no need for a hid2hci specific script.

Regards

Marcel


