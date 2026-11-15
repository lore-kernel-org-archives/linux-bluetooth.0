Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726589;
	b=jdyhhshFz8eEAKa8AlOqBf7m2Z60fM7NAibtQgB+rk6/x7ruejRd5nWYkzo6eEViHWbH
	 gh5zOTvEkxoJOSBi1BGMGN4Ah7oPQlsKuOv4mPlWy6A2ByVqVhnM0MuA36Ub+jcT7TKwz
	 WgB8QD92uhoHU5Vc+/x26juDtfSU3sy3XPYsOvlvZvVIHL3748pQzvMx60BN4Eev3Rv6m
	 nSZueZyJUwCFXOOfEJU8dxFuGlV8cZ2or6pj46VUus6EOSfM8NyT1vhHi8GB7V6stTXBN
	 3dwfqgyD85LoCHdOqugsrclkU77MvssxMi8kiwLSaFZVQltN4pl6GmSqwuxrLVf/YNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ssSyrrbdcdoCXfADw8of9AOPU1EY7r5ssdcoiWTmGrI=;
	b=hteZm0RBpM8j2v29t5YxOyhvx2putRejMog0yeRfzR4clDDQjfZnCoc+iForyJ6mVrqG
	 XqaEOytlQ+OQNkS9Qv4PqJrFnnBaQryCP18YAbDlLwPwmirLGBFytlNoSo8WzEAheOBNp
	 8BYl8VU7fo6H7x9e6IUPH29PYu5yR8WTbDCuMf3DYwQ0XTBZcNL0+bLbn2cD9vXbMCONE
	 OCW05Qu4VLZWSqZJ2mOHfzBfFJQ4YY+lMlW9DG0Lc//BWgmFdSp6s2jAKnm/srX7Ty5ZD
	 5somg7xMzLnTfcfA/rgh7XWJUFd/WGLt8x1XsqeLspjDrjKZbVrQcWk9GbB9/562sRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1jJbxmW;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D571D606A323
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 07:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D571D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K1jJbxmW
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7d2ee9e7093so572754137.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726588; x=1795331388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ssSyrrbdcdoCXfADw8of9AOPU1EY7r5ssdcoiWTmGrI=;
        b=K1jJbxmWYG/Z/RmV1vfC5+Wp++s68dx+Koz5mE4lm96lhaMXizGssBOH3afUUel7Fj
         oZJzNLdIj0UL5TV0ls/d8UhnH62lWok+Mger7Tvy8OfkUc0dUkcYC/ZemP9gsip5oUeu
         i8F+WNhTpIgomWADwJsJDL5gQNaYBxCLRBw1WTNL6ctAlW89c3emyFJQ3rCVNj+s2qcZ
         HMxczT3ogeFfF4HkU7sla5cPl9HYoPirFfGVzQyXIO4U+Ji673HAasa0i1d+E53ac//9
         FADU0NyrSooqERt1pHpAF8uGCxhgV+AmnJkgQI/cLTpZKV7hKDhgW6o19Gd38WgQa76Q
         POEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726588; x=1795331388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssSyrrbdcdoCXfADw8of9AOPU1EY7r5ssdcoiWTmGrI=;
        b=jZH1rQ7X9ds8bIiOqWiGGskIpLsVJQD8wkkPQ93ffvAsqYkRX2M+vDuFq4aMqymFr5
         ds5pyOfD7pre2y1nqyQnEswaP4BV5Dj2sfBtyRPSbgC6DOXtvP5DbKAq+X7PTeZdm7nr
         HCYwi3crHPEG9cDJjzg5sSbENNFAYC+dNwrRGKWCesvCB/QK3wYLaDoHtsYfoPLPGjzu
         Jb0XmR+kzhzIcTv1CqX+3ANBHAePaZppTXIEKbt09tIn8ogwD4oT1hB8DsSsOi8Sohw6
         TZAKh5A6Qn3GsiIaqWwofx6TTg1qzY1sVe6xJ8ieouxqdy6O3oJYtGLD1fIGWT66s075
         0faQ==
