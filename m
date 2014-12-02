Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: d.kasatkin@samsung.com, bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH 0/5] Add support for decoding RFCOMM MCC Message Type
Date: Tue, 02 Dec 2014 15:07:32 +0530
Message-id: <1417513057-16037-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set implements the handlers for decoding
MSC, RPN, RLS, PN, NSC frames for RFCOMM in bluetooth
monitor.


Gowtham Anandha Babu (5):
  monitor/rfcomm.c: Add support for MSC frame decoding
  monitor/rfcomm: Add support for RPN frame decoding
  monitor/rfcomm: Add support for RLS frame decoding
  monitor/rfcomm: Add support for PN frame decoding
  monitor/rfcomm: Add support for NSC frame decoding

 monitor/rfcomm.c | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 236 insertions(+), 7 deletions(-)

-- 
1.9.1

