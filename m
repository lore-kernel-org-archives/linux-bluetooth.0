Return-Path: <SRS0=18cS=PX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FBCC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 16:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E619720868
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Jan 2019 16:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfAOQUX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:20:23 -0500
Received: from p3plsmtpa06-08.prod.phx3.secureserver.net ([173.201.192.109]:60563
        "EHLO p3plsmtpa06-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730451AbfAOQUX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Jan 2019 11:20:23 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 11:20:22 EST
Received: from JROmen ([199.48.138.4])
        by :SMTPAUTH: with ESMTPA
        id jRKpglOG0SUw0jRKpgkfRj; Tue, 15 Jan 2019 09:13:04 -0700
From:   "John Rucker" <John.Rucker@Solar-Current.com>
To:     <linux-bluetooth@vger.kernel.org>
Subject: Help troubleshooting a random Bluez 5.50 Failed to set privacy: Rejected (0x0b) error during IPL
Date:   Tue, 15 Jan 2019 10:13:03 -0600
Message-ID: <000001d4aced$31eb5540$95c1ffc0$@Solar-Current.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdSs7TFdI6a9MVzxSMWCm+tTrIgH/A==
Content-Language: en-us
X-CMAE-Envelope: MS4wfAPa0oUyCGvH2kDIgyNc2797GLErbUnZuoUNApUKQ/QxHMyWo6uBwP+QjYXbfTF/BnHowAAPBIklaz/b+B9IyFCq+OTLqoIYoDSmE7AbdYBTaxl2RrGp
 hUFJQ7ftB/CQCxNJ/pRIStKqnZhlICW9ivbSPhYZYYi+hmlKV1m9KY0m3oyI31tgl/EB3gl4g6pEoQ==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I have a Raspberry Pi Zero W setup as a Bluetooth LE peripheral based on
BlueZ 5.50 and Node.JS. I'm running this on Raspbian Stretch Lite with a
build date of November 13, 2018. I upgraded BlueZ from 5.43 to 5.50. My
blePeripheral class works well for me, I'm able to securely bind to my
iPhone and exchange encrypted data with the Raspberry Pi Zero W. as
expected.

However, If I reboot the Raspberry Pi, and the random address of the bound
device (iPad in this example) changes, that device can no longer read or
write a secure characteristic. This seems to randomly happen, sometimes I
can reboot the Pi and everything is fine. When this happens (see snipit).
If I issue a sudo systemctl restart bluetooth after I get this error
everything works great until it randomly pops up again.  I have posted more
detail on the problem here
https://www.raspberrypi.org/forums/viewtopic.php?f=66&t=229337 

I'm open for trying anything all suggestions welcome.  Thanks

snipit from journalctl -u bluetooth.  
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:set_name() sending set
local name command for index 0
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:set_mode() sending set
mode command for index 0
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:new_settings_callback()
Settings: 0x00000281
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:settings_changed()
Changed settings: 0x00000201
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:adapter_start() adapter
/org/bluez/hci0 has been enabled
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:trigger_passive_scanning()
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:trigger_passive_scanning()

Jan 15 09:51:21 rgPi1 bluetoothd[355]: Failed to set mode: Rejected (0x0b)
Jan 15 09:51:21 rgPi1 bluetoothd[355]: Failed to set mode: Rejected (0x0b)
Jan 15 09:51:21 rgPi1 bluetoothd[355]: Failed to set privacy: Rejected
(0x0b)

Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:load_link_keys_complete() link keys loaded for hci0
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:load_ltks_complete()
LTKs loaded for hci0
Jan 15 09:51:21 rgPi1 bluetoothd[355]: src/adapter.c:load_irks_complete()
IRKs loaded for hci0
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:load_conn_params_complete() Connection Parameters loaded for
hci0
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:local_name_changed_callback() Name: rGauge Transmitter
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:local_name_changed_callback() Short name:
Jan 15 09:51:21 rgPi1 bluetoothd[355]:
src/adapter.c:local_name_changed_callback() Current alias: rGauge
Transmitter

