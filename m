Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Media API
Date: Mon, 13 Sep 2010 17:15:27 +0300
Message-Id: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Hi,

Now that DBus 1.4 has finally been released I guess it is time to integrate
the Media API that I've been working since the beginning of the year. For
those not aware of what it is about the discussion can be found here:

  http://thread.gmane.org/gmane.linux.bluez.kernel/4125

For now it is disabled by default to avoid a build dependency on DBus 1.4 and
to buy some time while Im working to getting it working reliably with
PulseAudio. To enable it just add the following to /etc/bluetooth/audio.conf
(won't work if DBus is < 1.3 but better use 1.3.1 or latter):

  Enable=<...,>Media

It can be used together with old unix socket, but I also add the possibility to
complete disable it by doing (highly suggested if the system is running PA):

  Disable=<...,>Socket

To register endpoint test/simple-endpoint can be used, note that it will not
stream anything, it basically configure a transport object which can be used by
e.g. gstreamer plugin:

  $./simple-endpoint
   dbus.Dictionary({'Codec': dbus.Byte(0), 'UUID': '0000110A-0000-1000-8000-00805F9B34FB', 'DelayReporting': True, 'Capabilities': dbus.Array([dbus.Byte(255), dbus.Byte(255), dbus.Byte(2), dbus.Byte(64)], signature=None)}, signature=None)
   SelectConfiguration (dbus.Array([dbus.Byte(255), dbus.Byte(255), dbus.Byte(2), dbus.Byte(32)], signature=dbus.Signature('y')))
   SetConfiguration (/org/bluez/16530/hci0/dev_00_0D_3C_B1_DD_56/fd0, dbus.Array([dbus.Byte(33), dbus.Byte(21), dbus.Byte(2), dbus.Byte(32)], signature=dbus.Signature('y')))

  $gst-launch-0.10 filesrc location=<file to stream> ! decodebin ! audioconvert ! sbcenc ! a2dpsink transport=/org/bluez/16530/hci0/dev_00_0D_3C_B1_DD_56/fd0

Or for mp3:

  $./simple-endpoint hci0 mp3source
   dbus.Dictionary({'Codec': dbus.Byte(1), 'UUID': '0000110A-0000-1000-8000-00805F9B34FB', 'Capabilities': dbus.Array([dbus.Byte(63), dbus.Byte(7), dbus.Byte(255), dbus.Byte(254)], signature=None)}, signature=None)
   SelectConfiguration (dbus.Array([dbus.Byte(63), dbus.Byte(7), dbus.Byte(255), dbus.Byte(254)], signature=dbus.Signature('y')))
   SetConfiguration (/org/bluez/15317/hci0/dev_00_0D_3C_B1_DD_56/fd2, dbus.Array([dbus.Byte(33), dbus.Byte(2), dbus.Byte(0), dbus.Byte(128)], signature=dbus.Signature('y')))

  $gst-launch-0.10 filesrc location=<file to stream> ! mp3parse ! a2dpsink transport=/org/bluez/15317/hci0/dev_00_0D_3C_B1_DD_56/fd2

Endpoints can be used with old unix socket so it should not break anything if
Media API got enabled but Socket doesn't got disabled, but note that PA will
probably try to use/lock if one register a sbcsource.

There are things that doesn't work though:

  - Simple-endpoint uses fixed configuration for sbc and mp3, also it should
  probably support streaming and more codecs via gstreamer to make it easier to
  test.
  - A2dp setconf callback need to be change since right now it expect a return
  from the endpoint but in case of MediaEndpoit this has to be async. For now
  it will block while waiting for SetConfiguration reply of the endpoint. Also
  to support BlueZ x BlueZ streams this has to take less than 4 sec. otherwise
  it will timeout on the requestor side, so timeout for SetConfiguration is set
  to 3 sec.
  - Properties such as Delay, NREC and InbandRingtone are not really writeable
  right now.

Luiz Augusto von Dentz (10):
  Add media API documentation
  Add rule to enabling talking to org.bluez.MediaEndpoint
  Add option to enable/disable unix ipc via audio.conf
  Add support for media transport in gstreamer plugin
  Add simple-endpoint test script
  Add initial implementation of org.bluez.Media spec
  Introduce headset_get_inband
  Update a2dp transport delay when it changes
  Remove local cache for nrec and inband
  Add proper checks for MediaTransport.SetProperty

 Makefile.am          |    6 +-
 audio/a2dp-codecs.h  |  116 ++++++++
 audio/a2dp.c         |  749 +++++++++++++++++++++++++++++++++++++++++--------
 audio/a2dp.h         |   15 +
 audio/avdtp.c        |   88 +++----
 audio/avdtp.h        |    5 +-
 audio/gsta2dpsink.c  |   33 ++-
 audio/gsta2dpsink.h  |    1 +
 audio/gstavdtpsink.c |  609 +++++++++++++++++++++++++++++++++++++++-
 audio/gstavdtpsink.h |    6 +
 audio/headset.c      |   10 +
 audio/headset.h      |    1 +
 audio/main.c         |    9 -
 audio/manager.c      |   66 +++++
 audio/manager.h      |    2 +
 audio/media.c        |  689 +++++++++++++++++++++++++++++++++++++++++++++
 audio/media.h        |   54 ++++
 audio/sink.c         |  179 ++-----------
 audio/source.c       |  174 ++----------
 audio/transport.c    |  758 ++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/transport.h    |   36 +++
 audio/unix.c         |    1 +
 doc/media-api.txt    |  169 +++++++++++
 src/bluetooth.conf   |    1 +
 test/simple-endpoint |  126 +++++++++
 25 files changed, 3395 insertions(+), 508 deletions(-)
 create mode 100644 audio/a2dp-codecs.h
 create mode 100644 audio/media.c
 create mode 100644 audio/media.h
 create mode 100644 audio/transport.c
 create mode 100644 audio/transport.h
 create mode 100644 doc/media-api.txt
 create mode 100755 test/simple-endpoint

