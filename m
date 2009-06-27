Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/3] use CONFIGDIR and STORAGEDIR in src/bluetoothd.8
From: Marcel Holtmann <marcel@holtmann.org>
To: Filippo Giunchedi <filippo@esaurito.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1245596485-11771-1-git-send-email-filippo@esaurito.net>
References: <1245596485-11771-1-git-send-email-filippo@esaurito.net>
Content-Type: text/plain
Date: Sat, 27 Jun 2009 12:29:17 +0200
Message-Id: <1246098557.12994.130.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Filippo,

> also export CONFIGDIR and STORAGEDIR with AC_SUBST
> ---
>  .topdeps            |    1 +
>  .topmsg             |    5 +++
>  acinclude.m4        |    4 ++
>  configure.ac        |    1 +
>  src/bluetoothd.8    |   91 ---------------------------------------------------
>  src/bluetoothd.8.in |   91 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 102 insertions(+), 91 deletions(-)
>  create mode 100644 .topdeps
>  create mode 100644 .topmsg
>  delete mode 100644 src/bluetoothd.8
>  create mode 100644 src/bluetoothd.8.in

please break this one down. It is doing more than you described. And
exporting CONFIGDIR and STORAGEDIR is different from the actual manpage
changes.

Regards

Marcel


