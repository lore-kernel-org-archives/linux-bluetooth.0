Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/5] hcitool: Change commands struct formating
Date: Mon, 28 Feb 2011 15:18:51 -0300
Message-Id: <1298917134-8229-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1298917134-8229-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hcitool.c |   58 +++++++++++++++++++++++++++---------------------------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/tools/hcitool.c b/tools/hcitool.c
index 1184b6b..8945156 100644
--- a/tools/hcitool.c
+++ b/tools/hcitool.c
@@ -2746,35 +2746,35 @@ static struct {
 	void (*func)(int dev_id, int argc, char **argv);
 	char *doc;
 } command[] = {
-	{ "dev",    cmd_dev,    "Display local devices"                },
-	{ "inq",    cmd_inq,    "Inquire remote devices"               },
-	{ "scan",   cmd_scan,   "Scan for remote devices"              },
-	{ "name",   cmd_name,   "Get name from remote device"          },
-	{ "info",   cmd_info,   "Get information from remote device"   },
-	{ "spinq",  cmd_spinq,  "Start periodic inquiry"               },
-	{ "epinq",  cmd_epinq,  "Exit periodic inquiry"                },
-	{ "cmd",    cmd_cmd,    "Submit arbitrary HCI commands"        },
-	{ "con",    cmd_con,    "Display active connections"           },
-	{ "cc",     cmd_cc,     "Create connection to remote device"   },
-	{ "dc",     cmd_dc,     "Disconnect from remote device"        },
-	{ "sr",     cmd_sr,     "Switch master/slave role"             },
-	{ "cpt",    cmd_cpt,    "Change connection packet type"        },
-	{ "rssi",   cmd_rssi,   "Display connection RSSI"              },
-	{ "lq",     cmd_lq,     "Display link quality"                 },
-	{ "tpl",    cmd_tpl,    "Display transmit power level"         },
-	{ "afh",    cmd_afh,    "Display AFH channel map"              },
-	{ "lp",     cmd_lp,     "Set/display link policy settings"     },
-	{ "lst",    cmd_lst,    "Set/display link supervision timeout" },
-	{ "auth",   cmd_auth,   "Request authentication"               },
-	{ "enc",    cmd_enc,    "Set connection encryption"            },
-	{ "key",    cmd_key,    "Change connection link key"           },
-	{ "clkoff", cmd_clkoff, "Read clock offset"                    },
-	{ "clock",  cmd_clock,  "Read local or remote clock"           },
-	{ "lescan", cmd_lescan, "Start LE scan"                        },
-	{ "lewladd", cmd_lewladd, "Add device to LE White List"        },
-	{ "lecc",   cmd_lecc,   "Create a LE Connection"               },
-	{ "ledc",   cmd_ledc,   "Disconnect a LE Connection"           },
-	{ "lecup",  cmd_lecup,  "LE Connection Update"                 },
+	{ "dev",      cmd_dev,     "Display local devices"                },
+	{ "inq",      cmd_inq,     "Inquire remote devices"               },
+	{ "scan",     cmd_scan,    "Scan for remote devices"              },
+	{ "name",     cmd_name,    "Get name from remote device"          },
+	{ "info",     cmd_info,    "Get information from remote device"   },
+	{ "spinq",    cmd_spinq,   "Start periodic inquiry"               },
+	{ "epinq",    cmd_epinq,   "Exit periodic inquiry"                },
+	{ "cmd",      cmd_cmd,     "Submit arbitrary HCI commands"        },
+	{ "con",      cmd_con,     "Display active connections"           },
+	{ "cc",       cmd_cc,      "Create connection to remote device"   },
+	{ "dc",       cmd_dc,      "Disconnect from remote device"        },
+	{ "sr",       cmd_sr,      "Switch master/slave role"             },
+	{ "cpt",      cmd_cpt,     "Change connection packet type"        },
+	{ "rssi",     cmd_rssi,    "Display connection RSSI"              },
+	{ "lq",       cmd_lq,      "Display link quality"                 },
+	{ "tpl",      cmd_tpl,     "Display transmit power level"         },
+	{ "afh",      cmd_afh,     "Display AFH channel map"              },
+	{ "lp",       cmd_lp,      "Set/display link policy settings"     },
+	{ "lst",      cmd_lst,     "Set/display link supervision timeout" },
+	{ "auth",     cmd_auth,    "Request authentication"               },
+	{ "enc",      cmd_enc,     "Set connection encryption"            },
+	{ "key",      cmd_key,     "Change connection link key"           },
+	{ "clkoff",   cmd_clkoff,  "Read clock offset"                    },
+	{ "clock",    cmd_clock,   "Read local or remote clock"           },
+	{ "lescan",   cmd_lescan,  "Start LE scan"                        },
+	{ "lewladd",  cmd_lewladd, "Add device to LE White List"          },
+	{ "lecc",     cmd_lecc,    "Create a LE Connection"               },
+	{ "ledc",     cmd_ledc,    "Disconnect a LE Connection"           },
+	{ "lecup",    cmd_lecup,   "LE Connection Update"                 },
 	{ NULL, NULL, 0 }
 };
 
-- 
1.7.4.1

