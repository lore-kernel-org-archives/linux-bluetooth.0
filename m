Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328519;
	b=U8m96YtxWK/HWDXBAKLanZylhBKap3xSV013Z+HV8xmWnKOLptQtUsyu4H5P+lC+VAtx
	 3ZFUcfsAvM5L5GsCNMwQQC8P6+AF7WV8dT/+13kwLT4l3Gwsmtd2IPHFwbk0EUOBUU5Ry
	 4SRVpmGRYc8B+4HYXl7efRkciLGR3Q1Pu5MHaPuHM7KjX5egpOrhwga+BLytpNx9UsPvH
	 g7grgyPtbjdrdqZJxysrLbXk1lwf0TDvwWFBU26jv41tcRw56vWpk6DqbAjXxh2+tvqNl
	 lP3D26i2NfrZu/hjUh+9/tMZ9NuINJ+/RqaatHU1CPO8beJ4PNoAZ7+sgk6Z4vFNICw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Dqu19fjgsgVmgIEnNOKPKFMh4EisKigjNx4xr0MM7K0=;
	b=n1TDk8i6k1O/0R1S9JpBDYWHLIhHBEYa/qVbzZOGu5h9Vnjawny2Wgq8CLGWqNqeSlDa
	 q/cJqxloSj+ZKpoofv3d3wFk7rwaHkVxAQwznFQCoJmhzjNq6qf6yDQ4YXpnqmJN/pwBF
	 cH8aLCHUDzJlEAxhsw5VeZXDkp9o7T+cG+kVP4xO+uTvNAIbfFu2BdYlnDWlOYXL7IUv+
	 5+lFK2dnPpnwqsSjQceHIz9SW56xi5IwqcWXweQq8nD/y/a9V1nkyDbMUo/QsncS3WMQc
	 EUebI4luwcDpGNO0NGgFe8KD1X8zRvMcZ4tZj8exybUpDnd2eRh7WPSbsfLu3R5fACw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y5Zr/7/z";
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10747606A20B
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10747606A20B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5Zr/7/z
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-99c0c1d07feso958891241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794328517; x=1794933317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dqu19fjgsgVmgIEnNOKPKFMh4EisKigjNx4xr0MM7K0=;
        b=Y5Zr/7/zB5QJJIkbcVrZBdLwykngt97ggzOwM7U93vXswvi+PesZdZ7L9CdTL7oGmF
         MdF45WYSHWvY4kVTeWP9YsQSXgEhXnFrT39H7hb5GafLSfNWIpWSun+MyWNc8x7Xlihp
         0vi3ogqYUL5sWdarSbvi1tEfb/q6Sw98WxwjQmTB4YUS3r/pp5S5+Kf9V/1kqVb8cabU
         b7l+mztXdAYWBrWqzvF4u2YVcGREEBvn34g7iaz/iGImJkjUOsTKR7YkkuT+NOAjOZKA
         GK1yY8R8qub+Mv3M1mkbv5n6jDvmi1ClVOgmpqStmmctnXfHxFDSZ/FsQqUQ10eivzzJ
         z0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794328517; x=1794933317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Dqu19fjgsgVmgIEnNOKPKFMh4EisKigjNx4xr0MM7K0=;
        b=tHXDHLRCPB+QiR+Q7wMkRUoQiHwPVrZDcZ/W2wykzQ9HOpI+C6DxBMEwqTSn7rm4Yh
         9tHCz2df5aeam05Vn0JP7AnxuH2tDgbzQCUCcKCPKX2dHokiTLNgSAXXGkz/8tCG56Sx
         20JUYrNnQeW/vrP3jMqLHrzLGxRrCzlVVQc7sNAUTW8VzmLbu/Qlq0tD1jHjoLjzLd3E
         9BrYwkMA7DBnuB8KrW0mPTOgmcRs4DfND/5wQNiNrlMd4F0ScPh78nWIAlOQLJtHLpSf
         Sm7WQ8pXXe08jCP7o8z1i239yCJkumFsrzb+lAkOSmT+7wcku3N9cP4SagdR4+odmbnY
         KRgQ==
X-Gm-Message-State: APuU4Z8b8gHWs7088Ar7T7oSlx0QqsMWu2l8yNV9ddoDyh+FJHcwY8fe
	D7nGrTdec1oWr7OqAXnWZy+SAHOxYDpOSpNtIpN3VtLtsGTe+N7BUd1OmgrHug==
X-Gm-Gg: AYBFou2CTewtm187EdPc5z9L7nFbjFErRaJmGUYaghQxDapW+IhC5/5QAiJq/J4WVw/
	CA20gOQ7fmtfrQA0X/wADdJHI7+VQ/JfC/SlvnbAogUk59QosDn3AnoYSGuPlwGVB89JPWIsxUB
	ErpsBlEtSZTDb6gvRQ1yvV+3kaMIc73Tvbx6FkZoZDrekQlmjwvDlHwA8jE47eM3du/rNjL1AQ9
	SMsGHjFRcOfjgR1F4mTlf3hUM8YVv5r7X20cV9/GG3tWHQBJQNckCThEncu8BPniI0QAxHzJxip
	Kupc6zQ1LNlCSxpC16r2sP8fmYU4xbi4nRZ1YiODaTT++gvVhyXNt884QqAaihVuOdJY9j3EWW9
	owU0nBYc4CS/rD9KKwbr3CkyCtvxCQK/3niywXpRx6ZTJ8Xz/WUseemqagHBZr0JYKDJjxZJFKJ
	0ML+ZvkqG8kpwvz73hir+G2Ic3N4CWNJGIjHrJvTaN6wmGAIh33SKlFRUFdp8iL+vq9WpAa/kBn
	iOoCKodWBuIXen8ZMWfCbUoq9ZBpY+SIGqhHf2L6LMBgaXEsIGqmXOajLSm5c/Gp4mdRjsGXv3F
	OC2k7dHSJaMyJoJsOMv5Z+8gjz5glXK7Fsai9WvSlPwowc7/EB9JI6mJqI6a2Eg5Ji/qgdmEMln
	pNaPHNibUXtn1i5vRt17nWAPRYWLX/RsBBBkKlSyNF8hGeZpeXBspOVenTQkKKMxRuL2UfvbnT5
	NjSbN5
X-Received: by 2002:a05:6102:3255:10b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7d301ad48a0mr1049310137.4.1794328516026;
        Tue, 10 Nov 2026 08:35:16 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d3023543casm1989315137.5.2026.11.10.08.35.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:35:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v8 10/11] l2cap-tester, iso-tester, mgmt-tester: Add HDT tests
Date: Tue, 10 Nov 2026 11:34:50 -0500
Message-ID: <20261110163452.2649366-11-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110163452.2649366-1-luiz.dentz@gmail.com>
References: <20261110163452.2649366-1-luiz.dentz@gmail.com>
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

Add tests for HDT on a 7.0 controller: L2CAP connections on each HDT
rate, MIC Length Too Short and MIC length downgrade on L2CAP, CIS with
HDT rates and default MIC length on ISO, and the HDT and EKS settings
and system configuration on MGMT.

Assisted-by: OpenCode:claude-opus-5
---
 tools/iso-tester.c   | 1418 +++++++++++++++++++++++++++++++++++++++++-
 tools/l2cap-tester.c | 1006 ++++++++++++++++++++++++++++++
 tools/mgmt-tester.c  |  218 +++++++
 3 files changed, 2618 insertions(+), 24 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 333c894ea06e..bfc905643117 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -128,11 +128,57 @@
 	QOS_FULL(0x01, 0x02, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 
+#define QOS_IO_EXT(_interval, _latency, _sdu, _phys, _rtn, _rates) \
+{ \
+	.interval = _interval, \
+	.latency = _latency, \
+	.sdu = _sdu, \
+	.phys = _phys, \
+	.rtn = _rtn, \
+	.rates = _rates, \
+}
+
+#define QOS_FULL_EXT_TYPE(_type, _cig, _cis, _in, _out) \
+{ \
+	.version = BT_ISO_QOS_VERSION_1, \
+	.type = _type, \
+	.ucast = { \
+		.cig = _cig, \
+		.cis = _cis, \
+		.sca = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.in = _in, \
+		.out = _out, \
+	},\
+}
+
+#define QOS_FULL_EXT(_cig, _cis, _in, _out) \
+{ \
+	.version = BT_ISO_QOS_VERSION_1, \
+	.type = BT_ISO_QOS_UCAST, \
+	.ucast = { \
+		.cig = _cig, \
+		.cis = _cis, \
+		.sca = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.in = _in, \
+		.out = _out, \
+	},\
+}
+
+#define QOS_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates) \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates), \
+		QOS_IO_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates))
+
 /* QoS Configuration settings for low latency audio data */
 #define QOS_8_1_1 QOS(7500, 8, 26, 0x02, 2)
 #define QOS_8_2_1 QOS(10000, 10, 30, 0x02, 2)
 #define QOS_16_1_1 QOS(7500, 8, 30, 0x02, 2)
 #define QOS_16_2_1 QOS(10000, 10, 40, 0x02, 2)
+#define HDT_16_2_1 QOS(10000, 10, 40, BIT(4), 2)
 #define QOS_1_16_2_1 QOS_1(10000, 10, 40, 0x02, 2)
 #define QOS_2_16_2_1 QOS_2(10000, 10, 40, 0x02, 2)
 #define QOS_1_1_16_2_1 QOS_1_1(10000, 10, 40, 0x02, 2)
@@ -179,6 +225,97 @@
 #define QOS_48_3_gr QOS(7500, 15, 90, 0x02, 1)
 #define QOS_48_4_gr QOS(10000, 20, 120, 0x02, 1)
 
+#define HDT_2M QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(0))
+#define HDT_3M QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(1))
+/* The type left to connect() and the type of the other member */
+#define HDT_2M_TYPE(_type) \
+	QOS_FULL_EXT_TYPE(_type, BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)))
+#define HDT_4M QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(2))
+#define HDT_6M QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(3))
+#define HDT_7_5M QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(4))
+#define HDT_IN_2M_OUT_3M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)))
+#define HDT_IN_2M_OUT_4M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)))
+#define HDT_IN_2M_OUT_6M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)))
+#define HDT_IN_2M_OUT_7_5M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)))
+#define HDT_IN_3M_OUT_2M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)))
+#define HDT_IN_3M_OUT_4M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)))
+#define HDT_IN_3M_OUT_6M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)))
+#define HDT_IN_3M_OUT_7_5M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)))
+#define HDT_IN_4M_OUT_2M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)))
+#define HDT_IN_4M_OUT_3M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)))
+#define HDT_IN_4M_OUT_6M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)))
+#define HDT_IN_4M_OUT_7_5M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)))
+#define HDT_IN_6M_OUT_2M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)))
+#define HDT_IN_6M_OUT_3M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)))
+#define HDT_IN_6M_OUT_4M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)))
+#define HDT_IN_6M_OUT_7_5M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)))
+#define HDT_IN_7_5M_OUT_2M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(0)))
+#define HDT_IN_7_5M_OUT_3M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(1)))
+#define HDT_IN_7_5M_OUT_4M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(2)))
+#define HDT_IN_7_5M_OUT_6M \
+	QOS_FULL_EXT(BT_ISO_QOS_CIG_UNSET, BT_ISO_QOS_CIS_UNSET, \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(4)), \
+		QOS_IO_EXT(10000, 10, 40, BIT(4), 2, BIT(3)))
+
 /* One unidirectional CIS. Unicast Server is Audio Sink */
 #define AC_1_4 QOS_OUT(10000, 10, 40, 0x02, 2)
 /* One unidirectional CIS. Unicast Server is Audio Sink CIG 0x01 */
