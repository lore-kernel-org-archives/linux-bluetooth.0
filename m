Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH] input: Control HID encryption from input.conf
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140305221503.CBDCE100321@puck.mtv.corp.google.com>
Date: Wed, 5 Mar 2014 15:09:46 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <124716E5-CE2A-49CD-906F-9579E60AAC49@holtmann.org>
References: <20140305221503.CBDCE100321@puck.mtv.corp.google.com>
To: Petri Gynther <pgynther@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

> Add support for optional config item "Encryption=<true|false>" in input.conf.
> Allows HID encryption to be disabled for keyboards and keyboard-like devices
> that don't work properly with encryption due to firmware bugs.

really? I assumed the specification and qualification is pretty clear. Encryption is a must requirement for keyboard devices. Do you have traces where this causes issues.

I would also like to hear about samples of these broken keyboards. I have to admit that I have not personally used a Bluetooth keyboard in a while, but when developing the HID support back in the days, the encryption was never an issue. So I am surprised to hear that it has gotten worse and I hope this is not a bug on our side.

Regards

Marcel

