Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/5] Improve robustness in Gatt Client
Date: Thu, 19 Mar 2015 10:56:26 +0100
Message-Id: <1426758991-20055-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

this is fixed and rebased version of Lukasz's patches from few weeks back.

>From original cover letter:
Last 5 patches is a same fix for shared/gatt-helpers. I did not write special
test for it as we will test it once we make Android to use it shared code.
Anyway, this change does not brake gatt unit tests


BR
Szymon

Lukasz Rymanowski (5):
  shated/gatt-helpers: Improve robustness of search service
  shared/gatt-helpers: Improve robustness of get characteristics
  shared/gatt-helpers: Improve robustness of get include services
  shared/gatt-helpers: Improve robustness read by type request
  shared/gatt-helpers: Improve robustness of get descriptors

 src/shared/gatt-helpers.c | 89 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 6 deletions(-)

-- 
1.9.3

