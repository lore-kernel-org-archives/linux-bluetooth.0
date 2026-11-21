Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240418;
	b=U5jLhJ3Izv3/YHdThkIxIB/6bgJ/LSYnqcyQ1sxjHSxalqXrl8CuqNh0i7aYoH5dXMzt
	 eywReC6ogs2sANwdpBqClbtaYJklhxGEz5hC1nr7r5hOcTrZe2g7TM0Ed9Z7ySzV+kjxu
	 a3GjHBHVnt1Nz+qfHgts/0/cKPAC0iW2KRwaiBB0pGeCAPp0zo31zJMkiaSdrwJ5h7GhP
	 nKmLhvD40cpXlivrNV3XEEv2Zh9ZaUzz6+geilVI5TvroQP3jg/tBPOI7CABYuzgHjtKU
	 KZKHsFxsRqaZAaJgpPownN3RZvCjs3iBhXOc2QF9TmQneByZ11Dpf6lqoeMyfS4tNkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240418;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wXUdJVY/blqhPHNteX3V4hqIsASn0BkUCQ/3SiABWrM=;
	b=xPw7GzNKGKcNul2UuiZH3M4+UhZ6CWxxn6B5z/A5V9qeSpYygOvDsYCoDBopKBqOXraL
	 6G5mIpfPLCbpOzlsuxRdXLz1qRa0HwcjLbCm7Yek65U4Q31FMGcWJq493t9Vet4OZy+mk
	 3PSMKbR6dnmD8iBCGVM1gkggm2VtcMHfb+HQXDnRmUwDpphpufclFyDRapjE7ydTQArap
	 M6Zr5GUUYJddM49Ywn7jWB8mBcM67Mfvjn2H8cDO3mHTQdue4l/nIMecO3gf5DH10yE4q
	 9frOxyYvFPNfNQtiruTnRD2ntrG5u0BP7OsyGHUmanjgvtQWz4dF6fhj4+zFONWIVog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+nGTSxn;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B3E606A331
	for <linux-bluetooth@vger.kernel.org>; Sat, 21 Nov 2026 05:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90B3E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+nGTSxn
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-53639b8903bso20409711cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2026 21:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240413; x=1795845213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXUdJVY/blqhPHNteX3V4hqIsASn0BkUCQ/3SiABWrM=;
        b=y+nGTSxn3Kxkmu2Q49Zwe34nKjNxnBq70yQ38a6UeSteB3YQy3OwTyBJtNygRjz9AE
         WjaGoDy3GPixULAtY97KUvW9j7OdYSqnquA1Ai7/ueGnN4JdVcTdJNuNM8yO10RBvXWW
         hs958lnjFbIAT8yYITPk4fsr9BkWNuKOW+Afib4GVK8n9yR2nxl4fkYwscPJJoc1RrYP
         Z7YO/mfmqW0JmYWau0fA7Kateu6tbLnlfKPCm5HuFNnVf+rbDRE+ESZAqD+DwnPMZvZk
         YbR/3aJ5HVvUVpHO2CqtM/4z23GA3I3RBzmWdqv/GehF4xJXj8Kq0EYxxF45Knnt9DgR
         W31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240413; x=1795845213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXUdJVY/blqhPHNteX3V4hqIsASn0BkUCQ/3SiABWrM=;
        b=PAQ5xBt8gM4ocsRJ0x53GB40M1wi6xOuq4MXVPBYKBO2qdU2J4zL0arC0zs5ImiHXV
         msx9TO20MjyxauL9GVjQ2ONVFyoqbYbtDnIIlIWyzm12hjDR4CGBktQKqfyP8hxmbxZW
         RbATu48zsaIuIVWO34JSViG7buMp2T1wgBbUzTKwd4Jf1xVHpYEq2gGckJuPXux+YoYB
         lza43W6e5j5uCnlRp1HTkYt41sEsvi5PCtcUJ56gtMnlcNYDOPqk7uLtZrxk/voq7VJE
         p4y6k70sMVFrC620KWculbz3l8KRGQyC3CKebnJIGOJqpUrG+gK35IjEogeHHIgC4ClU
         IYUg==
X-Gm-Message-State: APuU4Z+ybCtxEkYUSD8cxQKF+NUFKLLw7MGpvwsrV5U7SeO3MkgXw/Kp
	aE7fxLdrd1FJkb4hMEkvsecjGskqQf3PWfwQzJ2NbG3AhXsKHw29B4INv4gVVwem
