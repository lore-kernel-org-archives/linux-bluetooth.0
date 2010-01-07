Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Remove double free of skb pointer
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <508e92ca0912220656j6913ef64w4bd6c1557079d0b5@mail.gmail.com>
References: <508e92ca0912220656j6913ef64w4bd6c1557079d0b5@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 06 Jan 2010 19:47:38 -0800
Message-ID: <1262836058.16627.455.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> Trivial fix for double free of skb pointer with kfree_skb to
> make code simplier and cleaner. Remove unused variable err.

patch has been applied. Thanks.

Regards

Marcel


