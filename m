Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com
Subject: [PATCH BlueZ v2] Fix unpair device when disconnected for No Bonding
Date: Mon,  4 Jul 2011 16:40:27 +0300
Message-Id: <1309786828-11792-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is updated version of earlier patch that avoids reading of bonding
information from file system.

Here, device_is_bonded function is not introduced, as was suggested,
since it is not seen as necessary.

Br,
Dmitriy

