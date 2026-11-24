Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532966;
	b=ycAtR9ImjzbMl1z49mRws6B+zQeBt28Y9ahnVvyhxVvLtKMxPqWjjjPGolutsd9bHyr2
	 Rrw+uSgvUuTJpa5L9E1RQkFiTaDim4oNju8qNprfDe1flWzEWMY5MSO7fcoaaVQrnSk3Z
	 /qBdtGzIBAXlHFcEZFp+YsYAFDmgONkIBuH5RU3ISmVx41+3nV/NxC40FifhznGWAu1ye
	 wjY6kK3hg26O6SFRErOLgqqi7hUa+K3wrelI73gL+JuYs5mKCW4OVL+Sx/9gJnQFJ7eP2
	 du5NpButmOHoh0NtV7wfdd+FOX2lHG8X57ZGXEMBsaCLFADJ343G7OR8yypjLwJxVKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532966;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zxUFzzFYFZNvnxi4DXRKgik+mg3Yx60AHtJYW4ezN1Q=;
	b=vJmiE9b+GSlKH7w18f3C0BeT+m9sTkLr59eorR1qxPfUX9kD7gnl9AhUbdJdlrbcFU54
	 zgFNJuJeWfKM2jXrEfv+X8h6/Z8sBfMXp+wRw6q/atbUqN1eA1ffY6iENUhpxibfKk4gz
	 ik36fdZiX/R7N6P8/1/qAT9A692Nu6HySbP4yxJMtQajqlRb5dVi6v+2HixlfqUrwQ15m
	 bG8boJOnKePlTgenAaR8FB795uWpXNJB+gkp6bN6TxjrtpLS7HIxbS8Uy8CP5fEMccppi
	 Tl3ksDmFU0CtrcY1ZRcvKR+pO126XSPsEp4fHW1b9AKVpG1ImfYte6HNPQoIVQaKm7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Fsaz4d4B;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F290606A31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F290606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Fsaz4d4B
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so30014135e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795532965; x=1796137765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zxUFzzFYFZNvnxi4DXRKgik+mg3Yx60AHtJYW4ezN1Q=;
        b=Fsaz4d4BAwQX751ztbwYRb+XCGZXZbKXgOxKAh6HfnEZsA0kyx+47n2P8VbCcCXY88
         /YVnv8f/zjQYuloNzIMe0M3FIdcSYXzLGDo6jq4IhH9ZwpeIEYaXVCGuhWvhYycaGvLv
         Rxt7BiCTKxs5daRxsINJyHE+rdyTTpcRkG0Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795532965; x=1796137765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zxUFzzFYFZNvnxi4DXRKgik+mg3Yx60AHtJYW4ezN1Q=;
        b=MioZlrkHISVNagLUfkuU9DBX5wDLdNPzUPr2kvh8akpmTV77WgzonNU59DrANqC99d
         m0YSPLhDG/f2af4VvhIymbYi0tltuV0Z4cX7aG1suu66kw3Y5uqhm5kvj/fCF+XfUUIF
         Szuvg+Jvchc1ut49z3keqLqAC9iMR7WnUKR1RgU3MdbB+REQRK8ElnP26r7lcDBxbysa
         lqIT+pcT8H5i6JEnORqC0Y4nIt2QNhDM+iwjdfPSadF53GQg5QN22f9g15E4YbJMdTa9
         5aViZD36dCpBbT1C5WbNtu4awaRtGG+SvHi4HCr8EHuEH+bRRlbDl4OGi9MkkBI6AZAm
         tDHA==
X-Gm-Message-State: APuU4Z/lLc2u266ASDMWZWOixfXLp+ye9vL3LxwbAQMCqV1f26FODAan
	LI7cPIAC36T0iu3MPtVJtMIk4Ku16RE551/nsfkHYXE5j2mtnCP5EzTokZkBbUQ8nIU0L1F/cRP
	nJmSe
X-Gm-Gg: AZFdTZeM7/Nnxsf79stoTA8f1TtjSjmwj7jBNjA1pdJ8Kt3QdivuliNjuXZMvfV84Ar
	7orFFJ/i8DWKP4ZQtVjYwcfGtydJemPLYzjihc4F5qY6sq9fXUPCjuyhLGY9bMAm31q2rW9YYSf
	FAATcEEYvG8l2iFjbtMpwjk+pbDNzvU4tAIAjXpQrXxx1643acUtJpZ68HwfoSm2nMEvJCnWh4i
	x5r1McU67AAUbCJxVA0qcTXQgj2GNZKuKcxV9eNCuOnSsF+ATFNsyt1doT4GcvYq/5iCJlSGHMJ
	s+AXo7hafA1rJQUKlfJQApjCqm/dsXIxW8OePzW2ouIe7ZD9yTBpJBP4Dj/w1sGFa3qMpk4nHW2
	s+el4VOzZHRj4Hf9YhUPLQiFtB5LCbsZJSAJVRpgDdbaq7OBG7uStChOPG+Bvcz9mdWK2IrsC++
	PCR378eFvtNhgGniFgN1k3d9xrciTpwQ4yF2kOrNE7t5oMT4Ez5ByCPwUql5ozwjNBtUecHgFUb
	Rvwve8Mhw7tu+br8kwQLKFhJPeqISM2c+N+iOiQhmCtGyE8YxGJ68r5W/jh1boxuM4w9yO7Afgk
	sgioJcmay9EHWLLkilPBwS3gKPKHA7DjiiBIJz+JU+3jWDlxQA==
X-Received: by 2002:a05:600c:46c4:b0:4bb:6a5a:7834 with SMTP id 5b1f17b1804b1-4bb888106damr312359755e9.20.1795532964992;
        Tue, 24 Nov 2026 07:09:24 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:d476:8432:c5c5:dd98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8849e598sm402731955e9.8.2026.11.24.07.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 07:09:24 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v3 1/4] shared/bap: Remove broadcast sink PACs in bt_bap_remove_pac()
Date: Tue, 24 Nov 2026 16:09:19 +0100
Message-ID: <20261124150922.341655-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
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

bt_bap_remove_pac() looked for the PAC in the sink, source and broadcast
source lists only, so a broadcast sink PAC stayed in broadcast_sinks
after its endpoint was freed. When the endpoint owner goes away, like
WirePlumber restarting, the next BIGInfo matches the stale PAC and
bluetoothd crashes:

  pac_bcast_config (endpoint=<freed>) at profiles/audio/media.c
  pac_config () at profiles/audio/media.c
  bap_bcast_config () at src/shared/bap.c
  bt_bap_stream_config () at src/shared/bap.c
  create_stream_for_bis () at profiles/audio/bap.c
  bis_handler () at profiles/audio/bap.c
  bt_bap_parse_base () at src/shared/bap.c
  big_info_report_cb () at profiles/audio/bap.c

Fixes: d49ea14f70da ("shared/bap: Add support for BAP broadcast sink")
Assisted-by: Claude:claude-opus-5-5
---
 src/shared/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8fc28de52..9404bddba 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4864,6 +4864,9 @@ bool bt_bap_remove_pac(struct bt_bap_pac *pac)
 	if (queue_remove_if(pac->bdb->broadcast_sources, NULL, pac))
 		goto found;
 
+	if (queue_remove_if(pac->bdb->broadcast_sinks, NULL, pac))
+		goto found;
+
 	return false;
 
 found:

base-commit: 1608f836188610aabeff5a3164169ebe0360e443
-- 
2.43.0

