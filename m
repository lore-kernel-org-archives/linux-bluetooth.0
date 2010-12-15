Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/1] AVDTP SRC stream send buffer size verification
Date: Wed, 15 Dec 2010 11:48:52 +0200
Message-Id: <1292406533-18574-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

In this patch, send buffer size for L2CAP socket is verified against
outgoing L2CAP MTU size and increased to be twice of it if it is less
than that. Such verification is done for AVDTP source transport channel
only.

Reason to do this check is that system default socket buffer size was
reduced in Meego and it affected IOP with some car-kits that use large
MTUs.

Worth to mention that send buffer size is never decreased, and can be
increased only.

BR,
Dmitriy

