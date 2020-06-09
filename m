Return-Path: <SRS0=V72R=7W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1808CC433E1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D022D2078D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jun 2020 14:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VJvbmLPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgFIOEo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729793AbgFIOEn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Jun 2020 10:04:43 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A4BC05BD1E
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2020 07:04:42 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q2so12012680vsr.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2020 07:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JSWgLEKXx9L3gBgRXcltbqOvDqH9BjptfAO1aHbSLJU=;
        b=VJvbmLPhrheuVcuiyhwUSjkMZLIwe1ip7OkQgsyVmkhfGCNjNwbwr+QyyhmZGOA2qy
         HLgbWjzGO5g0A1K/02LIa1THxmI9qCbrfGR+hY+tZrHClhcb6kY9tuZg4xRsbdPJ/7oB
         hpGRPyQH4hI+He20aibMj0ivDEpg7Amw7SJro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JSWgLEKXx9L3gBgRXcltbqOvDqH9BjptfAO1aHbSLJU=;
        b=ptJr19fXSU+rjYzWdKAHjEeUVT/LhpTb15YrCLo9bttr1WfwA+MjujQIHKwi3VvkSM
         +0KSivsjZdvyuGkFrenYCi1LvH5sVQGetONQnbmRRuXtuDO6ymgUhNn2yCoPnNg+oOwr
         YHFQGXy//0JxAB+n0sPgV+o54h6ULpoyuBYMU7K0oE5KlAyuObcvQLbuPoW0/Rtd6+Lv
         cxkAiXNICHkPssowIzsmgzcsMLIVkZUJ5ee6FzYAq8KQKxa8/MuZE9qatFBOO2S46YrQ
         5sZonk6DafWCmqBpiw9JzuzOCPx58ZuL+a96RsR1fBcfFbT0po7ASnBOrg2beKTHICf5
         FqAQ==
X-Gm-Message-State: AOAM530qEBnZ86UFwSdjTAI/4Q4w7gEdBqLb423R4Ng8hQwtXai4gxwK
        +VnKMXrqqB7bG3G7zV7C1lbtEZYh2cg=
X-Google-Smtp-Source: ABdhPJzd/W3PfVeX629ce5KfroO09YIBkR6sb1zpNyGfWQaxJ1mP/Eoi/IS0Q7ZVdphGgwuGIG0UPw==
X-Received: by 2002:a05:6102:2373:: with SMTP id o19mr3034694vsa.205.1591711480070;
        Tue, 09 Jun 2020 07:04:40 -0700 (PDT)
Received: from alain.c.googlers.com.com (252.177.243.35.bc.googleusercontent.com. [35.243.177.252])
        by smtp.gmail.com with ESMTPSA id b7sm403849vsc.13.2020.06.09.07.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:04:39 -0700 (PDT)
From:   Alain Michaud <alainm@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Alain Michaud <alainm@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [PATCH v1 3/3] bluetooth: implement read/set default system parameters mgmt
Date:   Tue,  9 Jun 2020 14:03:54 +0000
Message-Id: <20200609140351.153833-4-alainm@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
In-Reply-To: <20200609140351.153833-1-alainm@chromium.org>
References: <20200609140351.153833-1-alainm@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements the read default system parameters and the set
default system parameters mgmt commands.

Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Signed-off-by: Alain Michaud <alainm@chromium.org>
---

 net/bluetooth/mgmt.c | 429 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 429 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9e8a3cccc6ca..98a4193c8e66 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -111,6 +111,8 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_SECURITY_INFO,
 	MGMT_OP_READ_EXP_FEATURES_INFO,
 	MGMT_OP_SET_EXP_FEATURE,
+	MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
+	MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
 };
 
 static const u16 mgmt_events[] = {
@@ -3849,6 +3851,431 @@ static int set_exp_feature(struct sock *sk, struct hci_dev *hdev,
 			       MGMT_STATUS_NOT_SUPPORTED);
 }
 
