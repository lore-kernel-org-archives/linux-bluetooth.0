Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 0/4] patch set for l2cap parser on hcidump
Date: Sun,  9 Aug 2009 05:41:05 -0300
Message-Id: <1249807269-21494-1-git-send-email-gustavo@las.ic.unicamp.br>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches add support to dump data from the new L2CAP features such as Enhanced Retransmission and Streaming Modes and FCS Option(a crc16 check).
It also adds a .gitignore file for the whole hcidump.


.gitignore     |   28 ++++++++++++++++++++++++++++
parser/l2cap.c |   35 ++++++++++++++++++++++++++++++++++-
2 files changed, 62 insertions(+), 1 deletions(-)
