Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv4 0/7] Support for out of band association model
Date: Tue, 23 Nov 2010 11:53:05 +0100
Message-ID: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes in this version:
  - code style/flow comments from Johan included
  - changes in D-Bus OOB api - ReadLocalOobData and provider
    register/unregister moved to adapter path (OobManager interface), provider
    is registered per adapter now
  - some bug fixes

Some things I'd like to collect comments about:
  - OobManager interface could be only available on 2.1 or higher adapters
    (this would require some adapter interface to be able check this in
    dbusoob plugin)
  - Agent's RequestPairing method name
  - RequestPairing is called only on device accepting incoming connection when
    it has OOB data for remote device (on RequestRemoteOobData event).
    Consequence is that when only initiator has OOB data RequestPairing is not
    called. We could store initiator's OOB capability in device structure (now
    only auth and cap are stored) to be able to know if initiator has OOB data.
    Yet, in such case RequestRemoteOobData on accepting device will not be 
    called and I have no idea where/when OOB capability should be check to call
    RequestPairing (and reject pairing if necessary)..


Comments are welcome.

BR,
Szymon Janc
on behalf of ST-Ericsson


Szymon Janc (7):
  Add support for Out of Band (OOB) association model
  Add D-Bus OOB plugin
  Add D-Bus OOB API documentation
  Add simple-oobprovider for testing
  Add request for accepting incoming pairing requests with OOB
    mechanism
  Update D-Bus OOB API with RequestPairing method
  Add RequestPairing method in simple-agent for accepting incoming OOB 
       pairing requests

 Makefile.am             |   10 +-
 acinclude.m4            |    6 +
 doc/oob-api.txt         |   76 +++++++++
 doc/oob-api.txt.orig    |   79 +++++++++
 lib/hci.h               |    3 +
 plugins/dbusoob.c       |  412 +++++++++++++++++++++++++++++++++++++++++++++++
 plugins/hciops.c        |  107 +++++++++++--
 src/adapter.c           |   21 +++-
 src/adapter.h           |   10 ++
 src/agent.c             |   59 +++++++-
 src/agent.h             |    3 +
 src/device.c            |   96 +++++++++++
 src/device.h            |   13 ++
 src/event.c             |   89 ++++++++---
 src/event.h             |    4 +-
 src/oob.c               |   67 ++++++++
 src/oob.h               |   47 ++++++
 test/simple-agent       |   10 ++
 test/simple-oobprovider |   57 +++++++
 19 files changed, 1131 insertions(+), 38 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 doc/oob-api.txt.orig
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h
 create mode 100755 test/simple-oobprovider

