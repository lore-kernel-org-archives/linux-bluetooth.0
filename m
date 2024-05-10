Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618001635DC
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332706; cv=none; b=Qo2YgNrU6UR0a39RXCKlHqtbOE9ZrpqXd7S3U8h9E8MPobzAW0GEypdBrcby3Ak8N9tLej2LlHTWjQRfgufyj6y4HVcYh/yOdVGZwUxiVQbtxv2PhizVq86Tz90ouINee1tryeDONTph4yNs1yRg63XWF2qPU1uJXHjTVj50Qrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332706; c=relaxed/simple;
	bh=LzkVIViMWIOKpornHLG/Viby6Q0GIaFx/oJcwTC9KMw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqNEcauKPdKGAVv61KNdtHurUF3Djz7D8SSNfGsOG6zLvuA5t6smI7lik35ys2xfbW40CHzhVa8OfLBoOMl+w/JT2DlkfjfJomVBwrH903xyFwcVQVWa+f1MHfFnEYJG5o7raUmGf6Ad8pNJxfdILhFnbgNLIccOJIjP18B9X5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id B835B1BF20F
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 09:18:16 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ 07/14] monitor/att: Fix memory leak
Date: Fri, 10 May 2024 11:11:05 +0200
Message-ID: <20240510091814.3172988-8-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510091814.3172988-1-hadess@hadess.net>
References: <20240510091814.3172988-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

name2utf8() returns newly allocated memory which needs to be freed.

Error: RESOURCE_LEAK (CWE-772): [#def27] [important]
bluez-5.75/monitor/att.c:2291:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2291:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2293:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2294:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2292|
2293|		print_field("  Media Player Name: %s", name);
2294|-> }
2295|
2296|   static void mp_name_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def28] [important]
bluez-5.75/monitor/att.c:2320:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2320:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2322:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2323:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2321|
2322|		print_field("  Track Title: %s", name);
2323|-> }
2324|
2325|   static void track_title_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def29] [important]
bluez-5.75/monitor/att.c:2453:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2453:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2455:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2456:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2454|
2455|		print_field("  Bearer Name: %s", name);
2456|-> }
2457|
2458|   static void bearer_name_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def30] [important]
bluez-5.75/monitor/att.c:2472:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2472:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2474:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2475:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2473|
2474|		print_field("  Bearer Uci Name: %s", name);
2475|-> }
2476|
2477|   static void print_technology_name(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def31] [important]
bluez-5.75/monitor/att.c:2541:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2541:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2543:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2544:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2542|
2543|		print_field("  Uri scheme Name: %s", name);
2544|-> }
2545|
2546|   static void bearer_uri_schemes_list_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def32] [important]
bluez-5.75/monitor/att.c:2653:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2653:2: var_assign: Assigning: "call_uri" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2655:2: noescape: Resource "call_uri" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2660:1: leaked_storage: Variable "call_uri" going out of scope leaks the storage it points to.
2658|		if (frame->size)
2659|			print_hex_field("  call_list Data", frame->data, frame->size);
2660|-> }
2661|
2662|   static void bearer_current_call_list_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def33] [important]
bluez-5.75/monitor/att.c:2741:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2741:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2743:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2748:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2746|		if (frame->size)
2747|			print_hex_field("  Data", frame->data, frame->size);
2748|-> }
2749|
2750|   static void incom_target_bearer_uri_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def34] [important]
bluez-5.75/monitor/att.c:2851:3: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:2851:3: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:2852:3: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:2871:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
2869|		if (frame->size)
2870|			print_hex_field("call_cp Data", frame->data, frame->size);
2871|-> }
2872|
2873|   static void print_call_cp_notification(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def35] [important]
bluez-5.75/monitor/att.c:3046:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:3046:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:3048:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:3053:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
3051|		if (frame->size)
3052|			print_hex_field(" Data", frame->data, frame->size);
3053|-> }
3054|
3055|   static void incoming_call_read(const struct l2cap_frame *frame)

