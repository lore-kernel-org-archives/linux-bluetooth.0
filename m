Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795031941;
	b=Z9xztDirirYHJxFen7Cpq83K1+ZOIAx+KLGh+g1925zAg+B/V8WwdNCd65AXYD+hm6EW
	 9o8tMrp/RtaVKIVvsO6MvITRoDFCdfArqilwlXsJAcXPTxWaNPoff45PH5NMatoRSLItx
	 FoI/SrZxd2QNX4ty6iqGrRODFibqlGRxZpdDPVje/laGoWCVuKZ/mVGkgi7IWgsdatwDy
	 N13v5U5Ol5OsraKOR3lpj5SahSaWtlxsP53deSQ7pK+w9C1XvDFTYVg2flAYqwLNrUzyn
	 CJgUvv9WI1repiO/1W0hkOmGBqBV4dScAyPFdhHUKKX0DKcqznCFzo5l7ntTMBwlqxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795031941;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QYSm6I6tK/zXaEc17qoCDE2OvMm3RGwRpPnFd9OpH6Y=;
	b=t8aWTX/jO6aACg+C7rtSFtOu38No3y7aSd7sjSWHjYvLB5QkHRZmDHE6XeecW6ia85HQ
	 YD1zX3Gpcoj8YOA5/R8bWO4CMTaXa7J7Scdf6Nfr2uHWaeE1Kj0if7IYqV03rB3O9MA/K
	 7xlpxG+CxzFwhpx5VNqQ73l1P133VnVEztVOSk/ML7N4yxCHHbblo16aDwrxbmF4vbGff
	 j+PwvbFRTkTueRzipzmdgJAWNG84+E6EJEWdTCZGrWjB+0IGetDPoxARRwxvkXmjTLjF6
	 lQ0alHP3ji+N7wQymVojElUQ3DtFe2ncHsznGSc6eUbUMVwaeTs/Vb1KoGcLkAiB8RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXWHxika;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9865B60A260C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 19:59:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9865B60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uXWHxika
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so1098227e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 11:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795031939; x=1795636739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QYSm6I6tK/zXaEc17qoCDE2OvMm3RGwRpPnFd9OpH6Y=;
        b=uXWHxikae5f2fSGmJwsSPsQvZQIvUbEWNGZ7fPpcqYFrEnv3zGubO54qO8d1WFLXRE
         t9HxitR64/JhfTlYRA1oqTHPhE282y0QrghFj8Ph60yUXBN5wvTMAueHOShq9t562pog
         fz78LyRjNvJtqft/pxrQfOpVt+dsxQ+2ZZCqS0mH3L7u7sCcv0LzCeb+ftYzDmAk/pr3
         aXDAlVF50PZbbJLccqmWLgpeJPXDPIJsI+hrjzFVJqKB2TrIT9OVZezvEbPYxrE9vjSE
         dG9OKQQqJ+01y2AMo9cjPXwBZJvEAxWdewJBYpuYKezF0ycLD/Gs1ujJWWDXj3loEaJP
         vgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795031939; x=1795636739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QYSm6I6tK/zXaEc17qoCDE2OvMm3RGwRpPnFd9OpH6Y=;
        b=iXPHWYIL47a5Jd2ULfmD/g4k4ShO6NkK+1IBPhMgG3JxERfIfhbWJEe7koHe8z30qv
         m93r/y4yXcowjTRVBXteTktnVlDIzNIpT88QzZvjG1zGy8MDhuwx+OPPWETrl0a4tEJp
         3m17semRsV+xIy0yOlz4aiwJGQZZ/Z7P5imLhUWqiObXy40nDFW3eSi4MI5lrtkGiJwN
         /kSvC0PniwBsbA6py/630LA4B1leCwD45xPM+g5fljMncIJZQ+JR2URpprJ38kaQtuvx
         CjvQyMX6LhwlcxkEQJNNE6NTPskqayd68QjAYfVZ0jvOMFtVsOouIDu9JV71H2jVCDhE
         6BbQ==
X-Gm-Message-State: APuU4Z+TobIDOY2zgST8CxV71VgqZFcSU1E213E+trTj8YGtTUlSBa/X
	RIg9G5RsDhJT/vN7URcKRhxfQl0FuGnADytXO751abXYLQcttyyM4HYxfHUk3kDj
X-Gm-Gg: AYBFou21JDaEoZlLZm71sZ2fIffa7MbrFpv7bXzSDsLwLQr33D33/Qg9j88lALToOR+
	+OGojAy8U0DfjN1zVi6PO2ijHLLx0+9wwZeGDPKTPD54hPq7ZbXLHWdbTbULvaoEWYd6BgJl5rg
	IjsMk6R9K2i0gahsTGbY3kncn4ZHouuV9DYLWefXEMBZsnIzDQPw2cnLhCb/jM/a2K2TKDKpYX9
	H2f5iPfeKG+aJYU1A8FjnNLy7pDWzDWAlqsPD8c0g/lLydsKEpb9te2MepWxAKnnextlgrJEvnW
	dK8F0hgdILwSSaRTKt7jLBviyPkFE4Q+GuUj9hcfEZEaaQudM0kOxaCEcGDmmLMTGtp51rscA90
	6UoDIr2/4D0QI8YHBzToiYLwSxtIxI3cHoc04xo3aJbY5z6ggLcm2IpndQ6icUH/4UrUG6wVkWa
	Bar6WkNYG6PGydeoL1sRplucGjqlKnQDK+MvuoMbicK08jDx1CkARfVNPJvKJbvD1PNDpVZpyqy
	yWJh0/lGKpLz7nI1mfipwGyyOtcwl/W71qf0oVAKosXUCyvPcd/MeoJEbbBLAbwNZkL+DlT+2Am
	fiy8cdZKxTNsrYsq6vxGcSj0D84AtGcsHmSpv97uCofl+I62dnnix3sP5gdgo3H+hh6D3EvlqPb
	PDw4bgycKwVhqijTPH5tUQaqYnnmqbQM8l+U2O7zOgWViKLoWEwb/pT4OWk4L6tfOjI32D+tt5U
	BIP2o=
