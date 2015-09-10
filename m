Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <3A3A3A19-AE6E-493A-AA1F-3C0A8451B775@holtmann.org>
References: <CACjvaw==Z9Mbgd6tBdHsNs1W+o7UbSudDUaGuwTLeY=LWkyW2A@mail.gmail.com>
	<3A3A3A19-AE6E-493A-AA1F-3C0A8451B775@holtmann.org>
Date: Thu, 10 Sep 2015 22:04:21 +0600
Message-ID: <CACjvaw=P2SNuKgMB5BjEhmrpPv55eJUGEZt21pHnh7zmTfE6bg@mail.gmail.com>
Subject: Re: mgmt-api callback not firing properly
From: Nazmul Alam <fadedreamz@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,
Thank you for your reply.


> are you utilizing src/shared/mgmt.c for your code. That one has proper ha=
ndling for queuing the commands. It however means that the next command is =
only send when the previous one completed? Which command do you have proble=
ms with. There are a few special ones that require mgmt_reply to be used.

Yes I am using src/shared/mgmt.c for my code. The problem occurs when
I try to issue the MGMT_OP_START_DISCOVERY &
MGMT_OP_ADD_ADVERTISING/MGMT_OP_REMOVE_ADVERTISING simultaneously,
sometimes the callback doesn't fire for the later call.

According to one of your reply to a thread, I changed the guarding
code of the kernel driver and simultaneous scanning / advertising is
working. But sometimes the callback is not firing (randomly).

I am using the mainloop_run() in a pthread. Is this can be a issue?


Regards,
