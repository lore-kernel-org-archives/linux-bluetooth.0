Return-Path: <cyrus@holtmann.org>
From: Vikrampal Yadav <vikram.pal@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, d.kasatkin@samsung.com,
	vikram.pal@samsung.com
Subject: [PATCH 3/6] monitor: Handle AVRCP specific AV/C PDUs
Date: Mon, 11 Aug 2014 19:56:39 +0530
Message-id: <1407767202-7693-3-git-send-email-vikram.pal@samsung.com>
In-reply-to: <1407767202-7693-1-git-send-email-vikram.pal@samsung.com>
References: <1407767202-7693-1-git-send-email-vikram.pal@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added handling of AVRCP specific AV/C PDUs.
---
 monitor/avctp.c | 188 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)

diff --git a/monitor/avctp.c b/monitor/avctp.c
index 2a41a7c..8eca5da 100644
--- a/monitor/avctp.c
+++ b/monitor/avctp.c
@@ -163,13 +163,201 @@ static const char *opcode2str(uint8_t opcode)
         }
 }
 
+static const char *pdu2str(uint8_t pduid)
+{
+	return "Unknown";
+}
+
+static const char *pt2str(uint8_t pt)
+{
+	return "Unknown";
+}
+
 static void avrcp_passthrough_packet(const struct l2cap_frame *frame)
 {
 }
 
+static void avrcp_get_capabilities(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_list_player_attributes(const struct l2cap_frame *frame,
+                                                uint8_t ctype, uint8_t len,
+                                                uint8_t indent)
+{
+}
+
+static void avrcp_list_player_values(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_get_current_player_value(const struct l2cap_frame *frame,
+                                                uint8_t ctype, uint8_t len,
+                                                uint8_t indent)
+{
+}
+
+static void avrcp_set_player_value(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_get_player_attribute_text(const struct l2cap_frame *frame,
+                                                uint8_t ctype, uint8_t len,
+                                                uint8_t indent)
+{
+}
+
+static void avrcp_get_player_value_text(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_displayable_charset(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_ct_battery_status(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_get_element_attributes(const struct l2cap_frame *frame,
+                                                uint8_t ctype, uint8_t len,
+                                                uint8_t indent)
+{
+}
+
+static void avrcp_get_play_status(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_register_notification(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_set_absolute_volume(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_set_addressed_player(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+static void avrcp_play_item(const struct l2cap_frame *frame,
+                                uint8_t ctype, uint8_t len,
+                                uint8_t indent)
+{
+}
+
+static void avrcp_add_to_now_playing(const struct l2cap_frame *frame,
+                                        uint8_t ctype, uint8_t len,
+                                        uint8_t indent)
+{
+}
+
+struct avrcp_ctrl_pdu_data {
+        uint8_t pduid;
+        void (*func) (const struct l2cap_frame *frame, uint8_t ctype,
+                        uint8_t len, uint8_t indent);
+};
+
+static const struct avrcp_ctrl_pdu_data avrcp_ctrl_pdu_table[] = {
+        { 0x10, avrcp_get_capabilities                  },
+        { 0x11, avrcp_list_player_attributes            },
+        { 0x12, avrcp_list_player_values                },
+        { 0x13, avrcp_get_current_player_value          },
+        { 0x14, avrcp_set_player_value                  },
+        { 0x15, avrcp_get_player_attribute_text         },
+        { 0x16, avrcp_get_player_value_text             },
+        { 0x17, avrcp_displayable_charset               },
+        { 0x18, avrcp_ct_battery_status                 },
+        { 0x20, avrcp_get_element_attributes            },
+        { 0x30, avrcp_get_play_status                   },
+        { 0x31, avrcp_register_notification             },
+        { 0x50, avrcp_set_absolute_volume               },
+        { 0x60, avrcp_set_addressed_player              },
+        { 0x74, avrcp_play_item                         },
+        { 0x90, avrcp_add_to_now_playing                },
+        { }
+};
+
+static void avrcp_rejected_packet(const struct l2cap_frame *frame)
+{
+}
+
 static void avrcp_pdu_packet(const struct l2cap_frame *frame, uint8_t ctype,
                                 uint8_t indent)
 {
+        uint8_t pduid, pt;
+        uint16_t len;
+        int i;
+        const struct avrcp_ctrl_pdu_data *ctrl_pdu_data = NULL;
+        const char *ctrl_pdu_data_color;
+        struct l2cap_frame avrcp_frame;
+
+        pduid = *((uint8_t *) frame->data);
+        pt = *((uint8_t *) (frame->data + 1));
+        len = get_be16(frame->data + 2);
+
+        print_indent(indent, ctrl_pdu_data_color, "AVRCP: ", pdu2str(pduid),
+                        COLOR_OFF, " pt %s len 0x%04x",
+                        pt2str(pt), len);
+
+        if ((frame->size < 4) || ((frame->size - 4) != len)) {
+                print_text(COLOR_ERROR, "PDU malformed");
+                packet_hexdump(frame->data, frame->size);
+                return;
+        }
+
+        if (ctype == 0xA) {
+                avrcp_rejected_packet(frame);
+                return;
+        }
+
+        for (i = 0; avrcp_ctrl_pdu_table[i].func; i++) {
+                if (avrcp_ctrl_pdu_table[i].pduid == pduid) {
+                        ctrl_pdu_data = &avrcp_ctrl_pdu_table[i];
+                        break;
+                }
+        }
+
+	if (ctrl_pdu_data) {
+                if (ctrl_pdu_data->func) {
+                        if (frame->in)
+                                ctrl_pdu_data_color = COLOR_MAGENTA;
+                        else
+                                ctrl_pdu_data_color = COLOR_BLUE;
+                } else
+                        ctrl_pdu_data_color = COLOR_WHITE_BG;
+        } else {
+                ctrl_pdu_data_color = COLOR_WHITE_BG;
+        }
+
+        if (!ctrl_pdu_data || !ctrl_pdu_data->func) {
+                packet_hexdump(frame->data + 4, frame->size - 4);
+                return;
+        }
+
+        l2cap_frame_pull(&avrcp_frame, frame, 4);
+        ctrl_pdu_data->func(&avrcp_frame, ctype, len, indent + 2);
 }
 
 static void avrcp_control_packet(const struct l2cap_frame *frame)
-- 
1.9.1

