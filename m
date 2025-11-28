Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB242DAFA9
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360174; cv=pass; b=gSBJdDop2p2EJEXBcAQposPHZuOiSKf2yVABHoec+JbMElryoapY9QbSWj5x6nb4Dyk7w2oVq+jtGdvzlAxY6ekkZTQpBmHjbUhiOFMHEgS71sRMrcurWdG/Fd3uT2XJBtiWz+UIdoYaf10UrciYcRuMIYSaTAx9EPyBqT3D5yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360174; c=relaxed/simple;
	bh=OL75nNrDNd/LlLadWkxBdJyG/ErJmXbTjgtXmbM+fdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qThKHdTqLN3UH2rF0CTtE05SF/FsRkmJ6qdSQ1GrqBApFm5xAqYowdxeJjCUgJiSIS7IzJJuQQBVTZaTKrcvzH+sPp9xGE1s1B1zL9Aghv1Rj6JKBZX0lq30m13toDUiFfH9JYHsMk4tnKEgf0N1xh1NdWsZT78vwOneyHQJ1fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XejUWzTx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XejUWzTx"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ43555r4z10HW;
	Fri, 28 Nov 2025 22:02:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXm7rZRLZvSnmw2rOB5vMrkdqrRozi2igVrrIwhbSs=;
	b=XejUWzTx3LdJsyIL1RrRRRe4m1/DE0nQy2Twn1iC1KxLf0t4QeAQcwgyRs6nMBxj/fMYax
	8cp9ZItwq4M6k0J2sx5o+p0RsyIrCRXIG7ut1XoZKOvLQANGcbWRKQR26sXNcoRxtKMAZj
	ghxoAZRfcWW+HJ9Rgh5dafK3w9zB+UU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360161;
	b=fpxl+tH7zKZbLwfe6ApOsFpc7OgSaaX51SfwVo1TE7QkYlWeec102Za/OVn6d97TBtaFo7
	0CWp/ooCuc620Nc48WUFlaimOzU9InC2BfkGwFDmPr9whpvcyxcewSsuOEB0mLbRiIDodj
	YsS1QXHZaIoCw5TI6xL81UmCK6xV0g0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXm7rZRLZvSnmw2rOB5vMrkdqrRozi2igVrrIwhbSs=;
	b=K14z2vxOfvce80px8umySYiMh8smGvYF/vQrnglfceeSttnK5dA/HbAmSpqM48crh+LQmp
	5c7MKO1EbIKXlQpCZxb1yrTj2ulwIMwRPjU6IGE/BlQqd9IMxdvyKnHkrpaAC7iuRCxexJ
	MymuSJkpuqFQolMk5QlTvzs6smcph+g=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 8/9] service: add btd_profile::ready callback when after_uuids ready
Date: Fri, 28 Nov 2025 22:02:27 +0200
Message-ID: <e4fa2723acf33689e9c235a9f2f0ec9c873679a9.1764360141.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
References: <cover.1764360140.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btd_profile::ready that is called when after_uuids dependencies have
finished connecting.
---

Notes:
    v2:
    - new commit

 src/profile.h |   3 ++
 src/service.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/src/profile.h b/src/profile.h
