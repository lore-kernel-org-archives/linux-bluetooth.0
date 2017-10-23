Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 4/8] tools/btmgmt: Add argument texts to help command
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Message-ID: <0ce46a5e-96b5-7fe4-6cca-084520e07033@jp.fujitsu.com>
Date: Mon, 23 Oct 2017 17:27:24 +0900
MIME-Version: 1.0
In-Reply-To: <2c74601a-9a6f-6dd3-5bf4-a1988ae21dc3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add the argument texts based on the usage of each command to the output of
the command help. So the command help can give overview easier than using
the option --help of each command.
---
 tools/btmgmt.c | 225 +++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 155 insertions(+), 70 deletions(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 319ee05..bcfcb5b 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4417,6 +4417,7 @@ static void cmd_appearance(struct mgmt *mgmt, uint16_t index, int argc,
 
 struct cmd_info {
 	char *cmd;
+	const char *arg;
 	void (*func)(struct mgmt *mgmt, uint16_t index, int argc, char **argv);
 	char *doc;
 	char * (*gen) (const char *text, int state);
@@ -4424,66 +4425,128 @@ struct cmd_info {
 };
 
 static struct cmd_info all_cmd[] = {
-	{ "version",	cmd_version,	"Get the MGMT Version"		},
-	{ "commands",	cmd_commands,	"List supported commands"	},
-	{ "config",	cmd_config,	"Show configuration info"	},
-	{ "info",	cmd_info,	"Show controller info"		},
-	{ "extinfo",	cmd_extinfo,	"Show extended controller info"	},
-	{ "auto-power",	cmd_auto_power,	"Power all available features"	},
-	{ "power",	cmd_power,	"Toggle powered state"		},
-	{ "discov",	cmd_discov,	"Toggle discoverable state"	},
-	{ "connectable",cmd_connectable,"Toggle connectable state"	},
-	{ "fast-conn",	cmd_fast_conn,	"Toggle fast connectable state"	},
-	{ "bondable",	cmd_bondable,	"Toggle bondable state"		},
-	{ "pairable",	cmd_bondable,	"Toggle bondable state"		},
-	{ "linksec",	cmd_linksec,	"Toggle link level security"	},
-	{ "ssp",	cmd_ssp,	"Toggle SSP mode"		},
-	{ "sc",		cmd_sc,		"Toogle SC support"		},
-	{ "hs",		cmd_hs,		"Toggle HS support"		},
-	{ "le",		cmd_le,		"Toggle LE support"		},
-	{ "advertising",cmd_advertising,"Toggle LE advertising",	},
-	{ "bredr",	cmd_bredr,	"Toggle BR/EDR support",	},
-	{ "privacy",	cmd_privacy,	"Toggle privacy support"	},
-	{ "class",	cmd_class,	"Set device major/minor class"	},
-	{ "disconnect", cmd_disconnect, "Disconnect device"		},
-	{ "con",	cmd_con,	"List connections"		},
-	{ "find",	cmd_find,	"Discover nearby devices"	},
-	{ "find-service", cmd_find_service, "Discover nearby service"	},
-	{ "stop-find",	cmd_stop_find,	"Stop discovery"		},
-	{ "name",	cmd_name,	"Set local name"		},
-	{ "pair",	cmd_pair,	"Pair with a remote device"	},
-	{ "cancelpair",	cmd_cancel_pair,"Cancel pairing"		},
-	{ "unpair",	cmd_unpair,	"Unpair device"			},
-	{ "keys",	cmd_keys,	"Load Link Keys"		},
-	{ "ltks",	cmd_ltks,	"Load Long Term Keys"		},
-	{ "irks",	cmd_irks,	"Load Identity Resolving Keys"	},
-	{ "block",	cmd_block,	"Block Device"			},
-	{ "unblock",	cmd_unblock,	"Unblock Device"		},
-	{ "add-uuid",	cmd_add_uuid,	"Add UUID"			},
-	{ "rm-uuid",	cmd_remove_uuid,"Remove UUID"			},
-	{ "clr-uuids",	cmd_clr_uuids,	"Clear UUIDs"			},
-	{ "local-oob",	cmd_local_oob,	"Local OOB data"		},
-	{ "remote-oob",	cmd_remote_oob,	"Remote OOB data"		},
-	{ "did",	cmd_did,	"Set Device ID"			},
-	{ "static-addr",cmd_static_addr,"Set static address"		},
-	{ "public-addr",cmd_public_addr,"Set public address"		},
-	{ "ext-config",	cmd_ext_config,	"External configuration"	},
-	{ "debug-keys",	cmd_debug_keys,	"Toogle debug keys"		},
-	{ "conn-info",	cmd_conn_info,	"Get connection information"	},
-	{ "io-cap",	cmd_io_cap,	"Set IO Capability"		},
-	{ "scan-params",cmd_scan_params,"Set Scan Parameters"		},
-	{ "get-clock",	cmd_clock_info,	"Get Clock Information"		},
-	{ "add-device", cmd_add_device, "Add Device"			},
-	{ "del-device", cmd_del_device, "Remove Device"			},
-	{ "clr-devices",cmd_clr_devices,"Clear Devices"			},
-	{ "bredr-oob",	cmd_bredr_oob,	"Local OOB data (BR/EDR)"	},
-	{ "le-oob",	cmd_le_oob,	"Local OOB data (LE)"		},
-	{ "advinfo",	cmd_advinfo,	"Show advertising features"	},
-	{ "advsize",	cmd_advsize,	"Show advertising size info"	},
-	{ "add-adv",	cmd_add_adv,	"Add advertising instance"	},
-	{ "rm-adv",	cmd_rm_adv,	"Remove advertising instance"	},
-	{ "clr-adv",	cmd_clr_adv,	"Clear advertising instances"	},
-	{ "appearance",	cmd_appearance,	"Set appearance"		},
+	{ "version",		NULL,
+		cmd_version,		"Get the MGMT Version"		},
+	{ "commands",		NULL,
+		cmd_commands,		"List supported commands"	},
+	{ "config",		NULL,
+		cmd_config,		"Show configuration info"	},
+	{ "info",		NULL,
+		cmd_info,		"Show controller info"		},
+	{ "extinfo",		NULL,
+		cmd_extinfo,		"Show extended controller info"	},
+	{ "auto-power",		NULL,
+		cmd_auto_power,		"Power all available features"	},
+	{ "power",		"<on/off>",
+		cmd_power,		"Toggle powered state"		},
+	{ "discov",		"<yes/no/limited> [timeout]",
+		cmd_discov,		"Toggle discoverable state"	},
+	{ "connectable",	"<on/off>",
+	cmd_connectable,		"Toggle connectable state"	},
+	{ "fast-conn",		"<on/off>",
+		cmd_fast_conn,		"Toggle fast connectable state"	},
+	{ "bondable",		"<on/off>",
+		cmd_bondable,		"Toggle bondable state"		},
+	{ "pairable",		"<on/off>",
+		cmd_bondable,		"Toggle bondable state"		},
+	{ "linksec",		"<on/off>",
+		cmd_linksec,		"Toggle link level security"	},
+	{ "ssp",		"<on/off>",
+		cmd_ssp,		"Toggle SSP mode"		},
+	{ "sc",			"<on/off/only>",
+		cmd_sc,			"Toogle SC support"		},
+	{ "hs",			"<on/off>",
+		cmd_hs,			"Toggle HS support"		},
+	{ "le",			"<on/off>",
+		cmd_le,			"Toggle LE support"		},
+	{ "advertising",	"<on/off>",
+	cmd_advertising,		"Toggle LE advertising",	},
+	{ "bredr",		"<on/off>",
+		cmd_bredr,		"Toggle BR/EDR support",	},
+	{ "privacy",		"<on/off>",
+		cmd_privacy,		"Toggle privacy support"	},
+	{ "class",		"<major> <minor>",
+		cmd_class,		"Set device major/minor class"	},
+	{ "disconnect", 	"[-t type] <remote address>",
+		cmd_disconnect,		"Disconnect device"		},
+	{ "con",		NULL,
+		cmd_con,		"List connections"		},
+	{ "find",		"[-l|-b] [-L]",
+		cmd_find,		"Discover nearby devices"	},
+	{ "find-service",	"[-u UUID] [-r RSSI_Threshold] [-l|-b]",
+		cmd_find_service,	"Discover nearby service"	},
+	{ "stop-find",		"[-l|-b]",
+		cmd_stop_find,		"Stop discovery"		},
+	{ "name",		"<name> [shortname]",
+		cmd_name,		"Set local name"		},
+	{ "pair",		"[-c cap] [-t type] <remote address>",
+		cmd_pair,		"Pair with a remote device"	},
+	{ "cancelpair",		"[-t type] <remote address>",
+		cmd_cancel_pair,	"Cancel pairing"		},
+	{ "unpair",		"[-t type] <remote address>",
+		cmd_unpair,		"Unpair device"			},
+	{ "keys",		NULL,
+		cmd_keys,		"Load Link Keys"		},
+	{ "ltks",		NULL,
+		cmd_ltks,		"Load Long Term Keys"		},
+	{ "irks",		"[--local <index>] [--file <file path>]",
+		cmd_irks,		"Load Identity Resolving Keys"	},
+	{ "block",		"[-t type] <remote address>",
+		cmd_block,		"Block Device"			},
+	{ "unblock",		"[-t type] <remote address>",
+		cmd_unblock,		"Unblock Device"		},
+	{ "add-uuid",		"<UUID> <service class hint>",
+		cmd_add_uuid,		"Add UUID"			},
+	{ "rm-uuid",		"<UUID>",
+		cmd_remove_uuid,	"Remove UUID"			},
+	{ "clr-uuids",		NULL,
+		cmd_clr_uuids,		"Clear UUIDs"			},
+	{ "local-oob",		NULL,
+		cmd_local_oob,		"Local OOB data"		},
+	{ "remote-oob",		"[-t <addr_type>] [-r <rand192>] "
+				"[-h <hash192>] [-R <rand256>] "
+				"[-H <hash256>] <addr>",
+		cmd_remote_oob,		"Remote OOB data"		},
+	{ "did",		"<source>:<vendor>:<product>:<version>",
+		cmd_did,		"Set Device ID"			},
+	{ "static-addr",	"<address>",
+		cmd_static_addr,	"Set static address"		},
+	{ "public-addr",	"<address>",
+		cmd_public_addr,	"Set public address"		},
+	{ "ext-config",		"<on/off>",
+		cmd_ext_config,		"External configuration"	},
+	{ "debug-keys",		"<on/off>",
+		cmd_debug_keys,		"Toogle debug keys"		},
+	{ "conn-info",		"[-t type] <remote address>",
+		cmd_conn_info,		"Get connection information"	},
+	{ "io-cap",		"<cap>",
+		cmd_io_cap,		"Set IO Capability"		},
+	{ "scan-params",	"<interval> <window>",
+		cmd_scan_params,	"Set Scan Parameters"		},
+	{ "get-clock",		"[address]",
+		cmd_clock_info,		"Get Clock Information"		},
+	{ "add-device", 	"[-a action] [-t type] <address>",
+		cmd_add_device,		"Add Device"			},
+	{ "del-device", 	"[-t type] <address>",
+		cmd_del_device,		"Remove Device"			},
+	{ "clr-devices",	NULL,
+		cmd_clr_devices,	"Clear Devices"			},
+	{ "bredr-oob",		NULL,
+		cmd_bredr_oob,		"Local OOB data (BR/EDR)"	},
+	{ "le-oob",		NULL,
+		cmd_le_oob,		"Local OOB data (LE)"		},
+	{ "advinfo",		NULL,
+		cmd_advinfo,		"Show advertising features"	},
+	{ "advsize",		"[options] <instance_id>",
+		cmd_advsize,		"Show advertising size info"	},
+	{ "add-adv",		"[options] <instance_id>",
+		cmd_add_adv,		"Add advertising instance"	},
+	{ "rm-adv",		"<instance_id>",
+		cmd_rm_adv,		"Remove advertising instance"	},
+	{ "clr-adv",		NULL,
+		cmd_clr_adv,		"Clear advertising instances"	},
+	{ "appearance",		"<appearance>",
+		cmd_appearance,		"Set appearance"		},
 };
 
 static void cmd_quit(struct mgmt *mgmt, uint16_t index,
@@ -4573,10 +4636,14 @@ static void cmd_select(struct mgmt *mgmt, uint16_t index,
 }
 
 static struct cmd_info interactive_cmd[] = {
-	{ "select",	cmd_select,	"Select a different index"	},
-	{ "quit",	cmd_quit,	"Exit program"			},
-	{ "exit",	cmd_quit,	"Exit program"			},
-	{ "help",	NULL,		"List supported commands"	},
+	{ "select",	"<index>",
+			cmd_select,	"Select a different index"	},
+	{ "quit",	NULL,
+			cmd_quit,	"Exit program"			},
+	{ "exit",	NULL,
+			cmd_quit,	"Exit program"			},
+	{ "help",	NULL,
+			NULL,		"List supported commands"	},
 };
 
 static char *cmd_generator(const char *text, int state)
@@ -4703,9 +4770,18 @@ static void rl_handler(char *input)
 
 	for (i = 0; i < NELEM(all_cmd); i++) {
 		c = &all_cmd[i];
-		if (c->doc)
-			print("  %s %-*s %s", c->cmd,
-				(int)(25 - strlen(c->cmd)), "", c->doc ? : "");
+		if ((int)strlen(c->arg ? : "") <=
+					(int)(25 - strlen(c->cmd)))
+			printf("  %s %-*s %s\n", c->cmd,
+					(int)(25 - strlen(c->cmd)),
+					c->arg ? : "",
+					c->doc ? : "");
+		else
+			printf("  %s %-s\n" "  %s %-25s %s\n",
+					c->cmd,
+					c->arg ? : "",
+					"", "",
+					c->doc ? : "");
 	}
 
 	if (!interactive)
@@ -4713,9 +4789,18 @@ static void rl_handler(char *input)
 
 	for (i = 0; i < NELEM(interactive_cmd); i++) {
 		c = &interactive_cmd[i];
-		if (c->doc)
-			print("  %s %-*s %s", c->cmd,
-				(int)(25 - strlen(c->cmd)), "", c->doc ? : "");
+		if ((int)strlen(c->arg ? : "") <=
+					(int)(25 - strlen(c->cmd)))
+			printf("  %s %-*s %s\n", c->cmd,
+					(int)(25 - strlen(c->cmd)),
+					c->arg ? : "",
+					c->doc ? : "");
+		else
+			printf("  %s %-s\n" "  %s %-25s %s\n",
+					c->cmd,
+					c->arg ? : "",
+					"", "",
+					c->doc ? : "");
 	}
 
 free_we:
-- 
2.7.4