Error: RESOURCE_LEAK (CWE-772): [#def36] [important]
bluez-5.75/monitor/att.c:3077:2: alloc_fn: Storage is returned from allocation function "name2utf8".
bluez-5.75/monitor/att.c:3077:2: var_assign: Assigning: "name" = storage returned from "name2utf8((uint8_t *)frame->data, frame->size)".
bluez-5.75/monitor/att.c:3079:2: noescape: Resource "name" is not freed or pointed-to in "printf". [Note: The source code implementation of the function has been overridden by a builtin model.]
bluez-5.75/monitor/att.c:3084:1: leaked_storage: Variable "name" going out of scope leaks the storage it points to.
3082|		if (frame->size)
3083|			print_hex_field(" Data", frame->data, frame->size);
3084|-> }
3085|
3086|   static void call_friendly_name_read(const struct l2cap_frame *frame)
---
 monitor/att.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index b3fb3ba6a0ad..a23347ef7ede 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -2291,6 +2291,8 @@ static void print_mp_name(const struct l2cap_frame *frame)
 	name = name2utf8((uint8_t *)frame->data, frame->size);
 
 	print_field("  Media Player Name: %s", name);
+
+	g_free(name);
 }
 
 static void mp_name_read(const struct l2cap_frame *frame)
@@ -2320,6 +2322,8 @@ static void print_track_title(const struct l2cap_frame *frame)
 	name = name2utf8((uint8_t *)frame->data, frame->size);
 
 	print_field("  Track Title: %s", name);
+
+	g_free(name);
 }
 
 static void track_title_read(const struct l2cap_frame *frame)
@@ -2453,6 +2457,8 @@ static void print_bearer_name(const struct l2cap_frame *frame)
 	name = name2utf8((uint8_t *)frame->data, frame->size);
 
 	print_field("  Bearer Name: %s", name);
+
+	g_free(name);
 }
 
 static void bearer_name_read(const struct l2cap_frame *frame)
@@ -2472,6 +2478,8 @@ static void bearer_uci_read(const struct l2cap_frame *frame)
 	name = name2utf8((uint8_t *)frame->data, frame->size);
 
 	print_field("  Bearer Uci Name: %s", name);
+
+	g_free(name);
 }
 
 static void print_technology_name(const struct l2cap_frame *frame)
@@ -2541,6 +2549,8 @@ static void print_uri_scheme_list(const struct l2cap_frame *frame)
 	name = name2utf8((uint8_t *)frame->data, frame->size);
 
 	print_field("  Uri scheme Name: %s", name);
+
+	g_free(name);
 }
 
 static void bearer_uri_schemes_list_read(const struct l2cap_frame *frame)
@@ -2654,6 +2664,8 @@ static void print_call_list(const struct l2cap_frame *frame)
 
 	print_field("  call_uri: %s", call_uri);
 
+	g_free(call_uri);
+
 done:
 	if (frame->size)
 		print_hex_field("  call_list Data", frame->data, frame->size);
@@ -2742,6 +2754,8 @@ static void print_target_uri(const struct l2cap_frame *frame)
 
 	print_field("  Uri: %s", name);
 
+	g_free(name);
+
 done:
 	if (frame->size)
 		print_hex_field("  Data", frame->data, frame->size);
@@ -2850,6 +2864,7 @@ static void print_call_cp(const struct l2cap_frame *frame)
 		str = "Originate";
 		name = name2utf8((uint8_t *)frame->data, frame->size);
 		print_field("  Operation: %s  Uri: %s", str, name);
+		g_free(name);
 		break;
 	case 0x05:
 		str = "Join";
@@ -3047,6 +3062,8 @@ static void print_incom_call(const struct l2cap_frame *frame)
 
 	print_field("  call_string: %s", name);
 
+	g_free(name);
+
 done:
 	if (frame->size)
 		print_hex_field(" Data", frame->data, frame->size);
@@ -3078,6 +3095,8 @@ static void print_call_friendly_name(const struct l2cap_frame *frame)
 
 	print_field("  Friendly Name: %s", name);
 
+	g_free(name);
+
 done:
 	if (frame->size)
 		print_hex_field(" Data", frame->data, frame->size);
-- 
2.44.0