index a8c2443e3..28504331e 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -52,6 +52,9 @@ struct btd_profile {
 
 	int (*accept) (struct btd_service *service);
 
+	/* Emitted when services in after_uuids are no longer connecting */
+	void (*ready)(struct btd_service *service);
+
 	int (*adapter_probe) (struct btd_profile *p,
 						struct btd_adapter *adapter);
 	void (*adapter_remove) (struct btd_profile *p,
diff --git a/src/service.c b/src/service.c
index 7690a1261..95950aa50 100644
--- a/src/service.c
+++ b/src/service.c
@@ -26,6 +26,8 @@
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/sdp.h"
 
+#include "src/shared/queue.h"
+
 #include "log.h"
 #include "backtrace.h"
 
@@ -43,6 +45,8 @@ struct btd_service {
 	int			err;
 	bool			is_allowed;
 	bool			initiator;
+	struct queue		*depends;
+	struct queue		*dependents;
 };
 
 struct service_state_callback {
@@ -71,6 +75,46 @@ static const char *state2str(btd_service_state_t state)
 	return NULL;
 }
 
+static void depends_ready(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+	struct btd_service *dep = user_data;
+	char addr[18];
+
+	if (dep && !queue_remove(service->depends, dep))
+		return;
+	if (!service->depends || !queue_isempty(service->depends))
+		return;
+
+	queue_destroy(service->depends, NULL);
+	service->depends = NULL;
+
+	ba2str(device_get_address(service->device), addr);
+	DBG("%p: device %s profile %s dependencies ready", service,
+						addr, service->profile->name);
+
+	switch (service->state) {
+	case BTD_SERVICE_STATE_CONNECTING:
+	case BTD_SERVICE_STATE_CONNECTED:
+		if (service->profile->ready)
+			service->profile->ready(service);
+		break;
+	case BTD_SERVICE_STATE_UNAVAILABLE:
+	case BTD_SERVICE_STATE_DISCONNECTING:
+	case BTD_SERVICE_STATE_DISCONNECTED:
+		break;
+	}
+}
+
+static void service_ready(struct btd_service *service)
+{
+	queue_foreach(service->dependents, depends_ready, service);
+	queue_destroy(service->dependents, NULL);
+	service->dependents = NULL;
+
+	depends_ready(service, NULL);
+}
+
 static void change_state(struct btd_service *service, btd_service_state_t state,
 									int err)
 {
@@ -98,6 +142,9 @@ static void change_state(struct btd_service *service, btd_service_state_t state,
 		cb->cb(service, old, state, cb->user_data);
 	}
 
+	if (state != BTD_SERVICE_STATE_CONNECTING)
+		service_ready(service);
+
 	if (state == BTD_SERVICE_STATE_DISCONNECTED)
 		service->initiator = false;
 }
@@ -111,6 +158,20 @@ struct btd_service *btd_service_ref(struct btd_service *service)
 	return service;
 }
 
+static void depends_remove(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+
+	queue_remove(service->dependents, user_data);
+}
+
+static void dependents_remove(void *item, void *user_data)
+{
+	struct btd_service *service = item;
+
+	queue_remove(service->depends, user_data);
+}
+
 void btd_service_unref(struct btd_service *service)
 {
 	service->ref--;
@@ -120,6 +181,11 @@ void btd_service_unref(struct btd_service *service)
 	if (service->ref > 0)
 		return;
 
+	queue_foreach(service->depends, depends_remove, service);
+	queue_foreach(service->dependents, dependents_remove, service);
+	queue_destroy(service->depends, NULL);
+	queue_destroy(service->dependents, NULL);
+
 	g_free(service);
 }
 
@@ -172,6 +238,37 @@ void service_remove(struct btd_service *service)
 	btd_service_unref(service);
 }
 
+static void add_depends(struct btd_service *service)
+{
+	const char **uuid;
+
+	queue_foreach(service->depends, depends_remove, service);
+	queue_destroy(service->depends, NULL);
+	service->depends = queue_new();
+
+	for (uuid = service->profile->after_uuids; uuid && *uuid; uuid++) {
+		struct btd_service *dep;
+
+		dep = btd_device_get_service(service->device, *uuid);
+		if (!dep)
+			continue;
+
+		/* Profiles are sorted vs after_uuids, so the dependency will
+		 * have started connecting before us if it is going to connect.
+		 */
+		if (dep->state != BTD_SERVICE_STATE_CONNECTING)
+			continue;
+		if (queue_find(service->depends, NULL, dep))
+			continue;
+
+		queue_push_tail(service->depends, dep);
+
+		if (!dep->dependents)
+			dep->dependents = queue_new();
+		queue_push_tail(dep->dependents, service);
+	}
+}
+
 int service_accept(struct btd_service *service, bool initiator)
 {
 	char addr[18];
@@ -199,6 +296,7 @@ int service_accept(struct btd_service *service, bool initiator)
 	}
 
 	service->initiator = initiator;
+	add_depends(service);
 
 	err = service->profile->accept(service);
 	if (!err)
@@ -265,6 +363,8 @@ int btd_service_connect(struct btd_service *service)
 		return -ECONNABORTED;
 	}
 
+	add_depends(service);
+
 	err = profile->connect(service);
 	if (err == 0) {
 		service->initiator = true;
-- 
2.51.1