X-Gm-Gg: AZFdTZeiNv/1DHKWUocN0qWNiVtBdbnx2o/K+TZTLSLe3nUwOLAtIw1zZgblRzU1Oxe
	TIgD9PZGZaRRcHCG3PRRhWsW5TILrMN/diuOSRheipAOdnY7oj+3iWJbrD0V1Gz1fDmN5XINYUj
	s+Yd2WHA8vhGk6vAInmgjrgraWn462ubbOuavhoQDi8kGV4M17h4wGdvq6jKf2YJCz/Ql6SQq0G
	suMFnvU5OV2zgvFPCMW6tPyPx7+P9qB9T91/k4V2Y6SbcRj3v+RCBk0AX0ctcR1YRxYuZzfnjaL
	OIByxnCzfg4GRvGeG3ojbLhPRYFCGYAMlpIUzJNc7fciVGk8nSYv1iuApY+SVzOIA8cu4Neoul/
	X90MWeONwuSqtIl0oEyFS8tKFCSA4pO0inmAKNa+KAydxsBTx7Zbiw00MlPdowGGZDzA45hkH0U
	k9dwqwUtJ3hmh93BKLhNNWxZbo11TzXlsib7voL2sgFoHx/ofIIO9WqQE1/Hu0ycGw2vAAf2uxy
	22RNwmT3F1BKsm+/mUUlzj+4hw7A5ds/nj8Ml3BSAZuoctQsZ7zp/dTceiZLhpk9aL0wZ+0ydZd
	wWDmDRQpH0BHCKE1cIFWkpRAJ2NMauF76T6gHozWRz7UGh5kiBuQdxHqFqDNhu574SQaX5S+uoE
	o7ZVJ0+cBaI7Xgmzu6OLxdNglra9v2fRN8+EKcYKtBJA=
X-Received: by 2002:ac8:5fcf:0:b0:55c:6ef2:7103 with SMTP id d75a77b69052e-55d76a88271mr88121761cf.39.1795240413209;
        Fri, 20 Nov 2026 21:53:33 -0800 (PST)
Received: from fishcake-omen-transcend.uwaterloo.ca (wn-res-nat-129-97-125-157.dynamic.uwaterloo.ca. [129.97.125.157])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788506b0sm41259421cf.17.2026.11.20.21.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:53:32 -0800 (PST)
From: Muxian Li <muxianli5401@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Muxian Li <muxianli5401@gmail.com>
Subject: [PATCH BlueZ v2 1/2] device: Fix SDP records without a record handle
Date: Sat, 21 Nov 2026 00:51:56 -0500
Message-ID: <20261121055157.131496-1-muxianli5401@gmail.com>
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

Tell such records apart by the missing attribute rather than by the
placeholder, which is also a valid handle, and compare them by content,
so copies returned by the different searches are still merged while
distinct records are kept.

Cache each of them under a key that nothing else is stored under,
chosen from 0xffffffff downwards. A record keeps its key as long as it
does not change, also when the device returns its records in another
order or leaves some out, and is moved to another key when a record
with that handle is found.

As for records with a handle, cached records are not removed when a
later discovery no longer returns them. Without a handle a changed
record can not be told from a new one, so it is cached next to the
version it replaces.

Fixes: 8b2e688eaf5b ("Check for duplicate record handles and not UUIDs")
Assisted-by: Claude:claude-mythos-5-2
---
v2:
- Records without handle keep their cache key from one discovery to
  the next, instead of being numbered in the order they were found
  (reported by Copilot review).
- Their key no longer takes the place of a record with that handle
  (reported by Copilot review).
- A record with the handle 0xffffffff is handled as any record with a
  handle.
- Records are no longer encoded again for every comparison.
- Link to v1: https://lore.kernel.org/linux-bluetooth/20261115070055.45999-1-muxianli5401@gmail.com/

 doc/settings-storage.txt |   5 +-
 src/device.c             | 202 +++++++++++++++++++++++++++++++++------
 2 files changed, 178 insertions(+), 29 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 8bd677e24..0caf3305e 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -187,7 +187,10 @@ Each file, named by remote device address, may includes multiple groups
 (General, ServiceRecords, Attributes, Endpoints, NameResolving).
 
 In ServiceRecords, SDP records are stored using their handle as key
-(hexadecimal format).
+(hexadecimal format). Records without a ServiceRecordHandle attribute are
+stored under a key that nothing else is stored under, chosen from 0xFFFFFFFF
+downwards. Such a record keeps its key as long as it does not change, and is
+moved to another key when a record with that handle is found.
 
 In "Attributes" group GATT database is stored using attribute handle as key
 (hexadecimal format). Value associated with this handle is serialized form of
