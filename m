Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth:L2CAP check FEAT success
From: Marcel Holtmann <marcel@holtmann.org>
To: Liejun Tao <liejuntao001@gmail.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
In-Reply-To: <8a7a8d7b1002021350o3c80c7d9p948365ea983a0d89@mail.gmail.com>
References: <8a7a8d7b1002021350o3c80c7d9p948365ea983a0d89@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 03 Feb 2010 07:22:27 -0800
Message-ID: <1265210547.31341.118.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Liejun,

> Resolve the connection issue with Blackbery 8900, if encryption is ON.
> If encryption turned on indication comes when L2CAP is in "Information
> Request" process, there will be 2 l2cap_conn_req, and one is denied
> from remote, cause the connection dropped.
> This patch applies to kernel version 2.6.29. 2.6.32 should have same issue.
> Please review.

I might have an idea what is going here. Can you send me the whole
hcidump -X -V from the Create Connection to the Connection Refused
without having it mangled via your mailer.

Regards

Marcel


