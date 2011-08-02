Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 2 Aug 2011 16:18:01 +0800
Message-ID: <CAB0WyvmynL15E0PegWmS3Kisxi4QY5k=q5-4Pg7pT3d8yagvjA@mail.gmail.com>
Subject: Regarding to TI WL1283 support in the "hciattach" command
From: "Min Jun,Xi" <xi.minjun@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Recently, I got one TI WL1283 devkit, which is not supported in the
current bluez code. When I am trying to attach it to my ubuntu desktop
by running the
    "hciattach ttyUSB0 texasalt 115200"
command, I failed because "wl1283" can not be recognized.
In order to make it work, I read through the code in
"tools/hciattach_tialt.c", and made several code changes in
"texasalt_init()" function. And here is the diff:

index 1ba009c..2514ee0 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -211,7 +211,7 @@ int texasalt_init(int fd, int speed, struct termios *ti)
        {
                unsigned short lmp_subv = resp[13] | (resp[14] << 8);
                unsigned short brf_chip = (lmp_subv & 0x7c00) >> 10;
-               static const char *c_brf_chip[8] = {
+               static const char *c_brf_chip[11] = {
                        "unknown",
                        "unknown",
                        "brf6100",
@@ -219,7 +219,10 @@ int texasalt_init(int fd, int speed, struct termios *ti)
                        "brf6300",
                        "brf6350",
                        "unknown",
-                       "wl1271"
+                       "wl1271",
+                       "unknown",
+                       "unknown",
+                       "wl1283"
                };
                char fw[100];

@@ -231,7 +234,7 @@ int texasalt_init(int fd, int speed, struct termios *ti)
                                "\tchip: %s (%d)\n",
                                lmp_subv & 0x7f,
                                ((lmp_subv & 0x8000) >> (15-3)) |
((lmp_subv & 0x380) >> 7),
-                               ((brf_chip > 7) ? "unknown" :
c_brf_chip[brf_chip]),
+                               ((brf_chip > 10) ? "unknown" :
c_brf_chip[brf_chip]),
                                brf_chip);

                sprintf(fw, "/etc/firmware/%s.bin", c_brf_chip[brf_chip]);

Is there anybody from TI can update the code to support WL1283? Or can
I commit the code to bluez? Thank you!

-- 
best regards,
Xi Minjun