diff --git a/src/device.c b/src/device.c
index 36a980d1e..d4d5f9d16 100644
--- a/src/device.c
+++ b/src/device.c
@@ -126,6 +126,9 @@ struct browse_req {
 	GSList *match_uuids;
 	GSList *profiles_added;
 	sdp_list_t *records;
+	GTree *handles;
+	GTree *pdus;
+	uint32_t keys_tried;
 	int search_uuid;
 	int reconnect_attempt;
 	guint listener_id;
@@ -797,6 +800,10 @@ static void browse_request_free(struct browse_req *req)
 	g_slist_free_full(req->profiles_added, g_free);
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
+	if (req->handles)
+		g_tree_destroy(req->handles);
+	if (req->pdus)
+		g_tree_destroy(req->pdus);
 
 	g_free(req);
 }
@@ -5948,29 +5955,144 @@ add_uuids:
 	device_add_uuids(device, uuids);
 }
 
-static void store_sdp_record(GKeyFile *key_file, sdp_record_t *rec)
+/*
+ * Some devices (e.g. the Nintendo Switch 2) omit the ServiceRecordHandle
+ * attribute from their Service Search Attribute responses. rec->handle of
+ * such a record is the placeholder set by sdp_record_alloc(), which is also
+ * a valid handle, so check for the attribute itself.
+ */
+static bool record_has_handle(const sdp_record_t *rec)
+{
+	return sdp_data_get(rec, SDP_ATTR_RECORD_HANDLE) != NULL;
+}
+
+static char *record_to_string(const sdp_record_t *rec)
 {
-	char handle_str[11];
 	sdp_buf_t buf;
-	int size, i;
+	uint32_t i;
 	char *str;
 
-	sprintf(handle_str, "0x%8.8X", rec->handle);
-
 	if (sdp_gen_record_pdu(rec, &buf) < 0)
-		return;
-
-	size = buf.data_size;
+		return NULL;
 
-	str = g_malloc0(size*2+1);
+	str = g_malloc0(buf.data_size * 2 + 1);
 
-	for (i = 0; i < size; i++)
+	for (i = 0; i < buf.data_size; i++)
 		sprintf(str + (i * 2), "%02X", buf.data[i]);
 
-	g_key_file_set_string(key_file, "ServiceRecords", handle_str, str);
-
 	free(buf.data);
-	g_free(str);
+
+	return str;
+}
+
+static bool string_is_record_without_handle(const char *str)
+{
+	sdp_record_t *rec;
+	bool ret;
+
+	rec = record_from_string(str);
+	if (!rec)
+		return false;
+
+	ret = rec->attrlist && !record_has_handle(rec);
+
+	sdp_record_free(rec);
+
+	return ret;
+}
+
+static int record_string_cmp(gconstpointer a, gconstpointer b, gpointer data)
+{
+	return strcmp(a, b);
+}
+
+static int record_handle_cmp(gconstpointer a, gconstpointer b)
+{
+	uint32_t h1 = GPOINTER_TO_UINT(a);
+	uint32_t h2 = GPOINTER_TO_UINT(b);
+
+	if (h1 == h2)
+		return 0;
+
+	return h1 < h2 ? -1 : 1;
+}
+
+/* Value to key of the cached records, to find the key of a known record */
+static GTree *load_sdp_record_keys(GKeyFile *key_file)
+{
+	GTree *keys;
+	char **names, **name;
+
+	keys = g_tree_new_full(record_string_cmp, NULL, g_free, g_free);
+
+	names = g_key_file_get_keys(key_file, "ServiceRecords", NULL, NULL);
+
+	for (name = names; name && *name; name++) {
+		char *str;
+
+		str = g_key_file_get_string(key_file, "ServiceRecords", *name,
+									NULL);
+		if (!str)
+			continue;
+
+		if (g_tree_lookup(keys, str))
+			g_free(str);
+		else
+			g_tree_insert(keys, str, g_strdup(*name));
+	}
+
+	g_strfreev(names);
+
+	return keys;
+}
+
+/* Next key, from 0xffffffff downwards, that nothing is stored under */
+static void unused_sdp_record_key(struct browse_req *req, GKeyFile *key_file,
+								char *key)
+{
+	do {
+		sprintf(key, "0x%8.8X", 0xffffffff - req->keys_tried++);
+	} while (g_key_file_has_key(key_file, "ServiceRecords", key, NULL));
+}
+
+/*
+ * A record is stored using its handle as key. A record without handle is
+ * stored under a key that nothing else uses, and keeps it as long as it
+ * does not change: there is nothing else to tell that it is the same
+ * record. It makes way for a record that has its key as handle.
+ */
+static void store_sdp_record(struct browse_req *req, GKeyFile *key_file,
+					GTree *keys, sdp_record_t *rec,
+					const char *str)
+{
+	char key[11];
+
+	if (record_has_handle(rec)) {
+		char *old;
+
+		sprintf(key, "0x%8.8X", rec->handle);
+
+		old = g_key_file_get_string(key_file, "ServiceRecords", key,
+									NULL);
+		if (old && string_is_record_without_handle(old)) {
+			char new_key[11];
+
+			unused_sdp_record_key(req, key_file, new_key);
+			g_key_file_set_string(key_file, "ServiceRecords",
+							new_key, old);
+			g_tree_replace(keys, old, g_strdup(new_key));
+		} else {
+			g_free(old);
+		}
+	} else {
+		if (g_tree_lookup(keys, str))
+			return;
+
+		unused_sdp_record_key(req, key_file, key);
+		g_tree_insert(keys, g_strdup(str), g_strdup(key));
+	}
+
+	g_key_file_set_string(key_file, "ServiceRecords", key, str);
 }
 
 static void store_primaries_from_sdp_record(GKeyFile *key_file,
@@ -6020,22 +6142,36 @@ done:
 	free(att_uuid);
 }
 
