Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: 'Bharat Bhusan Panda' <bharat.panda@samsung.com>, cpgs@samsung.com,
	'Grzegorz Kolodziejczyk' <grzegorz.kolodziejczyk@tieto.com>,
	'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>
Subject: Query regarding bneptest tool
Date: Mon, 11 May 2015 16:36:33 +0530
Message-id: <001a01d08bda$91503ab0$b3f0b010$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

I am testing BlueZ bnep test tool (tools/bneptest) using PTS 6.1.0.
The BNEP client test cases are not passing in BT_IO_SEC_MEDIUM security
level.
My PTS PICS and PIXIT are same as android/pixit-bnep.txt,
android/pics-bnep.txt.
Whereas when the security level is BT_IO_SEC_LOW, it is passing.
If it is a valid fix, then I will send a patch for the same.
This is tested in Linux, not sure about android.


diff --git a/tools/bneptest.c b/tools/bneptest.c
index 98ee9b1..fccecd2 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -477,7 +477,7 @@ static int bnep_client_connect(void)
                                        BT_IO_OPT_SOURCE_BDADDR, &src_addr,
                                        BT_IO_OPT_DEST_BDADDR, &dst_addr,
                                        BT_IO_OPT_PSM, BNEP_PSM,
-                                       BT_IO_OPT_SEC_LEVEL,
BT_IO_SEC_MEDIUM,
+                                       BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
                                        BT_IO_OPT_OMTU, BNEP_MTU,
                                        BT_IO_OPT_IMTU, BNEP_MTU,
                                        BT_IO_OPT_INVALID);


Regards,
Gowtham Anandha Babu

