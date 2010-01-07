Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Fix memory leak in l2cap
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
In-Reply-To: <508e92ca0912230317t3e5ff05ep9f51ef326e5e9de7@mail.gmail.com>
References: <508e92ca0912230317t3e5ff05ep9f51ef326e5e9de7@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jan 2010 19:47:40 -0800
Message-ID: <1262836060.16627.456.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Hi, Please check following patch (also attached)
> 
> Move skb_clone after error confition check so it is not going
> potentially out of the scope.

patch has been applied. Thanks.

Regards

Marcel


