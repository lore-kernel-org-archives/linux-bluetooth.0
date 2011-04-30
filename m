Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 00/16] Discovery procedure refactoring
Date: Fri, 29 Apr 2011 21:27:16 -0300
Message-Id: <1304123252-14464-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Today, discovery procedure is supported only in hciops. This refactoring has
been done to provide easier implementation of discovery procedure in mgmtops.
Lots of effort would be necessary to implement discovery procedure in mgmtops
because its logic is spread out adapter layer and hciops layer.

The approach this patchset follows is moving all logic related to discovery
procedure from adapter layer to hciops layer.

Future work will be:
        - full support for discovery procedure (BR/EDR, LE-Only, BR/EDR/LE
          devices) in kernel via management interface (today, only BR/EDR is
          supported).
        - name resolving support through mgmt interface (kernel + userspace)

Thanks,
Guedes.

Anderson Briglia (1):
  Implement mgmt start and stop discovery

Andre Guedes (15):
  Add discovery callbacks to btd_adapter_ops
  Replace inquiry/scanning calls by discovery calls
  Add 'discov_state' field to struct dev_info
  Code cleanup event.c
  Remove Periodic Inquiry support in hciops
  Change DiscoverSchedulerInterval default value
  Add 'timeout' param to start_scanning callback
  Refactoring adapter_set_state()
  Remove 'suspend' param from stop_discovery()
  Add extfeatures to struct dev_info
  Implement start_discovery hciops callback
  Remove obsolete code.
  Implement stop_discovery hciops callback
  Remove inquiry and scanning callbacks from btd_adapter_ops
  Remove 'periodic' param from hciops_start_inquiry()

 plugins/hciops.c  |  373 ++++++++++++++++++++++++++++++++++++-----------------
 plugins/mgmtops.c |   35 ++----
 src/adapter.c     |  217 ++++++++++---------------------
 src/adapter.h     |   19 +--
 src/event.c       |   48 +-------
 src/event.h       |    1 -
 src/main.conf     |    4 +-
 7 files changed, 345 insertions(+), 352 deletions(-)

