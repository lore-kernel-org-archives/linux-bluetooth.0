Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH BlueZ v3 5/6] replay: Add man page
Date: Wed,  5 Sep 2012 16:14:21 +0200
Message-Id: <1346854462-12396-5-git-send-email-ant@antweb.me>
In-Reply-To: <1346854462-12396-1-git-send-email-ant@antweb.me>
References: <1344533773-12914-1-git-send-email-ant@antweb.me>
 <1346854462-12396-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools          |    6 +-
 tools/replay/btreplay.1 |  148 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 152 insertions(+), 2 deletions(-)
 create mode 100644 tools/replay/btreplay.1

diff --git a/Makefile.tools b/Makefile.tools
index ba2db00..8b1e3de 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -94,11 +94,13 @@ endif
 
 dist_man_MANS += tools/rfcomm.1 tools/l2ping.8 \
 			tools/hciattach.8 tools/hciconfig.8 \
-			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
+			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1 \
+			tools/replay/btreplay.1
 else
 EXTRA_DIST += tools/rfcomm.1 tools/l2ping.8 \
 			tools/hciattach.8 tools/hciconfig.8 \
-			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
+			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1 \
+			tools/replay/btreplay.1
 endif
 
 CLEANFILES += tools/lexer.c tools/parser.c tools/parser.h
diff --git a/tools/replay/btreplay.1 b/tools/replay/btreplay.1
new file mode 100644
index 0000000..36fd6c7
--- /dev/null
+++ b/tools/replay/btreplay.1
@@ -0,0 +1,148 @@
+.TH BTREPLAY 1 "August 2012" BlueZ "Linux System Administration "
+
+.SH NAME
+btreplay \- Bluetooth Replayer
+
+.SH SYNOPSIS
+.B btreplay
+.RB [\| \-d
+.IR none|delta \|]
+.RB [\| \-m
+.IR factor \|]
+.RB [\| \-t
+.IR timeout \|]
+.RB [\| \-c
+.IR config-file \|]
+.RB [\| \-v \|]
+.RI "" file " ..."
+
+.SH DESCRIPTION
+.B btreplay
+uses a VHCI interface to simulate HCI traffic from a recorded scenario. It
+reads packets from BTSnoop dump files and replays them on the virtual
+interface.
+.PP
+.TP
+.B "Delay modes"
+The delay mode handles the delay between two packets in the replay process.
+.br
+Following delay modes are supported:
+
+.BR "delta" ": use time difference between two packets (delta value) from the"
+dump for delay
+.br
+.BR "none" ": no delay"
+.TP
+.B "Delay modifier"
+Allows to speed up or slow down the  overall  packet  delay.  When used with
+delta delay mode, each delta value in the sequence is multiplied with the
+specified factor.
+.TP
+.B "Packet action"
+The action defines how packets are handled within the replay process.
+.BR "" "The default action is " "replay" "."
+
+.BR "replay" ": Replay packet from dump file"
+.br
+.BR "skip" ": Skip packet"
+.br
+.BR "emulate" ": Forward packet to emulator"
+.TP
+.B "Config file"
+A config file can alter attributes and actions for specific packets in the
+sequence or packet types.
+
+.SH OPTIONS
+.TP
+.BI "\-d, --delay-mode=" "none|delta"
+.RI "Specify delay mode (default is " "none" ")"
+.TP
+.BI "\-m, --delay-modifier=" "N"
+Set delay modifier to N (default is 1)
+.TP
+.BI "\-t, --timeout=" "N"
+.RI "Set timeout to " "N" " milliseconds when receiving packets from host."
+.br
+Set to -1 by default (no timeout)
+.TP
+.BI "\-c, --config=" "config-file"
+Use config file
+.TP
+.BI "\-v, --verbose"
+Enable verbose output
+.TP
+.BI \--version
+Give version information
+.TP
+.BI \--help
+Give a short usage message
+
+.SH CONFIG FILE FORMAT
+The config parser expects one definition per line. Each line has the syntax
+
+.in +4n
+.nf
+.I "scope key=value[,key=value,...]"
+.fi
+.in
+
+and must be terminated by EOF or '\\n'.
+
+.SS Scopes
+The scope defines which packets are affected by the configuration. All scopes
+that do not specify a particular position in the sequence are used as a type
+filter (i.e. they also apply to all incoming and outgoing packets, even if they
+are not in the sequence).
+.TP
+.B all
+All packets in the sequence
+.TP
+.B N
+Single packet
+.TP
+.B N-M
+Packet range (e.g. 2-10, from packet 2 to 10)
+.TP
+.B HCI_ACL
+ACL data packets
+.TP
+.B HCI_EVT_0xXX
+Event code
+.br
+(e.g. HCI_EVT_0x0e, all packets with event code 0x0e (Command Complete))
+.TP
+.B HCI_CMD_0xXX|0xXXXX
+Opcode
+.br
+(e.g. 0x03|0x0003, all packets with OGF 0x03 and OCF 0x0003 (Reset)).
+.br
+Also applies to corresponding Command Complete event packets.
+.PP
+(N and M being the packet position in the sequence, starting with 1)
+
+.SS Properties
+The properties define the configuration that should be applied to the scope.
+.RB "Every property has a " "key"
+.RI " and a " "value" " delimited by an equals sign."
+.TP
+.BI "action="replay|skip|emulate
+Set packet action
+.TP
+.BI "delta="value
+Override delta value (used in delta delay mode)
+
+.SS Example configuration
+all delta=300,action=replay
+.br
+1-4 action=emulate
+.br
+1 delta=500
+.br
+HCI_EVT_0x0e delta=0
+.br
+HCI_CMD_0x03|0x0003 action=emulate
+.br
+HCI_ACL action=replay
+.br
+.SH AUTHOR
+Written by Anton Weber <ant@antweb.me>
-- 
1.7.9.5

