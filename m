Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: mgmt-api callback not firing properly
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CACjvaw=P2SNuKgMB5BjEhmrpPv55eJUGEZt21pHnh7zmTfE6bg@mail.gmail.com>
Date: Sat, 12 Sep 2015 11:23:27 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A1440DEA-2A32-40ED-8C2D-A7D4E2ABE415@holtmann.org>
References: <CACjvaw==Z9Mbgd6tBdHsNs1W+o7UbSudDUaGuwTLeY=LWkyW2A@mail.gmail.com> <3A3A3A19-AE6E-493A-AA1F-3C0A8451B775@holtmann.org> <CACjvaw=P2SNuKgMB5BjEhmrpPv55eJUGEZt21pHnh7zmTfE6bg@mail.gmail.com>
To: Nazmul Alam <fadedreamz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

>> are you utilizing src/shared/mgmt.c for your code. That one has proper handling for queuing the commands. It however means that the next command is only send when the previous one completed? Which command do you have problems with. There are a few special ones that require mgmt_reply to be used.
> 
> Yes I am using src/shared/mgmt.c for my code. The problem occurs when
> I try to issue the MGMT_OP_START_DISCOVERY &
> MGMT_OP_ADD_ADVERTISING/MGMT_OP_REMOVE_ADVERTISING simultaneously,
> sometimes the callback doesn't fire for the later call.
> 
> According to one of your reply to a thread, I changed the guarding
> code of the kernel driver and simultaneous scanning / advertising is
> working. But sometimes the callback is not firing (randomly).
> 
> I am using the mainloop_run() in a pthread. Is this can be a issue?

our code is not thread safe. So that might be a problem. Since I have not heard from issues with missing callbacks in bluetoothd and that is running exactly the same code.

Regards

Marcel

