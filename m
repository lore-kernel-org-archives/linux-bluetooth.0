Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: add support to configure ERTM and Streaming
 mode
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1246730784-30052-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1246730784-30052-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain
Date: Sat, 04 Jul 2009 11:47:49 -0700
Message-Id: <1246733269.12994.212.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> Add code to config_req and config_rsp to configure ERTM and Streaming
> mode. If the remote devices specifies ERTM or Streaming Mode, we propose
> the same mode received. Otherwise we propose ERTM or Basic Mode.
> And if we are a state 2 device the remote should propose the same mode
> that we sent, if not, the channel is disconnected.

this patch has been applied to bluetooth-testing.git now. Thanks.

Regards

Marcel


