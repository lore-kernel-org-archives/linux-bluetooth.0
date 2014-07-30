Return-Path: <cyrus@holtmann.org>
From: varkabhadram@gmail.com
To: linux-zigbee-devel@lists.sourceforge.net
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com,
	Varka Bhadram <varkab@cdac.in>
Subject: [PATCH bluetooth-next 0/2] 6lowpan cleanup
Date: Wed, 30 Jul 2014 11:05:10 +0530
Message-Id: <1406698512-29405-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Varka Bhadram <varkab@cdac.in>

This series removes the unused macros and function for 6lowpan

Varka Bhadram (2):
  6lowpan: remove unused macros
  6lowpan: remove unused function

 include/net/6lowpan.h |   26 --------------------------
 1 file changed, 26 deletions(-)

-- 
1.7.9.5

