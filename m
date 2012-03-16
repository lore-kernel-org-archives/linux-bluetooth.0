Return-Path: <cyrus@holtmann.org>
Message-ID: <1331913809.14217.155.camel@aeonflux>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE
 HIDP)
From: Marcel Holtmann <marcel@holtmann.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-input@vger.kernel.org, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, jprvita@openbossa.org,
	linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com
Date: Fri, 16 Mar 2012 09:03:29 -0700
In-Reply-To: <alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	 <alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jiri,

> > I have hacked together a small driver which allows user-space I/O drivers to
> > provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
> > Bluetooth-LE protocol is parsed in user-space.
> 
> David,
> 
> thanks for your effort.
> 
> I haven't read the full discussion you have CCed me on yesterday, but I 
> have one substantial question to start with -- is there a simple 
> explanation in a few sentences why Bluetooth-LE can't be added as a 
> in-kernel transport layer?
> 
> Answering that is, I believe, something that should start the whole 
> discussion.

that has been discussed. My point is that the Bluetooth SIG made a
mistake with their specification here. And my original words were much
harsher ;)

Let me make an analogy. It is like HID over XML. You don't want that in
the kernel.

Regards

Marcel


