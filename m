Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 00/10] Bluetooth: Fix more mgmt parameter checks
Date: Fri, 18 Jan 2013 15:25:48 +0200
Message-Id: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch set is intended to be applied after Szymon's "Bluetooth: Fix
pair device command reply if adapter is powered off" patch.

This set includes fixes to improve the validity checks on parameters we
receive from user space in mgmt commands. Each of these fixes has had
its own test case added to the user space mgmt-tester and has been
verified to work.

Johan

