Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Default bluez-gnome UI to a connectable state
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario_Limonciello@Dell.com
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <FA7963CC89065B49AED46A6F797F0FA6F28690@AUSX3MPC128.aus.amer.dell.com>
References: <FA7963CC89065B49AED46A6F797F0FA6F28690@AUSX3MPC128.aus.amer.dell.com>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 03:52:31 +0200
Message-Id: <1222653151.1825.5.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> Looking through the code, it appears that bluetoothd does start up connectable, but the UI doesn't reflect this from the first boot.  This patch should address it.

this patch can't be right. It can happen that the device starts up in
off mode. You need to figure out why the mode variable doesn't correctly
point to connectable.

Regards

Marcel


