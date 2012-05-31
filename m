Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1338393023-29941-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 31 May 2012 16:22:09 +0300
Message-ID: <CABBYNZJsznaHcBrpnqLESvHmP_BwyyVhnruJ3afcn33+WZbtmw@mail.gmail.com>
Subject: Re: [PATCH obexd v3 00/14] client: Remove D-Bus agent
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Wed, May 30, 2012 at 6:50 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> Several modifications from previous version as suggested by Luiz, most significantly:
>
> * All transfers will now be exposed in D-Bus, so we need no additional flag in the internal session API. The overhead is not considered relevant.
>
> * The D-Bus signal TransferAdded has been left out (patches v2 13/17, 14/17 and 15/17).
>
> From original cover letter:
>
> This patchset includes a second set of D-Bus changes as part of a bigger API rewrite in obex-client. The original API proposal started around 6 months ago ([1]) and it has later been discussed and modified several times.
>
> This second series focuses on the replacement of the D-Bus agent: the authorization part is entirely removed and the reporting part is now addressed using D-Bus signals. The resulting API is more BlueZ-style and easier to use.
>
> A third and last patchset is left out for later discussion (not proposed yet in the ML). These should extend the D-Bus API such that the transfer-initiating methods will return relevant information (D-Bus path + properties, to be discussed) about the created transfer object.
>
> This results in a transitional API problem regarding FileTransfer interface: once the agent is removed, and before the transfer path is reported, there is no proper way to get transfer notifications. This problem can be seen in patch v0 16/16, but hopefully it's acceptable during the API transition. The fix is not included here to keep a reasonable patchset size.
> Mikel Astiz (14):
>  client: Add D-Bus helper library
>  client-doc: Add progress property to transfer
>  client: Add progress property to transfer
>  client-doc: Add transfer event-reporting signals
>  client: Add transfer event-reporting signals
>  client-doc: Remove D-Bus agent
>  client: Use transfer owner instead of agent
>  client: Remove D-Bus agent
>  client: Remove unused functions in transfer API
>  client: Remove internal transfer progress report
>  client: Remove obsolete authentication code
>  client: Expose all transfers in D-Bus
>  client: Make FileTransfer.PutFile asynchronous
>  client-test: Remove agent from ftp-client
>
>  Makefile.am        |    2 +-
>  client/agent.c     |  252 -----------------------------------
>  client/agent.h     |   43 ------
>  client/dbus.c      |  256 +++++++++++++++++++++++++++++++++++
>  client/dbus.h      |   66 +++++++++
>  client/ftp.c       |   55 ++------
>  client/session.c   |  374 ++++++----------------------------------------------
>  client/session.h   |    4 -
>  client/transfer.c  |  192 ++++++++++++++-------------
>  client/transfer.h  |    8 +-
>  doc/client-api.txt |   49 +------
>  test/ftp-client    |   50 +------
>  12 files changed, 491 insertions(+), 860 deletions(-)
>  delete mode 100644 client/agent.c
>  delete mode 100644 client/agent.h
>  create mode 100644 client/dbus.c
>  create mode 100644 client/dbus.h
>
> --

All 14 patches are now upstream.


-- 
Luiz Augusto von Dentz
