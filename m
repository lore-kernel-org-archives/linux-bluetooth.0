Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCHv2 0/6] Query remote services support
Date: Tue, 5 Nov 2013 14:21:34 +0100
Message-ID: <1383657700-22313-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V2:
 - function fetch_remote__uids renamed to browse_remote_sdp
 - result of browse_remote_sdp changed to uint8_t
 - sdp_req_list name changed to browse_reqs
 - browse_reqs contains requests, not addresses

Marcin Kraglak (6):
  android: Initial implementation of get_remote_services
  android: Fetch remote device uuids after pairing
  android: Pass found uuids to remote_device_properties_cb
  android: Add supported uuids when adapter is initialized
  android: Implement class of device property callback
  android: Add support for getting adapter uuids

 android/adapter.c | 313 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 305 insertions(+), 8 deletions(-)

-- 
1.8.4.1

