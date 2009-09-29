Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/7] Bluetooth: Put Basic Mode to be the default when
 using SOCK_SEQPACKET
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1254199349-19713-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 22:00:46 -0700
Message-Id: <1254200446.2659.79.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> We can't break userspace app that will continue using SOCK_SEQPACKET.
> The default mode for SOCK_SEQPACKET is Basic Mode, so when no one
> specifies the mode and sk_type is SOCK_SEQPACKET Basic Mode shall be used.

this one is fine. Applied to my tree.

Regards

Marcel