@@ -282,6 +419,29 @@
 	}, \
 }
 
+#define QOS_BCAST_FULL_EXT(_big, _bis, _encryption, _bcode, _in, _out) \
+{ \
+	.version = BT_ISO_QOS_VERSION_1, \
+	.type = BT_ISO_QOS_BCAST, \
+	.bcast = { \
+		.big = _big, \
+		.bis = _bis, \
+		.sync_factor = 0x07, \
+		.packing = 0x00, \
+		.framing = 0x00, \
+		.in = _in, \
+		.out = _out, \
+		.encryption = _encryption, \
+		.bcode = _bcode, \
+		.options = 0x00, \
+		.skip = 0x0000, \
+		.sync_timeout = BT_ISO_SYNC_TIMEOUT, \
+		.sync_cte_type = 0x00, \
+		.mse = 0x00, \
+		.timeout = BT_ISO_SYNC_TIMEOUT, \
+	}, \
+}
+
 #define BCAST_QOS_OUT(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
 		0x00, {0x00}, {}, \
@@ -307,16 +467,38 @@
 		0x00, {0x00}, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 
+#define BCAST_QOS_IN_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates) \
+	QOS_BCAST_FULL_EXT(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		0x00, {0x00}, \
+		QOS_IO_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates), {})
+
 #define BCAST_QOS_IN_ENC(_interval, _latency, _sdu, _phy, _rtn) \
 	QOS_BCAST_FULL(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
 		0x01, BCODE, \
 		QOS_IO(_interval, _latency, _sdu, _phy, _rtn), {})
 
+#define BCAST_QOS_OUT_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates) \
+	QOS_BCAST_FULL_EXT(BT_ISO_QOS_BIG_UNSET, BT_ISO_QOS_BIS_UNSET, \
+		0x00, {0x00}, {}, \
+		QOS_IO_EXT(_interval, _latency, _sdu, _phy, _rtn, _rates))
+
 #define QOS_OUT_16_2_1 BCAST_QOS_OUT(10000, 10, 40, 0x02, 2)
+#define HDT_OUT_16_2_1 BCAST_QOS_OUT(10000, 10, 40, BIT(4), 2)
+#define HDT_OUT_2M BCAST_QOS_OUT_EXT(10000, 10, 40, BIT(4), 2, BIT(0))
+#define HDT_OUT_3M BCAST_QOS_OUT_EXT(10000, 10, 40, BIT(4), 2, BIT(1))
+#define HDT_OUT_4M BCAST_QOS_OUT_EXT(10000, 10, 40, BIT(4), 2, BIT(2))
+#define HDT_OUT_6M BCAST_QOS_OUT_EXT(10000, 10, 40, BIT(4), 2, BIT(3))
+#define HDT_OUT_7_5M BCAST_QOS_OUT_EXT(10000, 10, 40, BIT(4), 2, BIT(4))
 #define QOS_OUT_ENC_16_2_1 BCAST_QOS_OUT_ENC(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_1_16_2_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_1_1_16_2_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
 #define QOS_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, 0x02, 2)
+#define HDT_IN_16_2_1 BCAST_QOS_IN(10000, 10, 40, BIT(4), 2)
+#define HDT_IN_2M BCAST_QOS_IN_EXT(10000, 10, 40, BIT(4), 2, BIT(0))
+#define HDT_IN_3M BCAST_QOS_IN_EXT(10000, 10, 40, BIT(4), 2, BIT(1))
+#define HDT_IN_4M BCAST_QOS_IN_EXT(10000, 10, 40, BIT(4), 2, BIT(2))
+#define HDT_IN_6M BCAST_QOS_IN_EXT(10000, 10, 40, BIT(4), 2, BIT(3))
+#define HDT_IN_7_5M BCAST_QOS_IN_EXT(10000, 10, 40, BIT(4), 2, BIT(4))
 #define QOS_IN_ENC_16_2_1 BCAST_QOS_IN_ENC(10000, 10, 40, 0x02, 2)
 #define QOS_OUT_48_1_g BCAST_QOS_OUT(7500, 8, 75, 0x02, 1)
 #define QOS_OUT_48_2_g BCAST_QOS_OUT(10000, 10, 100, 0x02, 1)
@@ -483,8 +665,17 @@ struct test_data {
 	int seqnum;
 };
 
+enum {
+	BT_ISO_QOS_V1 = 0,
+	BT_ISO_QOS_EXT,
+};
+
 struct iso_client_data {
-	struct bt_iso_qos qos;
+	uint8_t qos_ver;
+	union {
+		struct bt_iso_qos qos;
+		struct bt_iso_qos_ext qos_ext;
+	};
 	struct bt_iso_qos qos_2;
 	int expect_err;
 	const struct iovec *send;
@@ -525,6 +716,17 @@ struct iso_client_data {
 	 * Used for testing TX timestamping OPT_ID.
 	 */
 	unsigned int repeat_send;
+
+	/* Configure def_mic_len as the default MIC length and check that
+	 * the resulting LE Set CIG Parameters or LE Create BIG carries it.
+	 * BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.159, Preferred_MIC_Length: 0x01 Preferred MIC length is
+	 * 64 bits. 0x02 MIC length is 128 bits (default). All other values
+	 * Reserved for future use.
+	 *
+	 * So 0x00 is not a value to test for and doubles as unset.
+	 */
+	uint8_t def_mic_len;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, struct tester_io *io,
@@ -637,9 +839,9 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
 					index_removed_callback, NULL, NULL);
 
-	data->hciemu = hciemu_new_num(HCIEMU_TYPE_BREDRLE52, data->client_num);
+	data->hciemu = hciemu_new_num(data->hciemu_type, data->client_num);
 	if (!data->hciemu)
-		data->hciemu = hciemu_new_num_debug(HCIEMU_TYPE_BREDRLE52,
+		data->hciemu = hciemu_new_num_debug(data->hciemu_type,
 						data->client_num, hciemu_debug,
 						"hciemu: ", NULL);
 	if (!data->hciemu) {
@@ -753,13 +955,13 @@ static void test_data_free(void *test_data)
 	free(data);
 }
 
-#define test_iso_full(name, data, setup, func, num, reason) \
+#define test_iso_full(name, type, data, setup, func, num, reason) \
 	do { \
 		struct test_data *user; \
 		user = new0(struct test_data, 1); \
 		if (!user) \
 			break; \
-		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->hciemu_type = type; \
 		user->test_data = data; \
 		user->client_num = num; \
 		user->accept_reason = reason; \
@@ -768,14 +970,21 @@ static void test_data_free(void *test_data)
 				test_post_teardown, 2, user, test_data_free); \
 	} while (0)
 
+#define test_le52(name, data, setup, func, num, reason) \
+	test_iso_full(name, HCIEMU_TYPE_BREDRLE52, data, setup, func, num, \
+			reason)
+
 #define test_iso(name, data, setup, func) \
-	test_iso_full(name, data, setup, func, 1, 0x00)
+	test_le52(name, data, setup, func, 1, 0x00)
 
 #define test_iso2(name, data, setup, func) \
-	test_iso_full(name, data, setup, func, 2, 0x00)
+	test_le52(name, data, setup, func, 2, 0x00)
 
 #define test_iso_rej(name, data, setup, func, reason) \
-	test_iso_full(name, data, setup, func, 1, reason)
+	test_le52(name, data, setup, func, 1, reason)
+
+#define test_bredrle70(name, data, setup, func) \
+	test_iso_full(name, HCIEMU_TYPE_BREDRLE70, data, setup, func, 1, 0x00)
 
 static const struct iso_client_data connect_8_1_1 = {
 	.qos = QOS_8_1_1,
@@ -797,6 +1006,200 @@ static const struct iso_client_data connect_16_2_1 = {
 	.expect_err = 0
 };
 
+static const struct iso_client_data connect_hdt_16_2_1 = {
+	.qos = HDT_16_2_1,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_2m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_2M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_type_any = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_2M_TYPE(BT_ISO_QOS_ANY),
+	.expect_err = 0
+};
+
+/* A reserved rate, and a rate without the LE HDT PHY */
+static const struct iso_client_data connect_hdt_rates_reserved = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = QOS_EXT(10000, 10, 40, BIT(4), 2, BIT(5)),
+	.expect_err = -EINVAL
+};
+
+static const struct iso_client_data connect_hdt_rates_no_hdt = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = QOS_EXT(10000, 10, 40, BIT(1), 2, BIT(0)),
+	.expect_err = -EINVAL
+};
+
+static const struct iso_client_data connect_hdt_type_mismatch = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_2M_TYPE(BT_ISO_QOS_BCAST),
+	.expect_err = -EINVAL
+};
+
+static const struct iso_client_data connect_hdt_3m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_3M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_4m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_4M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_6m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_6M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_7_5m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_7_5M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_mic_len_64 = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_7_5M,
+	.expect_err = 0,
+	.def_mic_len = 0x01,
+};
+
+static const struct iso_client_data connect_hdt_mic_len_128 = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_7_5M,
+	.expect_err = 0,
+	.def_mic_len = 0x02,
+};
+
+static const struct iso_client_data connect_hdt_2m_3m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_3M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_2m_4m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_4M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_2m_6m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_6M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_2m_7_5m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_7_5M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_3m_2m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_2M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_3m_4m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_4M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_3m_6m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_6M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_3m_7_5m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_7_5M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_4m_2m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_2M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_4m_3m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_3M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_4m_6m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_6M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_4m_7_5m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_7_5M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_6m_2m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_2M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_6m_3m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_3M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_6m_4m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_4M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_6m_7_5m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_7_5M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_7_5m_2m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_2M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_7_5m_3m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_3M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_7_5m_4m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_4M,
+	.expect_err = 0
+};
+
+static const struct iso_client_data connect_hdt_7_5m_6m = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_6M,
+	.expect_err = 0
+};
+
 static const struct iso_client_data connect_1_16_2_1 = {
 	.qos = QOS_1_16_2_1,
 	.expect_err = 0
@@ -1086,6 +1489,213 @@ static const struct iso_client_data listen_16_2_1_recv = {
 	.server = true,
 };
 
+static const struct iso_client_data listen_hdt_16_2_1_recv = {
+	.qos = HDT_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_2m_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_2m_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_2m_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_2m_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M_OUT_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_3m_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_3m_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_3m_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_3m_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M_OUT_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_4m_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_4m_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_4m_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_4m_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M_OUT_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_6m_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_6m_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_6m_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_6m_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M_OUT_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_7_5m_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_7_5m_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_7_5m_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
+static const struct iso_client_data listen_hdt_7_5m_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M_OUT_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.server = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv_frag = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1412,6 +2022,76 @@ static const struct iso_client_data bcast_16_2_1_send = {
 	.base_len = sizeof(base_lc3_16_2_1),
 };
 
+static const struct iso_client_data bcast_hdt_16_2_1_send = {
+	.qos = HDT_OUT_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data bcast_hdt_2m_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_2M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data bcast_hdt_3m_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_3M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data bcast_hdt_4m_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_4M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data bcast_hdt_6m_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_6M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
+static const struct iso_client_data bcast_hdt_mic_len_64_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_7_5M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+	.def_mic_len = 0x01,
+};
+
+static const struct iso_client_data bcast_hdt_7_5m_send = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_OUT_7_5M,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.bcast = true,
+	.base = base_lc3_16_2_1,
+	.base_len = sizeof(base_lc3_16_2_1),
+};
+
 static const struct iso_client_data past_16_2_1_send = {
 	.qos = QOS_OUT_16_2_1,
 	.expect_err = 0,
@@ -1499,6 +2179,65 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_hdt_16_2_1_recv = {
+	.qos = HDT_IN_16_2_1,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_hdt_2m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_2M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_hdt_3m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_3M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_hdt_4m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_4M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_hdt_6m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_6M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_hdt_7_5m_recv = {
+	.qos_ver = BT_ISO_QOS_EXT,
+	.qos_ext = HDT_IN_7_5M,
+	.expect_err = 0,
+	.recv = &send_16_2_1,
+	.bcast = true,
+	.server = true,
+	.big = true,
+};
+
 static const struct iso_client_data past_16_2_1_recv = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -1787,6 +2526,48 @@ static void acl_new_conn(uint16_t handle, void *user_data)
 	}
 }
 
+/* The QoS of the test as struct bt_iso_qos, converting struct bt_iso_qos_ext
+ * when the test uses it, for the emulated remote which takes the former. The
+ * unicast QoS is a prefix of the broadcast one, so converting the broadcast
+ * view converts either.
+ */
+static void iso_client_qos(const struct iso_client_data *isodata,
+						struct bt_iso_qos *qos)
+{
+	const struct bt_iso_bcast_qos_ext *ext = &isodata->qos_ext.bcast;
+	struct bt_iso_bcast_qos *b = &qos->bcast;
+
+	if (isodata->qos_ver != BT_ISO_QOS_EXT) {
+		*qos = isodata->qos;
+		return;
+	}
+
+	memset(qos, 0, sizeof(*qos));
+	b->big = ext->big;
+	b->bis = ext->bis;
+	b->sync_factor = ext->sync_factor;
+	b->packing = ext->packing;
+	b->framing = ext->framing;
+	b->in.interval = ext->in.interval;
+	b->in.latency = ext->in.latency;
+	b->in.sdu = ext->in.sdu;
+	b->in.phys = ext->in.phys;
+	b->in.rtn = ext->in.rtn;
+	b->out.interval = ext->out.interval;
+	b->out.latency = ext->out.latency;
+	b->out.sdu = ext->out.sdu;
+	b->out.phys = ext->out.phys;
+	b->out.rtn = ext->out.rtn;
+	b->encryption = ext->encryption;
+	memcpy(b->bcode, ext->bcode, sizeof(b->bcode));
+	b->options = ext->options;
+	b->skip = ext->skip;
+	b->sync_timeout = ext->sync_timeout;
+	b->sync_cte_type = ext->sync_cte_type;
+	b->mse = ext->mse;
+	b->timeout = ext->timeout;
+}
+
 static void setup_connect_recv(struct test_data *data, struct bthost *host)
 {
 	const uint8_t *bdaddr;
@@ -1884,10 +2665,13 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 							isodata->base_len);
 
 			if (isodata->big && (!isodata->past ||
-						i + 1 == data->client_num))
-				bthost_create_big(host, 1,
-						isodata->qos.bcast.encryption,
-						isodata->qos.bcast.bcode);
+						i + 1 == data->client_num)) {
+				struct bt_iso_qos qos;
+
+				iso_client_qos(isodata, &qos);
+				bthost_create_big(host, 1, qos.bcast.encryption,
+							qos.bcast.bcode);
+			}
 
 			if (isodata->past)
 				setup_past_recv(data, host);