-static int rec_cmp(const void *a, const void *b)
-{
-	const sdp_record_t *r1 = a;
-	const sdp_record_t *r2 = b;
-
-	return r1->handle - r2->handle;
-}
-
 static int update_record(struct browse_req *req, const char *uuid,
-							sdp_record_t *rec)
+					sdp_record_t *rec, const char *str)
 {
 	GSList *l;
 
-	/* Check for duplicates */
-	if (sdp_list_find(req->records, rec, rec_cmp))
-		return -EALREADY;
+	/*
+	 * Check for duplicates. Records without handle are compared by
+	 * content: copies of one record returned by different searches are
+	 * identical, different records are not.
+	 */
+	if (record_has_handle(rec)) {
+		gpointer handle = GUINT_TO_POINTER(rec->handle);
+
+		if (!req->handles)
+			req->handles = g_tree_new(record_handle_cmp);
+
+		if (g_tree_lookup_extended(req->handles, handle, NULL, NULL))
+			return -EALREADY;
+
+		g_tree_insert(req->handles, handle, NULL);
+	} else {
+		if (!req->pdus)
+			req->pdus = g_tree_new_full(record_string_cmp, NULL,
+								g_free, NULL);
+
+		if (g_tree_lookup_extended(req->pdus, str, NULL, NULL))
+			return -EALREADY;
+
+		g_tree_insert(req->pdus, g_strdup(str), NULL);
+	}
 
 	/* Copy record */
 	req->records = sdp_list_append(req->records, sdp_copy_record(rec));
@@ -6063,6 +6199,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	char att_file[PATH_MAX];
 	GKeyFile *sdp_key_file;
 	GKeyFile *att_key_file;
+	GTree *sdp_keys = NULL;
 	GError *gerr = NULL;
 
 	char *data;
@@ -6081,7 +6218,8 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 		g_clear_error(&gerr);
 		g_key_file_free(sdp_key_file);
 		sdp_key_file = NULL;
-	}
+	} else
+		sdp_keys = load_sdp_record_keys(sdp_key_file);
 
 	create_filename(att_file, PATH_MAX, "/%s/%s/attributes", srcaddr,
 							dstaddr);
@@ -6099,6 +6237,7 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 	for (seq = recs; seq; seq = seq->next) {
 		sdp_record_t *rec = (sdp_record_t *) seq->data;
 		char *profile_uuid;
+		char *str;
 
 		if (!rec)
 			break;
@@ -6132,16 +6271,22 @@ static void update_bredr_services(struct browse_req *req, sdp_list_t *recs)
 							product, version);
 		}
 
-		if (update_record(req, profile_uuid, rec) < 0)
+		str = record_to_string(rec);
+		if (!str)
+			goto next;
+
+		if (update_record(req, profile_uuid, rec, str) < 0)
 			goto next;
 
 		if (sdp_key_file)
-			store_sdp_record(sdp_key_file, rec);
+			store_sdp_record(req, sdp_key_file, sdp_keys, rec,
+									str);
 
 		if (att_key_file)
 			store_primaries_from_sdp_record(att_key_file, rec);
 
 next:
+		g_free(str);
 		free(profile_uuid);
 	}
 
@@ -6158,6 +6303,7 @@ next:
 
 		g_free(data);
 		g_key_file_free(sdp_key_file);
+		g_tree_destroy(sdp_keys);
 	}
 
 	if (att_key_file) {

base-commit: 20ffd285b58facfd1f2478d159a5f941b09d5be1
-- 
2.53.0

