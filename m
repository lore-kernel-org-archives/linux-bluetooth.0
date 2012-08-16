Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v3 00/14] LE General Connection Establishment procedure
Date: Thu, 16 Aug 2012 18:28:30 -0300
Message-Id: <1345152524-13404-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series implement the LE General Connection Establishment procedure
for LE connections.

If there are LE bonded devices marked for auto connection they are added
to a connect_list on the adapter. When there is any device on this list
scan is performed continuously. When a device is found the connect_list
is checked. If that device is on the list scan is stopped and a
connection attempt is made to that device.

If any client tries to perform discovery and the scan for the General
Connection Establishment procedure is active, the discovery request is
queued and performed right after the GCEP scan session finishes.

This series changes quite a lot the LE connection logic, but we've been
testing and using this code at INdT for about 4 weeks. Any comments and
more testing are appreciated.

Claudio Takahasi (7):
  core: Control connections based on adapter state
  mgmt: Add LE scanning callback
  core: Replace interleaved by LE scanning
  core: Start LE scanning when a device requests
  core: Remove leftover define
  core: Queue discovery if scanning is active
  core: Re-connect for ECONNRESET or ECONNABORTED

João Paulo Rechi Vita (5):
  mgmt: print error message when start_discovery fails
  core: add compare function for bdaddr in a struct btd_device
  core: Add a list of LE devices to connect
  core: use adapter connect list for LE connections
  core: mutually exclude concurrent connections

Paulo Alcantara (1):
  core: Disable unnecessary auto connections

Vinicius Costa Gomes (1):
  test: Fix exiting the bus when a discovery session ends

 src/adapter.c       | 189 +++++++++++++++++++++++++++++++++++++++++++++-------
 src/adapter.h       |   5 ++
 src/device.c        |  65 ++++++++----------
 src/device.h        |   2 +
 src/mgmt.c          |  41 +++++++++++-
 src/mgmt.h          |   1 +
 test/test-discovery |   8 ---
 7 files changed, 241 insertions(+), 70 deletions(-)

-- 
1.7.11.2

