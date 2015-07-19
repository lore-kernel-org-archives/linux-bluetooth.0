Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?I=C3=B1aki=20Arenaza?= <iarenaza@mondragon.edu>
Subject: [PATCH v2 0/1] device: Some devices send HSP UUIDs in the wrong order
Date: Sun, 19 Jul 2015 16:55:55 +0200
Message-Id: <1437317756-29432-1-git-send-email-iarenaza@mondragon.edu>
In-Reply-To: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
References: <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the updated version of the patch, taking Luiz Augusto's comments into
account. See <1436823169-32164-1-git-send-email-iarenaza@mondragon.edu> for the
original details.

Iñaki Arenaza (1):
  device: Some devices send HSP UUIDs in the wrong order

 lib/uuid.h   |  1 +
 src/device.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

-- 
2.1.4

