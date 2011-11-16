Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/17] Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:47 -0400
Message-Id: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series fix various places where variables which get errno values (usually
named "err") are not following the convention of always being negative. The
last 3 patches are simple fixes found during this review.

Best Regards,
--
Anderson Lizardo
Instituto Nokia de Tecnologia (INdT)
Manaus - Brazil

