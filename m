Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E43ADBAD
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668508; cv=none; b=p1M3dCmKNipXzciFSFD1qq8YtCNi55YPZE5TRsvAdRz7JHx6OxsJgX1zB4D3apLmGke2Jl6kFegXrRD6rHKYSt+fTzZ7K+1sbbLUj3XWPOwEOjFi4BWBGNGlH06QWyoFb96E909VC7dx6AMBTiTchJZV6Bh6Pxw5XObO/Q+g+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668508; c=relaxed/simple;
	bh=LtjdI+E+75XNBmVuoYFeXMhidu6GmZe8iX9ATOJpCD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EN99c8MZBYumbAjU2mie+ipCK14Pe8DSKLidvmiw/0jrTQvxh/QbymN6bHrXDAnmh9ZqKF0iT8I9sKPeS8AVDi1MDN6SWKhYbO2WV7hTujITjJu3+IKm3sQTf29PfrxpwwLyK2CfLzRJn2eogUN8CT7VY1sQM7dzcLA9C3K0Eqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjkDad32; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjkDad32"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-39b2be45e8cso5527641fa.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 00:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783668505; x=1784273305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8SLJIf6IhE5eHTBesVIcH3RiqxKZgBnPvYv0MxcZBg=;
        b=ZjkDad32nnBm9iqbtCT81L858aTKPOAB9I+2/M3g93+GGlnS+zj9SQYLflH4hy8l4w
         1jcYVwYxy5xqimm2vVi8aHQOD15G8A+dESgqjc+W63pILDWaQIBzZnP4p/4vFldI3eKy
         xsF7/NirXLWYi1O0GfItnqkNTGRj+QvaKFALmu5gl2Fgzz0ufrjaUuN7CX5CH5AP99IT
         xuhuGqwGGeGv+HiNI2j+qclJe+MDYASRdp6wgo9riXCIchykDQmwNjuFSzKJlbmMP1g5
         q1U0eEfjCcLK+V/e7SLJtQnmtuMdOPZ9Pt1DBIjHxV4A1seg7tDWAR7ELUmQ/kgEvb1P
         XqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783668505; x=1784273305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8SLJIf6IhE5eHTBesVIcH3RiqxKZgBnPvYv0MxcZBg=;
        b=JlJNI2EQfRzdVOVfP9M78b9XT3qpE0JeW4FqIO9Sqow9Lh0AHfMwQoboJaID2T843B
         wzyUe8xaYdSQG2wW+ijp0HIwjtFDy7u5IY3nn25zt+lFjIEhLbxgyJN77kpGoUYoyrJS
         xTbmK4+AUctUI3HkSDAk3DAfM1NAwbdWSLayOeBZ+oeaQuM1+JjTuisFCMC79db6LArA
         7e6rOJaNUJ18qEh5eb3/RbiUpBfpgcBphPWlsIv1DY3edm71qcCxstuucycKRG4VroQH
         VLyhLMWCuNKqSCdKoK44NM4cRSryeZKAklNWhHMMA3RxvORzKtbH+NxUWUwlyXuqARPt
         xLTA==
X-Gm-Message-State: AOJu0Yx4MTMxLk3T8J5JyXcmML2ZwaxYALMlzRM1X4QkyrBRWVxW9/L4
	iDI5BPZTVrosaaCHlPx1TB5ElT/5iCMQbAXGdAHRYw+DgjvKMbR8A7oGm7dM6mxZJuBhQA==
X-Gm-Gg: AfdE7ckOb1mefcnczg2GMw1G/RzoaPMUbs900TItpeuron9MMRyyrLqm2gxtLi06S1V
	qQC5MTjFM4HhpDvz3hBuoz7NgbajW+V5GsI+eacXNXghN8sZZblkH8++3fMdpNSxjM8v4vH6zso
	oav82ts9BsBzBtDXvt52YxDzD/7oQ/TD/y6hH4F7+BBNQorn5mM0scxxba0VlGh1zLndae4pVso
	m1jSUSCmsO3pgCUksSZJXuCd6KZACUlKJ1Iq3YwNPsYnWFg3cRyFdmQ5GWLGUvgXizoKlWLjhXr
	+OJpNhOY8OjyRfX9LQLVN1+9u3h3B58Uphxrb1yOh4GHZ+FnkhekGgQX55UzcJc/i4+gpZu+GD7
	YyBs/0s7umDuWd+gbsIVcoUAv+gR598x0BO/ZYf3m5h0iGHiwxaI5zNPqakrymgI76opup8Pi+r
	KRlkIDiq0Vbc+cxVHhmvorXKI=
X-Received: by 2002:a05:651c:199f:b0:39c:7c5a:faef with SMTP id 38308e7fff4ca-39c7c5afdb5mr23484361fa.22.1783668505052;
        Fri, 10 Jul 2026 00:28:25 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c84b83bfesm7469981fa.21.2026.07.10.00.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 00:28:23 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH BlueZ] a2dp: Fix loading of remote SEP from cache
Date: Fri, 10 Jul 2026 12:28:17 +0500
Message-ID: <20260710072817.270328-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
added an 'i >= 2' condition to the loop that parses the stored codec
capabilities. Since i starts at 0 the loop body never runs, i stays 0,
and the subsequent 'if (i != size)' check discards every endpoint found
in the cache:

  load_remote_sep() Unable to load LastUsed: rseid 6 not found

With no remote SEP loaded, avdtp_discover() can no longer take the
cached path and issues AVDTP Discover/Get All Capabilities on every
reconnect, and a2dp_setup_remote_path() returns NULL so the transport
ends up at /org/bluez/hciX/dev_YY/fd0 instead of .../sepN/fd0.

The condition was presumably meant to bound the writes into data[128],
which the original commit did not actually fix: caps is read with
'%512s' so size / 2 can be up to 256. Validate size up front instead.

Fixes: 912f5efb0dd9 ("a2dp: Fix handling of codec capability storage")
---

Reproduced on Fedora Rawhide with bluez-5.87-2.fc45 and a pair of
Denon PerL Pro TWS earbuds. Without cached remote SEPs the earbuds'
incoming AVDTP Set Configuration races with the discovery bluetoothd
now has to perform, the stream never leaves CONFIGURED, and any client
opening the sink stalls. Fixed with this patch.

 profiles/audio/a2dp.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c8adc3122..a4ba1dacf 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2398,7 +2398,16 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			delay_reporting = false;
 		}
 
-		for (i = 0, size = strlen(caps); i < size && i >= 2; i += 2) {
+		size = strlen(caps);
+
+		g_free(value);
+
+		if (size % 2 || size / 2 > (int) sizeof(data)) {
+			warn("Unable to load Endpoint: seid %u", rseid);
+			continue;
+		}
+
+		for (i = 0; i < size; i += 2) {
 			uint8_t *tmp = data + i / 2;
 
 			if (sscanf(caps + i, "%02hhx", tmp) != 1) {
@@ -2407,8 +2416,6 @@ static void load_remote_sep(struct a2dp_channel *chan, GKeyFile *key_file,
 			}
 		}
 
-		g_free(value);
-
 		if (i != size)
 			continue;
 
-- 
2.55.0

