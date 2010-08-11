Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Aug 2010 22:16:10 -0400
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Pavan Savoy <pavan_savoy@sify.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: why is hciops a plugin ?
Message-ID: <20100811021610.GA8306@jh-x301>
References: <AANLkTino39jMNvdcV=EiekN33vrfNXLyJVNsHcHtq5wz@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTino39jMNvdcV=EiekN33vrfNXLyJVNsHcHtq5wz@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Aug 10, 2010, Pavan Savoy wrote:
> Any reason behind making hciops a plugin and bluetoothd making use of
> that plugin, wasn't everything straight up in hcid before ?

We're planning on redoing the kernel-userspace interface and in the long
run the traditional raw HCI access wont exist anymore in userspace. In
order to accommodate both old and new kernels in a clean way the
interface towards the kernel needs to be easily interchangable, which is
what hciops is trying to do (it's just a first step in that direction
though). One of the drivers for this change is the need to have the
security logic in one place instead of it being split between kernel and
userspace (this has caused all sorts of trouble with SSP for us).

Originally the plan for the new kernel interface was netlink but now the
idea is to simply extend the stack internal messages of raw HCI sockets
with a more complete two-way protocol between the kernel and userspace.
You should (hopefully) be seeing more patches for this still during this
year.

Johan
