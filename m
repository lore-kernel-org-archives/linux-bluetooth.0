Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix out of scope variable access in
 hci_sock_cmsg()
From: Marcel Holtmann <marcel@holtmann.org>
To: Johann Felix Soden <johfel@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1266269028.8680.4.camel@LAPJFS>
References: <1266269028.8680.4.camel@LAPJFS>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 17 Feb 2010 02:15:15 -0800
Message-ID: <1266401715.8849.57.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johann,

> The pointer data can point to the variable ctv.
> Access to data happens when ctv is already out of scope.

patch has been applied to my bluetooth-2.6 tree.

Regards

Marcel


