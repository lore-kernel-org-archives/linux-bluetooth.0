Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/2] Add support for prepare writes authorization
Date: Wed,  2 May 2018 11:17:55 +0200
Message-Id: <20180502091757.24190-1-grzegorz.kolodziejczyk@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set adds support for prepare writes authorization handling.
This case covers "GATT/SR/GAW/BI-11-C [Write Long Characteristic Value –
Insufficient Authorization]" PTS test case. If authorization property doesn't
exist or is set to true then daemon doesn't bother application database
with authorization ask and behaves as before.

This patch set is on top of: 72c0c310fd2940d0989af2371728e743894ffcbc
(client: Define maximum attribute value length as initial value)

Grzegorz Kolodziejczyk (2):
  shared/gatt-server: Request authorization for prepare writes.
  client: Add authorized property handling to characteristic attribute

 client/gatt.c            | 46 ++++++++++++++++++++++++++++++++++
 doc/gatt-api.txt         |  8 ++++++
 src/gatt-database.c      |  6 +++++
 src/shared/gatt-server.c | 64 +++++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 115 insertions(+), 9 deletions(-)

-- 
2.13.6

