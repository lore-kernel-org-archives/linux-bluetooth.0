Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <cc36d73d51a53e1638494e52ce48c7e102bc532f.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/4] client: Add discoverable-timeout command
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 26 Jul 2018 14:43:06 +0200
In-Reply-To: <20180725102035.19439-1-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-07-25 at 13:20 +0300, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds discoverable-timeout command which can be used to get/set
> DiscoverableTimeout property:
> 
> [bluetooth]# discoverable-timeout 180
> Changing discoverable-timeout 180 succeeded

Tested ok here.