@@ -1897,6 +2681,66 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 	}
 }
 
+static void check_mic_len(struct test_data *data, uint8_t mic_len)
+{
+	const struct iso_client_data *isodata = data->test_data;
+
+	tester_print("MIC length: 0x%02x", mic_len);
+
+	if (mic_len != isodata->def_mic_len) {
+		tester_warn("Expected MIC length 0x%02x, got 0x%02x",
+				isodata->def_mic_len, mic_len);
+		tester_test_failed();
+	}
+}
+
+static bool hook_cig_mic_len(const void *msg, uint16_t len, void *user_data)
+{
+	const struct bt_hci_cmd_le_set_cig_params_v2 *cmd = msg;
+
+	if (len < sizeof(*cmd) + sizeof(*cmd->cis))
+		return true;
+
+	check_mic_len(user_data, cmd->cis[0].mic_len);
+
+	return true;
+}
+
+static bool hook_big_mic_len(const void *msg, uint16_t len, void *user_data)
+{
+	const struct bt_hci_cmd_le_create_big_v2 *cmd = msg;
+
+	if (len < sizeof(*cmd))
+		return true;
+
+	check_mic_len(user_data, cmd->bis.mic_len);
+
+	return true;
+}
+
+static void setup_mic_len(struct test_data *data, uint8_t mic_len)
+{
+	uint8_t param[] = {
+		0x21, 0x00,	/* Type: LE HDT Default MIC Length */
+		0x01,		/* Length */
+		0x00,		/* Value */
+	};
+
+	param[3] = mic_len;
+
+	tester_print("Setting default MIC length to 0x%02x", mic_len);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+				BT_HCI_CMD_LE_SET_CIG_PARAMS_V2,
+				hook_cig_mic_len, data);
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_CMD,
+				BT_HCI_CMD_LE_CREATE_BIG_V2,
+				hook_big_mic_len, data);
+}
+
 static void setup_powered(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1905,6 +2749,9 @@ static void setup_powered(const void *test_data)
 
 	tester_print("Powering on controller");
 
+	if (isodata && isodata->def_mic_len)
+		setup_mic_len(data, isodata->def_mic_len);
+
 	if (!isodata || !isodata->bcast || isodata->past)
 		mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 					sizeof(param), param,
@@ -2108,6 +2955,7 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 	struct hciemu_client *client;
 	const uint8_t *client_bdaddr = NULL;
 	const struct bt_iso_qos *qos = &isodata->qos;
+	const struct bt_iso_qos_ext *qos_ext = &isodata->qos_ext;
 	struct sockaddr_iso addr;
 	char str[18];
 	int err;
@@ -2146,7 +2994,21 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 		}
 	}
 
-	err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, qos, sizeof(*qos));
+	switch (isodata->qos_ver) {
+	case BT_ISO_QOS_V1:
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, qos,
+						sizeof(*qos));
+		break;
+	case BT_ISO_QOS_EXT:
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, qos_ext,
+						sizeof(*qos_ext));
+		break;
+	default:
+		tester_warn("Undefined qos_ver %u", isodata->qos_ver);
+		tester_test_failed();
+		return -EINVAL;
+	}
+
 	if (err < 0) {
 		tester_warn("Can't set socket BT_ISO_QOS option : %s (%d)",
 							strerror(errno), errno);
@@ -2187,6 +3049,28 @@ static int connect_iso_sock(struct test_data *data, uint8_t num, int sk)
 	return 0;
 }
 
