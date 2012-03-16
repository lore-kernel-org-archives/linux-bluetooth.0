Return-Path: <cyrus@holtmann.org>
Date: Fri, 16 Mar 2012 15:58:32 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, chen.ganir@ti.com,
	claudio.takahasi@openbossa.org, jprvita@openbossa.org,
	linux-bluetooth@vger.kernel.org, Vijaykumar.Dadmode@csr.com
Subject: Re: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE
 HIDP)
In-Reply-To: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Message-ID: <alpine.LNX.2.00.1203161556540.18356@pobox.suse.cz>
References: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 16 Mar 2012, David Herrmann wrote:

> I have hacked together a small driver which allows user-space I/O drivers to
> provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
> Bluetooth-LE protocol is parsed in user-space.

David,

thanks for your effort.

I haven't read the full discussion you have CCed me on yesterday, but I 
have one substantial question to start with -- is there a simple 
explanation in a few sentences why Bluetooth-LE can't be added as a 
in-kernel transport layer?

Answering that is, I believe, something that should start the whole 
discussion.

Thanks,

-- 
Jiri Kosina
SUSE Labs
