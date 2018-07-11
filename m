Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Jul 2018 16:45:01 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez: dbus method call for switching endpoint
Message-ID: <20180711144501.ovdxc2expa4bg6sc@pali>
References: <20180711082352.oo6srapfnol5nkxq@pali>
 <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CABBYNZJuGT5_zhg-BkAc4XjtVu5His92cHTujrin=SMOVbaodQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wednesday 11 July 2018 16:27:07 Luiz Augusto von Dentz wrote:
> One way to solve all of these is that we would expose the remote
> endpoints using MediaEndpoint1

So client application (like pulseadio) would see list of remote
endpoints (one for each codec) and choose one for connection?

Looks like this should solve this problem.

> though only SelectConfiguration would
> be really useful here and that doesn't contain the remote capabilities
> that probably should be made into properties, along with codec type
> and uuid.

Remote capabilities are needed. And for codec type == vendor it is needed
to know also vendor id and codec id.

> Besides a good headset would probably
> remember what codec you selected the last time and just connect with
> it, this btw is what I would do when operating as a sink.

I hope that Linux would support also not-so-good headsets.

Anyway, dual booting between systems which support different set of
codecs makes those "good headset" with remember support just
"no-so-good" one.

-- 
Pali Rohár
pali.rohar@gmail.com