+static int read_default_system_parameters(struct sock *sk, struct hci_dev *hdev,
+					  void *data, u16 data_len)
+{
+	struct {
+		struct mgmt_system_parameter_tlv entry;
+		union {
+			/* This is a simplification for now since all values
+			 * are 16 bits.  In the future, this code may need
+			 * refactoring to account for variable length values
+			 * and properly calculate the required buffer size.
+			 */
+			u16 value;
+		};
+	} __packed params[] = {
+		/* Please see mgmt-api.txt for documentation of these values */
+		{
+			{ 0x0000, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_page_scan_type) }
+		},
+		{
+			{ 0x0001, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_page_scan_int) }
+		},
+		{
+			{ 0x0002, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_page_scan_window) }
+		},
+		{
+			{ 0x0003, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_inq_scan_type) }
+		},
+		{
+			{ 0x0004, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_inq_scan_int) }
+		},
+		{
+			{ 0x0005, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_inq_scan_window) }
+		},
+		{
+			{ 0x0006, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_br_lsto) }
+		},
+		{
+			{ 0x0007, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_page_timeout) }
+		},
+		{
+			{ 0x0008, sizeof(__u16) },
+			{ cpu_to_le16(hdev->sniff_min_interval) }
+		},
+		{
+			{ 0x0009, sizeof(__u16) },
+			{ cpu_to_le16(hdev->sniff_max_interval) }
+		},
+		{
+			{ 0x000a, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_adv_min_interval) }
+		},
+		{
+			{ 0x000b, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_adv_max_interval) }
+		},
+		{
+			{ 0x000c, sizeof(__u16) },
+			{ cpu_to_le16(hdev->def_multi_adv_rotation_duration) }
+		},
+		{
+			{ 0x000d, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_interval) }
+		},
+		{
+			{ 0x000e, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_window) }
+		},
+		{
+			{ 0x000f, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_int_suspend) }
+		},
+		{
+			{ 0x0010, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_window_suspend) }
+		},
+		{
+			{ 0x0011, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_int_discovery) }
+		},
+		{
+			{ 0x0012, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_window_discovery) }
+		},
+		{
+			{ 0x0013, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_int_adv_monitor) }
+		},
+		{
+			{ 0x0014, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_window_adv_monitor) }
+		},
+		{
+			{ 0x0015, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_int_connect) }
+		},
+		{
+			{ 0x0016, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_scan_window_connect) }
+		},
+		{
+			{ 0x0017, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_conn_min_interval) }
+		},
+		{
+			{ 0x0018, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_conn_max_interval) }
+		},
+		{
+			{ 0x0019, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_conn_latency) }
+		},
+		{
+			{ 0x001a, sizeof(__u16) },
+			{ cpu_to_le16(hdev->le_supv_timeout) }
+		},
+	};
+	struct mgmt_rp_read_default_system_parameters *rp = (void *)params;
+
+	bt_dev_dbg(hdev, "sock %p", sk);
+
+	return mgmt_cmd_complete(sk, hdev->id,
+				 MGMT_OP_READ_DEFAULT_SYSTEM_PARAMETERS,
+				 0, rp, sizeof(params));
+}
+
+#define TO_TLV(x) ((struct mgmt_system_parameter_tlv *)(x))
+#define TLV_VALUE_CAST(tlv, type) (*((type *)(TO_TLV(tlv)->value)))
+
+static int set_default_system_parameters(struct sock *sk, struct hci_dev *hdev,
+					 void *data, u16 data_len)
+{
+	u16 buffer_left = data_len;
+	u8 *buffer = data;
+
+	if (buffer_left < sizeof(struct mgmt_system_parameter_tlv)) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	/* First pass to validate the tlv */
+	while (buffer_left >= sizeof(struct mgmt_system_parameter_tlv)) {
+		const u8 len = TO_TLV(buffer)->length;
+		const u16 exp_len = sizeof(struct mgmt_system_parameter_tlv) +
+				    len;
+		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
+
+		if (buffer_left < exp_len) {
+			bt_dev_warn(hdev, "invalid len left %d, exp >= %d",
+				    buffer_left, exp_len);
+
+			return mgmt_cmd_status(sk, hdev->id,
+					MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
+					MGMT_STATUS_INVALID_PARAMS);
+		}
+
+		/* Please see mgmt-api.txt for documentation of these values */
+		switch (type) {
+		case 0x0000:
+		case 0x0001:
+		case 0x0002:
+		case 0x0003:
+		case 0x0004:
+		case 0x0005:
+		case 0x0006:
+		case 0x0007:
+		case 0x0008:
+		case 0x0009:
+		case 0x000a:
+		case 0x000b:
+		case 0x000c:
+		case 0x000d:
+		case 0x000e:
+		case 0x000f:
+		case 0x0010:
+		case 0x0011:
+		case 0x0012:
+		case 0x0013:
+		case 0x0014:
+		case 0x0015:
+		case 0x0016:
+		case 0x0017:
+		case 0x0018:
+		case 0x0019:
+		case 0x001a:
+			if (len != sizeof(u16)) {
+				bt_dev_warn(hdev, "invalid length %d, exp %zu for type %d",
+					    len, sizeof(u16), type);
+
+				return mgmt_cmd_status(sk, hdev->id,
+					MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
+					MGMT_STATUS_INVALID_PARAMS);
+			}
+			break;
+		default:
+			bt_dev_warn(hdev, "unsupported parameter %u", type);
+			break;
+		}
+
+		buffer_left -= exp_len;
+		buffer += exp_len;
+	}
+
+	buffer_left = data_len;
+	buffer = data;
+	while (buffer_left >= sizeof(struct mgmt_system_parameter_tlv)) {
+		const u8 len = TO_TLV(buffer)->length;
+		const u16 exp_len = sizeof(struct mgmt_system_parameter_tlv) +
+				    len;
+		const u16 type = le16_to_cpu(TO_TLV(buffer)->type);
+
+		switch (type) {
+		case 0x0000:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_page_scan_type = le16_to_cpu(val);
+			break;
+		}
+		case 0x0001:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_page_scan_int = le16_to_cpu(val);
+			break;
+		}
+		case 0x0002:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_page_scan_window = le16_to_cpu(val);
+			break;
+		}
+		case 0x0003:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_inq_scan_type = le16_to_cpu(val);
+			break;
+		}
+		case 0x0004:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_inq_scan_int = le16_to_cpu(val);
+			break;
+		}
+		case 0x0005:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_inq_scan_window = le16_to_cpu(val);
+			break;
+		}
+		case 0x0006:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_br_lsto = le16_to_cpu(val);
+			break;
+		}
+		case 0x0007:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_page_timeout = le16_to_cpu(val);
+			break;
+		}
+		case 0x0008:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->sniff_min_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x0009:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->sniff_max_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x000a:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_adv_min_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x000b:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_adv_max_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x000c:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->def_multi_adv_rotation_duration =
+							       le16_to_cpu(val);
+			break;
+		}
+		case 0x000d:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x000e:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_window = le16_to_cpu(val);
+			break;
+		}
+		case 0x000f:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_int_suspend = le16_to_cpu(val);
+			break;
+		}
+		case 0x0010:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_window_suspend = le16_to_cpu(val);
+			break;
+		}
+		case 0x0011:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_int_discovery = le16_to_cpu(val);
+			break;
+		}
+		case 0x00012:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_window_discovery = le16_to_cpu(val);
+			break;
+		}
+		case 0x00013:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_int_adv_monitor = le16_to_cpu(val);
+			break;
+		}
+		case 0x00014:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_window_adv_monitor = le16_to_cpu(val);
+			break;
+		}
+		case 0x00015:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_int_connect = le16_to_cpu(val);
+			break;
+		}
+		case 0x00016:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_scan_window_connect = le16_to_cpu(val);
+			break;
+		}
+		case 0x00017:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_conn_min_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x00018:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_conn_max_interval = le16_to_cpu(val);
+			break;
+		}
+		case 0x00019:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_conn_latency = le16_to_cpu(val);
+			break;
+		}
+		case 0x0001a:
+		{
+			const u16 val = TLV_VALUE_CAST(buffer, u16);
+
+			hdev->le_supv_timeout = le16_to_cpu(val);
+			break;
+		}
+		default:
+			bt_dev_warn(hdev, "unsupported parameter %u",
+				    buffer[0]);
+			break;
+		}
+
+		buffer_left -= exp_len;
+		buffer += exp_len;
+	}
+
+	return mgmt_cmd_status(sk, hdev->id,
+			       MGMT_OP_SET_DEFAULT_SYSTEM_PARAMETERS,
+			       MGMT_STATUS_SUCCESS);
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7297,6 +7724,8 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_exp_feature,         MGMT_SET_EXP_FEATURE_SIZE,
 						HCI_MGMT_VAR_LEN |
 						HCI_MGMT_HDEV_OPTIONAL },
+	{ read_default_system_parameters, 0, HCI_MGMT_UNTRUSTED },
+	{ set_default_system_parameters, 0, HCI_MGMT_VAR_LEN },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.27.0.278.ge193c7cf3a9-goog

