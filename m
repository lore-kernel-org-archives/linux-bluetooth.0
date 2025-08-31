Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE64417AE11;
	Sun, 31 Aug 2025 17:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756660418; cv=none; b=Ufg0rFGj4EwjcuCyaSk9k8Ty4V8nKCLRDy2ANjm5LdcInAd0GFb7bS/fbfNsqAsW8hjJldoP37/4O8hQar3Di57l4RyCy6A8mXpExpUl5i/trWJUIS4cB5jonUXie7TTfZvt8y9iSkiLumhoLfCy7Q5Vyu8l0fjblYv3oV2d06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756660418; c=relaxed/simple;
	bh=bWiw0g/It4XUK2S29HbLGUxlfyTq9EHrd2OtfaB0MZM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M8V+AQHtzYc2QjAoxNynQGbPDLmsVEXVkIgMNldlq6ocEUUpO0Dlp3jRu1cVnli0S5HfGN/qDsb5jZURThK8NWFPT9OS2KJpqkcCvhjDNODW6KgAu9tUqGrH+yy3K6wa5ghJL+IOSYyGN3xcaE6DE6Kbsetf9vSg8btGZxW8Qks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3iT7VCf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3iT7VCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9BAC4CEED;
	Sun, 31 Aug 2025 17:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756660418;
	bh=bWiw0g/It4XUK2S29HbLGUxlfyTq9EHrd2OtfaB0MZM=;
	h=Date:From:To:Cc:Subject:From;
	b=Z3iT7VCfsxTvLDm1mEUBgalSDB+H6miFjdWAZA3/RfnAuAuWBnEy4sLrE5s+fePGa
	 kzo7YU8KMXvqloXoTDa/pcxp9XiVKRXpEbSzdolWPrR8xXYarSyyEU799SdDafmN/L
	 3ce/mkWfZcCFtCQJZrJaY3VH4mNUBtDSjehg6jt9WVitwBDm9XrBW8pZ7TN0jR3uYQ
	 D929ooqEnalyYG3icwvwbGfoDoaP+6A8bU5fYFa0ERTUs45a49i6rEytcsdLoI+ry6
	 nkNcF5spufIN11vpek13SyBuvptIGfK4hQCaMlhNUntIit3Z85G6QNP6hCYPGbWYEZ
	 6joJijGC6FBCw==
Date: Sun, 31 Aug 2025 19:13:31 +0200
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] Bluetooth: Avoid a couple dozen
 -Wflex-array-member-not-at-end warnings
Message-ID: <aLSCu8U62Hve7Dau@kspp>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the new TRAILING_OVERLAP() helper to fix 31 instances of the 
following type of warnings:

30 net/bluetooth/mgmt_config.c:16:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
1 net/bluetooth/mgmt_config.c:22:33: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

This helper creates a union between a flexible-array member (FAM)
and a set of members that would otherwise follow it. This overlays
the trailing members onto the FAM while preserving the original
memory layout.

Also, as the structs turn into unions, both members `entry` and
`value` cannot be statically initialized at once. Create another
macro to initialize everything after the declaration of `rp`.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 net/bluetooth/mgmt_config.c | 97 +++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 46 deletions(-)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index 6ef701c27da4..829c9cfcea7d 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -12,35 +12,71 @@
 #include "mgmt_config.h"
 
 #define HDEV_PARAM_U16(_param_name_) \
-	struct {\
-		struct mgmt_tlv entry; \
+	TRAILING_OVERLAP(struct mgmt_tlv, entry, value, \
 		__le16 value; \
-	} __packed _param_name_
+	) __packed _param_name_
 
 #define HDEV_PARAM_U8(_param_name_) \
-	struct {\
-		struct mgmt_tlv entry; \
+	TRAILING_OVERLAP(struct mgmt_tlv, entry, value, \
 		__u8 value; \
-	} __packed _param_name_
+	) __packed _param_name_
 
 #define TLV_SET_U16(_param_code_, _param_name_) \
 	{ \
-		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-		cpu_to_le16(hdev->_param_name_) \
+		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
+		rp._param_name_.entry.length = sizeof(__u16); \
+		rp._param_name_.value = cpu_to_le16(hdev->_param_name_); \
 	}
 
 #define TLV_SET_U8(_param_code_, _param_name_) \
 	{ \
-		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
-		hdev->_param_name_ \
+		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
+		rp._param_name_.entry.length = sizeof(__u8); \
+		rp._param_name_.value = hdev->_param_name_; \
 	}
 
 #define TLV_SET_U16_JIFFIES_TO_MSECS(_param_code_, _param_name_) \
 	{ \
-		{ cpu_to_le16(_param_code_), sizeof(__u16) }, \
-		cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)) \
+		rp._param_name_.entry.type = cpu_to_le16(_param_code_); \
+		rp._param_name_.entry.length = sizeof(__u16); \
+		rp._param_name_.value = cpu_to_le16(jiffies_to_msecs(hdev->_param_name_)); \
 	}
 