X-Gm-Message-State: APuU4Z+SK7sMXt46R6Pg2qKIqsD6LMeCCxyHc2IVHRwHL91d7Eo1lGQg
	85LfuyT9cKbc0kbvmge1NeUNWe8nfJIEkFJa+VC7Jp1u+Vl/KCyTdcjAzRxbVV/f
X-Gm-Gg: AYBFou0HNJf2xnVeScVU55i89+X7IYmeBCcHQW/dTGkTG8mUtopktGGhnxzm/VfXk8j
	nM4bFXaBg0d88iCNaCYpmE08dUKfcvBX184AID7KHUWI8lSrbxCJBCn1gzOovJ9fSwwNb7FSoGw
	B8uD+QWEyZCwzymVBb9i9DU4RCMZ2ZVQkHIEcYv5SgH+5oUpSX4yI5KpRN/aXgrYVEzAaMS8y43
	rIsdKvgpsRPep0LCdPjnK2YPZ3vQdQCCAgoioVhZ2ngABFBv/DAEKh9+0Iu2tKp65lKGBs0ha76
	NofnplUzBDj72xkIIJspSAZtYxTltdoPk38xHMB/61HBkjEa1rUXUkeqtc7EdEOaBWhK52eRWI/
	UlqJiIj2aUcmuoK73AJJFPWf9mEjRQiqdJ9wmy65D0Em41piEiDFYXpE4Qe6l7MNl9iXkfyGw14
	2lXeWqQM0zaBTIdHXf8t0xuC8S+8IlIGcJwCJH8gXnYIqZf4xOSTMwjP2YnEIKVmn41AFfIeq3c
	Ptg1HwOysPTNMttd4aYEoMtKkJ4hFdHojRTUFKS1dVdXfsMFckxh0WHvLOlbeHCL9QKqme6vlKE
	tlWA9WUHiF3zZrNu4V3Y9wclcSgMZqOwvsQEXJifkHNOEojU9f5sN5vQr3bnn8hxXfyz68UJRJO
	WxEQNrmSWY5XRqSHG4OzsXZMzUESz2IP3B4oOL20V
X-Received: by 2002:a05:6102:5128:b0:7d0:6db8:dc3d with SMTP id ada2fe7eead31-7d64d425102mr2134405137.5.1794726587489;
        Sat, 14 Nov 2026 23:09:47 -0800 (PST)
Received: from fishcake-omen-transcend.uwaterloo.ca (wn-res-nat-129-97-125-18.dynamic.uwaterloo.ca. [129.97.125.18])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c4b47aesm4580080137.7.2026.11.14.23.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:09:46 -0800 (PST)
From: Muxian Li <muxianli5401@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Muxian Li <muxianli5401@gmail.com>
Subject: [PATCH BlueZ 1/2] device: Fix SDP records without a record handle
Date: Sun, 15 Nov 2026 02:00:54 -0500
Message-ID: <20261115070055.45999-1-muxianli5401@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Devices that leave the ServiceRecordHandle attribute out of their
Service Search Attribute responses, such as the Nintendo Switch 2,
produce records that all carry the 0xffffffff placeholder handle.
update_record() then drops every record but the first as a duplicate,
so e.g. the AVRCP Controller record of the Switch 2 is lost and
absolute volume is rejected.

Compare such records by content instead, so copies returned by the
different searches are still merged while distinct records are kept,
and cache them under distinct keys, where they would otherwise
overwrite each other. As for records with a handle, cached entries are
not removed when a later browse returns fewer records.

Fixes: 8b2e688eaf5b ("Check for duplicate record handles and not UUIDs")
Assisted-by: Claude:claude-opus-5-5
---

Notes:
    Tested with a Nintendo Switch 2 as A2DP source on BlueZ 5.85 with the
    rec_cmp() change backported: its volume keys work, while without it
    bluetoothd rejects SetAbsoluteVolume. The new functional test fails
    without this patch and passes with it, also with AddressSanitizer and
    UBSan.

 doc/settings-storage.txt |  3 +-
 src/device.c             | 68 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 66 insertions(+), 5 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 8bd677e24..2b075725d 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -187,7 +187,8 @@ Each file, named by remote device address, may includes multiple groups
 (General, ServiceRecords, Attributes, Endpoints, NameResolving).
 
 In ServiceRecords, SDP records are stored using their handle as key
