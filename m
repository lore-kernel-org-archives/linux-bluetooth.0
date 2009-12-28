Return-Path: <cyrus@holtmann.org>
Subject: Re: How to snoop traffic
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20091228162807.5a16d9f5@redhat.com>
References: <20091228162807.5a16d9f5@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Dec 2009 15:33:42 -0800
Message-ID: <1262043222.16627.100.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pete,

> What is the preferred method to snoop the Bluetooth traffic?
> E.g. my phone seems to pair with my computer fine, but then it
> stops communicating, what now? I would like to debug the issue
> myself from the bottom up.

just use hcidump -X -V. It will trace and decode the Bluetooth HCI
traffic for you.

Regards

Marcel


