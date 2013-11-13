Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 0/3] Check if profile local_uuid is enabled
Date: Wed, 13 Nov 2013 10:53:30 +0200
Message-Id: <1384332813-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempts to solve a problem with certain APIs that are adapter bond
such as Media interface and adapter_service_add as opposed to btd_profile
that is valid for every adapter.

Making Media API to be available on /org/bluez and perhaps tight btd_profile
and adapter_service_add should solve the problem in the long term but since
we cannot just break the API this is probably still necessary.

Luiz Augusto von Dentz (3):
  core/device: Only connect profiles which are enabled
  audio/A2DP: Set profile .local_uuid properly
  input: Fix setting .local_uuid

 profiles/audio/a2dp.c    |  2 ++
 profiles/input/manager.c |  1 -
 src/device.c             | 35 ++++++++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 6 deletions(-)

-- 
1.8.3.1

