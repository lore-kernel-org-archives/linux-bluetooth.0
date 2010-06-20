Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Jun 2010 01:08:50 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@nokia.com>
Subject: Re: [PATCH] Bluetooth: Reset the security level after an
 authentication failure
Message-ID: <20100620040807.GA32372@vigoh>
References: <1276848536-29895-1-git-send-email-johan.hedberg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276848536-29895-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* johan.hedberg@gmail.com <johan.hedberg@gmail.com> [2010-06-18 11:08:56 +0300]:

> From: Johan Hedberg <johan.hedberg@nokia.com>
> 
> When authentication fails for a connection the assumed security level
> should be set back to BT_SECURITY_LOW so that subsequent connect
> attempts over the same link don't falsely assume that security is
> adequate enough.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
> ---
>  net/bluetooth/hci_event.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)

It works fine to me.

Acked-by: Gustavo F. Padovan <padovan@profusion.mobi>

-- 
Gustavo F. Padovan
http://padovan.org
