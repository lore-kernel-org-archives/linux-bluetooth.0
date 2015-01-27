Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: bt4.1 multiple simultaneous roles support?
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <54C5B717.1010009@esd-dev.be>
Date: Mon, 26 Jan 2015 22:10:06 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DB3E2752-3C72-4039-9B19-43183DC73ADA@holtmann.org>
References: <54C5B717.1010009@esd-dev.be>
To: =?utf-8?Q?Mathieu_Oca=C3=B1a?= <mo@esd-dev.be>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mathieu,

> Does bluez support the BT4.1 feature which allows multiple simultaneous roles (LE peripheral & LE central/hub at the same time)?
> I know the announces about the features of bt4.1 and bt4.2 included in bluez and the linux kernel, but I have not seen this feature explicitely mentionned, so I prefer to check before starting a developpement with a wrong assumption.

as long as your Bluetooth controller supports it, you can advertise while scanning or being connected. Even direct advertising is supported in case that is the preferred connection method.

Actually BlueZ never really imposed any limitation. If the controller supports it, then we allow any combination of roles. Just give it a try.

Regards

Marcel

