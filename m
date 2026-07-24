Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BD4450917
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920370; cv=none; b=EzRVrlFRiUowQmY9z416DGci2jmcioV33xktnTKGXIeskPc5kkL+jm7MEtYjNRYMwnKmPk891NJOV8zjZRHTMgElhogxaipN6KEX97cEEf1wKnZCxjyCYR1pjFeJVoC49JRuruPn4oR8/fejcNeY+ezqMKcKnaa+Cf0AYazev4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920370; c=relaxed/simple;
	bh=7Gl3w6i/beLA4zyGTHEkL4bTpF5y/oQBHyycPVSWXpY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XK3jyONpQP1PGx4toI43iCkE7d2dpe57n7rlO8pGSm7UC+/xJn9/tsMwmWbJtJi1DSIU+xNlFKU+Bw5a9TALII3g6qBVeSzzAGTivymOFZfTmX1al7jP2Vzh8WA3b0sEvgmIrXLYu44F/SVNZOyIu+mfau2FtRkP4/M0zNOROGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvn08Hoq; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvn08Hoq"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-74d43f06686so223379137.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920368; x=1785525168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yGbK2py4Un5QTCquODpt9/gmsqxb3kmj7TBg6yqar20=;
        b=Rvn08HoqQymxGF1jrOWKlS6Q+t656Hn4cxYJiofS/UC3TmjLTnp40iXhvAtaiiDkPr
         z5fuA2DPfRwgIS7AcrQdmaSbWLGpiBDxm1GIjVPFKPbeKv5mOjiV2IipxZPAAqqS7yKN
         kGgRdSSfxRpnUNIsNWlMjDgJvDR/ZonyEAFFEKxItEiL1PLcGcmsBzMMZ9RLEhc1dZBI
         jogwRawcUZhrJ1d+7DwCt4ZNHsbHby47JfHdZjU/3hNA4/fGmycCiuXyO9pmManWfoFe
         6BBzFG5O7F9yw62zgqQL7ldWYVN8zx5UzGhuv/e1M35IN0umx2s1lnWJmxfy3mnNxr2i
         MEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920368; x=1785525168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yGbK2py4Un5QTCquODpt9/gmsqxb3kmj7TBg6yqar20=;
        b=ipxhAMv0CMUWkzpm7eW13GvvozCOcb6MKnaCNzLGdhrlqt/XByZsbdDkNpue2BIgxs
         0XC2K8pORgH11OqMQuZGXmaRDsteScNJYSIi8lWAk4CEj2NJNO3j9tRt9clj4OcfBWxM
         UmSXt0vdsVcbpKoFVqk/loA/0RQm7nlxEPc8k9SiFvInyeIXO2eiZx/QLlVKDUsjRn/z
         XDsOoz34Uuw6M3xRLexzz9Si3ALph0nkfSwzLIPKJ9yRrRiLhAQ0om76r8wCSkJXj1ut
         hKqkE0nC6hA06/N4Jbaj2t+1yy9ok2M9phOOUsSdhGyYtwA7+vjfjkeQ/63jVOfnepRB
         cSdg==
X-Gm-Message-State: AOJu0YzIU8YX0XeB0jmoBYst/Q5DnBxw7G3h8+hXWR8DyDEESnTll+2i
	cUzaif4iyPFF4zX1W2wMVK3Lw1NQ6B73OlPpmPVqZf4okIBkG1DMx3patSIMT1Li
X-Gm-Gg: AR+sD12bcrWj2PWNToEnF/rn1w3soAyS2Yy7H6slqdjdgHwPRfIzy7IraNHYXx/GHzT
	rpr50fP+GmowzZgyZM7XP0w1VK5jD6ZxNKY1pK856NxbfH7kZK4LvaX/jm7ANURs2DU5ZQrZqs0
	ErxPkCstYt4nV3l8zFrEz/zD6Ti5OFtQapRWG8PQph/qWlX+Fb+5t8vybnYF7Pq8NuDtC6K6EHo
	qSgWxCt0g6AwK8F8wbke8goa9W8CT+6CSy5rnDJO+MefZuq5sQt61fJhmvjRqN1F5sgWWZpjxwV
	10Tc0aHfUSvaE778G6k+iI970WoBRD+x8lP4SklciNgwgqVkHh7hsp4AaDLEwsyiyMIx5kjwCgU
	smDkmt/2kV39lbgGzOpbDQd+rdn21ZiYeN63Gnq3M+jp6gwj2gd2Vqg6Ea6jw/pr0HoFpk+w2tx
	eU6imVIkhqGW7JRm/3fNb6c2fDQh6BjF/+PM+CfaMFXBM7l7F7Qfm+Ta4ZR/oo57qeoYIFPelr
