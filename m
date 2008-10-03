Return-Path: <cyrus@holtmann.org>
Subject: Re: Untrusted input devices by default
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48E3F51B.6050001@dell.com>
References: <48E3F51B.6050001@dell.com>
Content-Type: text/plain
Date: Fri, 03 Oct 2008 08:37:35 +0200
Message-Id: <1223015855.11272.34.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> In my efforts to get BlueZ 4.x into Intrepid a question was posed.  How
> come input devices don't default to "Trusted" when paired in the
> Wizard?  This makes for a weird experience the next time you reboot (or
> disconnect the device for that matter) that you need to give it
> "authorization".

that is a bug. We should set the input device as trusted after we
connected to it. Any chance you have a patch for it?

Regards

Marcel


