Return-Path: <cyrus@holtmann.org>
Message-ID: <1331920658.14217.180.camel@aeonflux>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE
 HIDP)
From: Marcel Holtmann <marcel@holtmann.org>
To: Joao Paulo Rechi Vita <jprvita@openbossa.org>
Cc: David Herrmann <dh.herrmann@googlemail.com>,
	linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org,
	Vijaykumar.Dadmode@csr.com
Date: Fri, 16 Mar 2012 10:57:38 -0700
In-Reply-To: <CAAngNMYSNPX8veuBD2jrvhHSV2v_8e4qRt8ZjYDPcF=-Q8XUCQ@mail.gmail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
	 <CAAngNMYSNPX8veuBD2jrvhHSV2v_8e4qRt8ZjYDPcF=-Q8XUCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Joao,

> > I have hacked together a small driver which allows user-space I/O drivers to
> > provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
> > Bluetooth-LE protocol is parsed in user-space.
> >
> > I have only compile-tested this driver, I haven't run it yet. It's just an
> > proposal how this could be implemented. It should also work as hint to the BT-LE
> > developers how such an interface will look-like.
> >
> 
> First of all, thanks for your effort. I haven't looked at the code
> yet, but thinking again about the problem and since it's very similar
> to uinput, would adding another ioctl to uinput that receives the HID
> descriptor and put uinput in a "HID mode" be sufficient? This way we
> could increase code reuse and ease maintainance, I guess. What do you
> think?

I am really against this. Input subsystem and HID subsystem are two
different things. Don't try to combine them.

You would also mess up the layering here. HID uses input, but input does
not require HID.

Regards

Marcel


