Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 0/4] Bluetooth: Patch set for ERTM
Date: Mon, 27 Jul 2009 03:17:00 -0300
Message-Id: <1248675424-20977-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches enable some parts of Enhanced Retransmission Mode. Now we already
support Sending I-frames; acknowledgment of packets; segmentation and
reassembly of SDU; retransmission of I-frames due to a recept of a S-frame; and
retransmission and monitor timers.

Still need to be done: treatment of busy conditions; support to ask
retransmission using a SREJ S-frame; implement missing parts of this things;
and put all this code to work together as specified by L2CAP ERTM state
tables. Then we will have Enhanced Retransmission on Bluez! :-)

Cheers!

include/net/bluetooth/bluetooth.h |    4 +-
include/net/bluetooth/l2cap.h     |   82 +++++-
net/bluetooth/l2cap.c             |  633 ++++++++++++++++++++++++++++++++-----
3 files changed, 631 insertions(+), 88 deletions(-)
