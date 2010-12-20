Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH 3/3] More CodingStyle in lib and tools
Date: Mon, 20 Dec 2010 11:13:49 +0100
Message-ID: <1292840029-27770-4-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
References: <1292840029-27770-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.c         |   69 +++++++++++++++++++++++++++-------------
 tools/hciconfig.c |   91 +++++++++++++++++++++++++++++++++-------------------
 tools/hcitool.c   |   20 ++++++------
 3 files changed, 114 insertions(+), 66 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 64c7dad..9e53479 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -56,8 +56,8 @@ typedef struct {
 
 static int is_number(const char *c)
 {
-	while(*c) {
-		if (! isdigit(*c))
+	while (*c) {
+		if (!isdigit(*c))
 			return 0;
 		++c;
 	}
@@ -138,7 +138,8 @@ static int hci_str2uint(hci_map *map, char *str, unsigned int *val)
 	while ((t = strsep(&ptr, ","))) {
 		for (m = map; m->str; m++) {
 			if (!strcasecmp(m->str,t)) {
-				*val = (unsigned int) m->val; set = 1;
+				*val = (unsigned int) m->val;
+				set = 1;
 				break;
 			}
 		}
@@ -781,7 +782,8 @@ char *lmp_featurestostr(uint8_t *features, char *pref, int width)
 
 		while (m->str) {
 			if (m->val & features[i])
-				size += strlen(m->str) + (pref ? strlen(pref) : 0) + 1;
+				size += strlen(m->str) +
+						(pref ? strlen(pref) : 0) + 1;
 			m++;
 		}
 	}
@@ -803,7 +805,8 @@ char *lmp_featurestostr(uint8_t *features, char *pref, int width)
 		while (m->str) {
 			if (m->val & features[i]) {
 				if (strlen(off) + strlen(m->str) > maxwidth) {
-					ptr += sprintf(ptr, "\n%s", pref ? pref : "");
+					ptr += sprintf(ptr, "\n%s",
+							pref ? pref : "");
 					off = ptr;
 				}
 				ptr += sprintf(ptr, "%s ", m->str);
@@ -816,8 +819,8 @@ char *lmp_featurestostr(uint8_t *features, char *pref, int width)
 }
 
 /* HCI functions that do not require open device */
-
-int hci_for_each_dev(int flag, int (*func)(int dd, int dev_id, long arg), long arg)
+int hci_for_each_dev(int flag, int (*func)(int dd, int dev_id, long arg),
+			long arg)
 {
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
@@ -951,7 +954,8 @@ int hci_devba(int dev_id, bdaddr_t *bdaddr)
 	return 0;
 }
 
-int hci_inquiry(int dev_id, int len, int nrsp, const uint8_t *lap, inquiry_info **ii, long flags)
+int hci_inquiry(int dev_id, int len, int nrsp, const uint8_t *lap,
+		inquiry_info **ii, long flags)
 {
 	struct hci_inquiry_req *ir;
 	uint8_t num_rsp = nrsp;
@@ -1138,7 +1142,8 @@ int hci_send_req(int dd, struct hci_request *r, int to)
 			}
 
 			to -= 10;
-			if (to < 0) to = 0;
+			if (to < 0)
+				to = 0;
 
 		}
 
@@ -1231,7 +1236,9 @@ done:
 	return 0;
 }
 
-int hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t ptype, uint16_t clkoffset, uint8_t rswitch, uint16_t *handle, int to)
+int hci_create_connection(int dd, const bdaddr_t *bdaddr, uint16_t ptype,
+				uint16_t clkoffset, uint8_t rswitch,
+				uint16_t *handle, int to)
 {
 	evt_conn_complete rp;
 	create_conn_cp cp;
@@ -1338,7 +1345,10 @@ int hci_write_local_name(int dd, const char *name, int to)
 	return 0;
 }
 
-int hci_read_remote_name_with_clock_offset(int dd, const bdaddr_t *bdaddr, uint8_t pscan_rep_mode, uint16_t clkoffset, int len, char *name, int to)
+int hci_read_remote_name_with_clock_offset(int dd, const bdaddr_t *bdaddr,
+						uint8_t pscan_rep_mode,
+						uint16_t clkoffset,
+						int len, char *name, int to)
 {
 	evt_remote_name_req_complete rn;
 	remote_name_req_cp cp;
@@ -1371,9 +1381,11 @@ int hci_read_remote_name_with_clock_offset(int dd, const bdaddr_t *bdaddr, uint8
 	return 0;
 }
 
-int hci_read_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name, int to)
+int hci_read_remote_name(int dd, const bdaddr_t *bdaddr, int len, char *name,
+				int to)
 {
-	return hci_read_remote_name_with_clock_offset(dd, bdaddr, 0x02, 0x0000, len, name, to);
+	return hci_read_remote_name_with_clock_offset(dd, bdaddr, 0x02, 0x0000,
+							len, name, to);
 }
 
 int hci_read_remote_name_cancel(int dd, const bdaddr_t *bdaddr, int to)
@@ -1396,7 +1408,8 @@ int hci_read_remote_name_cancel(int dd, const bdaddr_t *bdaddr, int to)
 	return 0;
 }
 
