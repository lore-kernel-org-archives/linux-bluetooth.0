Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Sep 2010 16:35:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/10] Media API
Message-ID: <20100915133523.GA30074@jh-x301>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Sep 13, 2010, Luiz Augusto von Dentz wrote:
> Luiz Augusto von Dentz (10):
>   Add media API documentation
>   Add rule to enabling talking to org.bluez.MediaEndpoint
>   Add option to enable/disable unix ipc via audio.conf
>   Add support for media transport in gstreamer plugin
>   Add simple-endpoint test script
>   Add initial implementation of org.bluez.Media spec
>   Introduce headset_get_inband
>   Update a2dp transport delay when it changes
>   Remove local cache for nrec and inband
>   Add proper checks for MediaTransport.SetProperty
> 
>  Makefile.am          |    6 +-
>  audio/a2dp-codecs.h  |  116 ++++++++
>  audio/a2dp.c         |  749 +++++++++++++++++++++++++++++++++++++++++--------
>  audio/a2dp.h         |   15 +
>  audio/avdtp.c        |   88 +++----
>  audio/avdtp.h        |    5 +-
>  audio/gsta2dpsink.c  |   33 ++-
>  audio/gsta2dpsink.h  |    1 +
>  audio/gstavdtpsink.c |  609 +++++++++++++++++++++++++++++++++++++++-
>  audio/gstavdtpsink.h |    6 +
>  audio/headset.c      |   10 +
>  audio/headset.h      |    1 +
>  audio/main.c         |    9 -
>  audio/manager.c      |   66 +++++
>  audio/manager.h      |    2 +
>  audio/media.c        |  689 +++++++++++++++++++++++++++++++++++++++++++++
>  audio/media.h        |   54 ++++
>  audio/sink.c         |  179 ++-----------
>  audio/source.c       |  174 ++----------
>  audio/transport.c    |  758 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  audio/transport.h    |   36 +++
>  audio/unix.c         |    1 +
>  doc/media-api.txt    |  169 +++++++++++
>  src/bluetooth.conf   |    1 +
>  test/simple-endpoint |  126 +++++++++
>  25 files changed, 3395 insertions(+), 508 deletions(-)
>  create mode 100644 audio/a2dp-codecs.h
>  create mode 100644 audio/media.c
>  create mode 100644 audio/media.h
>  create mode 100644 audio/transport.c
>  create mode 100644 audio/transport.h
>  create mode 100644 doc/media-api.txt
>  create mode 100755 test/simple-endpoint

All patches have been pushed upstream now (with the few minor changes
that we discussed). Next step: talk to PulseAudio guys and get this
merged there too.

Johan
