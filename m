Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 0/1] Fix unpair device when disconnected for No Bonding
Date: Mon, 11 Jul 2011 15:20:05 +0300
Message-Id: <1310386806-19305-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This version includes the fix regarding comment of Johan. Function
device_set_bonded is created and invoked when link key is stored to
file system which covers both pairing as initiator or acceptor cases.

BR,
Dmitriy

