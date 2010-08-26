Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 21:55:35 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 22/22] Parse EFS & EWS parameters for in
 l2cap_parse_conf_rsp
Message-ID: <20100826005535.GA16062@vigoh>
References: <AANLkTimQsNmOc-Mv30xA0x_NEpxvs4kXjGfuOfqHxEDP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimQsNmOc-Mv30xA0x_NEpxvs4kXjGfuOfqHxEDP@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:41:02 +0800]:

> From 72afc40895eb272269156b98ab3024ac4f130b0d Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Wed, 25 Aug 2010 22:08:47 +0800
> Subject: [PATCH 22/22] Parse EFS & EWS parameters for in l2cap_parse_conf_rsp.
> 
> ---
>  net/bluetooth/l2cap.c |   35 ++++++++++++++++++++++++++++++-----
>  1 files changed, 30 insertions(+), 5 deletions(-)

For all patches here, please write a proper commit title and message in
your patches. The subject should always start with "Bluetooth:" and then
briefly describe your changes in the patch. It's recommended to not use
more than 50 letters in the subject and never use more than 72 letters.

And then you have the commit message, there you explain everything it's
needed to understand the patch.

Also you need a Signed-off-by line in the commit, and fixes your git
configuration to show your name instead of your email id.

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
