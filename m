Return-Path: <cyrus@holtmann.org>
Message-ID: <5143419C.1060504@oss.bmw-carit.de>
Date: Fri, 15 Mar 2013 16:43:24 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] obexd: Add RegisterNotifications function
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de> <72B23061-16D8-4949-AAB4-9537F6726FCB@holtmann.org> <51407D38.2080600@oss.bmw-carit.de> <440C26C3-24C4-4A9B-8527-C94C75F850E5@holtmann.org> <CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com>
In-Reply-To: <CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On 03/13/2013 08:57 PM, Luiz Augusto von Dentz wrote:
> Hi Christian,
>
>
> On Wed, Mar 13, 2013 at 1:27 PM, Marcel Holtmann <marcel@holtmann.org 
> <mailto:marcel@holtmann.org>> wrote:
>
>     Hi Christian,
>
>     >>> This allows applications to register for all different types
>     >>> of MAP event reports.
>     >>>
>     >>> In response to this call, the MSE should connect to the local MNS
>     >>> instance.
>     >>> ---
>     >>> doc/obex-api.txt   |  6 ++++
>     >>> obexd/client/map.c | 86
>     ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>     >>> 2 files changed, 92 insertions(+)
>     >> never ever intermix doc/ changes with actual code. You really
>     need to learn on how to split patches properly. There is no reason
>     at all that this are not two patches.
>     >>
>     >>
>     >>> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
>     >>> index 759c4d8..ef5d85e 100644
>     >>> --- a/doc/obex-api.txt
>     >>> +++ b/doc/obex-api.txt
>     >>> @@ -651,6 +651,12 @@ Methods    void SetFolder(string name)
>     >>>                     Possible errors:
>     org.bluez.obex.Error.InvalidArguments
>     >>>  org.bluez.obex.Error.Failed
>     >>>
>     >>> +           void RegisterNotifications(boolean)
>     >>> +
>     >>> +                   Register / unregister reception of
>     notifications.
>     >>> +
>     >>> +                   Possible errors:
>     org.bluez.obex.Error.InvalidArguments
>     >>> +  org.bluez.obex.Error.Failed
>
>
> Why we are not doing this automatically? The application can opt out 
> by not connecting to signals, but I see no reason why not to be 
> connected to register the notification channel automatically when 
> connecting the MAP session if the remote support it.
>
> -- 
> Luiz Augusto von Dentz

as I tried to explain, the purpose of the function in the current patch 
is to select the one device for that you will receive notifications.
I agree, it would be better to hide the notification connection setup 
and rather do it implicitly.
That needs to go hand in hand with notification support for multiple 
devices; with removing the function, you loose the possibility to select 
a device.

I'll send a suggestion for multiple device notification support in a 
separate email and try to explain the relevant spec details.
Then we can continue the discussion there.

Br,
Christian
