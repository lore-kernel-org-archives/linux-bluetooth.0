Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 2/2] service-find command for new kernel method usage
Date: Wed, 29 Oct 2014 12:52:29 -0700
Message-Id: <1414612349-2262-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
References: <1414612349-2262-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example usage:
Find all low energy devices advertising service with UUID 'abcd' and
TxPower, that have pathloss less than 60 dB
btmgmt find-service -u abcd -p 60 -l

Find all low energy devices advertising service with UUID 'abcd', and
dont advertise TxPower and with RSSI over -50, or advertising TxPower
and pathloss less than 60 dB
btmgmt find-service -u abcd -r -50 -p 60  -l

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 tools/btmgmt.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 3326a46..45e4c51 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -1547,6 +1547,133 @@ static void cmd_con(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
 	}
 }
 
+static void find_service_rsp(uint8_t status, uint16_t len, const void *param,
+							void *user_data)
+{
+	free(user_data);
+	if (status != 0) {
+		fprintf(stderr,
+			"Unable to start service discovery. status 0x%02x (%s)\n",
+						status, mgmt_errstr(status));
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
+	printf("Usage: btmgmt find-service -u UUID [-r RSSI_Threshold] [-p Pathloss_Threshold] [-l|-b]>\n");
+}
+
+static struct option find_service_options[] = {
+	{ "help",	no_argument, 0, 'h' },
+	{ "le-only",	no_argument, 0, 'l' },
+	{ "bredr-only",	no_argument, 0, 'b' },
+	{ "uuid",	required_argument, 0, 'u' },
+	{ "rssi",	required_argument, 0, 'r' },
+	{ "pathloss",	required_argument, 0, 'p' },
+	{ 0, 0, 0, 0 }
+};
+
+static void uuid_to_uuid128(uuid_t *uuid128, const uuid_t *uuid);
+
+static void cmd_find_service(struct mgmt *mgmt, uint16_t index, int argc, char **argv)
+{
+	struct mgmt_cp_start_service_discovery *cp;
+	struct mgmt_uuid_filter *filter;
+	uint8_t type;
+	int opt;
+	int total_size = sizeof(struct mgmt_cp_start_service_discovery) + sizeof(struct mgmt_uuid_filter);
+	uuid_t uuid;
+	uint128_t uint128;
+	uuid_t uuid128;
+
+	if (index == MGMT_INDEX_NONE)
+		index = 0;
+
+	type = 0;
+	hci_set_bit(BDADDR_BREDR, &type);
+	hci_set_bit(BDADDR_LE_PUBLIC, &type);
+	hci_set_bit(BDADDR_LE_RANDOM, &type);
+
+	cp = malloc(total_size);
+	if(cp == NULL) {
+		fprintf(stderr, "Unable to allocate memory for mgmt_cp_start_service_discovery structure.\n");
+	}
+
+	memset(cp, 0, total_size);
+
+	filter = cp->filter;
+
+	if(argc == 1) {
+		find_service_usage();
+		exit(EXIT_FAILURE);
+	}
+
+	while ((opt = getopt_long(argc, argv, "+lbu:r:p:h", find_service_options,
+								NULL)) != -1) {
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
+			ntoh128((uint128_t *) uuid128.value.uuid128.data, &uint128);
+			htob128(&uint128, (uint128_t *) filter->uuid);
+			break;
+		case 'r':
+			filter->rssi = atoi(optarg);
+			filter->range_method |= MGMT_RANGE_RSSI;
+			printf("rssi filter: %d %d", filter->rssi, filter->range_method);
+			break;
+		case 'p':
+			filter->pathloss = atoi(optarg);
+			filter->range_method |= MGMT_RANGE_PATHLOSS;
+			printf("pathloss filter: %d %d", filter->pathloss, filter->range_method);
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
+	cp->filter_count = 1;
+
+	if (mgmt_send(mgmt, MGMT_OP_START_SERVICE_DISCOVERY, index, total_size, cp,
+						find_service_rsp, cp, NULL) == 0) {
+		free(cp);
+		fprintf(stderr, "Unable to send start_service_discovery cmd\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
 static void find_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
@@ -2867,6 +2994,7 @@ static struct {
 	{ "disconnect", cmd_disconnect, "Disconnect device"		},
 	{ "con",	cmd_con,	"List connections"		},
 	{ "find",	cmd_find,	"Discover nearby devices"	},
+	{ "find-service",	cmd_find_service,	"Discover nearby service"	},
 	{ "name",	cmd_name,	"Set local name"		},
 	{ "pair",	cmd_pair,	"Pair with a remote device"	},
 	{ "cancelpair",	cmd_cancel_pair,"Cancel pairing"		},
-- 
2.1.0.rc2.206.gedb03e5

