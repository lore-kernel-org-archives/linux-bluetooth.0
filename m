Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Clean up Obex btio.[ch] and make it self contained
Date: Thu, 19 Aug 2010 22:21:08 +0800
Message-Id: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series of patches is to seperate btio.[ch] from src to btio directory. To make btio.[ch] self contained for obexd, there're some cleanup work:

1. remove unused bt_io_set(). It is neither used by bluez or obexd.
2. remove unused SCO/L2RAW related code for Obexd. Note: BlueZ code requires SCO/L2RAW related functions. We may consider to add them back later.
3. replace void *userdata with gpointer userdata. To make it consistent with bluez btio.c
4. refactor hci_devba into devid2ba. Remove dependence with hci*.h
5. Remove libbluetooth dependence for obexd.

Regards,
Zhenhua
