Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: Question about mgmt header files and shared-mainloop library
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
Date: Tue, 9 Dec 2014 07:13:05 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <37A4BD1B-EB5A-49F7-93E5-E2C1AEC8C7DA@holtmann.org>
References: <CAPt0RYxF95U1KvU2-exkoJCwaYqdzg0P_kJmnO65oSKMVNmKxA@mail.gmail.com>
To: Mona Attariyan <monattar@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mona,

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

there are not meant to be a public API. Even libbluetooth is no longer installed by default actually.

Regards

Marcel

