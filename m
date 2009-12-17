Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: fix unset of RemoteBusy flag
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
Cc: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
In-Reply-To: <1260899794-5107-1-git-send-email-gustavo@las.ic.unicamp.br>
References: <1260899794-5107-1-git-send-email-gustavo@las.ic.unicamp.br>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Dec 2009 12:06:12 -0800
Message-Id: <1261080372.4041.47.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> RemoteBusy flag need to be unset before l2cap_ertm_send(), otherwise
> l2cap_ertm_send() will return without sending packets because it checks
> that flag before start sending.

patch has been applied. Thanks.

Regards

Marcel


