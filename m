Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <a70b8cd30908270945o761a64c3gf665e5660bdf12cc@mail.gmail.com>
References: <a70b8cd30908270945o761a64c3gf665e5660bdf12cc@mail.gmail.com>
Date: Fri, 28 Aug 2009 16:09:57 +0200
Message-ID: <a70b8cd30908280709u30a00f20j7136a221d8406f37@mail.gmail.com>
Subject: Re: [RFC] PS3Remote unpairing and power-saving
From: "Ruslan N. Marchenko" <rufferson@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

2009/8/27, Ruslan N. Marchenko <rufferson@gmail.com>:
> PS3 BD Remote driver in fakehid is not able to detect remote unpairing, thus
>  not handling it properly.
>  Also it keeps permanent BT link with remote controller, which drains batteries.
>  With these changes it now utlize IdleTimeout to implicitly unpair device,
>  forcing it to enter low power sleep mode.
>  IdleTimeout is treated in seconds, in contrast with default - minutes.
>  HID device is created on first pairing, and then kept cached till the end of
>  daemon life, allowing pairing keypresses to be sent to application with minimum
>  delays.
>  HID is distingueshed by vendor/product codes, which restricts it to only single
>  HID for all registered and active PS3 BD Remote controllers.
>
>  Signed-off-by: Ruslan N. Marchenko <rufferson@gmail.com>
>  ---
>   input/device.c  |   14 +------
>   input/device.h  |   13 ++++++-
>   input/fakehid.c |  115 +++++++++++++++++++++++++++++++++++++++++-------------
>   input/fakehid.h |    4 ++
>   4 files changed, 105 insertions(+), 41 deletions(-)
>

Well, if no one minds, I'll post it as a patch %)

-- 
----
Looking forward to reading yours.
 RUFF-RIPE DI76-GANDI RUFF-6BONE
     Ruslan N. Marchenko