+static uint8_t bit_phy(uint8_t bits)
+{
+	uint8_t phy = 0x00;
+
+	/* Convert PHY bits to PHY values on a ascending order so if HDT bit is
+	 * set it takes precedence over LE 2M and LE 1M.
+	 */
+	if (bits & BIT(0))
+		phy = 0x01; /* LE 1M */
+
+	if (bits & BIT(1))
+		phy = 0x02; /* LE 2M */
+
+	if (bits & BIT(2))
+		phy = 0x03; /* LE Coded */
+
+	if (bits & BIT(4))
+		phy = 0x05; /* HDT */
+
+	return phy;
+}
+
 static bool check_io_qos(const struct bt_iso_io_qos *io1,
 				const struct bt_iso_io_qos *io2)
 {
@@ -2207,7 +3091,9 @@ static bool check_io_qos(const struct bt_iso_io_qos *io1,
 		return false;
 	}
 
-	if (io1->phys && io2->phys && io1->phys != io2->phys) {
+	if (io1->phys && io2->phys && io1->phys != io2->phys &&
+			io1->phys != bit_phy(io2->phys) &&
+			bit_phy(io1->phys) != io2->phys) {
 		tester_warn("Unexpected IO PHY: 0x%02x != 0x%02x",
 				io1->phys, io2->phys);
 		return false;
@@ -2382,6 +3268,190 @@ static bool check_bcast_qos(const struct bt_iso_qos *qos1,
 	return true;
 }
 
+static bool check_io_qos_ext(const struct bt_iso_io_qos_ext *io1,
+				const struct bt_iso_io_qos_ext *io2)
+{
+	if (io1->interval && io2->interval && io1->interval > io2->interval) {
+		tester_warn("Unexpected IO interval: %u > %u",
+				io1->interval, io2->interval);
+		return false;
+	}
+
+	if (io1->latency && io2->latency && io1->latency > io2->latency) {
+		tester_warn("Unexpected IO latency: %u > %u",
+				io1->latency, io2->latency);
+		return false;
+	}
+
+	if (io1->sdu && io2->sdu && io1->sdu != io2->sdu) {
+		tester_warn("Unexpected IO SDU: %u != %u", io1->sdu, io2->sdu);
+		return false;
+	}
+
+	if (io1->phys && io2->phys && io1->phys != io2->phys &&
+			io1->phys != bit_phy(io2->phys) &&
+			bit_phy(io1->phys) != io2->phys) {
+		tester_warn("Unexpected IO PHYs: 0x%02x != 0x%02x",
+				io1->phys, io2->phys);
+		return false;
+	}
+
+	if (io1->rtn && io2->rtn && io1->rtn != io2->rtn) {
+		tester_warn("Unexpected IO RTN: %u != %u", io1->rtn, io2->rtn);
+		return false;
+	}
+
+	if (io1->rates && io2->rates && io1->rates != io2->rates) {
+		tester_warn("Unexpected IO rates: 0x%04x != 0x%04x",
+				io1->rates, io2->rates);
+		return false;
+	}
+
+	return true;
+}
+
+static bool check_ucast_qos_ext(const struct bt_iso_qos_ext *qos1,
+				const struct bt_iso_qos_ext *qos2)
+{
+	if (qos1->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
+			qos2->ucast.cig != BT_ISO_QOS_CIG_UNSET &&
+			qos1->ucast.cig != qos2->ucast.cig) {
+		tester_warn("Unexpected CIG ID: 0x%02x != 0x%02x",
+				qos1->ucast.cig, qos2->ucast.cig);
+		return false;
+	}
+
+	if (qos1->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
+			qos2->ucast.cis != BT_ISO_QOS_CIS_UNSET &&
+			qos1->ucast.cis != qos2->ucast.cis) {
+		tester_warn("Unexpected CIS ID: 0x%02x != 0x%02x",
+				qos1->ucast.cis, qos2->ucast.cis);
+		return false;
+	}
+
+	if (qos1->ucast.packing != qos2->ucast.packing) {
+		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
+				qos1->ucast.packing, qos2->ucast.packing);
+		return false;
+	}
+
+	if (qos1->ucast.framing != qos2->ucast.framing) {
+		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
+				qos1->ucast.framing, qos2->ucast.framing);
+		return false;
+	}
+
+	if (!check_io_qos_ext(&qos1->ucast.in, &qos2->ucast.in)) {
+		tester_warn("Unexpected Input QoS");
+		return false;
+	}
+
+	if (!check_io_qos_ext(&qos1->ucast.out, &qos2->ucast.out)) {
+		tester_warn("Unexpected Output QoS");
+		return false;
+	}
+
+	return true;
+}
+
+static bool check_bcast_qos_ext(const struct bt_iso_qos_ext *qos1,
+				const struct bt_iso_qos_ext *qos2)
+{
+	if (qos1->bcast.big != BT_ISO_QOS_BIG_UNSET &&
+			qos2->bcast.big != BT_ISO_QOS_BIG_UNSET &&
+			qos1->bcast.big != qos2->bcast.big) {
+		tester_warn("Unexpected BIG ID: 0x%02x != 0x%02x",
+				qos1->bcast.big, qos2->bcast.big);
+		return false;
+	}
+
+	if (qos1->bcast.bis != BT_ISO_QOS_BIS_UNSET &&
+			qos2->bcast.bis != BT_ISO_QOS_BIS_UNSET &&
+			qos1->bcast.bis != qos2->bcast.bis) {
+		tester_warn("Unexpected BIS ID: 0x%02x != 0x%02x",
+				qos1->bcast.bis, qos2->bcast.bis);
+		return false;
+	}
+
+	if (qos1->bcast.sync_factor != qos2->bcast.sync_factor) {
+		tester_warn("Unexpected QoS sync interval: 0x%02x != 0x%02x",
+			qos1->bcast.sync_factor, qos2->bcast.sync_factor);
+		return false;
+	}
+
+	if (qos1->bcast.packing != qos2->bcast.packing) {
+		tester_warn("Unexpected QoS packing: 0x%02x != 0x%02x",
+				qos1->bcast.packing, qos2->bcast.packing);
+		return false;
+	}
+
+	if (qos1->bcast.framing != qos2->bcast.framing) {
+		tester_warn("Unexpected QoS framing: 0x%02x != 0x%02x",
+				qos1->bcast.framing, qos2->bcast.framing);
+		return false;
+	}
+
+	if (!check_io_qos_ext(&qos1->ucast.in, &qos2->ucast.in)) {
+		tester_warn("Unexpected Input QoS");
+		return false;
+	}
+
+	if (!check_io_qos_ext(&qos1->ucast.out, &qos2->ucast.out)) {
+		tester_warn("Unexpected Output QoS");
+		return false;
+	}
+
+	if (qos1->bcast.encryption != qos2->bcast.encryption) {
+		tester_warn("Unexpected QoS encryption: 0x%02x != 0x%02x",
+				qos1->bcast.encryption, qos2->bcast.encryption);
+		return false;
+	}
+
+	if (memcmp(qos1->bcast.bcode, qos2->bcast.bcode,
+				sizeof(qos1->bcast.bcode))) {
+		tester_warn("Unexpected QoS Broadcast Code");
+		return false;
+	}
+
+	if (qos1->bcast.options != qos2->bcast.options) {
+		tester_warn("Unexpected QoS options: 0x%02x != 0x%02x",
+				qos1->bcast.options, qos2->bcast.options);
+		return false;
+	}
+
+	if (qos1->bcast.skip != qos2->bcast.skip) {
+		tester_warn("Unexpected QoS skip: 0x%04x != 0x%04x",
+				qos1->bcast.skip, qos2->bcast.skip);
+		return false;
+	}
+
+	if (qos1->bcast.sync_timeout != qos2->bcast.sync_timeout) {
+		tester_warn("Unexpected QoS sync timeout: 0x%04x != 0x%04x",
+			qos1->bcast.sync_timeout, qos2->bcast.sync_timeout);
+		return false;
+	}
+
+	if (qos1->bcast.sync_cte_type != qos2->bcast.sync_cte_type) {
+		tester_warn("Unexpected QoS sync cte type: 0x%02x != 0x%02x",
+			qos1->bcast.sync_cte_type, qos2->bcast.sync_cte_type);
+		return false;
+	}
+
+	if (qos1->bcast.mse != qos2->bcast.mse) {
+		tester_warn("Unexpected QoS MSE: 0x%02x != 0x%02x",
+				qos1->bcast.mse, qos2->bcast.mse);
+		return false;
+	}
+
+	if (qos1->bcast.timeout != qos2->bcast.timeout) {
+		tester_warn("Unexpected QoS MSE: 0x%04x != 0x%04x",
+				qos1->bcast.timeout, qos2->bcast.timeout);
+		return false;
+	}
+
+	return true;
+}
+
 static void test_connect(const void *test_data);
 static bool iso_connect_cb(struct tester_io *io, uint32_t cond,
 							void *user_data);
@@ -2888,15 +3958,30 @@ static bool iso_connect(struct tester_io *io, uint32_t cond,
 	int err, sk_err, sk;
 	socklen_t len;
 	struct bt_iso_qos qos;
+	struct bt_iso_qos_ext qos_ext;
 	bool ret = true;
 	uint8_t base[BASE_MAX_LENGTH] = {0};
 
 	sk = tester_io_get_fd(io);
 
-	len = sizeof(qos);
-	memset(&qos, 0, len);
+	switch (isodata->qos_ver) {
+	case BT_ISO_QOS_V1:
+		len = sizeof(qos);
+		memset(&qos, 0, len);
+		err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
+		break;
+	case BT_ISO_QOS_EXT:
+		len = sizeof(qos_ext);
+		memset(&qos_ext, 0, len);
+		err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos_ext, &len);
+		break;
+	default:
+		tester_warn("Invalid BT_ISO_QOS version");
+		data->step = 0;
+		tester_test_failed();
+		return false;
+	}
 
-	err = getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len);
 	if (err < 0) {
 		tester_warn("Can't get socket option : %s (%d)",
 							strerror(errno), errno);
@@ -2906,12 +3991,26 @@ static bool iso_connect(struct tester_io *io, uint32_t cond,
 	}
 
 	if (!isodata->bcast) {
-		ret = check_ucast_qos(&qos, &isodata->qos,
+		switch (isodata->qos_ver) {
+		case BT_ISO_QOS_V1:
+			ret = check_ucast_qos(&qos, &isodata->qos,
 				      isodata->mconn ? &isodata->qos_2 : NULL);
+			break;
+		case BT_ISO_QOS_EXT:
+			ret = check_ucast_qos_ext(&qos_ext, &isodata->qos_ext);
+			break;
+		}
 	} else if (!isodata->server) {
-		ret = check_bcast_qos(&qos, &isodata->qos);
-		if (ret && isodata->past)
-			ret = iso_rebind_bcast_dst(data, sk) == 0;
+		switch (isodata->qos_ver) {
+		case BT_ISO_QOS_V1:
+			ret = check_bcast_qos(&qos, &isodata->qos);
+			if (ret && isodata->past)
+				ret = iso_rebind_bcast_dst(data, sk) == 0;
+			break;
+		case BT_ISO_QOS_EXT:
+			ret = check_bcast_qos_ext(&qos_ext, &isodata->qos_ext);
+			break;
+		}
 	}
 
 	if (!ret) {
@@ -3305,8 +4404,22 @@ static int listen_iso_sock(struct test_data *data, uint8_t num)
 		}
 	}
 
-	if (setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &isodata->qos,
-						sizeof(isodata->qos)) < 0) {
+	switch (isodata->qos_ver) {
+	case BT_ISO_QOS_V1:
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &isodata->qos,
+				sizeof(isodata->qos));
+		break;
+	case BT_ISO_QOS_EXT:
+		err = setsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS,
+				&isodata->qos_ext, sizeof(isodata->qos_ext));
+		break;
+	default:
+		tester_warn("Unexpected BT_ISO_QOS version");
+		err = -EINVAL;
+		goto fail;
+	}
+
+	if (err < 0) {
 		tester_print("Can't set socket BT_ISO_QOS option: %s (%d)",
 					strerror(errno), errno);
 		goto fail;
@@ -3378,6 +4491,7 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 	if (!isodata->bcast) {
 		struct hciemu_client *client;
 		struct bthost *host;
+		struct bt_iso_qos qos;
 
 		if (!data->acl_handle) {
 			tester_print("ACL handle not set");
@@ -3388,7 +4502,8 @@ static void setup_listen_many(struct test_data *data, uint8_t n, uint8_t *num,
 		client = hciemu_get_client(data->hciemu, 0);
 		host = hciemu_client_host(client);
 
-		bthost_set_cig_params(host, 0x01, 0x01, &isodata->qos);
+		iso_client_qos(isodata, &qos);
+		bthost_set_cig_params(host, 0x01, 0x01, &qos);
 		bthost_create_cis(host, 256, data->acl_handle);
 	} else if (isodata->past) {
 		if (!data->acl_handle) {
@@ -3973,6 +5088,9 @@ int main(int argc, char *argv[])
 	test_iso("Basic Framework - Success", NULL, setup_powered,
 							test_framework);
 
+	test_bredrle70("HDT Framework - Success", NULL, setup_powered,
+							test_framework);
+
 	test_iso("Basic ISO Socket - Success", NULL, setup_powered,
 							test_socket);
 
@@ -4003,6 +5121,107 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect);
 
+	test_bredrle70("ISO QoS 16_2_1 HDT - Success", &connect_hdt_16_2_1,
+							setup_powered,
+							test_connect);
+
+	test_bredrle70("ISO QoS HDT 2M - Success", &connect_hdt_2m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT Type Any - Success",
+							&connect_hdt_type_any,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT Rates Reserved - Invalid",
+					&connect_hdt_rates_reserved,
+					setup_powered, test_connect);
+	test_bredrle70("ISO QoS HDT Rates Without HDT - Invalid",
+					&connect_hdt_rates_no_hdt,
+					setup_powered, test_connect);
+	test_bredrle70("ISO QoS HDT Type Mismatch - Invalid",
+					&connect_hdt_type_mismatch,
+					setup_powered, test_connect);
+	test_bredrle70("ISO QoS HDT 3M - Success", &connect_hdt_3m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 4M - Success", &connect_hdt_4m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 6M - Success", &connect_hdt_6m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 7.5M - Success", &connect_hdt_7_5m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT MIC Length 64 - Success",
+							&connect_hdt_mic_len_64,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT MIC Length 128 - Success",
+						&connect_hdt_mic_len_128,
+						setup_powered,
+						test_connect);
+	test_bredrle70("ISO QoS HDT 2M:3M - Success", &connect_hdt_2m_3m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 2M:4M - Success", &connect_hdt_2m_4m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 2M:6M - Success", &connect_hdt_2m_6m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 2M:7.5M - Success", &connect_hdt_2m_7_5m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 3M:2M - Success", &connect_hdt_3m_2m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 3M:4M - Success", &connect_hdt_3m_4m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 3M:6M - Success", &connect_hdt_3m_6m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 3M:7.5M - Success", &connect_hdt_3m_7_5m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 4M:2M - Success", &connect_hdt_4m_2m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 4M:3M - Success", &connect_hdt_4m_3m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 4M:6M - Success", &connect_hdt_4m_6m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 4M:7.5M - Success", &connect_hdt_4m_7_5m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 6M:2M - Success", &connect_hdt_6m_2m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 6M:3M - Success", &connect_hdt_6m_3m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 6M:4M - Success", &connect_hdt_6m_4m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 6M:7.5M - Success", &connect_hdt_6m_7_5m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 7.5M:2M - Success", &connect_hdt_7_5m_2m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 7.5M:3M - Success", &connect_hdt_7_5m_3m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 7.5M:4M - Success", &connect_hdt_7_5m_4m,
+							setup_powered,
+							test_connect);
+	test_bredrle70("ISO QoS HDT 7.5M:6M - Success", &connect_hdt_7_5m_6m,
+							setup_powered,
+							test_connect);
+
 	test_iso("ISO QoS 24_1_1 - Success", &connect_24_1_1, setup_powered,
 							test_connect);
 
@@ -4162,6 +5381,110 @@ int main(int argc, char *argv[])
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
+	test_iso("ISO Receive HDT - Success", &listen_hdt_16_2_1_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 2M - Success", &listen_hdt_2m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 3M - Success", &listen_hdt_3m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 4M - Success", &listen_hdt_4m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 6M - Success", &listen_hdt_6m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 7.5M - Success", &listen_hdt_7_5m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 2M:3M - Success", &listen_hdt_2m_3m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 2M:4M - Success", &listen_hdt_2m_4m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 2M:6M - Success", &listen_hdt_2m_6m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 2M:7.5M - Success", &listen_hdt_2m_7_5m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 3M:2M - Success", &listen_hdt_3m_2m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 3M:4M - Success", &listen_hdt_3m_4m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 3M:6M - Success", &listen_hdt_3m_6m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 3M:7.5M - Success", &listen_hdt_3m_7_5m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 4M:2M - Success", &listen_hdt_4m_2m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 4M:3M - Success", &listen_hdt_4m_3m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 4M:6M - Success", &listen_hdt_4m_6m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 4M:7.5M - Success", &listen_hdt_4m_7_5m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 6M:2M - Success", &listen_hdt_6m_2m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 6M:3M - Success", &listen_hdt_6m_3m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 6M:4M - Success", &listen_hdt_6m_4m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 6M:7.5M - Success", &listen_hdt_6m_7_5m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 7.5M:2M - Success", &listen_hdt_7_5m_2m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 7.5M:3M - Success", &listen_hdt_7_5m_3m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 7.5M:4M - Success", &listen_hdt_7_5m_4m_recv,
+							setup_powered,
+							test_listen);
+
+	test_iso("ISO Receive HDT 7.5M:6M - Success", &listen_hdt_7_5m_6m_recv,
+							setup_powered,
+							test_listen);
+
 	test_iso("ISO Receive Fragmented - Success", &listen_16_2_1_recv_frag,
 							setup_powered,
 							test_listen);
@@ -4340,6 +5663,29 @@ int main(int argc, char *argv[])
 
 	test_iso("ISO Broadcaster - Success", &bcast_16_2_1_send, setup_powered,
 							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT - Success", &bcast_hdt_16_2_1_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT 2M - Success", &bcast_hdt_2m_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT 3M - Success", &bcast_hdt_3m_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT 4M - Success", &bcast_hdt_4m_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT 6M - Success", &bcast_hdt_6m_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT 7.5M - Success",
+							&bcast_hdt_7_5m_send,
+							setup_powered,
+							test_bcast);
+	test_bredrle70("ISO Broadcaster HDT MIC Length 64 - Success",
+						&bcast_hdt_mic_len_64_send,
+						setup_powered,
+						test_bcast);
 	test_iso("ISO Broadcaster PAST Info - Success", &past_16_2_1_send,
 							setup_powered,
 							test_past);
@@ -4372,6 +5718,30 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster Receiver - Success", &bcast_16_2_1_recv,
 							setup_powered,
 							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT - Success",
+							&bcast_hdt_16_2_1_recv,
+							setup_powered,
+							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT 2M - Success",
+							&bcast_hdt_2m_recv,
+							setup_powered,
+							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT 3M - Success",
+							&bcast_hdt_3m_recv,
+							setup_powered,
+							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT 4M - Success",
+							&bcast_hdt_4m_recv,
+							setup_powered,
+							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT 6M - Success",
+							&bcast_hdt_6m_recv,
+							setup_powered,
+							test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver HDT 7.5M - Success",
+							&bcast_hdt_7_5m_recv,
+							setup_powered,
+							test_bcast_recv);
 	test_iso("ISO Broadcaster PAST Receiver - Success",
 							&past_16_2_1_recv,
 							setup_powered,
diff --git a/tools/l2cap-tester.c b/tools/l2cap-tester.c
index bc4495237b9c..4d2c5cd15c64 100644
--- a/tools/l2cap-tester.c
+++ b/tools/l2cap-tester.c
@@ -52,6 +52,9 @@ struct test_data {
 	uint32_t phys;
 	int sk;
 	int sk2;
+	int reencrypt_sk;
+	int opp_sk;
+	bool opp_encrypted;
 	bool host_disconnected;
 	int step;
 	struct queue *io_channels;
@@ -95,6 +98,23 @@ struct l2cap_data {
 	int sec_level;
 	bool reject_ssp;
 
+	uint8_t mic_len;
+	uint8_t client_mic_len;
+
+	/* PHYs the client requests before encrypting with client_mic_len,
+	 * HDT (0x17) in both directions if not set.
+	 */
+	uint8_t client_tx_phys;
+	uint8_t client_rx_phys;
+	bool client_encrypt;
+	uint8_t reencrypt_mic_len;
+
+	/* Expect opportunistic encryption, then raise the security level of
+	 * the connected socket to this, if set.
+	 */
+	bool opp_encrypt;
+	int opp_sec_level;
+
 	bool expect_pin;
 	uint8_t pin_len;
 	const void *pin;
@@ -331,6 +351,9 @@ static void test_data_free(void *test_data)
 #define test_l2cap_le_62(name, data, setup, func) \
 	test_l2cap(name, HCIEMU_TYPE_BREDRLE62, data, setup, func)
 
+#define test_l2cap_bredrle70(name, data, setup, func) \
+	test_l2cap(name, HCIEMU_TYPE_BREDRLE70, data, setup, func)
+
 static uint8_t pair_device_pin[] = { 0x30, 0x30, 0x30, 0x30 }; /* "0000" */
 
 static const struct l2cap_data client_connect_success_test = {
@@ -921,6 +944,32 @@ static const struct l2cap_data le_client_connect_phy_2m_coded_test_1 = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data le_client_opp_encrypt_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.opp_encrypt = true,
+};
+
+static const struct l2cap_data le_client_opp_encrypt_pair_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.opp_encrypt = true,
+	.opp_sec_level = BT_SECURITY_MEDIUM,
+};
+
+static const struct l2cap_data le_client_connect_phy_hdt_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+};
+
 static const struct l2cap_data le_client_set_phy_1m_test = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -948,6 +997,76 @@ static const struct l2cap_data le_client_set_phy_coded_test = {
 	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
 };
 
+static const struct l2cap_data le_client_set_hdt_2m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX,
+};
+
+static const struct l2cap_data le_client_set_hdt_3m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX,
+};
+
+static const struct l2cap_data le_client_set_hdt_4m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX,
+};
+
+static const struct l2cap_data le_client_set_hdt_6m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX,
+};
+
+static const struct l2cap_data le_client_set_hdt_7_5m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX,
+};
+
 static uint8_t nonexisting_bdaddr[] = {0x00, 0xAA, 0x01, 0x02, 0x03, 0x00};
 static const struct l2cap_data le_client_close_socket_test_1 = {
 	.client_psm = 0x0080,
@@ -1049,6 +1168,24 @@ static const struct l2cap_data le_server_phy_2m_coded_test = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data le_server_phy_hdt_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+};
+
 static const struct l2cap_data le_server_set_phy_1m_test = {
 	.server_psm = 0x0080,
 	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
@@ -1077,6 +1214,101 @@ static const struct l2cap_data le_server_set_phy_2m_test = {
 	.phy = BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX,
 };
 
+static const struct l2cap_data le_server_set_hdt_2m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX,
+};
+
+static const struct l2cap_data le_server_set_hdt_3m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX,
+};
+
+static const struct l2cap_data le_server_set_hdt_4m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX,
+};
+
+static const struct l2cap_data le_server_set_hdt_6m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX,
+};
+
+static const struct l2cap_data le_server_set_hdt_7_5m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = le_connect_rsp,
+	.expect_cmd_len = sizeof(le_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX,
+};
+
 static const struct l2cap_data le_server_set_phy_coded_test = {
 	.server_psm = 0x0080,
 	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
@@ -1091,6 +1323,136 @@ static const struct l2cap_data le_server_set_phy_coded_test = {
 	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
 };
 
+static const uint8_t nval_mic_len_connect_rsp[] = {
+						0x00, 0x00, /* DCID */
+						0x00, 0x00, /* MTU */
+						0x00, 0x00, /* MPS */
+						0x00, 0x00, /* Credits */
+						0x0c, 0x00, /* Result */
+};
+
+static const struct l2cap_data le_server_nval_mic_len_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = nval_mic_len_connect_rsp,
+	.expect_cmd_len = sizeof(nval_mic_len_connect_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x02,
+	.client_mic_len = 0x01,
+};
+
+/* HDT has to be the PHY of both directions or of none, so asking for it in only
+ * one leaves a GFSK PHY, whose 32-bit MIC the channel rejects. The PHY Update
+ * Complete events are checked for the pair.
+ */
+static const struct l2cap_data le_server_hdt_one_direction_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = nval_mic_len_connect_rsp,
+	.expect_cmd_len = sizeof(nval_mic_len_connect_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x02,
+	.client_mic_len = 0x01,
+	.client_tx_phys = 0x17,
+	.client_rx_phys = 0x07,
+};
+
+static const uint8_t ecred_mic_len_connect_req[] = {
+						0x80, 0x00, /* PSM */
+						0x40, 0x00, /* MTU */
+						0x40, 0x00, /* MPS */
+						0x05, 0x00, /* Credits */
+						0x41, 0x00, /* SCID #1 */
+};
+
+static const uint8_t nval_mic_len_ecred_connect_rsp[] = {
+						0x00, 0x00, /* MTU */
+						0x00, 0x00, /* MPS */
+						0x00, 0x00, /* Credits */
+						0x10, 0x00, /* Result */
+						0x00, 0x00, /* DCID #1 */
+};
+
+/* HDT, 64-bit MIC, Enhanced Credit Based, server requires 128-bit */
+static const struct l2cap_data le_server_nval_mic_len_ecred_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_mic_len_connect_req,
+	.send_cmd_len = sizeof(ecred_mic_len_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = nval_mic_len_ecred_connect_rsp,
+	.expect_cmd_len = sizeof(nval_mic_len_ecred_connect_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x02,
+	.client_mic_len = 0x01,
+};
+
+/* LE 1M, 32-bit MIC (implicit), LE Credit Based, server requires
+ * 64-bit
+ */
+static const struct l2cap_data le_server_nval_mic_len_1m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_LE_CONN_RSP,
+	.expect_cmd = nval_mic_len_connect_rsp,
+	.expect_cmd_len = sizeof(nval_mic_len_connect_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x01,
+	.client_encrypt = true,
+};
+
+/* LE 1M, 32-bit MIC (implicit), Enhanced Credit Based, server
+ * requires 64-bit
+ */
+static const struct l2cap_data le_server_nval_mic_len_1m_ecred_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_mic_len_connect_req,
+	.send_cmd_len = sizeof(ecred_mic_len_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = nval_mic_len_ecred_connect_rsp,
+	.expect_cmd_len = sizeof(nval_mic_len_ecred_connect_rsp),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x01,
+	.client_encrypt = true,
+};
+
+/* HDT, 128-bit MIC, LE Credit Based, re-encrypting asking for a 64-bit MIC
+ * keeps the 128-bit MIC since only one side prefers 64-bit.
+ */
+static const struct l2cap_data le_server_reencrypt_mic_len_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_LE_CONN_REQ,
+	.send_cmd = le_connect_req,
+	.send_cmd_len = sizeof(le_connect_req),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x02,
+	.client_mic_len = 0x02,
+	.reencrypt_mic_len = 0x01,
+};
+
+/* HDT, 128-bit MIC, Enhanced Credit Based, re-encrypting asking for a 64-bit
+ * MIC keeps the 128-bit MIC since only one side prefers 64-bit.
+ */
+static const struct l2cap_data le_server_reencrypt_mic_len_ecred_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_mic_len_connect_req,
+	.send_cmd_len = sizeof(ecred_mic_len_connect_req),
+	.sec_level = BT_SECURITY_MEDIUM,
+	.mic_len = 0x02,
+	.client_mic_len = 0x02,
+	.reencrypt_mic_len = 0x01,
+};
+
 static const uint8_t ecred_connect_req[] = {	0x80, 0x00, /* PSM */
 						0x40, 0x00, /* MTU */
 						0x40, 0x00, /* MPS */
@@ -1197,6 +1559,24 @@ static const struct l2cap_data ext_flowctl_server_phy_2m_coded_test = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data ext_flowctl_server_phy_hdt_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+};
+
 static const struct l2cap_data ext_flowctl_server_set_phy_1m_test = {
 	.server_psm = 0x0080,
 	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
@@ -1239,6 +1619,101 @@ static const struct l2cap_data ext_flowctl_server_set_phy_coded_test = {
 	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
 };
 
+static const struct l2cap_data ext_flowctl_server_set_hdt_2m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_hdt_3m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_hdt_4m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_hdt_6m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_server_set_hdt_7_5m_test = {
+	.server_psm = 0x0080,
+	.send_cmd_code = BT_L2CAP_PDU_ECRED_CONN_REQ,
+	.send_cmd = ecred_connect_req,
+	.send_cmd_len = sizeof(ecred_connect_req),
+	.expect_cmd_code = BT_L2CAP_PDU_ECRED_CONN_RSP,
+	.expect_cmd = ecred_connect_rsp,
+	.expect_cmd_len = sizeof(ecred_connect_rsp),
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX,
+};
+
 static const struct l2cap_data le_att_client_connect_success_test_1 = {
 	.cid = 0x0004,
 	.sec_level = BT_SECURITY_LOW,
@@ -1395,6 +1870,20 @@ static const struct l2cap_data ext_flowctl_client_phy_2m_coded_test_1 = {
 		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX),
 };
 
+static const struct l2cap_data ext_flowctl_client_phy_hdt_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+};
+
 static const struct l2cap_data ext_flowctl_client_set_phy_1m_test = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1425,6 +1914,81 @@ static const struct l2cap_data ext_flowctl_client_set_phy_coded_test = {
 	.phy = BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX,
 };
 