X-Received: by 2002:a05:6102:f0b:b0:6c3:1bcd:31dd with SMTP id ada2fe7eead31-74d5dcb9ffbmr4303399137.6.1784920368216;
        Fri, 24 Jul 2026 12:12:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:46 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 12/12] l2cap-tester: Add SCI mode tests for LE server connections
Date: Fri, 24 Jul 2026 15:12:25 -0400
Message-ID: <20260724191225.1815634-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add L2CAP LE server connection tests that exercise the peripheral
side of the Shorter Connection Interval feature. The emulated client
(central) is configured via bthost_le_conn_rate() to send an LE
Connection Rate Request once connected, using the HOGP v1.2
recommended values for each of the four HID SCI modes (Fast, Default,
Low Power, Full Range).
---
 tools/l2cap-tester.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 88bfd71bf580..3011a811e15e 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -740,6 +740,26 @@ static const struct l2cap_data le_client_connect_subrate_full_range_test = {
 	.conn_subrate = &conn_subrate_hids_full_range,
 };
 
+static const struct l2cap_data le_server_subrate_fast_test = {
+	.cid = 0x0004,
+	.conn_subrate = &conn_subrate_hids_fast,
+};
+
+static const struct l2cap_data le_server_subrate_default_test = {
+	.cid = 0x0004,
+	.conn_subrate = &conn_subrate_hids_default,
+};
+
+static const struct l2cap_data le_server_subrate_low_power_test = {
+	.cid = 0x0004,
+	.conn_subrate = &conn_subrate_hids_low_power,
+};
+
+static const struct l2cap_data le_server_subrate_full_range_test = {
+	.cid = 0x0004,
+	.conn_subrate = &conn_subrate_hids_full_range,
+};
+
 static const struct l2cap_data le_client_connect_close_test_1 = {
 	.client_psm = 0x0080,
 };
@@ -2963,6 +2983,24 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 
 	data->handle = handle;
 
+	if (l2data->conn_subrate) {
+		const struct l2cap_conn_subrate *cs = l2data->conn_subrate;
+		struct bthost_conn_rate rate;
+
+		rate.interval_min = cs->min_interval;
+		rate.interval_max = cs->max_interval;
+		rate.subrate_min = cs->subrate_min;
+		rate.subrate_max = cs->subrate_max;
+		rate.max_latency = cs->max_latency;
+		rate.cont_num = cs->cont_num;
+		rate.supv_timeout = cs->supv_timeout;
+
+		tester_print("Sending LE Connection Rate Request from client");
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_le_conn_rate(bthost, handle, &rate);
+	}
+
 	if (l2data->send_cmd) {
 		bthost_l2cap_rsp_cb cb;
 
@@ -3248,6 +3286,19 @@ int main(int argc, char *argv[])
 	test_l2cap_le_62("L2CAP LE Client - SCI Full Range Mode",
 				&le_client_connect_subrate_full_range_test,
 				setup_powered_client, test_connect);
+
+	test_l2cap_le_62("L2CAP LE Server - SCI Fast Mode",
+				&le_server_subrate_fast_test,
+				setup_powered_server, test_server);
+	test_l2cap_le_62("L2CAP LE Server - SCI Default Mode",
+				&le_server_subrate_default_test,
+				setup_powered_server, test_server);
+	test_l2cap_le_62("L2CAP LE Server - SCI Low Power Mode",
+				&le_server_subrate_low_power_test,
+				setup_powered_server, test_server);
+	test_l2cap_le_62("L2CAP LE Server - SCI Full Range Mode",
+				&le_server_subrate_full_range_test,
+				setup_powered_server, test_server);
 	test_l2cap_le("L2CAP LE Client - Close",
 				&le_client_connect_close_test_1,
 				setup_powered_client, test_connect_close);
-- 
2.54.0

