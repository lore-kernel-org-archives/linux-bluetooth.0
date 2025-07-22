Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF90265CCB
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 20:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753216522; cv=none; b=VuSxfDkl2ctGUPsnH1sg3+GqBbVS5QgoRctXFl5J/PQid4yOB6vx/w4nXN9k9MrRdMCZcwFLcDeuN/TT/FxQe5mG8yaVRBIs8jsfeU1+rukb3pCWONR57anrmZnqq5uWCQNwDlaTX9EBdColoipHHcWLNbwbUIT/VEYOXpv6M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753216522; c=relaxed/simple;
	bh=jZYL+YPO3MPWiTAQ2uiWVsOqJESEuu4PfqtDEzWmhjQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=R6qSy60NkO33aOz2dUXv6Gshe0QSjl2YUlUAQW2ggYR7hC2PwT/sRqBPjw8yBM8ZeOS5DohafWXqFymyrKyKYmHZ7WtP9QoXloJruKhjHjCtkClZwQYOYLEFCtAWNks8NdgwANTwI7vzy56GDvZoq8x46z1RQSDCRhiwHHmIvQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W96wkMPC; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W96wkMPC"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-87f298f3508so2168807241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jul 2025 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753216519; x=1753821319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P8mJ3XmN81/3+KeTb1cIref1zUl+oBxlLXlp+ZLiNNg=;
        b=W96wkMPCJ0aOf9O/+MyzlcaVpaT15yj/sa6/xUsRVu9UZa9zIQ0/A93x3xcpXTb+8i
         0OtpDR6FV3bJRYAvlgt/fQ2yV+LevsK9B4+TNzDUPn67PFSLZI5/C4SA0ThCFUpHiXfK
         Q0rkqkGQgYMPyMjjGbfdpdQk7nUEuE7U7/7MGpYKvQIWheqCPqO+H0CUvCXQC0G2uAyy
         xpl5uatRJZAZFssEOdcClFsVjQu3KnuGGV4VpGPj3Shnxr65QybKYsl0sEUUQvbwuzvf
         rkpnfONgFL4QEvyzAU3z1lVtDEj/T/HZx/QkbSybpO6r3+ZLbEurG53fxjNKBE/WK9Ym
         51TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753216519; x=1753821319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8mJ3XmN81/3+KeTb1cIref1zUl+oBxlLXlp+ZLiNNg=;
        b=cYmEGz3Q46tJydapa4NSXf0IUDEWJMqxFrYRQ8NsB7G+v4kKjFcDnib6pBOnDXjGwZ
         qcfS/HpTVy9F7rDuPjyPIjgwuBd4nC/dzz9/MaD8aIytaAy/FnvquYPin2puzv3xVTJr
         SgUF8QmWv6UEApvJVOYn3lYXrwzY88mtgqcuyCHaMDX2+G0jlNz4XtRyBdKnvcKeRf+U
         wbfNB6M0dfy3jxOqj2SwhJNcmNf/EQbJdAXafLoOVyHNkem6eXhA2EAnzQfjynjn8j8A
         bZ/73QfVcEvE5QbDZ7pPQ6EfJoS9eHujmFcJWHmaH/Z4d3Y5DD5Ww4dciZFY2FZO8jFe
         eiKA==
X-Gm-Message-State: AOJu0YySGQnqk/YT8bdF5UoTb922O6ZnDqrhIeh5uyXQPFZgGmj4DNrW
	/H3dqS6+qinxk8VB1RyBKuPdB3XSEmDrW2yvx69OakNew3Qug5+8H5OpSnvuy31J
X-Gm-Gg: ASbGncuaoc8CYyPX6wPySUQPM/NSsw4v1DKwozVOkHtu8XC8yYZS+0Tn9LTgnuuq6hY
	mdCRnv9GNvGrXWrrpthG2piZv0N7O/PbaxdwSrmngCH0Ng7ZNqPNbWvxSCEx2rVhioO5nBRAcup
	hk5J0+PsYaPGhEA0rsVfhEDK2esm/xU1InIn1ac2WYIDtmB0DGz4ozuIU2G89wApg6/xlAtQ+oP
	8oDT4WWwLbIhUZyu4f8abg7tNRrAzCBUkcd2VMmb0YUQCFRezdoTMT86UJABSPBXBOPF7nY9eE8
	Xsl5zlDwgAnXpTHAJwMegVb8lDExx/jRk8QH/1u/BYjWOuihB1Ikx73Sm5q7lmuPulWnKzvQUPg
	ZLja4Eiq5/ZfaLjvOEVvnGm8CeOhI4VJbj0xP36oot9n9bMAChcLxg/96BV+AoGdPAbKWQYNqhv
	c=
X-Google-Smtp-Source: AGHT+IHpT2mmfiyFELWm2EBxbepDLH++AhyuuVRDMmQBQ5Gsp0OWcKTay9if0udTMkf9ZW/SSgJG+A==
X-Received: by 2002:a05:6102:41a8:b0:4e6:443d:9b1a with SMTP id ada2fe7eead31-4fa151c1979mr190050137.24.1753216519177;
        Tue, 22 Jul 2025 13:35:19 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0abfe699sm3444451241.5.2025.07.22.13.35.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 13:35:18 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/3] transport: Add write support to Metadata property
Date: Tue, 22 Jul 2025 16:35:06 -0400
Message-ID: <20250722203508.1311750-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds initial support from writing to Metadata property.
---
 profiles/audio/transport.c | 45 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 4800570d934f..bf16de958be4 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1301,6 +1301,49 @@ static gboolean get_metadata(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void bap_metadata_complete(struct bt_bap_stream *stream,
+					uint8_t code, uint8_t reason,
+					void *user_data)
+{
+	GDBusPendingPropertySet id = PTR_TO_UINT(user_data);
+
+	if (code)
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".Failed",
+				"Unable to set metadata");
+	else
+		g_dbus_pending_property_success(id);
+}
+
+static void set_metadata(const GDBusPropertyTable *property,
+			DBusMessageIter *iter, GDBusPendingPropertySet id,
+			void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	DBusMessageIter array;
+	struct iovec iov;
+	int ret;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Expected ARRAY");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &iov.iov_base,
+					(int *)&iov.iov_len);
+
+	ret = bt_bap_stream_metadata(bap->stream, &iov, bap_metadata_complete,
+				     UINT_TO_PTR(id));
+	if (!ret)
+		g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".InvalidArguments",
+				"Invalid metadata");
+}
+
 static gboolean links_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -1422,7 +1465,7 @@ static const GDBusPropertyTable transport_bap_uc_properties[] = {
 	{ "QoS", "a{sv}", get_ucast_qos, NULL, qos_ucast_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
-	{ "Metadata", "ay", get_metadata },
+	{ "Metadata", "ay", get_metadata, set_metadata },
 	{ "Links", "ao", get_links, NULL, links_exists },
 	{ "Volume", "q", get_volume, set_volume, volume_exists },
 	{ }
-- 
2.50.1

