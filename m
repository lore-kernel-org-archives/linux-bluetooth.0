Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix debug messages logging from non-built-in plugins
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org,
	par-gunnar.p.hjalmdahl@stericsson.com, ulrik.lauren@stericsson.com
Date: Mon, 25 Jul 2011 15:30:52 +0200
In-Reply-To: <1311592144-14140-1-git-send-email-szymon.janc@tieto.com>
References: <1311592144-14140-1-git-send-email-szymon.janc@tieto.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1311600655.8920.0.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>  audio/main.c           |    2 +-
>  health/hdp_main.c      |    1 +
>  input/main.c           |    2 +-
>  network/main.c         |    1 +
>  plugins/adaptername.c  |    2 +-
>  plugins/formfactor.c   |    2 +-
>  plugins/gatt-example.c |    2 +-
>  plugins/hciops.c       |    2 +-
>  plugins/mgmtops.c      |    2 +-
>  plugins/service.c      |    2 +-
>  plugins/storage.c      |    2 +-
>  sap/main.c             |    1 +
>  serial/main.c          |    1 +
>  src/log.c              |   25 +++++++++++++++++++++++++
>  src/log.h              |    8 ++++++++
>  src/plugin.c           |   10 +++++++---
>  src/plugin.h           |    8 ++++++--
>  17 files changed, 59 insertions(+), 14 deletions(-)

before you do such a massive change, please explain what you are trying
to do. This change effects multiple projects (obexd, ConnMan, oFono
etc.) that are essentially using the same infrastructure.

Regards

Marcel