-int hci_read_remote_version(int dd, uint16_t handle, struct hci_version *ver, int to)
+int hci_read_remote_version(int dd, uint16_t handle, struct hci_version *ver,
+				int to)
 {
 	evt_read_remote_version_complete rp;
 	read_remote_version_cp cp;
@@ -1460,7 +1473,9 @@ int hci_read_remote_features(int dd, uint16_t handle, uint8_t *features, int to)
 	return 0;
 }
 
-int hci_read_remote_ext_features(int dd, uint16_t handle, uint8_t page, uint8_t *max_page, uint8_t *features, int to)
+int hci_read_remote_ext_features(int dd, uint16_t handle, uint8_t page,
+					uint8_t *max_page, uint8_t *features,
+					int to)
 {
 	evt_read_remote_ext_features_complete rp;
 	read_remote_ext_features_cp cp;
@@ -1603,7 +1618,8 @@ int hci_read_local_features(int dd, uint8_t *features, int to)
 	return 0;
 }
 
-int hci_read_local_ext_features(int dd, uint8_t page, uint8_t *max_page, uint8_t *features, int to)
+int hci_read_local_ext_features(int dd, uint8_t page, uint8_t *max_page,
+				uint8_t *features, int to)
 {
 	read_local_ext_features_cp cp;
 	read_local_ext_features_rp rp;
@@ -1944,7 +1960,8 @@ int hci_switch_role(int dd, bdaddr_t *bdaddr, uint8_t role, int to)
 	return 0;
 }
 
-int hci_park_mode(int dd, uint16_t handle, uint16_t max_interval, uint16_t min_interval, int to)
+int hci_park_mode(int dd, uint16_t handle, uint16_t max_interval,
+			uint16_t min_interval, int to)
 {
 	park_mode_cp cp;
 	evt_mode_change rp;
@@ -2342,7 +2359,8 @@ int hci_write_inquiry_transmit_power_level(int dd, int8_t level, int to)
 	return 0;
 }
 
-int hci_read_transmit_power_level(int dd, uint16_t handle, uint8_t type, int8_t *level, int to)
+int hci_read_transmit_power_level(int dd, uint16_t handle, uint8_t type,
+					int8_t *level, int to)
 {
 	read_transmit_power_level_cp cp;
 	read_transmit_power_level_rp rp;
@@ -2426,7 +2444,8 @@ int hci_write_link_policy(int dd, uint16_t handle, uint16_t policy, int to)
 	return 0;
 }
 
