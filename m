Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC PATCH BlueZ] LE Broadcaster/Observer API proposal
Date: Wed, 11 Apr 2012 21:04:27 -0400
Message-Id: <1334192668-21433-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

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

On Broadcaster, multiple applications cannot broadcast the same Adv. data type.
On Observer, the application(s) register(s) a callback that will be called only
when the specified Adv. types are present on the received advertising event.

We considered using signals for broadcast data, but it turns out it can cause
too much D-Bus traffic given that all registered applications will receive the
signals. The callback approach allows to ignore broadcasts which have no
information relevant to an application.

Note that this proposal does not describe the necessary mgmt API changes. This
will come once we agree on the higher level D-Bus API. But it should be
expected that new commands for enabling/disabling observer/broadcaster modes
and setting adv. data will be necessary, as well as modifying the current
kernel code that ignores non-connectable advertising (which are used by
Observers).

Comments and suggestions are welcome.

Anderson Lizardo (1):
  doc: Document Broadcaster/Observer API

 doc/adapter-api.txt |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

-- 
1.7.5.4

--
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