+static const struct l2cap_data ext_flowctl_client_set_hdt_2m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_hdt_3m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_hdt_4m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_hdt_6m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX,
+};
+
+static const struct l2cap_data ext_flowctl_client_set_hdt_7_5m_test = {
+	.client_psm = 0x0080,
+	.server_psm = 0x0080,
+	.mode = BT_MODE_EXT_FLOWCTL,
+	.phys = (BT_PHY_LE_1M_TX | BT_PHY_LE_1M_RX |
+		 BT_PHY_LE_2M_TX | BT_PHY_LE_2M_RX |
+		 BT_PHY_LE_CODED_TX | BT_PHY_LE_CODED_RX |
+		 BT_PHY_HDT_2M_TX | BT_PHY_HDT_2M_RX |
+		 BT_PHY_HDT_3M_TX | BT_PHY_HDT_3M_RX |
+		 BT_PHY_HDT_4M_TX | BT_PHY_HDT_4M_RX |
+		 BT_PHY_HDT_6M_TX | BT_PHY_HDT_6M_RX |
+		 BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX),
+	.phy = BT_PHY_HDT_7_5M_TX | BT_PHY_HDT_7_5M_RX,
+};
+
 static const struct l2cap_data ext_flowctl_client_defer_limit = {
 	.client_psm = 0x0080,
 	.server_psm = 0x0080,
@@ -1734,6 +2298,7 @@ static void setup_powered_client(const void *test_data)
 static void setup_powered_server(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
 	unsigned char param[] = { 0x01 };
 
 	setup_powered_common();
@@ -1743,6 +2308,43 @@ static void setup_powered_server(const void *test_data)
 	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
+	/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4, Part E,
+	 * Section 7.8.49:
+	 *
+	 * PHY_Options bit 7 specifies the preferred MIC length on the LE HDT
+	 * PHY if the connection is encrypted and the encryption key is being
+	 * refreshed. A MIC length of 64 is only used if both devices prefer
+	 * it.
+	 *
+	 * So make this side prefer 64 bits too when the client asks for it,
+	 * while the channel still requires what the test sets.
+	 */
+	if (l2data && l2data->client_mic_len == 0x01) {
+		uint8_t mic_param[] = {
+			0x21, 0x00,	/* Type: LE HDT Default MIC Length */
+			0x01,		/* Length */
+			0x01,		/* Value: 64-bit */
+		};
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+				data->mgmt_index, sizeof(mic_param),
+				mic_param, NULL, NULL, NULL);
+	}
+
+	/* Re-encrypting needs the LTK on both sides, which Secure
+	 * Connections pairing gives with EDIV and Rand set to zero.
+	 */
+	if (l2data && l2data->reencrypt_mic_len) {
+		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+		mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+		mgmt_send(data->mgmt, MGMT_OP_SET_SECURE_CONN,
+				data->mgmt_index, sizeof(param), param, NULL,
+				NULL, NULL);
+		bthost_set_sc_support(bthost, true);
+	}
+
 	if (data->hciemu_type > HCIEMU_TYPE_LE)
 		mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
@@ -1925,6 +2527,179 @@ static bool check_mtu(struct test_data *data, int sk)
 	return true;
 }
 
