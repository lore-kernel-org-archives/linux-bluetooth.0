Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix debug messages logging from non-built-in plugins
Date: Mon, 25 Jul 2011 16:01:32 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "par-gunnar.p.hjalmdahl@stericsson.com" <par-gunnar.p.hjalmdahl@stericsson.com>,
 "ulrik.lauren@stericsson.com" <ulrik.lauren@stericsson.com>
References: <1311592144-14140-1-git-send-email-szymon.janc@tieto.com> <1311600655.8920.0.camel@aeonflux>
In-Reply-To: <1311600655.8920.0.camel@aeonflux>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201107251601.32653.szymon.janc@tieto.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> >  audio/main.c           |    2 +-
> >  health/hdp_main.c      |    1 +
> >  input/main.c           |    2 +-
> >  network/main.c         |    1 +
> >  plugins/adaptername.c  |    2 +-
> >  plugins/formfactor.c   |    2 +-
> >  plugins/gatt-example.c |    2 +-
> >  plugins/hciops.c       |    2 +-
> >  plugins/mgmtops.c      |    2 +-
> >  plugins/service.c      |    2 +-
> >  plugins/storage.c      |    2 +-
> >  sap/main.c             |    1 +
> >  serial/main.c          |    1 +
> >  src/log.c              |   25 +++++++++++++++++++++++++
> >  src/log.h              |    8 ++++++++
> >  src/plugin.c           |   10 +++++++---
> >  src/plugin.h           |    8 ++++++--
> >  17 files changed, 59 insertions(+), 14 deletions(-)
> 
> before you do such a massive change, please explain what you are trying
> to do. This change effects multiple projects (obexd, ConnMan, oFono
> etc.) that are essentially using the same infrastructure.

Currently we are not able to see any debug messages from external plugins.
This regression was introduced with dynamic debug support and mostly (probably)
hits android platform which does build some plugins as external so files.

I can declare 'struct btd_debug_section' in plugin.h instead if you prefer.
That way log.h will not have to be included before plugin.h and will make this
patch smaller, yet having it declared in log.h seems better for me.. 

-- 
BR
Szymon Janc
