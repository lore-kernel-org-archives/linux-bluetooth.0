Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2D1A6836
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729666; cv=none; b=rR2LaShT9cHCVbwSL2QpgBubJ9ymftAr0FNcNXDntTP4AjsdV2MwJiV9hGVB061Z+BpBMoXQQb8+Wm4GdkUmAGZ4WSlCsA3kf9ErQiEDrmNF5fOOgdW5I0yXcx1YfCSM4IKJvqPWlj+aJIkzmL9U+NR4yLPECrr52ZpaLyEvDCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729666; c=relaxed/simple;
	bh=xA1FFry/Ea5nMlF4Yj3trgy1nrhqcVaF6ZVBFmaYqo4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKp1Bl5VT+fXtsqqTUVcc6xoF+b7QMi22U9JBU4Nih6Kv9CAfDipkxJJmJKzTUXj5Kli2ecw83GQkDEr49dTZU711oStLIRfuyJtvIvU7AIE8SqXZ/vCrHOQrVJYR4o9cXDCe/GQMvPWdHlG8MhBxbzsqtOHSgRt4d+uSjY8JEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZT+9vBB; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZT+9vBB"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so491113e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786729663; x=1787334463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pBhnlptk5LLOIUvHpyxjlVNkk2f+p9SziUzZGFzw+WE=;
        b=QZT+9vBBzfxMprsBKc8CLj7TvgDX26vy4vYS+C/Qj9a8JKlwNAT2FNtUXKr9Njo4gj
         BkxsTC3I+jKjaA+W/nTzl8/fl/f8V4XVHlhrfZM2GPrnqqGID+a0LF/HSKjgQZoBKnls
         9gBMkQbLL98+BNOp67Zbjyao5/rnkoFFyNZcTlNHTQrUyP9GJGx31wFp/PRMbDm72FBT
         WQt9S1t+84b1NPbwTaBVaGIInj6HjjSm314Nfh/m+F9kk8LKaHQ2pwkv51bAf5cKTVEz
         KB/EJEQ1G6nOynmp4fHV6GLHOxE3TtwPYirOpUYxhrcfTZnGOrUGAZA7FMaTUyuWjket
         iGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786729663; x=1787334463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pBhnlptk5LLOIUvHpyxjlVNkk2f+p9SziUzZGFzw+WE=;
        b=g+B+Xe29xNAIXZqeTyu7eyW1ySi6iUe7A9i4dhOmC62DN8RWK95fsLq6SQreDb448M
         lJZ9eGayA5AkjXVr+A1eAukn+yRFatk06GUKpEk5gTjDIeumY4bVz7TFuKtHleS+HtGb
         uWSeZrfOU88s/hZyBOwge6iubZ1jJ20kDLDL9OptqmJ8K64o5Q74MB0jsmKjvST2as53
         i5IBSWFoESUHxXI+jaGz+vNJGsHmA5MbiYzARj+5lYLIoZBhb65lmZUf1lc4DgDbPU44
         +MjdiZ3Wsu+LhC5O+jstfU4p2QoXn1Zfnvbi9u3PBsFxCNfaKgjsrgAe/2CHfNYX+vbe
         H8Uw==
X-Gm-Message-State: AOJu0Yyntx2+t/0SkEVbYp7/PY66UM7LXSeV7rF5cyVWUHjbc6b8KzdZ
	y3I4z279+/yaqUJvFQwH1JyVmjYdwWkZACyvFFRaQa2dVH8ysMYgmHSovw+21OQe
X-Gm-Gg: AR+sD125pD4TG8oikdhhwaqIQF/22Hn7ODTb+YCJA8n7FebZ17HrUpIQbkcwTTDw7JV
	HZn35ypxiUzgancB8a91ZGKp7cCLW7sn93YLqbLW+9INtOPuFBKkOPp98lbxPxAgZYTpX87Ed3v
	pSUWx5AOjrrZexU7Dj0eF3XOBvky9bHlHqJOFjHxxsaAUQMEOytfEQhNS/Hi7Wkijws8y3bJp76
	vJTYTvHTR87n1P6Mer41XrV9Cogqh4Vc4d08dh4su5qnTS/oNKapy02+45nqJiHMtYuGlwtF2rA
	sJe6/7aofCUStbeitCgRhNA/OkQ0603IZNmkV5k3AYpcZaqLC8PeAbynInJ11fR77NOPk6PQrSh
	Ehoq/pVJerNZ9wO1UCyaiWnw1vcLXNZAIz0QvnE1Mm2IpsmHI2E9PGewPxzTQUwesWCHy6gqOln
	8pJyrh5+iFdtKMB8M73csqi1dEd3oiJLB633nfqRtKpoYosW7KiiNDLKDAspOAoM06yDkHWjW6v
	TW0bNBRhCzqGDBWFcPHUs2iNqViX62Y+emo1wZny8txuFVD41Gp9yY=
