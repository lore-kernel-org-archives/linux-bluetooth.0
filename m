Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Mar 2011 15:48:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Suraj Sumangala <suraj@Atheros.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: accessing Link key within the Bluetooth module
Message-ID: <20110321134833.GA8819@jh-x301>
References: <4D870E6F.4050502@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D870E6F.4050502@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

On Mon, Mar 21, 2011, Suraj Sumangala wrote:
> I am working on a Bluetooth AMP manager module (linked to l2cap
> module) that require access to the Link key of the connected(paired)
> device.
> 
> I am trying to use the hci_find_link_key() call with the BDADDR of
> the remote device as parameter without success. It looks like the
> list "hci_dev.link_keys" is not getting populated in the first
> place.

That list only gets populated if you've enabled the management interface
(enable_mgmt=1 module option) and have a matching user space version
with management interface support.

Johan
