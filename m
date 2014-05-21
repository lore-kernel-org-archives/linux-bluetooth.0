Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv4 0/4] MTU negotiation
Date: Wed, 21 May 2014 16:17:31 +0200
Message-Id: <1400681855-7438-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

V4 changes:
	* add check for application type allowing only client to send request
	* simplified mtu handling, its stored in device on every change so there
		is no need to take it out of attrib io channel every time
	* added patches 3 and 4

Jakub Tyszkowski (4):
  android/gatt: Send Exchange MTU request on connect
  android/gatt: Use g_attrib buffer where possible for att
  android/gatt: Make att_handler use g_attrib buffer
  android/gatt: Use default mtu on mtu exchange response

 android/gatt.c | 221 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 168 insertions(+), 53 deletions(-)

--
1.9.3