X-Received: by 2002:a05:6102:f9d:b0:7c1:62d2:e18a with SMTP id ada2fe7eead31-7d6ba3db913mr1841510137.16.1795031939424;
        Wed, 18 Nov 2026 11:58:59 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b91e87f4sm2685571137.7.2026.11.18.11.58.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:58:59 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 14/16] profiles/ranging: Do not start a procedure after StopMeasurement()
Date: Wed, 18 Nov 2026 14:58:42 -0500
Message-ID: <20261118195846.393710-15-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118195846.393710-1-luiz.dentz@gmail.com>
References: <20261118195846.393710-1-luiz.dentz@gmail.com>
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

From: Cheng Jiang <cheng.jiang@oss.qualcomm.com>

StopMeasurement() during the setup phase, or the measurement duration
expiring there, found no procedure to disable and returned without
touching the setup. The pending Set Default Settings response, Config
Complete and Security Enable Complete still arrived, and the Initiator
went on to create a configuration and enable a procedure that nobody
was waiting for any more.

Remember that a stop was requested until the next StartMeasurement(),
and while it is set do not send Create Config, and do not send Set
Procedure Parameters and Procedure Enable as the Initiator.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/ranging/rap_hci.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/profiles/ranging/rap_hci.c b/profiles/ranging/rap_hci.c
index 80379598d510..eb07cef378d1 100644
--- a/profiles/ranging/rap_hci.c
+++ b/profiles/ranging/rap_hci.c
@@ -73,6 +73,7 @@ struct cs_state_machine {
 	unsigned int measurement_timeout_id;
 	bool initiator;
 	bool procedure_active;
+	bool stop_requested;  /* StopMeasurement() since StartMeasurement() */
 	struct bt_rap_hci_cs_options cs_opt;  /* Per-instance CS options */
 	uint8_t role_enable;  /* Role value for HCI commands (1, 2, or 3) */
 	bool sec_enable_pending;  /* Security Enable deferred until encrypted */
@@ -565,7 +566,9 @@ static void rap_def_settings_done_cb(const void *data, uint8_t size,
 		/* Only the Initiator creates the config; the Reflector waits
 		 * for its own CS Config Complete.
 		 */
-		if (cs_local_is_initiator(sm))
+		if (sm->stop_requested)
+			DBG("Measurement stopped during setup, no config");
+		else if (cs_local_is_initiator(sm))
 			rap_send_hci_cs_create_config_command(sm, rp->handle);
 		else
 			DBG("Reflector role: Waiting for CS Config Completed");
@@ -1257,6 +1260,15 @@ static void rap_cs_sec_enable_cmplt_evt(const void *data, uint8_t size,
 
 		/* Check if role is initiator */
 		if (sm->cs_role_known && sm->cs_role == CS_INITIATOR) {
+			/* StopMeasurement() during the setup phase had no
+			 * procedure to disable, so do not enable one now.
+			 */
+			if (sm->stop_requested) {
+				DBG("Measurement stopped during setup");
+				cs_set_state(sm, CS_STATE_STOPPED);
+				return;
+			}
+
 			DBG("Initiator role: Sending CS Set Procedure Params");
 			if (!rap_send_hci_cs_set_procedure_parameters(
 							sm, handle)) {
@@ -2015,6 +2027,7 @@ bool bt_rap_start_measurement(void *hci_sm, uint16_t conn_handle,
 	}
 
 	sm->active_conn_handle = conn_handle;
+	sm->stop_requested = false;
 
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
@@ -2044,6 +2057,11 @@ bool bt_rap_stop_measurement(void *hci_sm)
 	if (!sm || !sm->hci)
 		return false;
 
+	/* The setup phase may still be running, with nothing to disable yet:
+	 * keep it from creating a config or enabling a procedure.
+	 */
+	sm->stop_requested = true;
+
 	if (sm->measurement_timeout_id) {
 		timeout_remove(sm->measurement_timeout_id);
 		sm->measurement_timeout_id = 0;
@@ -2125,6 +2143,7 @@ void bt_rap_clear_conn_handle(void *hci_sm, uint16_t handle)
 	sm->cs_role_known = false;
 	sm->sec_enable_pending = false;
 	sm->remote_caps_known = false;
+	sm->stop_requested = false;
 	sm->current_state = CS_STATE_UNSPECIFIED;
 }
 
-- 
2.56.0

