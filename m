Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 22:26:17 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: haijun liu <liuhaijun.er@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 22/22] Parse EFS & EWS parameters for in
 l2cap_parse_conf_rsp
Message-ID: <20100826012617.GH16062@vigoh>
References: <AANLkTimQsNmOc-Mv30xA0x_NEpxvs4kXjGfuOfqHxEDP@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimQsNmOc-Mv30xA0x_NEpxvs4kXjGfuOfqHxEDP@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Haijun,

* haijun liu <liuhaijun.er@gmail.com> [2010-08-26 06:41:02 +0800]:

> From 72afc40895eb272269156b98ab3024ac4f130b0d Mon Sep 17 00:00:00 2001
> From: haijun.liu <haijun.liu@atheros.com>
> Date: Wed, 25 Aug 2010 22:08:47 +0800
> Subject: [PATCH 22/22] Parse EFS & EWS parameters for in l2cap_parse_conf_rsp.
> 
> ---
>  net/bluetooth/l2cap.c |   35 ++++++++++++++++++++++++++++++-----
>  1 files changed, 30 insertions(+), 5 deletions(-)

For 20, 21 and 22. Create a separeted patches for EFS and EWS, they are
different stuff and do not overstep the column 80 when coding.

Fix that and the we can do another review ;)

-- 
Gustavo F. Padovan
ProFUSION embedded systems - http://profusion.mobi
