Return-Path: <cyrus@holtmann.org>
Subject: Re: doing hcitool name [addr] while a hcitool inq is running
From: Marcel Holtmann <marcel@holtmann.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20081212122043.GC19659@vanheusden.com>
References: <20081212122043.GC19659@vanheusden.com>
Content-Type: text/plain
Date: Fri, 19 Dec 2008 08:02:02 +0100
Message-Id: <1229670122.17082.30.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Folkert,

> Am I right that one cannot do a
> 	hcitool name 00:11:22:33:44:55
> while a
> 	hcitool inq
> is running on the same bluetooth device?

and that is expected. You can do a page, while doing inquiry and vice
versa.

Regards

Marcel


