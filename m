Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth:  FTP and OPP over L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: Nami <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 15 Jun 2011 04:14:38 -0700
In-Reply-To: <1308109889-5597-1-git-send-email-nami.li@atheros.com>
References: <1308109889-5597-1-git-send-email-nami.li@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308136501.2518.8.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nami,

> From: nami <nami.li@atheros.com>
> 
> 
> Signed-off-by: Nami <nami.li@atheros.com>

the number one thing here is to get your GIT setup done right and follow
our polices like no signed-off-by line for bluez and obexd submissions.

> ---
>  client/main.c       |   26 +++++++----
>  client/session.c    |  119 ++++++++++++++++++++++++++++++++++++++++++++++----
>  client/session.h    |    6 +++
>  gwobex/gw-obex.c    |    6 +-
>  gwobex/gw-obex.h    |    3 +-
>  gwobex/obex-priv.c  |    4 +-
>  gwobex/obex-priv.h  |    2 +-
>  plugins/bluetooth.c |  112 +++++++++++++++++++++++++++++++++++++++++++++---
>  plugins/ftp.c       |    8 +++-
>  plugins/opp.c       |    8 +++-
>  src/obex.c          |   10 +++-
>  src/service.h       |    7 +++
>  test/main.c         |    2 +-
>  13 files changed, 275 insertions(+), 38 deletions(-)

And without even looking at the actual patch, I can tell you right now
here that you should have split this up into logical pieces. For example
gwobex should be it separate patch in the first place. And I assume
others can also be nicely split up.

These "monster" patches are not acceptable.

Regards

Marcel