+#define TLV_SET_ALL() \
+{ \
+	TLV_SET_U16(0x0000, def_page_scan_type); \
+	TLV_SET_U16(0x0001, def_page_scan_int); \
+	TLV_SET_U16(0x0002, def_page_scan_window); \
+	TLV_SET_U16(0x0003, def_inq_scan_type);  \
+	TLV_SET_U16(0x0004, def_inq_scan_int); \
+	TLV_SET_U16(0x0005, def_inq_scan_window); \
+	TLV_SET_U16(0x0006, def_br_lsto); \
+	TLV_SET_U16(0x0007, def_page_timeout); \
+	TLV_SET_U16(0x0008, sniff_min_interval); \
+	TLV_SET_U16(0x0009, sniff_max_interval); \
+	TLV_SET_U16(0x000a, le_adv_min_interval); \
+	TLV_SET_U16(0x000b, le_adv_max_interval); \
+	TLV_SET_U16(0x000c, def_multi_adv_rotation_duration); \
+	TLV_SET_U16(0x000d, le_scan_interval); \
+	TLV_SET_U16(0x000e, le_scan_window); \
+	TLV_SET_U16(0x000f, le_scan_int_suspend); \
+	TLV_SET_U16(0x0010, le_scan_window_suspend); \
+	TLV_SET_U16(0x0011, le_scan_int_discovery); \
+	TLV_SET_U16(0x0012, le_scan_window_discovery); \
+	TLV_SET_U16(0x0013, le_scan_int_adv_monitor); \
+	TLV_SET_U16(0x0014, le_scan_window_adv_monitor); \
+	TLV_SET_U16(0x0015, le_scan_int_connect); \
+	TLV_SET_U16(0x0016, le_scan_window_connect); \
+	TLV_SET_U16(0x0017, le_conn_min_interval); \
+	TLV_SET_U16(0x0018, le_conn_max_interval); \
+	TLV_SET_U16(0x0019, le_conn_latency); \
+	TLV_SET_U16(0x001a, le_supv_timeout); \
+	TLV_SET_U16_JIFFIES_TO_MSECS(0x001b, def_le_autoconnect_timeout); \
+	TLV_SET_U16(0x001d, advmon_allowlist_duration); \
+	TLV_SET_U16(0x001e, advmon_no_filter_duration); \
+	TLV_SET_U8(0x001f, enable_advmon_interleave_scan); \
+}
+
 int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 data_len)
 {
@@ -78,40 +114,9 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(advmon_allowlist_duration);
 		HDEV_PARAM_U16(advmon_no_filter_duration);
 		HDEV_PARAM_U8(enable_advmon_interleave_scan);
-	} __packed rp = {
-		TLV_SET_U16(0x0000, def_page_scan_type),
-		TLV_SET_U16(0x0001, def_page_scan_int),
-		TLV_SET_U16(0x0002, def_page_scan_window),
-		TLV_SET_U16(0x0003, def_inq_scan_type),
-		TLV_SET_U16(0x0004, def_inq_scan_int),
-		TLV_SET_U16(0x0005, def_inq_scan_window),
-		TLV_SET_U16(0x0006, def_br_lsto),
-		TLV_SET_U16(0x0007, def_page_timeout),
-		TLV_SET_U16(0x0008, sniff_min_interval),
-		TLV_SET_U16(0x0009, sniff_max_interval),
-		TLV_SET_U16(0x000a, le_adv_min_interval),
-		TLV_SET_U16(0x000b, le_adv_max_interval),
-		TLV_SET_U16(0x000c, def_multi_adv_rotation_duration),
-		TLV_SET_U16(0x000d, le_scan_interval),
-		TLV_SET_U16(0x000e, le_scan_window),
-		TLV_SET_U16(0x000f, le_scan_int_suspend),
-		TLV_SET_U16(0x0010, le_scan_window_suspend),
-		TLV_SET_U16(0x0011, le_scan_int_discovery),
-		TLV_SET_U16(0x0012, le_scan_window_discovery),
-		TLV_SET_U16(0x0013, le_scan_int_adv_monitor),
-		TLV_SET_U16(0x0014, le_scan_window_adv_monitor),
-		TLV_SET_U16(0x0015, le_scan_int_connect),
-		TLV_SET_U16(0x0016, le_scan_window_connect),
-		TLV_SET_U16(0x0017, le_conn_min_interval),
-		TLV_SET_U16(0x0018, le_conn_max_interval),
-		TLV_SET_U16(0x0019, le_conn_latency),
-		TLV_SET_U16(0x001a, le_supv_timeout),
-		TLV_SET_U16_JIFFIES_TO_MSECS(0x001b,
-					     def_le_autoconnect_timeout),
-		TLV_SET_U16(0x001d, advmon_allowlist_duration),
-		TLV_SET_U16(0x001e, advmon_no_filter_duration),
-		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
-	};
+	} __packed rp;
+
+	TLV_SET_ALL();
 
 	bt_dev_dbg(hdev, "sock %p", sk);
 
-- 
2.43.0

