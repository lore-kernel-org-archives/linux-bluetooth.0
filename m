Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/4] Add hciops_allow_sniff to disable and restore LMP_SNIFF bit
Date: Tue, 24 Jan 2012 14:58:52 +0200
Message-Id: <1327409936-6709-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

The following set of patches introduces disabling/enabling sniff bit
in link policy settings. Further, the sniff mode is than disallowed
while SCO channel is open.

This helps to avoid problems in instability in some of TI controllers
firmware when sniff request comes from remote device during an active
call. Real impact is that controller becomes unconnectable eventhough
page scan is enabled.

Any comments, and possibly ideas, would be highly appreciated.

BR,
Dmitriy

