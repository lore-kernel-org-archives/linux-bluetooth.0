Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20160921193225.23199-1-aar@pengutronix.de>
References: <20160921193225.23199-1-aar@pengutronix.de>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 22 Sep 2016 11:11:40 +0300
Message-ID: <CABBYNZJqz0W-oeupFtaQs7bxmxdvMure5q=0twhk8sy3d9ujUw@mail.gmail.com>
Subject: Re: [BlueZ] tests: example-gatt-server: change GATT_CHRC_IFACE
To: Alexander Aring <aar@pengutronix.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        revestflo@gmail.com, Szymon Janc <szymon.janc@codecoup.pl>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

On Wed, Sep 21, 2016 at 10:32 PM, Alexander Aring <aar@pengutronix.de> wrote:
> This patch changes GATT_CHRC_IFACE to GATT_DESC_IFACE. The example
> do not test this case and this is the reason why nobody detected it yet.
>
> Cc: Szymon Janc <szymon.janc@codecoup.pl>
> Suggested-by: Florent Revest <revestflo@gmail.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> Florent Revest reported this via irc and I put my "send-patches" hat on
> to send this fix to mainline.
>
> Review carefully, not tested in any case.
>
>  test/example-gatt-server | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/test/example-gatt-server b/test/example-gatt-server
> index 44ceb70..bac1687 100755
> --- a/test/example-gatt-server
> +++ b/test/example-gatt-server
> @@ -234,7 +234,7 @@ class Descriptor(dbus.service.Object):
>          if interface != GATT_DESC_IFACE:
>              raise InvalidArgsException()
>
> -        return self.get_properties()[GATT_CHRC_IFACE]
> +        return self.get_properties()[GATT_DESC_IFACE]
>
>      @dbus.service.method(GATT_DESC_IFACE,
>                          in_signature='a{sv}',
> --
> 2.9.3

Applied, note that I reworded it a little bit and removed the
Signed-off-by, etc, as we don't use that in userspace.

-- 
Luiz Augusto von Dentz
