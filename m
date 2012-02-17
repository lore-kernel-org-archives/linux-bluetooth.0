Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH hcidump 2/2] core: Add support for passing PSM as OBEX port
Date: Fri, 17 Feb 2012 11:48:55 +0200
Message-Id: <1329472135-14123-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1329472135-14123-1-git-send-email-luiz.dentz@gmail.com>
References: <1329472135-14123-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As OBEX can now use L2CAP as transport, -O/--obex option should accept
values other than RFCOMM channel, so values over 31 are now interpreted
as PSM.
---
 src/hcidump.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index 0c13360..36eedc5 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -855,7 +855,7 @@ static void usage(void)
 	"  -R, --raw                  Dump raw data\n"
 	"  -C, --cmtp=psm             PSM for CMTP\n"
 	"  -H, --hcrp=psm             PSM for HCRP\n"
-	"  -O, --obex=channel         Channel for OBEX\n"
+	"  -O, --obex=port            Channel/PSM for OBEX\n"
 	"  -P, --ppp=channel          Channel for PPP\n"
 	"  -D, --pppdump=file         Extract PPP traffic\n"
 	"  -A, --audio=file           Extract SCO audio data\n"
@@ -904,6 +904,7 @@ int main(int argc, char *argv[])
 	int defpsm = 0;
 	int defcompid = DEFAULT_COMPID;
 	int opt, pppdump_fd = -1, audio_fd = -1;
+	uint16_t obex_port;
 
 	while ((opt=getopt_long(argc, argv, "i:l:p:m:w:r:d:taxXRC:H:O:P:D:A:YZ46hv", main_options, NULL)) != -1) {
 		switch(opt) {
@@ -970,7 +971,11 @@ int main(int argc, char *argv[])
 			break;
 
 		case 'O':
-			set_proto(0, 0, atoi(optarg), SDP_UUID_OBEX);
+			obex_port = atoi(optarg);
+			if (obex_port > 31)
+				set_proto(0, obex_port, 0, SDP_UUID_OBEX);
+			else
+				set_proto(0, 0, obex_port, SDP_UUID_OBEX);
 			break;
 
 		case 'P':
-- 
1.7.7.6