+static bool check_reencrypt_mic_len(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	struct bt_security sec;
+	socklen_t optlen = sizeof(sec);
+	/* A MIC length of 64 is only used if both devices prefer it, see
+	 * setup_powered_server(), so the refresh keeps the 128-bit MIC the
+	 * channel requires.
+	 */
+	memset(&sec, 0, sizeof(sec));
+	if (getsockopt(data->reencrypt_sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							&optlen) < 0) {
+		tester_warn("getsockopt(BT_SECURITY): %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+		return false;
+	}
+
+	if (sec.mic_len != l2data->mic_len) {
+		tester_warn("MIC length changed: 0x%02x != 0x%02x",
+						sec.mic_len, l2data->mic_len);
+		tester_test_failed();
+		return false;
+	}
+
+	tester_print("MIC length unchanged: 0x%02x", sec.mic_len);
+	tester_test_passed();
+
+	return false;
+}
+
+static bool hook_reencrypt_complete(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const uint8_t *status = msg;
+
+	if (len < 1)
+		return true;
+
+	if (*status) {
+		tester_warn("Re-encryption failed: status 0x%02x", *status);
+		tester_test_failed();
+		return true;
+	}
+
+	tester_print("Re-encryption complete");
+
+	/* Let the host process the event before checking */
+	timeout_add(50, check_reencrypt_mic_len, NULL, NULL);
+
+	return true;
+}
+
+static bool check_opp_sec(void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct l2cap_data *l2data = data->test_data;
+	int level = l2data->opp_sec_level ? : BT_SECURITY_LOW;
+	struct bt_security sec;
+	socklen_t optlen = sizeof(sec);
+
+	memset(&sec, 0, sizeof(sec));
+	if (getsockopt(data->opp_sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							&optlen) < 0) {
+		tester_warn("getsockopt(BT_SECURITY): %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+		return false;
+	}
+
+	tester_print("Security level %u key size %u", sec.level,
+							sec.key_size);
+
+	close(data->opp_sk);
+	data->opp_sk = -1;
+
+	if (sec.level != level) {
+		tester_warn("Security level %u != %u", sec.level, level);
+		tester_test_failed();
+		return false;
+	}
+
+	/* Only a key from pairing has a key size */
+	if (l2data->opp_sec_level && sec.key_size < 7) {
+		tester_warn("Invalid key size %u", sec.key_size);
+		tester_test_failed();
+		return false;
+	}
+
+	tester_test_passed();
+
+	return false;
+}
+
+static bool hook_opp_key_refresh(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const struct bt_hci_evt_encrypt_key_refresh_complete_v2 *ev = msg;
+
+	if (len < sizeof(*ev))
+		return true;
+
+	if (ev->status) {
+		tester_warn("Key refresh failed: status 0x%02x", ev->status);
+		tester_test_failed();
+		return true;
+	}
+
+	tester_print("Key refreshed by pairing");
+
+	/* Let the host process the event before checking */
+	timeout_add(50, check_opp_sec, NULL, NULL);
+
+	return true;
+}
+
+/* Runs once the socket is connected and the link opportunistically
+ * encrypted, which may happen in either order.
+ */
+static void opp_encrypt_continue(struct test_data *data)
+{
+	const struct l2cap_data *l2data = data->test_data;
+	struct bt_security sec;
+
+	if (data->opp_sk < 0 || !data->opp_encrypted)
+		return;
+
+	if (!l2data->opp_sec_level) {
+		check_opp_sec(NULL);
+		return;
+	}
+
+	tester_print("Raising security level to %u", l2data->opp_sec_level);
+
+	/* Pairing over the encrypted link refreshes its key */
+	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+				BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2,
+				hook_opp_key_refresh, data);
+
+	memset(&sec, 0, sizeof(sec));
+	sec.level = l2data->opp_sec_level;
+	if (setsockopt(data->opp_sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
+							sizeof(sec)) < 0) {
+		tester_warn("setsockopt(BT_SECURITY): %s (%d)",
+						strerror(errno), errno);
+		tester_test_failed();
+	}
+}
+
+static bool hook_opp_encrypt(const void *msg, uint16_t len, void *user_data)
+{
+	const struct bt_hci_evt_encrypt_change_v3 *ev = msg;
+	struct test_data *data = user_data;
+
+	if (len < sizeof(*ev) || ev->eks_mode != 0x02)
+		return true;
+
+	if (ev->status || !ev->mode) {
+		tester_warn("Opportunistic encryption failed: status 0x%02x",
+								ev->status);
+		tester_test_failed();
+		return true;
+	}
+
+	tester_print("Link opportunistically encrypted");
+
+	data->opp_encrypted = true;
+	opp_encrypt_continue(data);
+
+	return true;
+}
+
 static bool check_phy_and_sec(void *args)
 {
 	int sk = PTR_TO_INT(args);
@@ -2228,6 +3003,19 @@ static bool l2cap_connect_cb(struct tester_io *io, uint32_t cond,
 		return false;
 	}
 
+	if (l2data->opp_encrypt) {
+		/* The socket is closed once this returns, so keep a copy */
+		data->opp_sk = dup(sk);
+		if (data->opp_sk < 0) {
+			tester_warn("dup: %s (%d)", strerror(errno), errno);
+			tester_test_failed();
+			return false;
+		}
+
+		opp_encrypt_continue(data);
+		return false;
+	}
+
 	if (l2data->read_data) {
 		l2cap_read_data(data, io, data->dcid);
 		return false;
@@ -2304,6 +3092,9 @@ static int create_l2cap_sock(struct test_data *data, uint16_t psm,
 		memset(&sec, 0, sizeof(sec));
 		sec.level = sec_level;
 
+		if (l2data)
+			sec.mic_len = l2data->mic_len;
+
 		if (setsockopt(sk, SOL_BLUETOOTH, BT_SECURITY, &sec,
 							sizeof(sec)) < 0) {
 			err = -errno;
@@ -2441,6 +3232,13 @@ static void test_connect(const void *test_data)
 	struct tester_io *io;
 	int sk;
 
+	if (l2data->opp_encrypt) {
+		data->opp_sk = -1;
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_ENCRYPT_CHANGE_V3,
+					hook_opp_encrypt, data);
+	}
+
 	if (l2data->server_psm) {
 		struct bthost *bthost = hciemu_client_get_host(data->hciemu);
 		bthost_l2cap_connect_cb host_connect_cb = NULL;
@@ -3075,6 +3873,30 @@ static bool l2cap_accept_cb(struct tester_io *io, uint32_t cond,
 
 	tester_print("Successfully connected");
 
+	if (l2data->reencrypt_mic_len) {
+		struct bthost *bthost;
+
+		tester_print("Re-encrypting with mic_len 0x%02x"
+					" (expect the MIC to be kept)",
+					l2data->reencrypt_mic_len);
+
+		/* The check runs once the refresh reaches the host, as
+		 * Encryption Change v3 or Key Refresh Complete v2.
+		 */
+		data->reencrypt_sk = sk;
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+					BT_HCI_EVT_ENCRYPT_CHANGE_V3,
+					hook_reencrypt_complete, data);
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_EVT,
+				BT_HCI_EVT_ENCRYPT_KEY_REFRESH_COMPLETE_V2,
+				hook_reencrypt_complete, data);
+
+		bthost = hciemu_client_get_host(data->hciemu);
+		bthost_le_reencrypt(bthost, data->handle,
+						l2data->reencrypt_mic_len);
+		return false;
+	}
+
 	tester_test_passed();
 
 	return false;
@@ -3209,6 +4031,60 @@ failed:
 	tester_test_failed();
 }
 
+/* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 6, Part B,
+ * Section 2.4.2.23:
+ *
+ * If a PHY is changing, then both fields shall be set to the LE HDT PHY or
+ * both shall be set to a GFSK PHY (which may be a different PHY in each
+ * direction).
+ */
+static bool hook_phy_update_pair(const void *msg, uint16_t len,
+							void *user_data)
+{
+	const struct bt_hci_evt_le_phy_update_complete *ev;
+	const uint8_t *subevent = msg;
+
+	if (len < 1 + sizeof(*ev) ||
+			*subevent != BT_HCI_EVT_LE_PHY_UPDATE_COMPLETE)
+		return true;
+
+	ev = (void *)(subevent + 1);
+
+	tester_print("PHY Update Complete: TX 0x%02x RX 0x%02x", ev->tx_phy,
+								ev->rx_phy);
+
+	if ((ev->tx_phy == 0x05) != (ev->rx_phy == 0x05)) {
+		tester_warn("HDT in only one direction");
+		tester_test_failed();
+	}
+
+	return true;
+}
+
+static void send_l2cap_req_after_encrypt(uint16_t handle, void *user_data)
+{
+	struct test_data *data = user_data;
+	const struct l2cap_data *l2data = data->test_data;
+	struct bthost *bthost;
+	bthost_l2cap_rsp_cb cb;
+
+	if (l2data->expect_cmd_code)
+		cb = client_l2cap_rsp;
+	else
+		cb = NULL;
+
+	tester_print("Sending L2CAP Request from client after encryption");
+
+	bthost = hciemu_client_get_host(data->hciemu);
+
+	/* Only once: a later re-encryption must not send it again */
+	bthost_set_encrypt_cb(bthost, NULL, NULL);
+
+	bthost_l2cap_req(bthost, handle, l2data->send_cmd_code,
+				l2data->send_cmd, l2data->send_cmd_len,
+				cb, data);
+}
+
 static void send_req_new_conn(uint16_t handle, void *user_data)
 {
 	struct test_data *data = user_data;
@@ -3240,6 +4116,33 @@ static void send_req_new_conn(uint16_t handle, void *user_data)
 	if (l2data->send_cmd) {
 		bthost_l2cap_rsp_cb cb;
 
+		if (l2data->client_mic_len) {
+			bthost = hciemu_client_get_host(data->hciemu);
+			if (l2data->client_tx_phys || l2data->client_rx_phys)
+				hciemu_add_hook(data->hciemu,
+						HCIEMU_HOOK_POST_EVT,
+						BT_HCI_EVT_LE_META_EVENT,
+						hook_phy_update_pair, data);
+
+			/* Set HDT PHY first, then encrypt, then send L2CAP */
+			bthost_le_set_phy(bthost, handle,
+					l2data->client_tx_phys ? : 0x17,
+					l2data->client_rx_phys ? : 0x17);
+			bthost_set_encrypt_cb(bthost,
+					send_l2cap_req_after_encrypt, data);
+			bthost_request_auth(bthost, handle);
+			return;
+		}
+
+		if (l2data->client_encrypt) {
+			bthost = hciemu_client_get_host(data->hciemu);
+			/* Encrypt (no PHY change), then send L2CAP */
+			bthost_set_encrypt_cb(bthost,
+					send_l2cap_req_after_encrypt, data);
+			bthost_request_auth(bthost, handle);
+			return;
+		}
+
 		if (l2data->expect_cmd_code)
 			cb = client_l2cap_rsp;
 		else
@@ -3313,6 +4216,9 @@ static void start_test_server(const void *test_data, bthost_new_conn_cb conn_cb,
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_connect_cb(bthost, conn_cb, data);
 
+	if (l2data->client_mic_len)
+		bthost_set_mic_len(bthost, l2data->client_mic_len);
+
 	if (data->hciemu_type == HCIEMU_TYPE_BREDR)
 		addr_type = BDADDR_BREDR;
 	else
@@ -3756,6 +4662,16 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Client - PHY 2M/Coded",
 				&le_client_connect_phy_2m_coded_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Opportunistic Encryption HDT",
+				&le_client_opp_encrypt_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Opportunistic Encryption "
+				"then Pairing HDT",
+				&le_client_opp_encrypt_pair_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - PHY HDT",
+				&le_client_connect_phy_hdt_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le_52("L2CAP LE Client - Set PHY 1M",
 				&le_client_set_phy_1m_test,
 				setup_powered_client, test_connect);
@@ -3765,6 +4681,21 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Client - Set PHY Coded",
 				&le_client_set_phy_coded_test,
 				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Set HDT 2M",
+				&le_client_set_hdt_2m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Set HDT 3M",
+				&le_client_set_hdt_3m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Set HDT 4M",
+				&le_client_set_hdt_4m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Set HDT 6M",
+				&le_client_set_hdt_6m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP LE Client - Set HDT 7.5M",
+				&le_client_set_hdt_7_5m_test,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP LE Client - Close socket 1",
 				&le_client_close_socket_test_1,
@@ -3798,6 +4729,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Server - PHY 2M/Coded",
 					&le_server_phy_2m_coded_test,
 					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - PHY HDT",
+					&le_server_phy_hdt_test,
+					setup_powered_server, test_server);
 	test_l2cap_le_52("L2CAP LE Server - Set PHY 1M",
 					&le_server_set_phy_1m_test,
 					setup_powered_server, test_server);
@@ -3807,6 +4741,42 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP LE Server - Set PHY Coded",
 					&le_server_set_phy_coded_test,
 					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - Set HDT 2M",
+					&le_server_set_hdt_2m_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - Set HDT 3M",
+					&le_server_set_hdt_3m_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - Set HDT 4M",
+					&le_server_set_hdt_4m_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - Set HDT 6M",
+					&le_server_set_hdt_6m_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - Set HDT 7.5M",
+					&le_server_set_hdt_7_5m_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - MIC Length Too Short HDT/CFC",
+					&le_server_nval_mic_len_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - HDT One Direction",
+				&le_server_hdt_one_direction_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - MIC Length Too Short HDT/ECFC",
+					&le_server_nval_mic_len_ecred_test,
+					setup_powered_server, test_server);
+	test_l2cap_le("L2CAP LE Server - MIC Length Too Short 1M/CFC",
+					&le_server_nval_mic_len_1m_test,
+					setup_powered_server, test_server);
+	test_l2cap_le("L2CAP LE Server - MIC Length Too Short 1M/ECFC",
+					&le_server_nval_mic_len_1m_ecred_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - MIC Length Downgrade HDT/CFC",
+					&le_server_reencrypt_mic_len_test,
+					setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP LE Server - MIC Length Downgrade HDT/ECFC",
+					&le_server_reencrypt_mic_len_ecred_test,
+					setup_powered_server, test_server);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Success",
 				&ext_flowctl_client_connect_success_test_1,
@@ -3843,6 +4813,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Client - PHY 2M/Coded",
 				&ext_flowctl_client_phy_2m_coded_test_1,
 				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - PHY HDT",
+				&ext_flowctl_client_phy_hdt_test,
+				setup_powered_client, test_connect);
 	test_l2cap_le_52("L2CAP Ext-Flowctl Client - Set PHY 1M",
 				&ext_flowctl_client_set_phy_1m_test,
 				setup_powered_client, test_connect);
@@ -3852,6 +4825,21 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Client - Set PHY Coded",
 				&ext_flowctl_client_set_phy_coded_test,
 				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - Set HDT 2M",
+				&ext_flowctl_client_set_hdt_2m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - Set HDT 3M",
+				&ext_flowctl_client_set_hdt_3m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - Set HDT 4M",
+				&ext_flowctl_client_set_hdt_4m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - Set HDT 6M",
+				&ext_flowctl_client_set_hdt_6m_test,
+				setup_powered_client, test_connect);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Client - Set HDT 7.5M",
+				&ext_flowctl_client_set_hdt_7_5m_test,
+				setup_powered_client, test_connect);
 
 	test_l2cap_le("L2CAP Ext-Flowctl Client - Defer limit",
 				&ext_flowctl_client_defer_limit,
@@ -3874,6 +4862,9 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Server - PHY 2M/Coded",
 				&ext_flowctl_server_phy_2m_coded_test,
 				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - PHY HDT",
+				&ext_flowctl_server_phy_hdt_test,
+				setup_powered_server, test_server);
 	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Set PHY 1M",
 				&ext_flowctl_server_set_phy_1m_test,
 				setup_powered_server, test_server);
