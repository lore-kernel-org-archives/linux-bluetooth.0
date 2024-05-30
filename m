Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB84517D881
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 May 2024 15:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717081263; cv=none; b=VeydX1Aa24adh+iZvRp3H4/MuclRuzWhF2JgqAQPmYrPviEdeLZhqlCZDwP72F8YLIS08Ot76/8WArcQFTJ45Gdgqu3H7CnXkEYary29ZVB2QaF0P+adsimC/2hq6nQtkRSsWUFYqo8PCnGZxGYHQ4u/61/IsYa5sFK3WXZ+/Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717081263; c=relaxed/simple;
	bh=0Ir4+Cm2Qgu/7c90GLMzOafurRrJ9DGDxA3byKKmbN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2VJhzDO5zJ2FYZPglpvFprcK3bjNSuXLg2SLsvFNoVDxAY2xKmAbSyzCYcPulAVLDM0ycSyT6hxyBhqCwKv8dYTjwJ5fJvlN+yxNAQ2e/PFTUBDI5cxN72U81/EAuR6DFdl9EJF6X2vnGN+EGzwqUEaiLkL7cEPOWUTF1kDCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44C0320018;
	Thu, 30 May 2024 15:01:00 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 9/9] avdtp: Fix manipulating struct as an array
Date: Thu, 30 May 2024 16:58:03 +0200
Message-ID: <20240530150057.444585-10-hadess@hadess.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240530150057.444585-1-hadess@hadess.net>
References: <20240530150057.444585-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Don't manipulate the "req" structs as if they were flat arrays, static
analysis and humans are both equally confused by this kind of usage.

Error: ARRAY_VS_SINGLETON (CWE-119): [#def26] [important]
bluez-5.76/profiles/audio/avdtp.c:1675:2: address_of: Taking address with "&start->first_seid" yields a singleton pointer.
bluez-5.76/profiles/audio/avdtp.c:1675:2: assign: Assigning: "seid" = "&start->first_seid".
bluez-5.76/profiles/audio/avdtp.c:1679:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1677|           int i;
1678|
1679|->         for (i = 0; i < count; i++, seid++) {
1680|                   if (seid->seid == id) {
1681|                           req->collided = TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def27] [important]
bluez-5.76/profiles/audio/avdtp.c:1690:2: address_of: Taking address with "&suspend->first_seid" yields a singleton pointer.
bluez-5.76/profiles/audio/avdtp.c:1690:2: assign: Assigning: "seid" = "&suspend->first_seid".
bluez-5.76/profiles/audio/avdtp.c:1694:25: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1692|		int i;
1693|
1694|->		for (i = 0; i < count; i++, seid++) {
1695|			if (seid->seid == id) {
1696|				req->collided = TRUE;

Error: ARRAY_VS_SINGLETON (CWE-119): [#def28] [important]
bluez-5.76/profiles/audio/avdtp.c:1799:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer.
bluez-5.76/profiles/audio/avdtp.c:1799:2: assign: Assigning: "seid" = "&req->first_seid".
bluez-5.76/profiles/audio/avdtp.c:1801:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1799|		seid = &req->first_seid;
1800|
1801|->		for (i = 0; i < seid_count; i++, seid++) {
1802|			failed_seid = seid->seid;
1803|

Error: ARRAY_VS_SINGLETON (CWE-119): [#def29] [important]
bluez-5.76/profiles/audio/avdtp.c:1912:2: address_of: Taking address with "&req->first_seid" yields a singleton pointer.
bluez-5.76/profiles/audio/avdtp.c:1912:2: assign: Assigning: "seid" = "&req->first_seid".
bluez-5.76/profiles/audio/avdtp.c:1914:30: ptr_arith: Using "seid" as an array.  This might corrupt or misinterpret adjacent memory locations.
1912|		seid = &req->first_seid;
1913|
1914|->	for (i = 0; i < seid_count; i++, seid++) {
1915|			failed_seid = seid->seid;
1916|
---
 profiles/audio/avdtp.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 3667e08400dd..38c1870e619d 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -429,6 +429,20 @@ static void avdtp_sep_set_state(struct avdtp *session,
 				struct avdtp_local_sep *sep,
 				avdtp_state_t state);
 
+#define REQ_GET_NTH_SEID(x)						\
+	static struct seid *						\
+	x##_req_get_nth_seid(struct x##_req *req, int count, int i)	\
+	{								\
+		if (count == 0 || i >= count)				\
+			return NULL;					\
+		if (i == 1)						\
+			return &req->first_seid;			\
+		return &req->other_seids[i];				\
+	}
+
+REQ_GET_NTH_SEID(start)
+REQ_GET_NTH_SEID(suspend)
+
 static const char *avdtp_statestr(avdtp_state_t state)
 {
 	switch (state) {
@@ -1672,11 +1686,11 @@ static void check_seid_collision(struct pending_req *req, uint8_t id)
 static void check_start_collision(struct pending_req *req, uint8_t id)
 {
 	struct start_req *start = req->data;
-	struct seid *seid = &start->first_seid;
 	int count = 1 + req->data_size - sizeof(struct start_req);
 	int i;
 
-	for (i = 0; i < count; i++, seid++) {
+	for (i = 0; i < count; i++) {
+		struct seid *seid = start_req_get_nth_seid(start, count, i);
 		if (seid->seid == id) {
 			req->collided = TRUE;
 			return;
@@ -1687,11 +1701,11 @@ static void check_start_collision(struct pending_req *req, uint8_t id)
 static void check_suspend_collision(struct pending_req *req, uint8_t id)
 {
 	struct suspend_req *suspend = req->data;
-	struct seid *seid = &suspend->first_seid;
 	int count = 1 + req->data_size - sizeof(struct suspend_req);
 	int i;
 
-	for (i = 0; i < count; i++, seid++) {
+	for (i = 0; i < count; i++) {
+		struct seid *seid = suspend_req_get_nth_seid(suspend, count, i);
 		if (seid->seid == id) {
 			req->collided = TRUE;
 			return;
@@ -1785,7 +1799,6 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
 	struct stream_rej rej;
-	struct seid *seid;
 	uint8_t err, failed_seid;
 	int seid_count, i;
 
@@ -1796,9 +1809,9 @@ static gboolean avdtp_start_cmd(struct avdtp *session, uint8_t transaction,
 
 	seid_count = 1 + size - sizeof(struct start_req);
 
-	seid = &req->first_seid;
+	for (i = 0; i < seid_count; i++) {
+		struct seid *seid = start_req_get_nth_seid(req, seid_count, i);
 
-	for (i = 0; i < seid_count; i++, seid++) {
 		failed_seid = seid->seid;
 
 		sep = find_local_sep_by_seid(session, seid->seid);
@@ -1898,7 +1911,6 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 	struct avdtp_local_sep *sep;
 	struct avdtp_stream *stream;
 	struct stream_rej rej;
-	struct seid *seid;
 	uint8_t err, failed_seid;
 	int seid_count, i;
 
@@ -1909,9 +1921,8 @@ static gboolean avdtp_suspend_cmd(struct avdtp *session, uint8_t transaction,
 
 	seid_count = 1 + size - sizeof(struct suspend_req);
 
-	seid = &req->first_seid;
-
-	for (i = 0; i < seid_count; i++, seid++) {
+	for (i = 0; i < seid_count; i++) {
+		struct seid *seid = suspend_req_get_nth_seid(req, seid_count, i);
 		failed_seid = seid->seid;
 
 		sep = find_local_sep_by_seid(session, seid->seid);
-- 
2.45.1

