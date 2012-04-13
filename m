Return-Path: <cyrus@holtmann.org>
Message-ID: <1334341645.16897.146.camel@aeonflux>
Subject: Re: [PATCH 1/1] Add bluetooth support for Foxconn - Hon Hai
 bluetooth usb present in Acer TimelineX AS4830TG-6808
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Harms <sjharms@gmail.com>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 13 Apr 2012 20:27:25 +0200
In-Reply-To: <1334324827-6017-1-git-send-email-sjharms@gmail.com>
References: <1334324827-6017-1-git-send-email-sjharms@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

> Signed-off-by: Steven Harms <sjharms@gmail.com>
> ---
>  drivers/bluetooth/btusb.c |    3 +++
>  1 file changed, 3 insertions(+)

break the subject line into something shorter and add a proper commit
messages that includes /sys/kernel/debug/usb/devices details for this
device.

Regards

Marcel


