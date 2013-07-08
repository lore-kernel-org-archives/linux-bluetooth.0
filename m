Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 2/2] bluetooth: Add l2cap sockopt for LE conn params
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1372980303-3007-3-git-send-email-kyle@kylemanna.com>
Date: Mon, 8 Jul 2013 12:01:38 -0700
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <4F35141E-2B22-4905-952E-29764B784D5C@holtmann.org>
References: <1372980303-3007-1-git-send-email-kyle@kylemanna.com> <1372980303-3007-3-git-send-email-kyle@kylemanna.com>
To: Kyle Manna <kyle@kylemanna.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Kyle,

here again, patches to linux-bluetooth only please.

> * Userspace can now specify connection parameters to override the
>  defaults prior to connecting to the device.
> * The intention is that setsockopt() will be called before connect() is
>  called in userspace apps and BlueZ libraries.
> * It is critical to set these parameters prior to connect() to avoid
>  issues with hardware that must arbitrate the antenna access between
>  Bluetooth LE and things like WiFi.  Aggressive connect (and scan)
>  window and interval values result in significant WiFi degradation.
> * Reduces the need to call the hci LE Connection Update Command to
>  override the "defaults" when the desired values are known ahead of
>  time.
> * Add BT_LE_CONN_PARAM socket option.

I am not convinced that this is a good idea. My idea is that bluetoothd should just program connection parameters into the kernel via mgmt and not via the L2CAP socket.

Especially since with LE auto-connect handling most likely starting to use listen() + accept() instead in the future, the L2CAP socket is not a good option here.

Regards

Marcel

