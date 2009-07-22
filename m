Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org
Subject: [PATCH 0/3] Initial support for ERTM
Date: Wed, 22 Jul 2009 06:29:33 -0300
Message-Id: <1248254976-12090-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These 3 patches add a basic support for ERTM (without retransmission). The code
is able to send I-frames with txWindow up to 63 and send/receive RR S-frames
to acknowledge packets (first patch).

The third patch adds Segmentation and Reassembly which permits that upper
layers use MTU values greater than MPS value. To segment packets we use a
separated queue, and then append it to the end of tx_queue. To reassembly we
use a sk_buff to reconstruct the SDU on the other side.

Second patch is just a code clean up.


include/net/bluetooth/bluetooth.h |    3 +-
include/net/bluetooth/l2cap.h     |  164 +++++++++++-
net/bluetooth/l2cap.c             |  554 +++++++++++++++++++++++++++++++------
3 files changed, 638 insertions(+), 83 deletions(-)

