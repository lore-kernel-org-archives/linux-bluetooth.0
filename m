Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH RFC BlueZ 00/16] Phone Alert Status GATT Profile (server)
Date: Mon, 26 Sep 2011 15:13:26 -0400
Message-Id: <1317064422-1654-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This RFC series contains our current work in progress for Phone Alert Status
GATT profile (server role). This profile was recently adopted and you can find
it on the Bluetooth SIG page:

https://www.bluetooth.org/Technical/Specifications/adopted.htm

We are sending these patches now for public review, and to discuss a few
implementation issues. A few notes about the implementation:

* Some events monitored by the profile require access to the session bus. Our
  approach was to introduce an Agent which listens on the session bus and sends
  events to BlueZ (which listens to system bus).

* The "Phone Agent" contains two D-Bus methods: SetSilentMode() and
  CancelSilentMode(). These methods map to the same functions found on the PAS
  profile. The implementation is platform specific, but on N9 (Harmattan) it
  asks the profile daemon to change to/from the "Silent" profile.

* The Alert Server exports three D-Bus methods: RegisterAgent(),
  NotifyRingerSetting(), NotifyAlertStatus(). These methods are called by the
  agent to notify platform specific events which cause either Ringer Setting or
  Alert Status (Ringer, Vibrator, Display) changes.

There are a number of know issues:

* The agent API is not stable yet. We are unsure if yet another agent is the
  best solution. Any ideas? (Remember: there is a requirement to read things
  from session bus).

* There is a call to NGF (N9 specific component) inside alert/server.c. This
  should be moved to the Maemo6/harmattan specific code inside BlueZ. Ideally,
  we should move anything platform-specific and shared between profiles (e.g.
  the "Stop Ringtone" call used by HFP which is now used by Phone Alert) to a
  common place in BlueZ.

Feedback is very welcome.

Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil

