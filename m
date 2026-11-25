Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795641128;
	b=CHUd7YUR7OKjkgaCdNrGfQk3sq+YfJKaIeW01TZU1eFmugvQoRZOFA4m4+x8vZOjrC/Z
	 HMWygBVx3Urd1rf0fRwgzovEXcrbtBt3Q7eu73JzkWFnJ8GHmFy4q5QQBGqNzGEr6kZp/
	 aEe5rUrVi4S5b+O/8nQx/2BK/nqZwhVY9+ed6H1baeoqb9WRR72u3nptdIfoowSFTncC9
	 yayAXmnnOdlarp90POJu+Vg7ImuCI7fZRpP/LtDfE0eb2DdfbDdn1DXWm7dnOZRvY/5Uc
	 YbIh9pU6LgO1H4l/IjFTaKxy7tGuIj2qj4NcPGb7VCB4eOMYyqZILhi0DHC68/Oyj9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795641128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9DM1BObO3EN2hJHUP0XapSaCt0jlQ4U0Y0iGF/b0SwY=;
	b=GUHv9OJkZEaabwN6EH1oW8IDuN4T+K3o+MV0ARJKx1UWA+PEc/Efva3GRmLhh/n9Qx1x
	 qQgXlf5+vVTzQjQLhgmUqw+44AbAq2cew5TB0LkyelkwfOn486D6E/oVgdKRh8JJVf1KB
	 H/jcGmvRpJDkaIC4+0134LbZW4cuOT5NhCqZoQM9hsg+mW5hnYWFyGx3idzHLLeAYFCaa
	 VenzoNtjl6kHRCVJnOMD55Bd26fV70dl94mq+U4cljHV6+FnG6miN1i22PV1Hifqlp4Nh
	 Bnc8eis/NqH63iO11wMFOwZv0oQjvErT/3LNdMp1nMxxa8haLlrys/Uv3cEJHjKBF6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7ejHGJP;
	arc=none smtp.remote-ip=209.85.222.44
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAC606A31E
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 21:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62FAC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7ejHGJP
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-99e0db26c4bso1838984241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795641127; x=1796245927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9DM1BObO3EN2hJHUP0XapSaCt0jlQ4U0Y0iGF/b0SwY=;
        b=K7ejHGJP+oUBAnEEdnmiZV3zmPUijBYYlHuMHrcgNr+qNSGpbkP7/VZC4GV2Vzp/mQ
         5Q8HLoGOsg9eU/LkhXw01n7Ui3DL5P8GIVDAEhVnEj8rcHkIUJK28Qg3uQAMP5sNX7Qm
         opoLX+HE1vM3ALEeAwyn2GrA+mCpltiAgWO3TeQQdxYY1QGqRveZFuPOCLjyWbSvSl7T
         pzZivcaLNDzi+USsO5AR75ZJcbaNOKu49xUIKqVXIRUHG/rUeKCYfsDfborjmJzg0hqw
         Ac9JW3bxsf1dUgMugvAWeN2q+X84YW2tqED+a5Id6IeZXP/VcuJEMkiub5E3eYroDCDS
         6b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795641127; x=1796245927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9DM1BObO3EN2hJHUP0XapSaCt0jlQ4U0Y0iGF/b0SwY=;
        b=XUELDwvJ8lHRsTEqM604sPgoXfQQjSv6UOD5R1Oyo4JpnlIjbK10iFIcCm5ptOohVS
         icy0uXtUEgVUt/0ikJUzO0CbRNSwL9b+uBE+VUrP7IuBIDWwWdoFxlDDCkA3F4Jjppo+
         ta1UELC4qxwwsZ6vRUJbsRac/eItKemJliCmER7ZLS8zEWKTS+HmuNIBAd3eQtQAsMbI
         7em+w4rH4vnTKybMIcN0Wt0l8SsgWUa0XNz5VpnvcORChKQfzKdtvnFV9IVCmhZKrOfp
         +QoP6cU4RXjJmmiiLTv3q0fdI06bRbmGZXDHt2CeVWxm3nzLnuzFap+rov4YUuHDv77z
         cEpg==
X-Gm-Message-State: APuU4Z/HjfLI05QmVaGNIBYK166cX3yqxQfy0dvsdMpzXkYFLOlX69TO
	fM7US2iT00ogEg2pPd9FcYfg2B9ab63HHefscb3lLxyFcQ0HR7vQrTgLN55aFw==
X-Gm-Gg: AZFdTZfS0c001he9lEpy9cQH0NXAcSGFV9iYifFLqq4hq1m+Rj5hT5ejxqUmHjWF7WO
	FwyFlsQf+idHpL+/KYYH5WHXjz6I3i7B8MSGpcei/frZtSgZqQarmE/kf5SUHztX6s3iNfpG+l1
	Q1jCLPtfDHzNNtXG2HSoLrFMKv0dVEMwDw/G4Y4Mur5UnrjqheimzAwUYw5Ekf3LqyZGNb+pV3O
	Bg0gcN8v21v595D66mA1tIvqQ7ucl4Xsb1nvWVfRZpdp+5+/ZMu6qJZ3TZdzHzUdVHT7uwXGLpZ
	Zd9uFIuU0oj2UR0Cjx5arv+xMg2kgt+fkztHhqvGpZkYV+c7RKVnG3JwbnBy67ns61T2lAyeJ/i
	Isae1aGh1wbpyHQMgd7TY2gKXuKAveg7dmB5p6Daek3kUq9hzCvKGc9GNxzF9ZisUVYpM5SZU9W
	v2uFpFilv8UCXXlVHF/lOtlcVbvtoDjAMpRVH5d/IJngVKxIbHP/6bpmHsBaIDmhoer2Xal+gjW
	cftzV0KV+0vnLOHdznCLRD/AZGn9uNNO922FtyCd72sWeVg6fbc8zYZSlhtR1mWw8xSpDIe0TWU
	9UFxeegKhbYC+PIrQw1cSy5qsr1sQehIpOjrKcZ2jVTSqWWXR2Og7cXj9Hhj5S/0lPYRFhoV9iW
	P+yABywKP84457iMv60zs1XYGIRZ5nGf7/ZiMwAz+GtU/dTvaQ0GDIisf73Bc2cShmylc7041gY
	GmkF8=
X-Received: by 2002:a05:6102:8097:b0:7d2:da5c:6f7e with SMTP id ada2fe7eead31-7d7395e32acmr8754467137.21.1795641127257;
        Wed, 25 Nov 2026 13:12:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e6e0686b1sm20199653241.10.2026.11.25.13.12.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 13:12:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 5/6] l2cap-tester: Set IO capability in Client SSP - Success 2
Date: Wed, 25 Nov 2026 16:11:59 -0500
Message-ID: <20261125211200.1955466-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125211200.1955466-1-luiz.dentz@gmail.com>
References: <20261125211200.1955466-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

L2CAP BR/EDR Client SSP - Success 2 connects with BT_SECURITY_HIGH but
doesn't set the IO capability, which defaults to NoInputNoOutput, so
pairing results in an unauthenticated key and the test only passes
because the kernel lowers the security level of the channel to the one
of the link.

Set the IO capability to DisplayYesNo so pairing results in an
authenticated key and the security level requested is met.

Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 tools/l2cap-tester.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index 6ad8a7aae717..58fd77a3ec79 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -102,6 +102,7 @@ struct l2cap_data {
 	const void *write_data;
 
 	bool enable_ssp;
+	uint8_t io_cap;
 	uint8_t client_io_cap;
 	int sec_level;
 	bool reject_ssp;
@@ -397,6 +398,7 @@ static const struct l2cap_data client_connect_ssp_success_test_2 = {
 	.server_psm = 0x1001,
 	.enable_ssp = true,
 	.sec_level  = BT_SECURITY_HIGH,
+	.io_cap = 0x01,
 	.client_io_cap = 0x04,
 };
 
@@ -2343,6 +2345,16 @@ static void setup_powered_common(void)
 				data->mgmt_index, pin_code_request_callback,
 				data, NULL);
 
+	if (test && test->io_cap) {
+		struct mgmt_cp_set_io_capability cp;
+
+		cp.io_capability = test->io_cap;
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_IO_CAPABILITY,
+				data->mgmt_index, sizeof(cp), &cp,
+				NULL, NULL, NULL);
+	}
+
 	if (test && test->client_io_cap)
 		bthost_set_io_capability(bthost, test->client_io_cap);
 
-- 
2.56.0

