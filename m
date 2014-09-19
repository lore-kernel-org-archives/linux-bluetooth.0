Return-Path: <cyrus@holtmann.org>
From: Varka Bhadram <varkabhadram@gmail.com>
To: linux-wpan@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc: alan@signal11.us, Varka Bhadram <varkab@cdac.in>
Subject: [PATCH bluetooth-next v2 0/3] cleanup for mrf24j40 driver
Date: Fri, 19 Sep 2014 10:15:07 +0530
Message-Id: <1411101911-12462-1-git-send-email-varkab@cdac.in>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

changes since v1:
 - changes in commit messages and descriptions suggested by Alan Ott

Varka Bhadram (3):
  mrf24j40: fix Missing a blank line after declarations
  mrf24j40: remove unnecessary return statement
  mrf24j40: use pr_* / dev_* instead of printk()

 drivers/net/ieee802154/mrf24j40.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
1.7.9.5

