Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/8] Bluetooth: Update mgmt to latest API specifiction
Date: Thu,  9 Feb 2012 17:23:42 +0200
Message-Id: <1328801030-24274-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set updates the kernel mgmt code to match the latest
mgmt-api.txt in user space. The main changes are the renaming of
mgmt_remove_keys to mgmt_unpair_device and the addition of an address
type parameter to serveral messages.

Johan

