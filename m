Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC v4 0/8]  DBus OutOfBand API update
Date: Mon, 13 Aug 2012 12:46:32 +0200
Message-ID: <1344854800-20972-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

changes since V3:
- remove of DeviceFound signal (rationale below)
- remove of UUIDs from AddRemoteData dictionary
- AlreadyPaired -> AlreadyExist error change
- proposed implementation


After some more thinking about OOB API I've decided that emitting
DeviceFound signal when OOB data are provided is not the best thing to do.

Typical usecase with dbusoob plugin is to provide oob data and either start
pairing with CreatePairedDevice or wait for incoming pairing request. No need
to emit DeviceFound as OOB provider is already aware of device address and can
start pairing. If it doesn't provide pairing agent for device there will be
fallback to adapter agent (which doesn't need to know anything about OOB
channel).


For UUIDs removal is similar - OOB provider already knows which UUIDs are
supported by remote device and based on that can choose to pair or not. No
need to provide that to bluetoothd as it would be only used in DeviceFound
signal anyway.

Comments are welcome.

-- 
BR
Szymon Janc

Szymon Janc (8):
  dbusoob: Update API
  dbusoob: Simplify remove_remote_data
  dbusoob: Change ReadLocalData to match new API
  dbusoob: Change AddRemoteData to match new API
  dbusoob: Add support for Class in AddRemoteData
  dbusoob: Add support for Name in AddRemoteData
  dbusoob: Reply with error if SSP is not supported
  Update test/test-oob to match new DBus OOB API

 doc/oob-api.txt   |   59 ++++++++++++++--
 plugins/dbusoob.c |  193 +++++++++++++++++++++++++++++++++++++++++++++--------
 src/adapter.c     |    5 ++
 src/adapter.h     |    2 +
 src/mgmt.c        |    7 ++
 src/mgmt.h        |    2 +
 test/test-oob     |    4 +-
 7 files changed, 235 insertions(+), 37 deletions(-)

-- 
1.7.9.5

