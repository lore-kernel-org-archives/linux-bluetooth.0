Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 Dec 2009 17:44:08 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: How to snoop traffic
Message-ID: <20091228174408.30cc5065@redhat.com>
In-Reply-To: <1262043222.16627.100.camel@localhost.localdomain>
References: <20091228162807.5a16d9f5@redhat.com>
	<1262043222.16627.100.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 28 Dec 2009 15:33:42 -0800
Marcel Holtmann <marcel@holtmann.org> wrote:

> > What is the preferred method to snoop the Bluetooth traffic?

> just use hcidump -X -V. It will trace and decode the Bluetooth HCI
> traffic for you.

Thanks a lot. As it turned out, my distribution (Fedora) packaged
it into a nondefault package (bluez-hcidump), so I missed it, sorry.
I thought we might've moved to a libpcap-based capture while I wasn't
looking, but fortunately not.

-- Pete