X-Received: by 2002:a05:6122:4899:b0:5c2:c0ae:c2de with SMTP id 71dfb90a1353d-5c591d9a02amr1395973e0c.8.1786729663417;
        Fri, 14 Aug 2026 10:47:43 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c59472656csm1158387e0c.5.2026.08.14.10.47.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 10:47:42 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] sdp: Fix memory leak when freeing alternates
Date: Fri, 14 Aug 2026 13:47:31 -0400
Message-ID: <20260814174731.1441738-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814174731.1441738-1-luiz.dentz@gmail.com>
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

sdp_data_alloc_with_length() stores the members of SDP_ALT8, SDP_ALT16
and SDP_ALT32 in val.dataseq, exactly like it does for the SDP_SEQ8,
SDP_SEQ16 and SDP_SEQ32 sequences.

sdp_data_free() only calls data_seq_free() for the sequences though, so
freeing an alternate frees the alternate itself and leaks every one of
its members, along with anything they own in turn.

Free the members of alternates as well, and add a test parsing a record
containing an alternate, which leaks without this change:

209 (48 direct, 161 indirect) bytes in 1 blocks are definitely lost
   at calloc (vg_replace_malloc.c:1678)
   by sdp_data_alloc_with_length (sdp.c:350)
   by sdp_data_alloc (sdp.c:486)
   by sdp_xml_parse_int (sdp-xml.c:243)
   by sdp_xml_parse_datatype (sdp-xml.c:421)
   by element_start (sdp-xml.c:507)

Assisted-by: Claude:claude-opus-5
---
 Makefile.am                |  1 +
 lib/bluetooth/sdp.c        |  3 +++
 unit/sdp-xml/alternate.xml | 12 ++++++++++++
 unit/test-sdp-xml.c        |  1 +
 4 files changed, 17 insertions(+)
 create mode 100644 unit/sdp-xml/alternate.xml

diff --git a/Makefile.am b/Makefile.am
index 3c6cf92ab403..2754e1b7f2da 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -648,6 +648,7 @@ unit_test_sdp_xml_CFLAGS = $(AM_CFLAGS) $(GLIB_CFLAGS) -DTOP_SRCDIR=\""$(srcdir)
 unit_test_sdp_xml_CPPFLAGS = -I$(srcdir)/lib
 
 EXTRA_DIST += unit/sdp-xml/Bluetooth_HID-sdp_record.xml		\
+	unit/sdp-xml/alternate.xml				\
 	unit/sdp-xml/compute-seq-size-type-confusion.xml	\
 	unit/sdp-xml/duplicate-attribute.xml			\
 	unit/sdp-xml/qt-SerialPortSDPRecord.xml
diff --git a/lib/bluetooth/sdp.c b/lib/bluetooth/sdp.c
index 8c0865398519..1e027f9ebe6d 100644
--- a/lib/bluetooth/sdp.c
+++ b/lib/bluetooth/sdp.c
@@ -972,6 +972,9 @@ void sdp_data_free(sdp_data_t *d)
 	case SDP_SEQ8:
 	case SDP_SEQ16:
 	case SDP_SEQ32:
+	case SDP_ALT8:
+	case SDP_ALT16:
+	case SDP_ALT32:
 		data_seq_free(d);
 		break;
 	case SDP_URL_STR8:
diff --git a/unit/sdp-xml/alternate.xml b/unit/sdp-xml/alternate.xml
new file mode 100644
index 000000000000..a35ebccbc71f
--- /dev/null
+++ b/unit/sdp-xml/alternate.xml
@@ -0,0 +1,12 @@
+<?xml version="1.0" encoding="UTF-8" ?>
+<record>
+	<attribute id="0x0004">
+		<alternate>
+			<uint32 value="0x11223344" />
+			<text value="alternate-member" />
+			<sequence>
+				<uint16 value="0x0100" />
+			</sequence>
+		</alternate>
+	</attribute>
+</record>
diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
index 72e01f5f5806..069b064b7ae8 100644
--- a/unit/test-sdp-xml.c
+++ b/unit/test-sdp-xml.c
@@ -127,6 +127,7 @@ static struct test_data file_tests[] = {
 	DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE),
 	/* From https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc */
 	DEFINE_TEST("duplicate-attribute.xml", TRUE),
+	DEFINE_TEST("alternate.xml", TRUE),
 };
 
 int main(int argc, char *argv[])
-- 
2.54.0

