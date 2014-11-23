Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 2/3] tools/btmgmt: service-find command
Date: Sat, 22 Nov 2014 23:50:37 -0800
Message-Id: <1416729038-4486-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1416729038-4486-1-git-send-email-jpawlowski@google.com>
References: <1416729038-4486-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add command for using MGMT_OP_START_SERVICE_DISCOVERY.

Example usage:
Find all low energy devices advertising service with UUID 'abcd'
that have rssi higher than -60 dB
btmgmt find-service -u abcd -r -60 -l

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 tools/btmgmt.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 122 insertions(+), 10 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index e227a1c..32e4a23 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1547,6 +1547,127 @@ static void cmd_con(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	}
 }
 
+static void find_service_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	if (status != 0) {
+		fprintf(stderr,
+			"Unable to start service discovery. status 0x%02x (%s)\n",
+			status, mgmt_errstr(status));
+		mainloop_quit();
+		return;
+	}
+
+	printf("Service discovery started\n");
+	discovery = true;
+}
+
+static void find_service_usage(void)
+{
+	printf("Usage: btmgmt find-service -u UUID [-r RSSI_Threshold] [-l|-b]>\n");
+}
+
+static struct option find_service_options[] = {
+	{ "help",	no_argument, 0, 'h' },
+	{ "le-only",	no_argument, 0, 'l' },
+	{ "bredr-only",	no_argument, 0, 'b' },
+	{ "uuid",	required_argument, 0, 'u' },
+	{ "rssi",	required_argument, 0, 'r' },
+	{ 0, 0, 0, 0 }
+};
+
+static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
+{
+	if (uuid->type == SDP_UUID16)
+		sdp_uuid16_to_uuid128(uuid128, uuid);
+	else if (uuid->type == SDP_UUID32)
+		sdp_uuid32_to_uuid128(uuid128, uuid);
+	else
+		memcpy(uuid128, uuid, sizeof(*uuid));
+}
+
+static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc,
+			     char **argv)
+{
+	struct mgmt_cp_start_service_discovery *cp;
+	uint8_t buf[sizeof(*cp) + 16];
+	int opt;
+	int total_size = sizeof(*cp) + 16;
+	uuid_t uuid;
+	uint128_t uint128;
+	uuid_t uuid128;
+	uint8_t type;
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	cp = (void *) buf;
+	cp->rssi_threshold = -127;
+
+	type = 0;
+	hci_set_bit(BDADDR_BREDR, &type);
+	hci_set_bit(BDADDR_LE_PUBLIC, &type);
+	hci_set_bit(BDADDR_LE_RANDOM, &type);
+
+	if (argc == 1) {
+		find_service_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	while ((opt = getopt_long(argc, argv, "+lbu:r:p:h",
+				  find_service_options, NULL)) != -1) {
+		switch (opt) {
+		case 'l':
+			hci_clear_bit(BDADDR_BREDR, &type);
+			hci_set_bit(BDADDR_LE_PUBLIC, &type);
+			hci_set_bit(BDADDR_LE_RANDOM, &type);
+			break;
+		case 'b':
+			hci_set_bit(BDADDR_BREDR, &type);
+			hci_clear_bit(BDADDR_LE_PUBLIC, &type);
+			hci_clear_bit(BDADDR_LE_RANDOM, &type);
+			break;
+		case 'u':
+			if (bt_string2uuid(&uuid, optarg) < 0) {
+				printf("Invalid UUID: %s\n", optarg);
+				exit(EXIT_FAILURE);
+			}
+			uuid_to_uuid128(&uuid128, &uuid);
+			ntoh128((uint128_t *) uuid128.value.uuid128.data,
+				&uint128);
+			htob128(&uint128, (uint128_t *) cp->uuid);
+			break;
+		case 'r':
+			cp->rssi_threshold = atoi(optarg);
+			break;
+		case 'h':
+			find_service_usage();
+			exit(EXIT_SUCCESS);
+		default:
+			find_service_usage();
+			exit(EXIT_FAILURE);
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+	optind = 0;
+
+	if (argc > 0) {
+		find_service_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	cp->type = type;
+	cp->num_uuid = 1;
+
+	if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, index, total_size,
+		      cp, find_service_rsp, NULL, NULL) == 0) {
+		fprintf(stderr, "Unable to send start_service_discovery cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void find_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -2145,16 +2266,6 @@ static void cmd_unblock(struct mgmt *mgmt, uint16_t index, int argc,
 	}
 }
 
-static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid)
-{
-	if (uuid->type == SDP_UUID16)
-		sdp_uuid16_to_uuid128(uuid128, uuid);
-	else if (uuid->type == SDP_UUID32)
-		sdp_uuid32_to_uuid128(uuid128, uuid);
-	else
-		memcpy(uuid128, uuid, sizeof(*uuid));
-}
-
 static void cmd_add_uuid(struct mgmt *mgmt, uint16_t index, int argc,
 							char **argv)
 {
@@ -2978,6 +3089,7 @@ static struct {
 	{ "disconnect", cmd_disconnect, "Disconnect device"		},
 	{ "con",	cmd_con,	"List connections"		},
 	{ "find",	cmd_find,	"Discover nearby devices"	},
+	{ "find-service", cmd_find_service, "Discover nearby service"	},
 	{ "name",	cmd_name,	"Set local name"		},
 	{ "pair",	cmd_pair,	"Pair with a remote device"	},
 	{ "cancelpair",	cmd_cancel_pair,"Cancel pairing"		},
-- 
2.1.0.rc2.206.gedb03e5

