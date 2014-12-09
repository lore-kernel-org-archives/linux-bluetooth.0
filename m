Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
References: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
Date: Mon, 8 Dec 2014 21:59:52 -0800
Message-ID: <CAPt0RYy9SQfKfbodgi7EtfDOLZMKzBWotsFd1RQNrH8NA=387A@mail.gmail.com>
Subject: Re: Question about mgmt header files and shared-mainloop library
From: Mona Attariyan <monattar@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reposting. Any ideas?

On Wed, Dec 3, 2014 at 3:28 PM, Mona Attariyan <monattar@gmail.com> wrote:
> Hi,
> I'm using bluez mgmt API in a simple scan application. I've been
> including headers files like src/shared/mgmt.h and src/shared/util.h.
> Also the main bluez bluetooth library (libbluetooth.so) does not
> include the mgmt and mainloop stuff, so I've been linking against
> shared-mainloop.a. My question is why aren't these header files part
> of the public API? as in in lib directory or something that doesn't
> sound internal. Same question about the library. Why aren't mgmt stuff
> compiled into the main library?
> I appreciate it if anyone could shed some light into the reasoning
> behind this. Am I not supposed to be using these?
>
> Thanks.
