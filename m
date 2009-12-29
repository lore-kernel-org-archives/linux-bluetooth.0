Return-Path: <cyrus@holtmann.org>
Subject: Re: How to snoop traffic
From: Marcel Holtmann <marcel@holtmann.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <20091228174408.30cc5065@redhat.com>
References: <20091228162807.5a16d9f5@redhat.com>
	 <1262043222.16627.100.camel@localhost.localdomain>
	 <20091228174408.30cc5065@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Dec 2009 18:20:00 -0800
Message-ID: <1262053200.16627.101.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pete,

> > > What is the preferred method to snoop the Bluetooth traffic?
> 
> > just use hcidump -X -V. It will trace and decode the Bluetooth HCI
> > traffic for you.
> 
> Thanks a lot. As it turned out, my distribution (Fedora) packaged
> it into a nondefault package (bluez-hcidump), so I missed it, sorry.
> I thought we might've moved to a libpcap-based capture while I wasn't
> looking, but fortunately not.

actually PCAP is not possible since we can't store packet direction in
PCAP format and that is needed for HCI traffic.

Regards

Marcel


