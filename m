Return-Path: <cyrus@holtmann.org>
Date: Thu, 31 May 2012 10:33:10 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Change default MTU for L2CAP ATT channel
Message-ID: <20120531133310.GO18069@joana>
References: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338401329-31429-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-05-30 15:08:47 -0300]:

> This patch changes the default MTU value for L2CAP ATT fixed channel
> to L2CAP_DEFAULT_MTU (672 octets).
> 
> Differently from others L2CAP channels, in L2CAP ATT fixed channel
> there is no MTU negotiation. The MTU value for that channel is up to
> the L2CAP implementation. The only restriction in L2CAP spec is the
> MTU value must not be less than 23 octets.
> 
> At ATT protocol level (on top of L2CAP), we have the ATT_MTU which
> defines the maximum size of any ATT message sent between client and
> server. GATT profile defines ATT_MTU default value to 23 octets. If
> a GATT based profile wants to use ATT_MTU greater than 23 octets
> (e.g. HID over GATT profile), it should negotiate a new value by
> executing the GATT Exchange MTU sub-procedure.
> 
> Thus, in order to support any value of ATT_MTU negotiated at ATT
> protocol level, our L2CAP implementation should have L2CAP ATT
> fixed channel MTU equal or greater than ATT_MAX_MTU (512 octets).

Shouldn't we define a L2CAP_LE_MAX_MTU then and set its value to 512?
If we will never have anything greater than 512 octets why allow it?

	Gustavo
