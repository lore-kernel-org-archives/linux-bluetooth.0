Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd 00/10] Major API changes in obex-client
Date: Thu, 24 Nov 2011 15:08:52 +0100
Message-ID: <1322143742-31182-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series splits the perviously proposed obex-client API into incremental changes. The goal is to agree on the desired API before starting with the implementation.

There are some differences with respect to the previous proposal, mainly:

- The representation of devices has been dropped for now and considered of lower priority.

- Progress-reporting signals are not defined as unicast signals, assuming that the perfomance overhead might not be significant.

- Some operations such as PhonebookAccess.List have not been changed either, although it would be possible (as included in the previous proposal) to also use a file-based transfer here.

Also note that the Transfer interface has been left inside the client-specific API, but would ideally be shared with the server. This is something to be kept in mind now in the design of the API.

Mikel Astiz (10):
  client-doc: reformatted to fit in 80 columns
  client-doc: copyright statement added
  client-doc: minor formatting changes
  client-doc: wrap OPP into specific session type
  client-doc: replace parameter dict with conventional ones
  client-doc: remove agent in favour of transfer signals
  client-doc: ObjectPush sessions return transports
  client-doc: FileTransfer sessions return transports
  client-doc: PhonebookAccess sessions return transports
  client-doc: Synchronization sessions return transports

 doc/client-api.txt |  265 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 148 insertions(+), 117 deletions(-)

-- 
1.7.6.4

