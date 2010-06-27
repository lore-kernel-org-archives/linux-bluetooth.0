Return-Path: <cyrus@holtmann.org>
Date: Sun, 27 Jun 2010 03:30:25 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Hieu Le Trung <hieuletrung@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to programmatically pair device using bluez API
Message-ID: <20100627063025.GA7825@vigoh>
References: <1277619176.6618.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1277619176.6618.3.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

* Hieu Le Trung <hieuletrung@gmail.com> [2010-06-27 13:12:56 +0700]:

> Hi,
> 
> I wonder how can I pair the device using BlueZ API. I've searched on the
> net but there is no place talk about this.

You can the CreatedPairedDevice() method from the Adapter interface. See
the doc/ dir inside the sources for more information.

Regards,

-- 
Gustavo F. Padovan
http://padovan.org
