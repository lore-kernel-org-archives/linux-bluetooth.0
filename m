Return-Path: <cyrus@holtmann.org>
Subject: Re: What's hcitrace?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20091229111734.4aaec550@strolchi.home.s3e.de>
References: <20091229111734.4aaec550@strolchi.home.s3e.de>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Dec 2009 03:41:06 -0800
Message-ID: <1262086866.16627.104.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> I found hcitrace in the bluez-4.59 tarball.
> What is it? Should it be packaged? Maybe in the bluez-test package?

eventually it should be, but right now, you better don't.

So the hcitrace daemon (when I finish it), will allow per advanced
tracing capabilities with multiple HCI controllers per stream (that is
needed for AMPs). And of course it will use D-Bus activation etc. All
fancy stuff, but as of of now, it is not finished yet.

Regards

Marcel


