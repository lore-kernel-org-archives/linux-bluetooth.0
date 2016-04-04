Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <57025247.3080709@nomovok.com>
References: <57025247.3080709@nomovok.com>
Date: Mon, 4 Apr 2016 16:04:20 +0300
Message-ID: <CABBYNZ+AxeD1SJ7DV1=FWGT_269nwbpksyXmkseAU-evcdS-RA@mail.gmail.com>
Subject: Re: property changes emited but not captured, why?::
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Yunchuan Geng <yunchuan.geng@nomovok.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Yunchuan,

On Mon, Apr 4, 2016 at 2:38 PM, Yunchuan Geng <yunchuan.geng@nomovok.com> wrote:
> Hi,
>
> I am testing map-client python script from bluez-5.30. Everything works
> fine, except that I found I can not capture the properties change signal,
> which I confirmed from log did been emitted from parse_subject function in
> obexd/client/map.c
>
> In order to check if the signal is captured in python script or not, I have
> patched the script like this. But have not catch any signal the
> parse_subject
> function has emitted.
>
> Could anyone tell me why and how to correctly capture property changes
> emitted by g_dbus_emit_property_changed function.
>
>
> Yunchuan
>
> =====Patch=====
> diff --git a/test/map-client b/test/map-client
> index b9695da..634b91a 100755
> --- a/test/map-client
> +++ b/test/map-client
> @@ -118,6 +119,9 @@ class MapClient:
>                 mainloop.quit()
>
>         def properties_changed(self, interface, properties, invalidated,
> path):
> +                print(properties)
> +                print(interface)
> +                print(path)
>                 req = self.props.get(path)
>                 if req == None:
>                         return
>

Have you tried using obexctl or the idea is to use python? I guess it
is perhaps not subscribing to the signal properly.

-- 
Luiz Augusto von Dentz
