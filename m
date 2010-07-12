Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: Add Fixed Channels support to connect()
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtman.org,
	"Gustavo F. Padovan" <padovan@profusion.mobi>
In-Reply-To: <1278969545-26864-2-git-send-email-gustavo@padovan.org>
References: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
	 <1278969545-26864-2-git-send-email-gustavo@padovan.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jul 2010 18:46:52 -0300
Message-ID: <1278971212.6282.7.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> All the Fixed Channel shall be set up with SOCK_DGRAM passing the channel
> id too. If you don't inform the channel id, L2CAP will use the
> Connectionless channel (0x0002), which was already the default channel for
> SOCK_DGRAM.

we actually can't do that. So the fixed channel have specific types
assigned with it. For example LE configures the ATT channel in basic
mode and HS uses ERTM on the AMP manager protocol.

However the only channel that we currently wanna access from user space
with SOCK_SEQPACKET is the ATT channel on LE. So we should disallow any
other access to fixed channels and use SOCK_DGRAM for raw access to the
signal channel as before. And SOCK_SEQPACKET for the ATT channel. All
other attempts to bind or connect a fixed channel should be rejected for
now.

Regards

Marcel


