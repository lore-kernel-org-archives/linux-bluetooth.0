Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <091c4654551ea0d3e937cc2a54809e8c3b8de226.camel@hadess.net>
Subject: Re: [PATCH BlueZ 2/4] client: Make show command print
 DiscoverableTimeout
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date: Thu, 26 Jul 2018 14:43:25 +0200
In-Reply-To: <20180725102035.19439-2-luiz.dentz@gmail.com>
References: <20180725102035.19439-1-luiz.dentz@gmail.com>
         <20180725102035.19439-2-luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2018-07-25 at 13:20 +0300, Luiz Augusto von Dentz wrote:
>         DiscoverableTimeout: 0x00000000

That seems to work, but an hex number is pretty useless here. Could you
special case DiscoverableTimeout in print_property to show a base-10
integer instead?
