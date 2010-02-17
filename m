Return-Path: <cyrus@holtmann.org>
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [Patch 0/2] Resend: Fix hcidump compilation with bluez-4.61+
Date: Wed, 17 Feb 2010 13:49:40 +0100
Message-Id: <1266410982-26964-1-git-send-email-stefan.seyfried@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Bluez 4.61 broke compilation of hcidump.
The first patch fixes this for bluez 4.61, the second patch implements an
(admittedly ugly) hack to also allow to compile hcidump with older bluez
versions.
