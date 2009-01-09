Return-Path: <cyrus@holtmann.org>
From: "Liu, Raymond" <raymond.liu@intel.com>
To: YAO Ye <yesiryao@qq.com>
CC: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Fri, 9 Jan 2009 10:05:19 +0800
Subject: RE: openobex vs. obexd vs. obex-data-server
Message-ID: <0463F45F3606F4428ED35AC8C709F92E047EC02E@pdsmsx502.ccr.corp.intel.com>
References: <tencent_35783ED162416CF800F4F938@qq.com>
In-Reply-To: <tencent_35783ED162416CF800F4F938@qq.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi YaoYe
>
>Happy new year, everyone !
>Thx for the great SW -- bluez !
>I am a new user of bluez. My questions is about file transfer based on bluez.
>
>what is the defference between: openobex, obexd, obex-data-server ?

I think openobex is the implementation of obex protocol, while obexd and obex-data-server is the implementation of the profiles base on obex.

>I have porting bluez4 to my pxa310 handheld platform.
>so, which one is the best/more suit one for me to use ?
>

For a handheld platform, I guess openobex + obexd might be somehow more suitable for you since obexd is aim to be light-weighted to support FTP/PBAP/OPP etc with a single daemon. But it really depends on your own choice.

Raymond
