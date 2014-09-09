Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 0/3] Fix for sdp-client in reconnect scenario
Date: Tue,  9 Sep 2014 11:02:07 +0200
Message-Id: <1410253330-27768-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes following error scenario:
1. Local device does sdp search and cache sdp session.
2. Peer device disconnect and connect again
3. Local device wants to do sdp search again on outdated sdp session

If those 3 steps will happen withing 2 sec, we face the issue.

Those patch fixes that.
Automated test which easly triggers that will come from Jakub.
(Hid Host reconnect test)

Lukasz Rymanowski (3):
  sdp-client: Extract cleanup function for cached session
  sdp-client: Add disconnect watch for cached session
  sdp-client: Minor code style fix

 src/sdp-client.c | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

-- 
1.8.4

