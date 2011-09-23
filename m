Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4E7C598C.8050309@bmw-carit.de>
References: <4E7C598C.8050309@bmw-carit.de>
Date: Fri, 23 Sep 2011 13:19:15 +0300
Message-ID: <CABBYNZL+TSR9RPrRZQxVeoPQ1NpzJyHiLVTOwja4bKLnPeOabQ@mail.gmail.com>
Subject: Re: SCO control in HansfreeGateway
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz@bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Sep 23, 2011 at 1:03 PM, Mikel Astiz <mikel.astiz@bmw-carit.de> wrote:
> Hi all,
>
> Some recent patches have made that the State property in HandsfreeGateway
> exposes if the SCO connection is active or not. As far as I understand, the
> state Playing is specifically added for this reason.
>
> However, I don't see any way in the D-Bus API to control the state of this
> connection. One example would be that a phone would drop the audio
> connection (it is allowed to do so at any time) but the user wants this
> connection to be re-established.

If you want to control the connection then you need to use the unix
socket or register a endpoint with org.bluez.Media.RegisterEndpoint
(recommended), for the latter you need this is your audio.conf

Enable=Media
Disable=Socket

There is some documentation about it in doc/media-api.txt and a test
script test/simple-endpoint

> Wouldn't this require the addition of some methods like ConnectAudio and
> DisconnectAudio in the HandsfreeGateway interface?

Nope, this was why we also deprecated Headset.Play/Stop, it is not up
to the application to decide when to connect but to the endpoints e.g.
if you are using PulseAudio make use of set_profile.

-- 
Luiz Augusto von Dentz