@@ -3883,6 +4874,21 @@ int main(int argc, char *argv[])
 	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Set PHY Coded",
 				&ext_flowctl_server_set_phy_coded_test,
 				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - Set HDT 2M",
+				&ext_flowctl_server_set_hdt_2m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - Set HDT 3M",
+				&ext_flowctl_server_set_hdt_3m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - Set HDT 4M",
+				&ext_flowctl_server_set_hdt_4m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - Set HDT 6M",
+				&ext_flowctl_server_set_hdt_6m_test,
+				setup_powered_server, test_server);
+	test_l2cap_bredrle70("L2CAP Ext-Flowctl Server - Set HDT 7.5M",
+				&ext_flowctl_server_set_hdt_7_5m_test,
+				setup_powered_server, test_server);
 
 	test_l2cap_le_52("L2CAP Ext-Flowctl Server - Nval Conn Req",
 				&ext_flowctl_server_nval_conn_req_test,
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 201bd4396c84..967ddd12e487 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -703,6 +703,13 @@ static void test_condition_complete(struct test_data *data)
 #define test_bredrle62(name, data, setup, func) \
 	test_bredrle62_full(name, data, setup, func, 2)
 
+#define test_bredrle70_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE70, \
+					0x10, 0x0601beff, 0x00000080)
+
+#define test_bredrle70(name, data, setup, func) \
+	test_bredrle70_full(name, data, setup, func, 2)
+
 #define test_hs_full(name, data, setup, func, timeout) \
 	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE, \
 					0x09, 0x0001bfff, 0x00000080)
