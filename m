Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Dec 2013 16:00:09 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] all: Use G_SOURCE_REMOVE/G_SOURCE_CONTINUE macros
Message-ID: <20131205140009.GA27251@x220.p-661hnu-f1>
References: <1384937788.10231.5.camel@nuvo>
 <20131205133527.GA10825@x220.p-661hnu-f1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131205133527.GA10825@x220.p-661hnu-f1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Dec 05, 2013, Johan Hedberg wrote:
> On Wed, Nov 20, 2013, Bastien Nocera wrote:
> > 
> > Instead of TRUE/FALSE. This makes the source more readable.
> > ---
> >  attrib/gattrib.c                     |  2 +-
> >  attrib/gatttool.c                    |  2 +-
> >  configure.ac                         |  8 ++++++++
> >  gdbus/mainloop.c                     |  6 +++---
> >  gdbus/object.c                       |  2 +-
> >  gdbus/watch.c                        |  2 +-
> >  gobex/gobex.c                        |  4 ++--
> >  obexd/client/session.c               |  4 ++--
> >  obexd/client/transfer.c              |  6 +++---
> >  obexd/plugins/messages-dummy.c       |  2 +-
> >  obexd/plugins/messages-tracker.c     |  2 +-
> >  obexd/plugins/phonebook-dummy.c      |  6 +++---
> >  plugins/policy.c                     |  6 +++---
> >  profiles/audio/a2dp.c                | 16 ++++++++--------
> >  profiles/audio/avctp.c               | 12 ++++++------
> >  profiles/audio/avdtp.c               | 14 +++++++-------
> >  profiles/audio/avrcp.c               |  2 +-
> >  profiles/audio/player.c              |  4 ++--
> >  profiles/cyclingspeed/cyclingspeed.c |  2 +-
> >  profiles/health/hdp.c                |  4 ++--
> >  profiles/health/mcap.c               |  2 +-
> >  profiles/health/mcap_sync.c          | 18 +++++++++---------
> >  profiles/input/device.c              | 10 +++++-----
> >  profiles/network/connection.c        |  2 +-
> >  profiles/proximity/monitor.c         |  4 ++--
> >  profiles/sap/server.c                |  4 ++--
> >  src/adapter.c                        | 20 ++++++++++----------
> >  src/device.c                         | 16 ++++++++--------
> >  src/main.c                           |  4 ++--
> >  src/sdp-client.c                     |  2 +-
> >  src/shared/hciemu.c                  |  2 +-
> >  src/shared/tester.c                  | 18 +++++++++---------
> >  tools/btiotest.c                     |  6 +++---
> >  unit/test-gdbus-client.c             |  4 ++--
> >  unit/test-gobex-transfer.c           |  2 +-
> >  unit/test-gobex.c                    |  4 ++--
> >  unit/test-sdp.c                      |  2 +-
> >  37 files changed, 117 insertions(+), 109 deletions(-)
> 
> Applied. Thanks.

Correction, I had to take this back out because of the gdbus changes
which should at least be independent.

Johan