-int hci_read_link_supervision_timeout(int dd, uint16_t handle, uint16_t *timeout, int to)
+int hci_read_link_supervision_timeout(int dd, uint16_t handle,
+					uint16_t *timeout, int to)
 {
 	read_link_supervision_timeout_rp rp;
 	struct hci_request rq;
@@ -2451,7 +2470,8 @@ int hci_read_link_supervision_timeout(int dd, uint16_t handle, uint16_t *timeout
 	return 0;
 }
 
-int hci_write_link_supervision_timeout(int dd, uint16_t handle, uint16_t timeout, int to)
+int hci_write_link_supervision_timeout(int dd, uint16_t handle,
+					uint16_t timeout, int to)
 {
 	write_link_supervision_timeout_cp cp;
 	write_link_supervision_timeout_rp rp;
@@ -2508,7 +2528,8 @@ int hci_set_afh_classification(int dd, uint8_t *map, int to)
 	return 0;
 }
 
-int hci_read_link_quality(int dd, uint16_t handle, uint8_t *link_quality, int to)
+int hci_read_link_quality(int dd, uint16_t handle, uint8_t *link_quality,
+				int to)
 {
 	read_link_quality_rp rp;
 	struct hci_request rq;
@@ -2558,7 +2579,8 @@ int hci_read_rssi(int dd, uint16_t handle, int8_t *rssi, int to)
 	return 0;
 }
 
-int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map, int to)
+int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map,
+			int to)
 {
 	read_afh_map_rp rp;
 	struct hci_request rq;
@@ -2584,7 +2606,8 @@ int hci_read_afh_map(int dd, uint16_t handle, uint8_t *mode, uint8_t *map, int t
 	return 0;
 }
 
-int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock, uint16_t *accuracy, int to)
+int hci_read_clock(int dd, uint16_t handle, uint8_t which, uint32_t *clock,
+			uint16_t *accuracy, int to)
 {
 	read_clock_cp cp;
 	read_clock_rp rp;
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 0a3668e..6eadd3e 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -57,7 +57,8 @@ static void print_dev_list(int ctl, int flags)
 	struct hci_dev_req *dr;
 	int i;
 
-	if (!(dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t)))) {
+	if (!(dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) +
+		sizeof(uint16_t)))) {
 		perror("Can't allocate memory");
 		exit(1);
 	}
@@ -501,7 +502,7 @@ static char *get_minor_device_name(int major, int minor)
 	case 0:	/* misc */
 		return "";
 	case 1:	/* computer */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -519,7 +520,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 2:	/* phone */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -539,7 +540,7 @@ static char *get_minor_device_name(int major, int minor)
 	case 3:	/* lan access */
 		if (minor == 0)
 			return "Uncategorized";
