Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v5 00/16] Bluetooth: Multi-advertising infrastructure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
Date: Mon, 25 May 2015 02:52:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F21682C7-106D-4293-993D-D68087860A58@holtmann.org>
References: <1430408000-17785-1-git-send-email-fgrandel@gmail.com> <1432507154-22925-1-git-send-email-fgrandel@gmail.com>
To: Florian Grandel <fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Florian,

> patch set introducing the infrastructure for multi-advertising
> capability to the HCI core and mgmt API.

the patch set is actually breaking functionality. If you want to overwrite the advertising data of an existing instance, then you can just do that by issuing another management command.

	add-adv -u 180d 1
	add-adv -u 180f 1

This will first enable advertising with the heart rate UUID and then with the battery service UUID. With your patch set, this basic feature does not work anymore.

I think first we need a lot more mgmt-tester commands that actually test this functionality.

Regards

Marcel

