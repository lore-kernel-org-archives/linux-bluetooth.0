Return-Path: <cyrus@holtmann.org>
Message-ID: <1322663484.26198.16.camel@aeonflux>
Subject: Re: [RFCv0 0/3] AMP HCI interface from A2MP
From: Marcel Holtmann <marcel@holtmann.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 30 Nov 2011 15:31:24 +0100
In-Reply-To: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> The code adds AMP HCI commands from A2MP protocol. HCI events are handled
> similar way as mgmt interface. amp_pending is a kind of copy of mgmt_pending.

this is all kernel internal code with no interface to user space. I do
not see the need for such a complex infrastructure. Can not just have
proper callbacks or event callback table like with L2CAP. Or just
something similar.

As far as I see it, we get an A2MP command over L2CAP fixed channel, we
have to issue a HCI command or do some other task based on this and then
respond to it. We only have one user of this first of all. And second of
all, I think we can not really have pending A2MP commands anyway. This
is pretty much one command at a time (per ACL link).

If I am mistaken here, please correct here. It has been a while since I
read that specification.

Regards

Marcel


