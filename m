Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/3] Bluetooth: Add kernel-side SMP self-tests
Date: Sat, 25 Oct 2014 21:15:36 +0200
Message-Id: <1414264539-19068-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set adds some simple self-tests for the SMP crypto functions.
The tests are disabled by default and need to be enabled with a new
config option in order to be compiled in.

Johan

----------------------------------------------------------------
Johan Hedberg (3):
      Bluetooth: Pass only crypto context to SMP crypto functions
      Bluetooth: Add skeleton for SMP self-tests
      Bluetooth: Add self-tests for SMP crypto functions

 net/bluetooth/Kconfig |   6 ++
 net/bluetooth/smp.c   | 150 ++++++++++++++++++++++++++++++++++++++++------
 2 files changed, 138 insertions(+), 18 deletions(-)


