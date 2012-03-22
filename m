Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 0/7] A2DP MP3 support with media API
Date: Thu, 22 Mar 2012 17:37:48 +0100
Message-Id: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I'm trying to make A2DP MP3 work in pulseaudio using media API.
In contrast to Unix API, media API lacks the possibility to reconfigure the
transport BT_SET_CONFIGURATION. So I've defined a dbus API that offers a
similar functionnality.
First there is a MediaTransport.Codecs property to list supported codecs on a
transport.
Then there is a Reconfigure method that tries to reconfigure the transport
to use a specified endpoint.

I'm sending a patch on pulseaudio list for using this new APIs at same time.

This is an RFC so feel free to comment, especially on the way a configuration
could be specified.

Regards,
Frédéric


Frédéric Dalleau (7):
  media: Remove unimplemented declaration
  doc: document MediaTransport.Codecs property
  doc: document MediaTransport.Reconfigure
  media: Add Codecs property to MediaTransport
  media: add dbus method MediaTransport.Reconfigure
  media: implement media_endpoint_find function
  media: implement a2dp reconfiguration

 audio/media.c     |   16 +++++
 audio/media.h     |    3 +-
 audio/transport.c |  164 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/media-api.txt |   12 ++++
 4 files changed, 193 insertions(+), 2 deletions(-)

-- 
1.7.5.4

