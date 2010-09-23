Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 23 Sep 2010 13:19:42 -0300
Message-ID: <AANLkTindKFz1fx9cJMu9aSpehG5LaUHHO7TkgWqMzqj=@mail.gmail.com>
Subject: Pull request: git://git.infradead.org/users/cktakahasi/bluez.git for-upstream
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following changes since commit e7b1d878d15c0eb1bc0109c19cbdf5f84a29394d:

  Fix coding style issues in attribute client code (2010-09-22 16:33:15 -0400)

are available in the git repository at:
  git://git.infradead.org/users/cktakahasi/bluez.git for-upstream

Claudio Takahasi (23):
      Add LE start and stop scanning
      Remove RSSI field from the advertising report event
      Decoding the RSSI parameter from the advertising report event
      Send Discovering property "FALSE" when the interleave finishes
      Add length argument on hciops start discovery function
      Stop inquiry using the length parameter
      Fix remote name resolution for interleave discovery
      Add Write LE host supported function
      Set the LE host supported and disable simultaneous LE and BR/EDR flags
      Add extended feature mask constants definition
      Read the local extended features
      Stop LE scanning when discovery is suspended
      Rename hciops {start, stop}_discovery to {start, stop}_inquiry
      Don't enter on interleave mode if there isn't active sessions
      Code cleanup: improving inquiry logic
      Clear the remote device found list in the state transition
      Fix periodic inquiry signals
      Fixing DeviceDisappeared signal
      Postpone discovery if still resolving names
      Add adapter discovery type function
      Do not send another Discovering TRUE signal if still resolving names
      Forcing periodic inquiry exit
      Fix interleave scanning

Vinicius Costa Gomes (1):
      Add BR/EDR LE interleaved discovery

 lib/hci.c        |   29 +++++
 lib/hci.h        |   17 +++-
 lib/hci_lib.h    |    1 +
 plugins/hciops.c |   53 +++++++++-
 src/adapter.c    |  302 +++++++++++++++++++++++++++++++++++++-----------------
 src/adapter.h    |   37 ++++---
 src/dbus-hci.c   |   45 +++++++--
 src/dbus-hci.h   |    1 +
 src/security.c   |  133 ++++++++++++++----------
 9 files changed, 436 insertions(+), 182 deletions(-)


Implements interleave discovery for dual mode adapters(LE and BR/EDR).
Now, the behavior is:
1) for single mode: LE scanning for 5.12 seconds every DiscoverSchedulerInterval
2) for BR/EDR only: still the same
3) for dual mode: inquiry(5.12) sec, LE scanning(5.12) sec, resolve
names. The next discovery interval is controlled by
DiscoverSchedulerInterval.

Signals still the same, the idea is try to hide from the users/apps
the discovery internals. No mater the adapter type(LE only, BR/EDR or
Dual Mode)
PropertyChanged("Discovering", TRUE/FALSE) is sent to notify when a
new discovery "session" starts/finishes. Found LE devices are reported
using DeviceFound() signals.

Regards,
Claudio
-- 
--
Claudio Takahasi
Instituto Nokia de Tecnologia
Recife - Pernambuco - Brasil
+55 81 30879999
