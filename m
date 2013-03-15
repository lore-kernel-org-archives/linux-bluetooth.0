Return-Path: <cyrus@holtmann.org>
Message-ID: <51434084.6060905@oss.bmw-carit.de>
Date: Fri, 15 Mar 2013 16:38:44 +0100
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v3 5/8] obexd: Add RegisterNotifications function
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de> <72B23061-16D8-4949-AAB4-9537F6726FCB@holtmann.org> <51407D38.2080600@oss.bmw-carit.de> <440C26C3-24C4-4A9B-8527-C94C75F850E5@holtmann.org> <CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com>
In-Reply-To: <CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------050003050404070805030306"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------050003050404070805030306
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

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
Then we can discuss it.

Br,
Christian

--------------050003050404070805030306
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Luiz,<br>
      <br>
      On 03/13/2013 08:57 PM, Luiz Augusto von Dentz wrote:<br>
    </div>
    <blockquote
cite="mid:CABBYNZKcYCHg0oy2fr=uf0UwN8Mivi8jhfLfd4=jYjgzrwLWYQ@mail.gmail.com"
      type="cite">
      <div dir="ltr">Hi Christian,
        <div class="gmail_extra"><br>
          <br>
          <div class="gmail_quote">On Wed, Mar 13, 2013 at 1:27 PM,
            Marcel Holtmann <span dir="ltr">&lt;<a
                moz-do-not-send="true" href="mailto:marcel@holtmann.org"
                target="_blank">marcel@holtmann.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex">
              <div class="HOEnZb">
                <div class="h5">Hi Christian,<br>
                  <br>
                  &gt;&gt;&gt; This allows applications to register for
                  all different types<br>
                  &gt;&gt;&gt; of MAP event reports.<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; In response to this call, the MSE should
                  connect to the local MNS<br>
                  &gt;&gt;&gt; instance.<br>
                  &gt;&gt;&gt; ---<br>
                  &gt;&gt;&gt; doc/obex-api.txt &nbsp; | &nbsp;6 ++++<br>
                  &gt;&gt;&gt; obexd/client/map.c | 86
                  ++++++++++++++++++++++++++++++++++++++++++++++++++++++<br>
                  &gt;&gt;&gt; 2 files changed, 92 insertions(+)<br>
                  &gt;&gt; never ever intermix doc/ changes with actual
                  code. You really need to learn on how to split patches
                  properly. There is no reason at all that this are not
                  two patches.<br>
                  &gt;&gt;<br>
                  &gt;&gt;<br>
                  &gt;&gt;&gt; diff --git a/doc/obex-api.txt
                  b/doc/obex-api.txt<br>
                  &gt;&gt;&gt; index 759c4d8..ef5d85e 100644<br>
                  &gt;&gt;&gt; --- a/doc/obex-api.txt<br>
                  &gt;&gt;&gt; +++ b/doc/obex-api.txt<br>
                  &gt;&gt;&gt; @@ -651,6 +651,12 @@ Methods &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp; &nbsp;void SetFolder(string name)<br>
                  &gt;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Possible errors:
                  org.bluez.obex.Error.InvalidArguments<br>
                  &gt;&gt;&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp;org.bluez.obex.Error.Failed<br>
                  &gt;&gt;&gt;<br>
                  &gt;&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; void
                  RegisterNotifications(boolean)<br>
                  &gt;&gt;&gt; +<br>
                  &gt;&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Register / unregister
                  reception of notifications.<br>
                  &gt;&gt;&gt; +<br>
                  &gt;&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; Possible errors:
                  org.bluez.obex.Error.InvalidArguments<br>
                  &gt;&gt;&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                  &nbsp;org.bluez.obex.Error.Failed<br>
                </div>
              </div>
            </blockquote>
          </div>
          <br>
          Why we are not doing this automatically? The application can
          opt out by not connecting to signals, but I see no reason why
          not to be connected to register the notification channel
          automatically when connecting the MAP session if the remote
          support it.<br clear="all">
          <div><br>
          </div>
          -- <br>
          Luiz Augusto von Dentz
        </div>
      </div>
    </blockquote>
    <br>
    as I tried to explain, the purpose of the function in the current
    patch is to select the one device for that you will receive
    notifications.<br>
    I agree, it would be better to hide the notification connection
    setup and rather do it implicitly.<br>
    That needs to go hand in hand with notification support for multiple
    devices; with removing the function, you loose the possibility to
    select a device.<br>
    <br>
    I'll send a suggestion for multiple device notification support in a
    separate email and try to explain the relevant spec details.<br>
    Then we can discuss it.<br>
    <br>
    Br,<br>
    Christian<br>
  </body>
</html>

--------------050003050404070805030306--
