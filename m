Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Egerer <hakke_007@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4B5C554D.4030702@gmx.de>
References: <4B5C554D.4030702@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jan 2010 15:28:36 +0100
Message-ID: <1264343316.11653.0.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> the default learning time of a bridge -- 15 seconds -- appears
> unacceptably long, especially for clients that disconnect quite
> often after a short time (e.g. web-browsers);
> this patch tries to remedy this by setting the the waiting period to a
> value of zero (by default) or -- if the administrator wishes a larger
> value -- to whatever the General section of the network.conf holds in
> the variable ForwardDelay;
> ---
>  Makefile.am       |    2 +-
>  acinclude.m4      |    6 +++
>  configure.ac      |    1 +
>  network/bridge.c  |  117
> ++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  network/bridge.h  |    3 +-
>  network/manager.c |   19 +++++++-
>  6 files changed, 142 insertions(+), 6 deletions(-)

using libsysfs is not acceptable. That library is deprecated.

Regards

Marcel


