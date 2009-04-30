Return-Path: <cyrus@holtmann.org>
From: ngh@isomerica.net
To: linux-bluetooth@vger.kernel.org
Subject: Revamped Enhanced Retransmission mode L2CAP support
Date: Thu, 30 Apr 2009 17:16:37 -0400
Message-Id: <1241126207-19996-1-git-send-email-ngh@isomerica.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


This is a reworking of the previous patchset I submitted.  This includes fixes
from Marcel's comments.

 include/net/bluetooth/bluetooth.h |    3 
 include/net/bluetooth/l2cap.h     |  101 +++++-
 net/bluetooth/l2cap.c             |  628 ++++++++++++++++++++++++++++++++++----
 3 files changed, 665 insertions(+), 67 deletions(-)



    --Nathan
