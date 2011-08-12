Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Aug 2011 15:29:23 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 0/8] client: isolate target/profile code
Message-ID: <20110812122923.GA30885@dell>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Fri, Aug 12, 2011, Luiz Augusto von Dentz wrote:
> This patches aim to make obex-client more modular and easier to
> add new profiles/targets.
> 
> It works similarly to a built-in plugin, but without messing around with
> the build system, modules are hardcoded directly in the vtable in manager.c
> so manager_init also initialize the modules which then can register their
> drivers.
> 
> Luiz Augusto von Dentz (8):
>   client: add target module vtable
>   client: move __obex_log_init before manager_init
>   client: add target driver support
>   client: make use of obc_ prefix for public functions
>   client: add opp target
>   client: add ftp target
>   client: add pbap target
>   client: add sync target
> 
>  Makefile.am       |    7 +-
>  client/agent.c    |   30 ++--
>  client/agent.h    |   20 ++--
>  client/driver.c   |   85 ++++++++++++
>  client/driver.h   |   35 +++++
>  client/ftp.c      |  146 +++++++++++++++-----
>  client/ftp.h      |    8 +-
>  client/main.c     |    4 +-
>  client/manager.c  |  101 +++++++++-----
>  client/opp.c      |   53 ++++++++
>  client/opp.h      |   25 ++++
>  client/pbap.c     |  136 +++++++++++++------
>  client/pbap.h     |    7 +-
>  client/session.c  |  380 ++++++++++++++++++++++++++---------------------------
>  client/session.h  |   49 ++++----
>  client/sync.c     |   95 ++++++++++---
>  client/sync.h     |    7 +-
>  client/transfer.c |  108 ++++++++--------
>  client/transfer.h |   35 +++---
>  19 files changed, 857 insertions(+), 474 deletions(-)
>  create mode 100644 client/driver.c
>  create mode 100644 client/driver.h
>  create mode 100644 client/opp.c
>  create mode 100644 client/opp.h

Applied. Thanks.

Johan