@@ -4709,6 +4716,21 @@ static const struct generic_data set_le_on_success_sci = {
 	.expect_hci_len = sizeof(set_le_on_write_le_host_param),
 };
 
+static const char set_le_settings_param_hdt[] = { 0x81, 0x02, 0xfc, 0x07 };
+static const struct generic_data set_le_on_success_hdt = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_hdt,
+	.expect_len = sizeof(set_le_settings_param_hdt),
+	.expect_settings_set = MGMT_SETTING_LE,
+	.expect_hci_command = BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED,
+	.expect_hci_param = set_le_on_write_le_host_param,
+	.expect_hci_len = sizeof(set_le_on_write_le_host_param),
+};
+
 static const uint8_t load_conn_subrate_nval_1[16] = { 0x12, 0x11 };
 static const struct generic_data load_conn_subrate_fail_1 = {
 	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
@@ -14253,6 +14275,166 @@ static void test_hci_devcd(const void *test_data)
 	tester_wait(test->dump_data->timeout + 1, verify_devcd, NULL);
 }
 
+/* HDT Default Parameters - Set Default System Config with TLVs 0x0021-0x0023 */
+static const uint8_t set_def_system_config_hdt_mic_len_param[] = {
+	0x21, 0x00,	/* Type: LE HDT Default MIC Length */
+	0x01,		/* Length */
+	0x02,		/* Value: 128-bit */
+};
+
+static const struct generic_data set_def_system_config_hdt_mic_len = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_mic_len_param,
+	.send_len = sizeof(set_def_system_config_hdt_mic_len_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* 32 bits is the MIC length of the GFSK PHYs, it is reserved for HDT */
+static const uint8_t set_def_system_config_hdt_mic_len_invalid_param[] = {
+	0x21, 0x00,	/* Type: LE HDT Default MIC Length */
+	0x01,		/* Length */
+	0x00,		/* Value: 32-bit */
+};
+
+static const struct generic_data set_def_system_config_hdt_mic_len_invalid = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_mic_len_invalid_param,
+	.send_len = sizeof(set_def_system_config_hdt_mic_len_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+/* Packet formats above 1 are reserved */
+static const uint8_t set_def_system_config_hdt_format_invalid_param[] = {
+	0x22, 0x00,	/* Type: LE HDT Default Packet Format */
+	0x01,		/* Length */
+	0x03,		/* Value: reserved */
+};
+
+static const struct generic_data set_def_system_config_hdt_format_invalid = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_format_invalid_param,
+	.send_len = sizeof(set_def_system_config_hdt_format_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+/* Rate bits above HDT7.5 (bit 4) are reserved */
+static const uint8_t set_def_system_config_hdt_rates_invalid_param[] = {
+	0x23, 0x00,	/* Type: LE HDT Default Rates */
+	0x02,		/* Length */
+	0x20, 0x00,	/* Value: bit 5, reserved */
+};
+
+static const struct generic_data set_def_system_config_hdt_rates_invalid = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_rates_invalid_param,
+	.send_len = sizeof(set_def_system_config_hdt_rates_invalid_param),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const uint8_t set_def_system_config_hdt_format_param[] = {
+	0x22, 0x00,	/* Type: LE HDT Default Packet Format */
+	0x01,		/* Length */
+	0x01,		/* Value: Format 1 */
+};
+
+static const struct generic_data set_def_system_config_hdt_format = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_format_param,
+	.send_len = sizeof(set_def_system_config_hdt_format_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const uint8_t set_def_system_config_hdt_rates_param[] = {
+	0x23, 0x00,	/* Type: LE HDT Default Rates */
+	0x02,		/* Length */
+	0x1f, 0x00,	/* Value: All rates (bits 0-4) */
+};
+
+static const struct generic_data set_def_system_config_hdt_rates = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_hdt_rates_param,
+	.send_len = sizeof(set_def_system_config_hdt_rates_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* EKS Opportunistic Encryption - Set Default System Config with TLV 0x0024 */
+static const uint8_t set_def_system_config_eks_oppt_param[] = {
+	0x24, 0x00,	/* Type: LE Opportunistic Encryption */
+	0x01,		/* Length */
+	0x01,		/* Value: enabled */
+};
+
+static const struct generic_data set_def_system_config_eks_oppt_on = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_eks_oppt_param,
+	.send_len = sizeof(set_def_system_config_eks_oppt_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+static const uint8_t set_def_system_config_eks_oppt_off_param[] = {
+	0x24, 0x00,	/* Type: LE Opportunistic Encryption */
+	0x01,		/* Length */
+	0x00,		/* Value: disabled */
+};
+
+static const struct generic_data set_def_system_config_eks_oppt_off = {
+	.send_opcode = MGMT_OP_SET_DEF_SYSTEM_CONFIG,
+	.send_param = set_def_system_config_eks_oppt_off_param,
+	.send_len = sizeof(set_def_system_config_eks_oppt_off_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* EKS Opportunistic Encryption - Verify encryption happens on connect */
+static const void *add_device_auto_connect_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static struct mgmt_cp_add_device cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.addr.bdaddr, hciemu_get_client_bdaddr(data->hciemu), 6);
+	cp.addr.type = BDADDR_LE_PUBLIC;
+	cp.action = 0x02; /* Auto connect */
+
+	*len = sizeof(cp);
+
+	return &cp;
+}
+
+static int check_encrypt_v2_opportunistic(const void *param, uint16_t length)
+{
+	const struct bt_hci_cmd_le_enable_encrypt_v2 *cmd = param;
+
+	if (length < sizeof(*cmd))
+		return -1;
+
+	/* Verify encryption field is 0x01 (opportunistic) */
+	if (cmd->encryption != 0x01) {
+		tester_warn("Expected encryption=0x01 (opportunistic), "
+					"got 0x%02x", cmd->encryption);
+		return -1;
+	}
+
+	return 0;
+}
+
+static uint16_t settings_powered_le_ssp[] = {
+	MGMT_OP_SET_LE,
+	MGMT_OP_SET_SSP,
+	MGMT_OP_SET_POWERED,
+	0 };
+
+static const struct generic_data eks_oppt_connect_encrypt_test = {
+	.setup_settings = settings_powered_le_ssp,
+	.client_enable_adv = true,
+	.send_opcode = MGMT_OP_ADD_DEVICE,
+	.send_func = add_device_auto_connect_func,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_ignore_param = true,
+	.expect_hci_command = BT_HCI_CMD_LE_ENABLE_ENCRYPT_V2,
+	.expect_hci_len = sizeof(struct bt_hci_cmd_le_enable_encrypt_v2),
+	.expect_hci_param_check_func = check_encrypt_v2_opportunistic,
+};
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -14601,6 +14783,9 @@ int main(int argc, char *argv[])
 	test_bredrle62("Set Low Energy on 6.2 - SCI Setting",
 				&set_le_on_success_sci,
 				NULL, test_command_generic);
+	test_bredrle70("Set Low Energy on HDT - HDT Setting",
+				&set_le_on_success_hdt,
+				NULL, test_command_generic);
 	test_bredrle("Set Low Energy on - Invalid parameters 1",
 				&set_le_on_invalid_param_test_1,
 				NULL, test_command_generic);
@@ -14897,6 +15082,10 @@ int main(int argc, char *argv[])
 	test_bredrle("Pair Device - SSP Just-Works Success 1",
 				&pair_device_ssp_test_1,
 				NULL, test_command_generic);
+	/* Encryption Change v3 reports the key size, so it isn't read */
+	test_bredrle70("Pair Device - SSP Just-Works Success 7.0",
+				&pair_device_ssp_test_1,
+				NULL, test_command_generic);
 	test_bredrle("Pair Device - SSP Just-Works Success 2",
 				&pair_device_ssp_test_2,
 				NULL, test_command_generic);
@@ -16486,5 +16675,34 @@ int main(int argc, char *argv[])
 	test_bredrle_full("HCI Devcoredump - Dump Timeout", &dump_timeout, NULL,
 				test_hci_devcd, 3);
 
+	/* EKS Opportunistic Encryption */
+	test_bredrle70("Set Default System Config - HDT MIC Length",
+				&set_def_system_config_hdt_mic_len,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - HDT MIC Length Invalid",
+				&set_def_system_config_hdt_mic_len_invalid,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - HDT Packet Format Invalid",
+				&set_def_system_config_hdt_format_invalid,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - HDT Rates Invalid",
+				&set_def_system_config_hdt_rates_invalid,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - HDT Packet Format",
+				&set_def_system_config_hdt_format,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - HDT Rates",
+				&set_def_system_config_hdt_rates,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - EKS Opportunistic on",
+				&set_def_system_config_eks_oppt_on,
+				NULL, test_command_generic);
+	test_bredrle70("Set Default System Config - EKS Opportunistic off",
+				&set_def_system_config_eks_oppt_off,
+				NULL, test_command_generic);
+	test_bredrle70_full("EKS Opportunistic - Auto Encrypt on Connect",
+				&eks_oppt_connect_encrypt_test,
+				NULL, test_command_generic, 5);
+
 	return tester_run();
 }
-- 
2.56.0

