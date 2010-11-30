Return-Path: <cyrus@holtmann.org>
From: Mike Tsai <Mike.Tsai@Atheros.com>
To: Mike Tsai <Mike.Tsai@Atheros.com>,
	Szymon Janc <szymon.janc@tieto.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Tue, 30 Nov 2010 13:26:36 -0800
Subject: RE: [PATCHv4 0/7] Support for out of band association model
Message-ID: <35B17FE5076C7040809188FBE7913F98406D68D125@SC1EXMB-MBCL.global.atheros.com>
References: <1290509592-9262-1-git-send-email-szymon.janc@tieto.com>
 <35B17FE5076C7040809188FBE7913F98406D68CFAB@SC1EXMB-MBCL.global.atheros.com>
In-Reply-To: <35B17FE5076C7040809188FBE7913F98406D68CFAB@SC1EXMB-MBCL.global.atheros.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

	Correction on my comments below,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Mike Tsai
Sent: Tuesday, November 30, 2010 8:02 AM
To: Szymon Janc; linux-bluetooth@vger.kernel.org
Subject: RE: [PATCHv4 0/7] Support for out of band association model

Hi Szymon,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Szymon Janc
Sent: Tuesday, November 23, 2010 2:53 AM
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc
Subject: [PATCHv4 0/7] Support for out of band association model

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

[MTsai]7.7.44 Remote OOB Data Request Event.
If host has received remote peer's OOB data before pairing, the host shall set the "OOB present" flag of the peer device. This "OOB present" flag will be sent over the air as part of pairing process with lmp_ioCap_Req or lmp_iocap_rsp.
If either one of the devices have OOB data, then OOB shall be used to do the pairing.
The event "Remote OOB Data Request Event" shall be sent to host before calculating the commitment value.
The LM state machine shall call "device_request_oob_data" when either local or remote peer has "OOB data present". I think this part of the code is not present.

[Mtsai correction]
The local OOB data present is set when host send HCI command "Read Local OOB Data". And this "OOB data present" flag is sent over the air to peer device during pairing.

The LM state machine is inside the controller firmware, so there is no issue on the stack code you submitted.

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

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
