Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: [PATCH 0/1 v2] Fix no SEP if corresponding interface is disabled
Date: Thu, 17 Feb 2011 11:31:16 +0200
Message-Id: <1297935077-25540-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Patch reworked wrt comments of Luiz provided in previous submission. Here
check is done on enabled A2DP interfaces in audio.conf configuration file.
If interface is not enabled then corresponding SEPs will not be created.

BR,
Dmitriy

