Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <lukasz.rymanowski@tieto.com>,
	Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH hcidump 3/3] core: Add support for passing RFCOMM channel for SAP
Date: Mon, 26 Mar 2012 12:02:11 +0200
Message-ID: <1332756131-16439-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1332756131-16439-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1332756131-16439-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/hcidump.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/hcidump.c b/src/hcidump.c
index 089bff8..089d444 100644
--- a/src/hcidump.c
+++ b/src/hcidump.c
@@ -859,6 +859,7 @@ static void usage(void)
 	"  -H, --hcrp=psm             PSM for HCRP\n"
 	"  -O, --obex=port            Channel/PSM for OBEX\n"
 	"  -P, --ppp=channel          Channel for PPP\n"
+	"  -S, --sap=channel          Channel for SAP\n"
 	"  -D, --pppdump=file         Extract PPP traffic\n"
 	"  -A, --audio=file           Extract SCO audio data\n"
 	"  -Y, --novendor             No vendor commands or events\n"
@@ -887,6 +888,7 @@ static struct option main_options[] = {
 	{ "hcrp",		1, 0, 'H' },
 	{ "obex",		1, 0, 'O' },
 	{ "ppp",		1, 0, 'P' },
+	{ "sap",		1, 0, 'S' },
 	{ "pppdump",		1, 0, 'D' },
 	{ "audio",		1, 0, 'A' },
 	{ "novendor",		0, 0, 'Y' },
@@ -908,7 +910,9 @@ int main(int argc, char *argv[])
 	int opt, pppdump_fd = -1, audio_fd = -1;
 	uint16_t obex_port;
 
-	while ((opt=getopt_long(argc, argv, "i:l:p:m:w:r:d:taxXRC:H:O:P:D:A:YZ46hv", main_options, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv,
+				"i:l:p:m:w:r:d:taxXRC:H:O:P:S:D:A:YZ46hv",
+				main_options, NULL)) != -1) {
 		switch(opt) {
 		case 'i':
 			if (strcasecmp(optarg, "none") && strcasecmp(optarg, "system"))
@@ -984,6 +988,10 @@ int main(int argc, char *argv[])
 			set_proto(0, 0, atoi(optarg), SDP_UUID_LAN_ACCESS_PPP);
 			break;
 
+		case 'S':
+			set_proto(0, 0, atoi(optarg), SDP_UUID_SIM_ACCESS);
+			break;
+
 		case 'D':
 			pppdump_file = strdup(optarg);
 			break;
-- 
1.7.9.4

