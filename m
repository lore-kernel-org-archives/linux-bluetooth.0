Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Cc: Nathan Holstein <nathan@lampreynetworks.com>
Subject: [PATCH] *** SUBJECT HERE ***
Date: Wed, 29 Apr 2009 21:42:23 -0400
Message-Id: <1241055744-12140-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Nathan Holstein <nathan@lampreynetworks.com>

This is a revamping of the previous patches that I submited.  I started from
scratch, rebase all the changes onto the latest bluetooth-testing (2.6.30-rc3).
While applying the changes, I attempted to clean up the code and apply the
input from Marcel and Gustavo.

Unfortunately, I did not get a chance to test this for regressions vs. the
previous version of the code.  I did remove the code which segmented outgoing
PDUs: it wouldn't have worked with the current tx window=1, and would have
produced memory leaks.

The code is available from git://staticfree.info/git/el2cap on branch "ertm".

Nathan Holstein (9):
  Add #defines and data structures for enhanced L2CAP
  Add support for sending enhanced L2CAP data
  Add support for sending L2CAP S-frames.
  Append RFC option when configuring an L2CAP socket.
  Add support for parsing enhanced L2CAP configuration options.
  Add support for receiving data over an enhanced L2CAP channel
  Check the FCS of a received L2CAP packet.
  Reassemble segmented L2CAP PDUs upon reception
  Add support for negotiating new L2CAP options after a failed
    configuration

 include/net/bluetooth/bluetooth.h |    3 +-
 include/net/bluetooth/l2cap.h     |  124 +++++++-
 net/bluetooth/l2cap.c             |  607 ++++++++++++++++++++++++++++++++++---
 3 files changed, 673 insertions(+), 61 deletions(-)

