Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE41477281
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 03:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791862952; cv=none; b=lCTLBf2oCd32PRcWoxK+Uw8P3oTtDvY+KsGMYDlSS7rsMP/trmjpf4GsZK2yx6TGpZzRFEmJ2yhpQtE6LNKI273eTm0IlwONHIbHrCwuKvF++4QiSESuJ6Nal04E2RoHhO9IgyPGvL7Nz49c5Xe7up4JlukDLxE25/96KpMQInQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791862952; c=relaxed/simple;
	bh=MW3pyeNZaeTw696bnv759T/r7OXQCBFEDxtk0xrWJu0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qTORg3Ef1225vJkFY5aD4P7M4uuDx76gn5l/yPJp8/yP5yyxxyfMD4DklchI2/o/5tMamQfYRX3B7tSf6SZO6O4Lnuxu3gnvH56ItORNko7Vu4fdwTLex9EkWWxKK9Rv7/wXH8fz9csWsQrqTindB3tsv+MEPN4mJ1LzEkyOxnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvTS6z9d; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvTS6z9d"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so4784073eec.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 20:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791862949; x=1792467749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YRRv98G9cn0AlpTayBXQFsFs2oRDwoIU3+IQF5Vkek4=;
        b=NvTS6z9ddnomUVb+xpfL3J4iJgBwGQjFiSH5xHwT8J+Sa8qImtpb+vmaTVF/tZBm1r
         8GeEGIgakQJGcuVqPE3S4sjpSgEoSxg51rA/SEfqR4Q1sLd+Q8lJf0xnTn7mM/+t5rhT
         V/79Jh7JBFhuP/HRmYGopf8VYWe1PhKE4LCX2UvqwM68deuhagRlb7oeZnWj/JDHH9iF
         nuAPkwLXe4VVFQ2gSBYw5xlxVaeywV5QwEJDvb2kbYAwwoYUtFuLdy5N3ruaCCzasehQ
         Glfn5GqwbV2jq88HF3tQGHQ7bX1/Xza9uMhYD0G4D2WciLhPofLzXgFgWG4N0FQ87Oq/
         X+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791862949; x=1792467749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YRRv98G9cn0AlpTayBXQFsFs2oRDwoIU3+IQF5Vkek4=;
        b=o4q9aiG/1pF8VBLZX0tCy3C9NtGUrYYj5oTrvXBspFcFN+WVZrTteZTvZoeObNOd5K
         M2RGuhqm9DL51sNXEEtBrUmZZt0og0PZzpEqQJdCCKKYbd/sNKw0Bn9Qv6qinliCRQdY
         a/5jzmIiRq/NGEE/jSA2sBI5nrw/bE7HzhYKLQEKHU78Bny8nSGEhyfqfVUKlN3DWbhy
         0Cl66ihI1hDP2ZivXK84n4ukI4ZKbMBMii79RBmyiGSXUGLU1x2+kds1eCBnguxgrcbT
         zh6HAxX7MTfNmwERO9tcHaj0KdzHGk32oCxbeMhMCqVujl06rQigcjytQqS8Rs0hZevo
         hXLw==
X-Gm-Message-State: AFq9FYLYLZk/qEmVP+PfpXOnx7JXjsfndXy2Soa5+npt8eBTxbKu1t76
	+IMwUtb5PmC3JZ+sZzVhP0U/PUqEw1vYMgBHCbTeO6Csf7NBbq/MAoUg
X-Gm-Gg: AYBFou2AjqkNQ43Y43h4D923eY/qMTFBT8wl/WCefMjoRJSydWF4f2ePGozvdZnvYt1
	MdHaeFQPzOs9WXgrw06j+5CBq2kUZtRKCiF3zg6TRogZALvqKuMiI6TuxLkTly2UOBjtgmyArkW
	yfp5YPqa4w2URUvweUsAKEBxSqA+QDxUZW4QNKhh0VSnbPULj/Zj8zfOMTDDh1WYXNVc+DOkSc2
	gzeIOMeECKE+h4vrv1AUXgcoJ3YRUbUfHAGYY82x0IHQxElrbr0t5vMPJbG8AjW0MZTcP2yXCkM
	MafkLCMsvYJhE5nlZcujHEh5GEA2WbwYw1NqMCCgziwusfFSXOBv3z0tNXeeMU8XzTC68QlmfYU
	8jKzbe+nK+ZWbbhA3lxa51/2uIw/pqmxF6Da07PrXqJWnbrx02oW9YIGch8x9D2FLK/1KJ2PUIJ
	1q6rCPuRH+iNqDYXj0u7CkthcePrFOBtHzH7wmeT0a8H1BQpZwtPl0Hq/Q9C2ntHsieaDitNjX3
	Veu0lF2XcJ4zuu+sXCwCemyzUv0+Byh1LpiMCcdGTgnz6WdXC7xuxEhbJpVcQc=
X-Received: by 2002:a05:693c:41c7:10b0:353:5cf0:df09 with SMTP id 5a478bee46e88-3537df8d300mr16954343eec.8.1791862948560;
        Mon, 12 Oct 2026 20:42:28 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:679a:f35b:7c29:e0f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cb68e56sm35268677eec.29.2026.10.12.20.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 20:42:27 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Mon, 12 Oct 2026 20:42:19 -0700
Subject: [PATCH 3/9] HID: core: Reject mixing numbered and unnumbered
 reports
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-hid-core-report-validation-v1-3-e0dd5cb60b2e@gmail.com>
References: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
In-Reply-To: <20261012-hid-core-report-validation-v1-0-e0dd5cb60b2e@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 David Rheinsberg <david@readahead.eu>, 
 Frank Praznik <frank.praznik@oh.rr.com>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, Even Xu <even.xu@intel.com>, 
 Xinpeng Sun <xinpeng.sun@intel.com>, 
 Roderick Colenbrander <roderick.colenbrander@sony.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-input@vger.kernel.org, Shashikirana H K <shashikiranah@chromium.org>
X-Mailer: b4 0.17-dev-e56a4

According to the Device Class Definition for HID, if any report of a
given type includes a Report ID tag, all reports of that type must
include a Report ID tag. Mixing numbered and unnumbered reports within
the same report enumeration is invalid and causes confusion when sizing
and parsing incoming and outgoing transfers.

Reject descriptors that attempt to mix numbered and unnumbered reports
within the same report enumeration by warning and aborting report
registration.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index a33e864a25f9..3a9bd56dbf85 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -96,6 +96,12 @@ struct hid_report *hid_register_report(struct hid_device *device,
 	if (report_enum->report_id_hash[id])
 		return report_enum->report_id_hash[id];
 
+	if ((id == 0 && report_enum->numbered) ||
+	    (id != 0 && report_enum->report_id_hash[0])) {
+		hid_warn(device, "not allowed to mix numbered and unnumbered reports\n");
+		return NULL;
+	}
+
 	report = kzalloc_obj(struct hid_report);
 	if (!report)
 		return NULL;

-- 
2.56.0.385.gd3acb90ef8-goog

