Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Date: Fri, 16 Mar 2012 14:50:16 -0300
Message-ID: <CAAngNMYSNPX8veuBD2jrvhHSV2v_8e4qRt8ZjYDPcF=-Q8XUCQ@mail.gmail.com>
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE HIDP)
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, linux-bluetooth@vger.kernel.org,
	Vijaykumar.Dadmode@csr.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello David,

On Fri, Mar 16, 2012 at 11:53 AM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi
>
> I have hacked together a small driver which allows user-space I/O drivers to
> provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
> Bluetooth-LE protocol is parsed in user-space.
>
> I have only compile-tested this driver, I haven't run it yet. It's just an
> proposal how this could be implemented. It should also work as hint to the BT-LE
> developers how such an interface will look-like.
>

First of all, thanks for your effort. I haven't looked at the code
yet, but thinking again about the problem and since it's very similar
to uinput, would adding another ioctl to uinput that receives the HID
descriptor and put uinput in a "HID mode" be sufficient? This way we
could increase code reuse and ease maintainance, I guess. What do you
think?


-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
