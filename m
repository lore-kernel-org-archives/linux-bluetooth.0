Return-Path: <cyrus@holtmann.org>
Message-ID: <1327283783.1955.84.camel@aeonflux>
Subject: Re: [PATCH COMMITTED] bluetooth: hci: Fix type of "enable_hs" to
 bool.
From: Marcel Holtmann <marcel@holtmann.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Date: Mon, 23 Jan 2012 02:56:23 +0100
In-Reply-To: <20120122.144654.2252112633629547845.davem@davemloft.net>
References: <20120122.144654.2252112633629547845.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dave,

> net/bluetooth/hci_core.c: In function ‘__check_enable_hs’:
> net/bluetooth/hci_core.c:2587:1: warning: return from incompatible pointer type [enabled by default]
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
> 
> I noticed this while validating the build today, committed to 'net'.

and from your subject, I assume you rightfully just applied that patch
to your tree.

I remember that I acked such a patch, but it seems it never made it
anywhere in the end :(

Regards

Marcel


