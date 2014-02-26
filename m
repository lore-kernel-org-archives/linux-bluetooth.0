Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 13/17] Bluetooth: Connection parameters and resolvable address
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393362104-12175-14-git-send-email-andre.guedes@openbossa.org>
Date: Tue, 25 Feb 2014 22:37:35 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <7BB46396-5302-407C-874A-1DE043378DDE@holtmann.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org> <1393362104-12175-14-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> We should only add connection parameters for public, random static and
> random private resolvable with IRK. If we allow non-resolvable or
> resolvable without IRK, the background scan may run indefinitely. So, to
> avoid this undesired behavior, we should check the address type in
> hci_conn_params_add().

this makes no sense. We should only allow auto-connection from public and static random addresses. These two are identity addresses.

Every IRK has an identity address assigned to it. If you want to auto-connect a device using a resolvable private address, then the identity address needs to be programmed into our auto-connection list. The RPA should never ever go there.

That is how connect() works actually. You give it the identity address and it will use the IRK to match it to the RPA in use. We need to do exactly the same.

In addition please keep in mind that userspace only knows about RPA as long as they are not identified. Once they are identified, the kernel will only tell us about identity addresses. The RPA will be in all mgmt commands and events automatically resolved.

Regards

Marcel

