Return-Path: <cyrus@holtmann.org>
Message-ID: <1343934984.2083.3.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Add support for Sony Vaio T-Series
From: Marcel Holtmann <marcel@holtmann.org>
To: Mohammed Shafi Shajakhan <mohammed@qca.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Yevgeniy Melnichuk <yevgeniy.melnichuk@googlemail.com>
Date: Thu, 02 Aug 2012 12:16:24 -0700
In-Reply-To: <1343906361-2747-1-git-send-email-mohammed@qca.qualcomm.com>
References: <1343906361-2747-1-git-send-email-mohammed@qca.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mohammed,

> Add Sony Vaio T-Series Bluetooth Module( 0x489:0xE036) to
> the blacklist of btusb module and add it to the ath3k module.

include part of /sys/kernel/debug/usb/devices in the commit message.
This is nothing new to you guys. I requested it multiple times.

Regards

Marcel


