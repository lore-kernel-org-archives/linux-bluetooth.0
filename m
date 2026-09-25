Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F4C4DAFA3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351914; cv=none; b=G17TJqoKH3Hb7W1m0iPrMsDwUteRzuAj8Ltqb6C50J7vipuVKyLbgRhDoDFvDWEsqqggvhMQpP8ISMgJanv2fV0HAXWhZx+R1x7BH562AIErZlSpUZ/cMGkeb+QtZYlzYOG5lulgUKt1Fz/X03DZo8ffhgBTk8XUcR7utxQjekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351914; c=relaxed/simple;
	bh=nE6JGKhUDIFVnlAA5sNhpXtD851sh+Lf2zqYYR7lttQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ZtpwUNhzaIkQdtilh997NAsdyeN6F21gMRLkHeACGfBVIWgdoZR0skZQLWOyGCo9755aAwckz4mRa7UtpHhwzxglSF30bD6Ka/qjTHlCto1knFsnlDx82n9JRCrhuYU04Ye7sEiHsumm765/1t9jELe5/Xyse+ui8GgtBozn3VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9E8ow8r; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9E8ow8r"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc74520b20bso276877a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790351901; x=1790956701; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4FlgkinYnPRVlByzIpTNqBhFNkDe7+NYV3V5/gAR6kY=;
        b=G9E8ow8rkdp7RhFoW/iC99YLOFzEoHMqvbt0GkjNlX2tXrLSFjXT+hjvcMTl47i3RG
         UDaLXCOqFo8UPkEk1E2i7Dwf3pSOTRIpumfUNAmCo3Lt1v2PNgNZwnZkOfqiLv4z44b7
         2YurYXG+J2E+PAZm03dnJ8+NKQpoX+rLBI/bhRjxSsPaAHpae7lTH9ANkfyJyjD7rH4X
         ak0/W5PLisCqUcrd6GhxP3KW7B87AMwbbaLihliFlc4oZbOexJrcINmDvLVr3RfcITg9
         MmntKDQG5LvRHnPz/i5E2YidiGpxQ3F+zE4KArVp/Upw8dVJhRQZtYfUOWlB5gsbOfS2
         2EWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790351901; x=1790956701;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4FlgkinYnPRVlByzIpTNqBhFNkDe7+NYV3V5/gAR6kY=;
        b=wOVYw6fB/jcB7STQKIhh74AzWte1/EcAiDR3nbmJtMIXyfff1mPpXbnfLOy7Q3pgX1
         32IZYwoNjJG9jmsrnuQDxItAV4t7rRq/z+WGvdf/IUfgNjqMXhtoJWh9vamM1XVHaNcX
         qKsQhW8eyWGMF8KgQtA9phdnI0O5EuMnfLUL0tjlwYXtqu2j9s/MGTzwS1eCSQyLeD1p
         Tvkjy9GlqLZGXFXgUfP2QmSysbHN37zWSIVjSrjbrDOqIJRdowQ/8fsKYUt5V53XpnI+
         /E0nZx7nGLBgiTidX80wsRP07tddxN8H3V3lbfkWBwnTP6SxQR2idN2UH7Cy6qmGZ5Kz
         HULA==
X-Gm-Message-State: AFuF++nz393KegsDQNgzW7u74CIA97Zf/Vpyexwa6h8R/8S016lK+nC8
	kICiO26RN+z63Ru23XOtpjy4x7tDUXW+7MQcPpgrpuM1feqp8H2GTEYj08GRk4j6JJw=
X-Gm-Gg: AYBFou1pHti/fUleCej+pRNsLrdZeUfd2oOmrY5/KR4wl1z5YQz6QtJTAv5Bo0+6chq
	GW02V0zv64iZcnozCOZXlaaV7r6UPdkoB7Eyci40+Lb6LZLfSS3lowL1cE+dKN/kLDj1vRqMEin
	caa5nNgrZlyd2TNwKpDLsug+ru+a8rIwpuPzjTTuWPqer6aDPIgKQKb5QuzYjBiJDAsm7OmiTQR
	Ajc/4ZTYyQ5zqC+3wPibC+HZcsui0XsaVf8MQiDPoX9oD/Ck127qtzytNV2bTwe5QjGc3fgIvtS
	/c5bF0/LlHqbLMd+znKwn/Fg1NWbGXSpnn971+Pj7kYRBHhcGRh+0CxSbQ/SjMqR/uY84COvbLh
	sYY+ziNhq8XjCIRewAjxYkzotE0CNzjG0lpgfRGxrtvvqDtl5WUpnCn7U371M4yjzqnj6XJrXGA
	ttaR8kmnEw/W+Z+YY0o1HlXgzcUTF42B/5neIg+gqtdqY/awVUArtx1xuLfcTZnB0WA/K9MNopM
	OGQZavWvAvLsbs=
X-Received: by 2002:a17:90b:5108:b0:3a0:ca3d:c330 with SMTP id 98e67ed59e1d1-3a0ca3dc5c6mr658063a91.32.1790351901325;
        Fri, 25 Sep 2026 08:58:21 -0700 (PDT)
Received: from [172.17.0.2] ([4.246.63.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c7435sm12054253a91.11.2026.09.25.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:58:20 -0700 (PDT)
Message-ID: <6ab69a1c.81b1ab59.de404.c888@mx.google.com>
Date: Fri, 25 Sep 2026 08:58:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2439158193441653226=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ,v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported
In-Reply-To: <20260925141047.3397212-1-frederic.danis@collabora.com>
References: <20260925141047.3397212-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2439158193441653226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173825/

---Test result---

Test Summary:
CheckPatch                    PASS      0.39 seconds
GitLint                       FAIL      0.22 seconds
BuildEll                      PASS      19.56 seconds
BluezMake                     PASS      381.03 seconds
MakeCheck                     PASS      2.72 seconds
MakeDistcheck                 PASS      140.31 seconds
CheckValgrind                 PASS      150.60 seconds
CheckSmatch                   PASS      290.33 seconds
bluezmakeextell               PASS      95.40 seconds
TestFunctional                PASS      1109.57 seconds
IncrementalBuild              PASS      375.13 seconds
ScanBuild                     PASS      1132.95 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported

1: T1 Title exceeds max length (82>80): "[BlueZ,v2] audio/avrcp: Poll GetPlayStatus when position changed event unsupported"


https://github.com/bluez/bluez/pull/2589

---
Regards,
Linux Bluetooth


--===============2439158193441653226==--
