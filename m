Return-Path: <cyrus@holtmann.org>
Subject: Re: [BUG] kernel panic with bluetooth-testing
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <6b53b1990908080122m1f66f07et97d05a163be5d58a@mail.gmail.com>
References: <6b53b1990908080122m1f66f07et97d05a163be5d58a@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Aug 2009 08:33:37 -0700
Message-Id: <1249745617.30166.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> This commit is broken, but I don' t know why ;-). It's causing a
> kernel panic on my machine.
> The case is: I run a l2test server and a l2test client to transfers
> some data and the I try to reload l2cap. When reloading, the kernel
> crashes.

I forgot to remove the extra connection reference counts. They break it
and crash the kernel. Pushed the fix now.

Regards

Marcel


