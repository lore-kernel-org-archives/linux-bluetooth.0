Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659823BF9C
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759301681; cv=none; b=n385WJ5AcIcRP7KDgPWkxkVh+T8dpM0+Gf+YQUAvQO6cYWNNqSRr5AodEAN3g3ZyOP/Wbxt6h/5Aoi+sElbjsKy1DlEOMird/mi0F9FFyyzwGEjau43JPTeVJ3/aoSdcVF2/bOVa68bN2lue8Tzw4FKr7kXgnMstNAxGmLbNyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759301681; c=relaxed/simple;
	bh=zD5dh4kqj4OmgBoZ2yiDrL9iardxFOqkakzdZx4gD4o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcA3OPxgJHQqBRouUtjMXYSHrXNUmG1o3Fg0Ha1YLnVC9E6qpiqsTzQBGurVv/co+0HvUGZTSzuzGFr/MACjifehH1eYt4nwX6S7mYMV/ZrnhIOuFbminuFvv/MwXchwPJ2mCmkLpyHaZdO8RGTkbiSlG5zq+mZhW1U9F9SHons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NCwIQ21z; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NCwIQ21z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759301676;
	bh=zD5dh4kqj4OmgBoZ2yiDrL9iardxFOqkakzdZx4gD4o=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=NCwIQ21zXpDwCj5inR8j94StTin/ohmZvZxcMw7WCWLWmLmfxWXutTM6yrMaSBBmB
	 5sX2gnprr0E0ClXppM5k/hyuou0x+4yd8BFIWHCKM8dzHKyGp+sO+qgVZGdn4rBYZw
	 b93XIQRwbFjuCG/Nz9jEHR3d2MYp6RlSkuzByjtlFKraHzGknD8pdQq6/jzWOdVPa/
	 Uu4Ji7ADlSwa/oeD8QVASQ7QyzR33ZkanwvethOOdUwMJJf/hgUAzk90v3VPhwp6dU
	 lxFqGVjtVyF83JVd5JJObNrkVYx3200JXlHjC+LQG2as7UssHHx4GihMQoHL3mopcH
	 oaD/CgnlHMwtw==
Received: from fdanis-ThinkPad-X1.. (2a02-8428-af44-1001-2e77-3033-4926-5452.rev.sfr.net [IPv6:2a02:8428:af44:1001:2e77:3033:4926:5452])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AA7C817E131B
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Oct 2025 08:54:36 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] unit/test-hfp: Add incoming call prior to connection test
Date: Wed,  1 Oct 2025 08:54:28 +0200
Message-ID: <20251001065429.268068-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001065429.268068-1-frederic.danis@collabora.com>
References: <20251001065429.268068-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This add the following test:
- /HFP/HF/ICA/BV-07-C
  Verify that HF can connect to an AG that is receiving an in-coming
  call.
---
 unit/test-hfp.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 7667c525c..2d8f4396d 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -849,7 +849,10 @@ static void hf_update_indicator(enum hfp_indicator indicator, uint32_t val,
 			g_assert_cmpint(val, ==, 0);
 			break;
 		case HFP_INDICATOR_CALLSETUP:
-			g_assert_cmpint(val, ==, 0);
+			if (g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C"))
+				g_assert_cmpint(val, ==, 1);
+			else
+				g_assert_cmpint(val, ==, 0);
 			break;
 		case HFP_INDICATOR_CALLHELD:
 			g_assert_cmpint(val, ==, 0);
@@ -934,6 +937,7 @@ static void hf_call_added(uint id, enum hfp_call_status status,
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICR/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
@@ -996,6 +1000,7 @@ static void hf_call_line_id_updated(uint id, const char *number,
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-03-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-01-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		bool ret;
@@ -1037,6 +1042,7 @@ static void hf_call_status_updated(uint id, enum hfp_call_status status,
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-04-C-full") ||
 		g_str_equal(test_name, "/HFP/HF/ICA/BV-06-C") ||
+		g_str_equal(test_name, "/HFP/HF/ICA/BV-07-C") ||
 		g_str_equal(test_name, "/HFP/HF/TCA/BV-02-C")) {
 		const char *number;
 
@@ -1491,6 +1497,27 @@ int main(int argc, char *argv[])
 				'2', ',', '0', '\r', '\n'),
 			data_end());
 
+	/* Answer Incoming call on AG prior to connection, no in-band
+	 * ring - HF
+	 */
+	define_hf_test("/HFP/HF/ICA/BV-07-C", test_hf_session,
+			NULL, test_hf_session_done,
+			MINIMAL_SLC_SESSION('1', '0', '1', '0'),
+			frg_pdu('\r', '\n', 'R', 'I', 'N', 'G', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'L', 'I', 'P', ':',
+				'\"', '1', '2', '3', '4', '5', '6', '7', '\"',
+				',', '1', '2', '9', ',', ',', ',', '\"', 'A',
+				'i', 'n', 'c', 'o', 'm', 'i', 'n', 'g', 'c',
+				'a', 'l', 'l', '\"', '\r', '\n'),
+			raw_pdu('\r', '\n', 'O', 'K', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '1', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'3', ',', '0', '\r', '\n'),
+			frg_pdu('\r', '\n', '+', 'C', 'I', 'E', 'V', ':', ' ',
+				'2', ',', '0', '\r', '\n'),
+			data_end());
+
 	/* Initiate rejection of incoming call - HF */
 	define_hf_test("/HFP/HF/ICR/BV-01-C", test_hf_session,
 			NULL, test_hf_session_done,
-- 
2.43.0

