Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [RFC 4/4] client: Print LEAddress type in show and info commands
Date: Mon, 11 Dec 2017 11:38:37 +0100
Message-Id: <20171211103837.25150-4-szymon.janc@codecoup.pl>
In-Reply-To: <20171211103837.25150-1-szymon.janc@codecoup.pl>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/main.c b/client/main.c
index f3369e89a..a1d941e30 100644
--- a/client/main.c
+++ b/client/main.c
@@ -872,6 +872,7 @@ static void cmd_show(int argc, char *argv[])
 	print_property(proxy, "Powered");
 	print_property(proxy, "Discoverable");
 	print_property(proxy, "Pairable");
+	print_property(proxy, "LEAddressType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "Discovering");
@@ -1447,6 +1448,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "Blocked");
 	print_property(proxy, "Connected");
 	print_property(proxy, "LegacyPairing");
+	print_property(proxy, "LEAddressType");
 	print_uuids(proxy);
 	print_property(proxy, "Modalias");
 	print_property(proxy, "ManufacturerData");
-- 
2.14.3

