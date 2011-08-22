Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/1] Fix remove temporary link key for No Bonding
Date: Mon, 22 Aug 2011 16:45:38 +0300
Message-Id: <1314020739-15376-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch takes into account comment of Luiz about moving
btd_adapter_remove_bonding in device_set_paired(device, FALSE).

Br,
Dmitriy

