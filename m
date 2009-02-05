Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ qualification tool
From: Marcel Holtmann <marcel@holtmann.org>
To: alex lei <seak_learn2@yahoo.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <421284.20385.qm@web58306.mail.re3.yahoo.com>
References: <421284.20385.qm@web58306.mail.re3.yahoo.com>
Content-Type: text/plain
Date: Thu, 05 Feb 2009 20:53:51 +0100
Message-Id: <1233863631.20189.4.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> In your BlueZ web site, you mentioned that bluez-4.2 release passed all qualification tests form the Bluetooth 2.1 specification on 29th of August 2008. I just wonder what
> tools/applications did you use to set up all the test cases for the
> IUT?  Specifically, what apps did you use as the "upper tester" or
> "MMI"? Are the tools in bluez-utils/test/ sufficient to do the job?

all the tools in bluez/test/ are enough to pass the qualification. I do
have a more advanced one for the GAP testing and you need the PICS,
PIXIT and additional documentation to make your life easier. Non of
these advanced tools are released to the public.

Regards

Marcel


