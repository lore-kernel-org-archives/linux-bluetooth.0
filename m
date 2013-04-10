Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Wed, 10 Apr 2013 16:02:03 +0300
Message-ID: <CABBYNZ+3YjTqjEnQhbqx7j1S9SD80kgUg+1kJ99vQY4nP8BOEg@mail.gmail.com>
Subject: Re: [PATCH 0/5] MAP client: Add Message Notification Service (MNS) server
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Tue, Apr 9, 2013 at 2:51 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> As follow-up on our discussions, I've split the patch set
> "MAP client: notification support" into smaller chunks that can be reviewed
> separately.
>
> This first patch set adds the Message Notification Service (MNS) server to the
> MAP client and automatically establishes/terminates the MNS connection together
> with the MAS connections.
>
> The MNS implementation will parse event reports received from the MSE and
> print debug messages for now. The dispatching of event reports to the correct
> MAS client instance will follow in a different patch set.
>
> Christian Fetzer (5):
>   profile: Add MNS server record
>   obexd: Add Message Notification Service (MNS) server
>   build: Add support for building MNS server
>   obexd: Enable MNS server
>   obexd: Automatically setup notification connection for MAP client
>
>  Makefile.obexd            |   3 +
>  obexd/client/map-event.h  |  42 ++++++
>  obexd/client/map.c        |  34 +++++
>  obexd/client/mns.c        | 363 ++++++++++++++++++++++++++++++++++++++++++++++
>  obexd/plugins/bluetooth.c |   2 +
>  obexd/src/obexd.h         |   1 +
>  src/profile.c             |  55 +++++++
>  7 files changed, 500 insertions(+)
>  create mode 100644 obexd/client/map-event.h
>  create mode 100644 obexd/client/mns.c
>
> --
> 1.8.2.1

All 5 patches are now upstream, thanks.


--
Luiz Augusto von Dentz