-(hexadecimal format).
+(hexadecimal format). Records without a ServiceRecordHandle attribute are
+stored as 0xFFFFFFFF, 0xFFFFFFFE, ... in the order they were found.
 
 In "Attributes" group GATT database is stored using attribute handle as key
 (hexadecimal format). Value associated with this handle is serialized form of
diff --git a/src/device.c b/src/device.c
index 36a980d1e..a042f6267 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5948,14 +5948,15 @@ add_uuids:
 	device_add_uuids(device, uuids);
 }
 
-static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
+static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec,
+							uint32_t handle)
 {
 	char handle_str[11];
 	sdp_buf_t buf;
 	int size, i;
 	char *str;
 
-	sprintf(handle_str, "0x%8.8X", rec->handle);
+	sprintf(handle_str, "0x%8.8X", handle);
 
 	if (sdp_gen_record_pdu(rec, &buf) < 0)
 		return;
@@ -6024,8 +6025,41 @@ static int rec_cmp(const void *a, const void *b)
 {
 	const sdp_record_t *r1 = a;
 	const sdp_record_t *r2 = b;
+	sdp_buf_t pdu1, pdu2;
+	int ret;
 
-	return r1->handle - r2->handle;
+	if (r1->handle != r2->handle)
+		return r1->handle - r2->handle;
+
+	/*
+	 * Some devices (e.g. the Nintendo Switch 2) omit the
+	 * ServiceRecordHandle attribute from their Service Search Attribute
+	 * responses, so all of their records keep the 0xffffffff placeholder
+	 * set by sdp_record_alloc(). Comparing handles alone would treat every
+	 * such record as a duplicate of the first one, so compare their
+	 * contents instead: copies of one record returned by different
+	 * searches are identical, different records are not.
+	 */
+	if (r1->handle != 0xffffffff)
+		return 0;
+
+	if (sdp_gen_record_pdu(r1, &pdu1) < 0)
+		return -1;
+
+	if (sdp_gen_record_pdu(r2, &pdu2) < 0) {
+		free(pdu1.data);
+		return -1;
+	}
+
+	if (pdu1.data_size != pdu2.data_size)
+		ret = pdu1.data_size < pdu2.data_size ? -1 : 1;
+	else
+		ret = memcmp(pdu1.data, pdu2.data, pdu1.data_size);
+
+	free(pdu1.data);
+	free(pdu2.data);
+
+	return ret;
 }
 
 static int update_record(struct browse_req *req, const char *uuid,
@@ -6054,6 +6088,31 @@ static int update_record(struct browse_req *req, const char *uuid,
 	return 0;
 }
 
+/*
+ * Records without a ServiceRecordHandle all keep the 0xffffffff placeholder,
+ * so store them as 0xffffffff, 0xfffffffe, ... in the order they were found
+ * instead of under the same key.
+ */
+static uint32_t record_storage_handle(struct browse_req *req,
+						const sdp_record_t *rec)
+{
+	uint32_t handle = 0xffffffff;
+	sdp_list_t *l;
+
+	if (rec->handle != 0xffffffff)
+		return rec->handle;
+
+	/* The last entry is the copy of rec added by update_record() */
+	for (l = req->records; l && l->next; l = l->next) {
+		const sdp_record_t *r = l->data;
+
+		if (r->handle == 0xffffffff)
+			handle--;
+	}
+
+	return handle;
+}
+
 static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 {
 	struct btd_device *device = req->device;
@@ -6136,7 +6195,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 			goto next;
 
 		if (sdp_key_file)
-			store_sdp_record(sdp_key_file, rec);
+			store_sdp_record(sdp_key_file, rec,
+					record_storage_handle(req, rec));
 
 		if (att_key_file)
 			store_primaries_from_sdp_record(att_key_file, rec);

base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.53.0

