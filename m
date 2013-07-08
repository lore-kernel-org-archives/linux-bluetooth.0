Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH v8 3/8] Bluetooth: Add bluetooth socket voice option
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1373036503-1349-4-git-send-email-frederic.dalleau@linux.intel.com>
Date: Mon, 8 Jul 2013 12:17:48 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C7E4774E-72FB-415E-B7C2-41B808BC7C21@holtmann.org>
References: <1373036503-1349-1-git-send-email-frederic.dalleau@linux.intel.com> <1373036503-1349-4-git-send-email-frederic.dalleau@linux.intel.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric_Dalleau?=
	<frederic.dalleau@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> This patch extends the current bluetooth socket option to add BT_VOICE.
> This is intended to choose voice data type at runtime. It only applies to SCO
> sockets.
> Incoming connections shall be setup during defered setup. Outgoing connections
> shall be setup before connect(). The desired setting is stored in the sco
> socket info.
> This patch declares needed members, modifies getsockopt() and setsockopt().
> 
> Signed-off-by: Frédéric Dalleau <frederic.dalleau@linux.intel.com>
> ---
> include/net/bluetooth/bluetooth.h |    8 ++++++++
> include/net/bluetooth/sco.h       |    1 +
> net/bluetooth/sco.c               |   40 ++++++++++++++++++++++++++++++++++++-
> 3 files changed, 48 insertions(+), 1 deletion(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

