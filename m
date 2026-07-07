Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A62306D3F
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jul 2026 18:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783449396; cv=none; b=rEYn/p9wXaA2L3YqSxbmWTHNmvamqbzaMj1sk/uWRADumsCK/JB+kjWasW9WMdjtKmkuLOJvlyVdpBVO0Wm0KqRso1XVffvgtDBcahwRPEudLwor72k+09U0uV3EFAa7QoyU8lVMCqRGnj4hCC8hlixWSrCo6qsoXjIwBy5wpY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783449396; c=relaxed/simple;
	bh=y/NwzvgwSOtFvHKkaqlUuCfUEyn9rpa3ki0u135dBZI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=N/KR3RRRyWkGihPvTNx/mcB73oNBNJLgZlU3qbQ6e566hHll3o9i6rskI2M28jP8eLp/D8zfz8CSpKZWn+PAkk4ZglZCQXSE7VHBmMcOnkMlaPBthd4Y4YaFVS1LnYyOjN3PN5P2HbfJRpFgfn26tViHW7FkRCCAsYTYBvet75Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWJ+5JPZ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWJ+5JPZ"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92eafc94c9cso152473485a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jul 2026 11:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783449394; x=1784054194; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6kqafwW/WWP6lxg7ddHhaxWNTOEe6IdSPuhJLqpzBS8=;
        b=kWJ+5JPZREgAaKV632GFhkSs+Wy0TFYr83hKlQNBnLQlM2DyJb5Gxbit7gCY02lr4Y
         hDmSuDOGFZ3Ipty+BYXl4nB9nspmq8UjAOjRyEchGlOtvQsdHCeE7LXQMLT8PSE07KS+
         Qqo7KWzOi2+PXIoNiTtLPo9D6taJzdN/QQHLT6WiEt/b/j6CzmpJElH77q6tkKbJVpsH
         oiI1O3cQlLMBvPWpROF9pCbMZ+XmOkny8OiGUVh/MnZUsK/5iYNIN9WzqP2zZ1AXyflS
         tF5GD+6/h1bwxRO9z+U/+K5pL47BtqwaiA8XoXVxgv8LNTKcymY71rJkAa0ITEnqpq2V
         yRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783449394; x=1784054194;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6kqafwW/WWP6lxg7ddHhaxWNTOEe6IdSPuhJLqpzBS8=;
        b=oBVL2JgdstkzufBjnVOULODL4e4cPr4GFp9rdQVy+7Y13vQ2/EJhYxozJ9qN0mjBUW
         nLQj1wcuo8kkEfv1ItScXTYX3sZbYAeHZkBTUsfRbqBMSd0fI3IiqsyoayR0sx5LPDjW
         gersivzvHdA7pKkXU56upuKEoFxbilj+f5EBLMgr/VLOY6JarfLmMnlyTbeD8DCjzLof
         Rljfs2NbiPBllhMK5AC4oLRIjiyD3d9/q5fPmJvwsuqsa3e1Im3vnS8IBWwVF9DGprH+
         hmlw+Hsap5g68JxeFw6U+cYi40rmPSG0KdW/xz1wzAukhipmbqhS5LY3avwiOs+u/NQf
         7tbg==
X-Gm-Message-State: AOJu0YyWm7nS4WUJcZ57OQkxJctF1oyv3FY4srF4sGtlP2fu07zYcT5U
	UBtJX9jIoDx7ur/kLm64+kM/nbBEhZOLBBpyGoJfgSCkBIPV/sydWloZF+QQMw==
X-Gm-Gg: AfdE7cnQaVq2/1+8mPTabqpPZaT+6S+K6LGZafQpe1hqkbB92QFWUO2wrtSo9LO/b25
	2MXsrF21jUgyUiwj2dc4JVlEZNrKRDDMrZCGOk/wzc3Gw/Zc0GQpHz2TZNxZDtj1Zwy7hWiH30H
	WTEmineNjM8gFP88dq5yL36yDO34a9tDNZTHj0Z29M5NpkQWfjge/WMOTzCOYmIdZCKkocECj8h
	uH27dQid49QiR2rBKkkvWQzKhetO94y29rOK9DFFHwDKXRnrXWeTZoAzbbnHGbH3paLMCQj+i6c
	376Eaz0H5PA6p2Of28R5Hq8DjgQtYqx4ddbz15GiHMEMJaOGPuFZpE8RTYh7frmoo4Rlq1rvIZk
	ADlVm0pUIJmwpKbHxqybdqHvpxa4bD2FuKQUpwTeT1DZa89OuMPQiGxgJigAFg2HzQ0YjnoleCW
	UpqwnFw80PBcpS3U1jboYb4A==
X-Received: by 2002:a05:622a:4107:b0:51c:1c2c:a8bc with SMTP id d75a77b69052e-51c748bed73mr71770161cf.37.1783449393981;
        Tue, 07 Jul 2026 11:36:33 -0700 (PDT)
Received: from [172.17.0.2] ([172.214.155.232])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41ab77e7sm120775041cf.3.2026.07.07.11.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 11:36:33 -0700 (PDT)
Message-ID: <6a4d4731.0298835c.1de39a.0ab7@mx.google.com>
Date: Tue, 07 Jul 2026 11:36:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5254557452567443250=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, prathibha.madugonde@oss.qualcomm.com
Subject: RE: [BlueZ,v2] shared/rap: Add bcs_procedure_data aggregation and procedure data API
In-Reply-To: <20260707174104.2468658-1-prathm@qti.qualcomm.com>
References: <20260707174104.2468658-1-prathm@qti.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5254557452567443250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1123273

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.27 seconds
BuildEll                      PASS      15.98 seconds
BluezMake                     PASS      462.97 seconds
MakeCheck                     PASS      0.79 seconds
MakeDistcheck                 PASS      120.59 seconds
CheckValgrind                 PASS      112.46 seconds
CheckSmatch                   PASS      226.51 seconds
bluezmakeextell               PASS      73.31 seconds
IncrementalBuild              PASS      417.31 seconds
ScanBuild                     PASS      670.70 seconds



https://github.com/bluez/bluez/pull/2278

---
Regards,
Linux Bluetooth


--===============5254557452567443250==--
