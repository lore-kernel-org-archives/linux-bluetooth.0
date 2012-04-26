Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH RFC BlueZ v2 0/1] LE Broadcaster/Observer API proposal
Date: Thu, 26 Apr 2012 17:03:25 -0400
Message-Id: <1335474206-21914-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Changes since v1:

* Add UpdateBroadcastData() (suggested by Chen Ganir)
* Add Broadcasting/Observing adapter properties (based on Chen's suggestion)


This patch contains an API proposal for implementing LE Broadcaster/Observer
roles in BlueZ. These roles allow to transfer data unidirectionally (from
Broadcaster to Observer) in a connectionless setup. See Core spec Vol 3, Part
C, section 9.1 for more details.

The API consists on extending the Adapter API to support Observer/Broadcaster
procedures. These are implemented as methods separate from Discovery, given
that Broadcaster devices are non-connectable and non-discoverable.

Multiple D-Bus clients can register for Observer mode, as well as for
Broadcaster. BlueZ is thus responsible for constructing the Adv. Data (in
Broadcaster mode) or routing the broadcast data (in Observer mode) to the
applications.

On Broadcaster, each application registers the values to be broadcast. Note
that some advertising types cannot be registered by multiple applications (they
can only appear once on the Adv. data), and thus a second registration attempt
will fail with a proper error message. Some advertising data types are also
managed internally by BlueZ and are not available for external applications.

On Observer, the application(s) register(s) a callback that will be called only
when the specified Adv. types are present on the received advertising event.

We considered using signals for broadcast data, but it turns out it can cause
too much D-Bus traffic given that all registered applications will receive the
signals. The callback approach allows to ignore broadcasts which have no
information relevant to an application.

These are the currently known adv. data types (as listed on the Core
Specification Supplement v1):

* 1.1 Service UUID: managed internally by BlueZ as LE services are registered
  (same as BR/EDR)
* 1.2 Local Name: managed internally by BlueZ (same as BR/EDR)
* 1.3 Flags: managed internally by BlueZ based on discovery status
* 1.4 Manufacturer Specific Data: this is freely defined, and can be registered
  by multiple applications
* 1.5 TX Power Level: managed internally by BlueZ (application can enable
  broadcast, but cannot control the value)
* 1.6, 1.7, 1.8 (not applicable for AD or EIR)
* 1.9 Slave Connection Interval Range: managed internally by BlueZ (once we
  support dynamic connection parameters)
* 1.10 Service Solicitation: managed internally by BlueZ as LE services are
  registered
* 1.11 Service Data: this is freely defined per-service data. Not sure if it is
  interesting to be available for external applications
* 1.12 Appearance: managed internally by BlueZ
* 1.13 Public Target Address: managed internally by BlueZ (useful for
  notifications/indications)
* 1.14 Random Target Address: managed internally by BlueZ (useful for
  notifications/indications)

Therefore, only "Manufacturer specific data" (and maybe "Service data") are
currently available for external Broadcaster applications. In future, other
Broadcaster/Observer based profiles may add new adv. types, so we need a
extensible solution.

Note that this proposal does not describe the necessary mgmt API changes. This
will come once we agree on the higher level D-Bus API. But it should be
expected that new commands for enabling/disabling observer/broadcaster modes
and setting adv. data will be necessary, as well as modifying the current
kernel code that ignores non-connectable advertising (which are used by
Observers).

A few open topics:

* It is still not clear when actual scanning (for Observer) or advertising (for
  Broadcaster) will start. It cannot conflict with any ongoing Discovery
  session on the Observer side. We may want to check the supported LE states on
  the kernel side.
* Duplicate filtering affects Broadcaster role. So it is interesting to be able
  to enable/disable it as necessary.
* Given that maximum Adv. data size is very limited (31 bytes), we may want to
  implement some algorithm to "split" or "interleave" advertising data. We
  could not find any references to this on the Core specifications. Suggestions
  or ideas how to handle this are welcome.
* Adv. data can appear either on adv. reports or in scan responses (sent when
  Observer does a active scan), but usually not in both. We may want to have a
  way to set which adv. types will go on each case. Note that some adv. types
  may not be allowed in either adv. reports or scan responses.
* Scan and advertising parameters are not covered on this proposal. We expect
  to have a common setting mechanism which may be used for Central/Peripheral
  roles (e.g. LE HID will probably need configurable scan parameters as well),
  so it will be discussed in a separate proposal.

Comments and suggestions are welcome.

Anderson Lizardo (1):
  doc: Document Broadcaster/Observer API

 doc/adapter-api.txt |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

-- 
1.7.5.4

