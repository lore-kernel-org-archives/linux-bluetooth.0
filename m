Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 2/3] all: Use G_SOURCE_REMOVE/G_SOURCE_CONTINUE macros
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1384016586.3880.37.camel@nuvo>
Date: Mon, 11 Nov 2013 17:04:20 +0900
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <BCD6D340-765E-45BB-AC3E-7A0C98348773@holtmann.org>
References: <1384016586.3880.37.camel@nuvo>
To: Bastien Nocera <hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Instead of TRUE/FALSE. This makes the source more readable.
> ---
> android/main.c                       |  4 ++--
> attrib/gattrib.c                     |  2 +-
> attrib/gatttool.c                    |  2 +-
> gdbus/mainloop.c                     |  6 +++---
> gdbus/object.c                       |  2 +-
> gdbus/watch.c                        |  2 +-
> gobex/gobex.c                        |  4 ++--
> obexd/client/session.c               |  4 ++--
> obexd/client/transfer.c              |  6 +++---
> obexd/plugins/messages-dummy.c       |  2 +-
> obexd/plugins/messages-tracker.c     |  2 +-
> obexd/plugins/phonebook-dummy.c      |  6 +++---
> plugins/policy.c                     |  6 +++---
> profiles/audio/a2dp.c                | 16 ++++++++--------
> profiles/audio/avctp.c               | 12 ++++++------
> profiles/audio/avdtp.c               | 14 +++++++-------
> profiles/audio/avrcp.c               |  2 +-
> profiles/audio/player.c              |  4 ++--
> profiles/cyclingspeed/cyclingspeed.c |  2 +-
> profiles/health/hdp.c                |  4 ++--
> profiles/health/mcap.c               |  2 +-
> profiles/health/mcap_sync.c          | 18 +++++++++---------
> profiles/input/device.c              | 10 +++++-----
> profiles/network/connection.c        |  2 +-
> profiles/proximity/monitor.c         |  4 ++--
> profiles/sap/server.c                |  4 ++--
> src/adapter.c                        | 20 ++++++++++----------
> src/device.c                         | 16 ++++++++--------
> src/main.c                           |  4 ++--
> src/sdp-client.c                     |  2 +-
> src/shared/hciemu.c                  |  2 +-
> src/shared/tester.c                  | 18 +++++++++---------
> tools/btiotest.c                     |  6 +++---
> unit/test-gdbus-client.c             |  4 ++--
> unit/test-gobex-transfer.c           |  2 +-
> unit/test-gobex.c                    |  4 ++--
> unit/test-sdp.c                      |  2 +-
> 37 files changed, 111 insertions(+), 111 deletions(-)
> 
> diff --git a/android/main.c b/android/main.c
> index 75004cf..a36269c 100644
> --- a/android/main.c
> +++ b/android/main.c
> @@ -377,7 +377,7 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
> static gboolean quit_eventloop(gpointer user_data)
> {
> 	g_main_loop_quit(event_loop);
> -	return FALSE;
> +	return G_SOURCE_REMOVE;
> }

problem is that we currently only require GLib 2.28 and this got introduced in GLib 2.32.

Regards

Marcel

