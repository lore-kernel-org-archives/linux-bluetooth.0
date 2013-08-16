Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v10 08/10] Bluetooth: Prevent transparent SCO on older devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376499814-11386-9-git-send-email-frederic.dalleau@linux.intel.com>
Date: Fri, 16 Aug 2013 11:45:34 -0700
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@intel.com>
Message-Id: <65EB0AD1-2EA4-4095-BA8F-2F86FCAEC362@holtmann.org>
References: <1376499814-11386-1-git-send-email-frederic.dalleau@linux.intel.com> <1376499814-11386-9-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Older Bluetooth devices may not support Setup Synchronous Connection or
> SCO transparent data. This is indicated by the corresponding LMP feature
> bits. It is not possible to know if the adapter support these features
> before setting BT_VOICE option since the socket is not bound to an
> adapter. An adapter can also be added after the socket is created. The
> socket can be bound to an address before adapter is plugged in.
> 
> Thus, on a such adapters, if user request BT_VOICE_TRANSPARENT, outgoing
> connections fail on connect() and returns -EOPNOTSUPP. Incoming
> connections do not fail. However, they should only be allowed depending
> on what was specified in Write_Voice_Settings command.
> 
> EOPNOTSUPP is choosen because connect() system call is failing after
> selecting route but before any connection attempt.
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/sco.c |    6 ++++++
> 1 file changed, 6 insertions(+)

lets go with EOPNOTSUPP.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

