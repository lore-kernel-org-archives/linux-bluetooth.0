Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/3] btattach: Use HCI UART vendor specific setup kernel calls
Date: Thu,  2 Apr 2015 16:38:00 +0200
Message-Id: <1427985483-31580-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series of patches uses the new IOCTLs introduced in RFC "Move HCI UART
vendor specific setup to kernel" previously sent.

Frederic Danis (3):
  btattach: Add SetDevType ioctl call
  btattach: Add SetBaudRate ioctl call
  btattach: Increase timeout for raw user channel creation

 tools/btattach.c  | 38 ++++++++++++++++++++++++++++++++------
 tools/hciattach.h |  2 ++
 2 files changed, 34 insertions(+), 6 deletions(-)

-- 
1.9.1

