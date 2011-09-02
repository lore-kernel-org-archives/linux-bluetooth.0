Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 00/11] Re-connections triggered by platform event
Date: Fri,  2 Sep 2011 18:38:30 -0300
Message-Id: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial proposal to enable re-connection(for ATT) started by platform/
user actions. eg: Screen unlocked.

Use case: When the user unlock the screen, automatic re-connections for
bonded devices will be started. It will remain active for 3 minutes
(configurable).

The code needs cleanup, I am exposing the idea to get feedback before
clean the code and fix corner cases. In order to achieve better control
of re-connections, "Pending" state needs to be extended to LE. At the
moment, only BR/EDR supports setting a connection request as pending
when the controller returns Command Disallowed.

Development branch:
git://git.infradead.org/users/cktakahasi/bluez.git proximity-devel-w35

Comments/Suggestions?

BR,
Claudio.

Anderson Briglia (1):
  Add display lock watcher on maemo6 plugin

Claudio Takahasi (10):
  Remove timer to trigger connection attempts
  Add set auto connect in device
  Add continuous connection attempt
  Add checking if profiles are requesting connection
  Add tracking of connect sources
  Disable automatic connections after 3 minutes
  Notify unlocked event when using maemo6 plugin
  Add automatic connect timeout config option
  Add an interval between connection attempts
  Enable re-connections when disconnected

 plugins/maemo6.c |   33 ++++++++++++++++++
 src/adapter.c    |   43 +++++++++++++++++++++++
 src/adapter.h    |    1 +
 src/device.c     |   99 ++++++++++++++++++++++++++++++++++++++----------------
 src/device.h     |    1 +
 src/hcid.h       |    1 +
 src/main.c       |   12 ++++++
 src/main.conf    |    6 +++
 8 files changed, 167 insertions(+), 29 deletions(-)

-- 
1.7.6