-		switch(minor / 8) {
+		switch (minor / 8) {
 		case 0:
 			return "Fully available";
 		case 1:
@@ -559,7 +560,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 4:	/* audio/video */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -603,7 +604,7 @@ static char *get_minor_device_name(int major, int minor)
 
 		cls_str[0] = '\0';
 
-		switch(minor & 48) {
+		switch (minor & 48) {
 		case 16:
 			strncpy(cls_str, "Keyboard", sizeof(cls_str));
 			break;
@@ -614,10 +615,10 @@ static char *get_minor_device_name(int major, int minor)
 			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
 			break;
 		}
-		if((minor & 15) && (strlen(cls_str) > 0))
+		if ((minor & 15) && (strlen(cls_str) > 0))
 			strcat(cls_str, "/");
 
-		switch(minor & 15) {
+		switch (minor & 15) {
 		case 0:
 			break;
 		case 1:
@@ -642,7 +643,7 @@ static char *get_minor_device_name(int major, int minor)
 			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
 			break;
 		}
-		if(strlen(cls_str) > 0)
+		if (strlen(cls_str) > 0)
 			return cls_str;
 	}
 	case 6:	/* imaging */
@@ -656,7 +657,7 @@ static char *get_minor_device_name(int major, int minor)
 			return "Printer";
 		break;
 	case 7: /* wearable */
-		switch(minor) {
+		switch (minor) {
 		case 1:
 			return "Wrist Watch";
 		case 2:
@@ -670,7 +671,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 8: /* toy */
-		switch(minor) {
+		switch (minor) {
 		case 1:
 			return "Robot";
 		case 2:
@@ -754,10 +755,24 @@ static void cmd_class(int ctl, int hdev, char *opt)
 
 static void cmd_voice(int ctl, int hdev, char *opt)
 {
-	static char *icf[] = { "Linear", "u-Law", "A-Law", "Reserved" };
-	static char *idf[] = { "1's complement", "2's complement", "Sign-Magnitude", "Reserved" };
-	static char *iss[] = { "8 bit", "16 bit" };
-	static char *acf[] = { "CVSD", "u-Law", "A-Law", "Reserved" };
+	static char *icf[] = {	"Linear",
+				"u-Law",
+				"A-Law",
+				"Reserved" };
+
+	static char *idf[] = {	"1's complement",
+				"2's complement",
+				"Sign-Magnitude",
+				"Reserved" };
+
+	static char *iss[] = {	"8 bit",
+				"16 bit" };
+
+	static char *acf[] = {	"CVSD",
+				"u-Law",
+				"A-Law",
+				"Reserved" };
+
 	int s = hci_open_dev(hdev);
 
 	if (s < 0) {
@@ -787,15 +802,19 @@ static void cmd_voice(int ctl, int hdev, char *opt)
 			((vs & 0x03fc) == 0x0060) ? " (Default Condition)" : "");
 		printf("\tInput Coding: %s\n", icf[ic]);
 		printf("\tInput Data Format: %s\n", idf[(vs & 0xc0) >> 6]);
+
 		if (!ic) {
-			printf("\tInput Sample Size: %s\n", iss[(vs & 0x20) >> 5]);
-			printf("\t# of bits padding at MSB: %d\n", (vs & 0x1c) >> 2);
+			printf("\tInput Sample Size: %s\n",
+				iss[(vs & 0x20) >> 5]);
+			printf("\t# of bits padding at MSB: %d\n",
+				(vs & 0x1c) >> 2);
 		}
 		printf("\tAir Coding Format: %s\n", acf[vs & 0x03]);
 	}
 }
 
-static int get_link_key(const bdaddr_t *local, const bdaddr_t *peer, uint8_t *key)
+static int get_link_key(const bdaddr_t *local, const bdaddr_t *peer,
+			uint8_t *key)
 {
 	char filename[PATH_MAX + 1], addr[18], tmp[3], *str;
 	int i;
@@ -1356,8 +1375,10 @@ static void cmd_page_parms(int ctl, int hdev, char *opt)
 
 		window   = btohs(rp.window);
 		interval = btohs(rp.interval);
-		printf("\tPage interval: %u slots (%.2f ms), window: %u slots (%.2f ms)\n",
-				interval, (float)interval * 0.625, window, (float)window * 0.625);
+		printf("\tPage interval: %u slots (%.2f ms), "
+			"window: %u slots (%.2f ms)\n",
+			interval, (float)interval * 0.625,
+			window, (float)window * 0.625);
 	}
 }
 
@@ -1441,7 +1462,7 @@ static void cmd_afh_mode(int ctl, int hdev, char *opt)
 
 		if (hci_write_afh_mode(dd, mode, 2000) < 0) {
 			fprintf(stderr, "Can't set AFH mode on hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
+					hdev, strerror(errno), errno);
 			exit(1);
 		}
 	} else {
@@ -1449,7 +1470,7 @@ static void cmd_afh_mode(int ctl, int hdev, char *opt)
 
 		if (hci_read_afh_mode(dd, &mode, 1000) < 0) {
 			fprintf(stderr, "Can't read AFH mode on hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
+					hdev, strerror(errno), errno);
 			exit(1);
 		}
 
@@ -1474,7 +1495,7 @@ static void cmd_ssp_mode(int ctl, int hdev, char *opt)
 
 		if (hci_write_simple_pairing_mode(dd, mode, 2000) < 0) {
 			fprintf(stderr, "Can't set Simple Pairing mode on hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
+					hdev, strerror(errno), errno);
 			exit(1);
 		}
 	} else {
@@ -1482,12 +1503,13 @@ static void cmd_ssp_mode(int ctl, int hdev, char *opt)
 
 		if (hci_read_simple_pairing_mode(dd, &mode, 1000) < 0) {
 			fprintf(stderr, "Can't read Simple Pairing mode on hci%d: %s (%d)\n",
-						hdev, strerror(errno), errno);
+					hdev, strerror(errno), errno);
 			exit(1);
 		}
 
 		print_dev_hdr(&di);
-		printf("\tSimple Pairing mode: %s\n", mode == 1 ? "Enabled" : "Disabled");
+		printf("\tSimple Pairing mode: %s\n",
+			mode == 1 ? "Enabled" : "Disabled");
 	}
 }
 
@@ -1505,7 +1527,8 @@ static void print_rev_ericsson(int dd)
 	rq.rlen   = sizeof(buf);
 
 	if (hci_send_req(dd, &rq, 1000) < 0) {
-		printf("\nCan't read revision info: %s (%d)\n", strerror(errno), errno);
+		printf("\nCan't read revision info: %s (%d)\n",
+			strerror(errno), errno);
 		return;
 	}
 
@@ -1551,7 +1574,8 @@ static void print_rev_digianswer(int dd)
 	rq.rlen   = sizeof(buf);
 
 	if (hci_send_req(dd, &rq, 1000) < 0) {
-		printf("\nCan't read revision info: %s (%d)\n", strerror(errno), errno);
+		printf("\nCan't read revision info: %s (%d)\n",
+			strerror(errno), errno);
 		return;
 	}
 
@@ -1560,7 +1584,8 @@ static void print_rev_digianswer(int dd)
 
 static void print_rev_broadcom(uint16_t hci_rev, uint16_t lmp_subver)
 {
-	printf("\tFirmware %d.%d / %d\n", hci_rev & 0xff, lmp_subver >> 8, lmp_subver & 0xff);
+	printf("\tFirmware %d.%d / %d\n",
+		hci_rev & 0xff, lmp_subver >> 8, lmp_subver & 0xff);
 }
 
 static void print_rev_avm(uint16_t hci_rev, uint16_t lmp_subver)
@@ -1723,7 +1748,7 @@ static void print_dev_info(int ctl, struct hci_dev_info *di)
 
 static int is_number(const char *c)
 {
-	while(*c) {
+	while (*c) {
 		if (! isdigit(*c))
 			return 0;
 		++c;
@@ -1807,7 +1832,7 @@ static void usage(void)
 		"\thciconfig\n"
 		"\thciconfig [-a] hciX [command ...]\n");
 	printf("Commands:\n");
-	for (i=0; command[i].cmd; i++)
+	for (i = 0; command[i].cmd; i++)
 		printf("\t%-10s %-8s\t%s\n", command[i].cmd,
 		command[i].opt ? command[i].opt : " ",
 		command[i].doc);
@@ -1821,10 +1846,10 @@ static struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	int opt, ctl, i, cmd=0;
+	int opt, ctl, i, cmd = 0;
 
-	while ((opt=getopt_long(argc, argv, "ah", main_options, NULL)) != -1) {
-		switch(opt) {
+	while ((opt = getopt_long(argc, argv, "ah", main_options, NULL)) != -1) {
+		switch (opt) {
 		case 'a':
 			all = 1;
 			break;
diff --git a/tools/hcitool.c b/tools/hcitool.c
index 847bf1b..d50adaf 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -197,7 +197,7 @@ static char *get_minor_device_name(int major, int minor)
 	case 0:	/* misc */
 		return "";
 	case 1:	/* computer */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -215,7 +215,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 2:	/* phone */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -235,7 +235,7 @@ static char *get_minor_device_name(int major, int minor)
 	case 3:	/* lan access */
 		if (minor == 0)
 			return "Uncategorized";
-		switch(minor / 8) {
+		switch (minor / 8) {
 		case 0:
 			return "Fully available";
 		case 1:
@@ -255,7 +255,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 4:	/* audio/video */
-		switch(minor) {
+		switch (minor) {
 		case 0:
 			return "Uncategorized";
 		case 1:
@@ -297,7 +297,7 @@ static char *get_minor_device_name(int major, int minor)
 	case 5:	/* peripheral */ {
 		static char cls_str[48]; cls_str[0] = 0;
 
-		switch(minor & 48) {
+		switch (minor & 48) {
 		case 16:
 			strncpy(cls_str, "Keyboard", sizeof(cls_str));
 			break;
@@ -308,10 +308,10 @@ static char *get_minor_device_name(int major, int minor)
 			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
 			break;
 		}
-		if((minor & 15) && (strlen(cls_str) > 0))
+		if ((minor & 15) && (strlen(cls_str) > 0))
 			strcat(cls_str, "/");
 
-		switch(minor & 15) {
+		switch (minor & 15) {
 		case 0:
 			break;
 		case 1:
@@ -336,7 +336,7 @@ static char *get_minor_device_name(int major, int minor)
 			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
 			break;
 		}
-		if(strlen(cls_str) > 0)
+		if (strlen(cls_str) > 0)
 			return cls_str;
 	}
 	case 6:	/* imaging */
@@ -350,7 +350,7 @@ static char *get_minor_device_name(int major, int minor)
 			return "Printer";
 		break;
 	case 7: /* wearable */
-		switch(minor) {
+		switch (minor) {
 		case 1:
 			return "Wrist Watch";
 		case 2:
@@ -364,7 +364,7 @@ static char *get_minor_device_name(int major, int minor)
 		}
 		break;
 	case 8: /* toy */
-		switch(minor) {
+		switch (minor) {
 		case 1:
 			return "Robot";
 		case 2:
-- 
1.7.0.4

