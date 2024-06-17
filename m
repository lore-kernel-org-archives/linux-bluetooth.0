Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B766A225AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718649690; cv=none; b=Pw6uoRSzksTm4/jAm2S3a/0txuIU7FzkNsRDUFl7jOmSm19ZUynOQEY33/xsa5APeI/YRhWEyChZ4iiudrft7FWampEVQmkz4cIQxgB5o8zv4guosHLLojVy1HZpsfP3B1fDmHs0/MyuGOx6BlHPB87IF5nROEoikSQ9wnG57DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718649690; c=relaxed/simple;
	bh=T3sBzSfapxI2oyjrLQl/RXavmD0AQ6rDpQCBh87FLNA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IfOo22rg4TTMccrXXOFVyXPcES6ohyDgxCEO/ra5gzzBmoP/CHRLSUMVYAUSe++81o34XeXxHHJcktfp1RBZO09N+yUVXVddf6matZa0bfwkvWZgv6ZF4WomO2/UvcZlk5gSvwdj3txi2VXpG2zMuO6Lb5/W1sCmcytOCpGSwUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA4GE6dn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA4GE6dn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2c6277ef3so3749799a91.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 11:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718649688; x=1719254488; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/uDZBQxFwJSRGYNBX0hFLwz3/tSY+g7T/c9HLL1Z7Ik=;
        b=OA4GE6dn4WHXkhrTuTSPki3doRChplaYzCywij7KWilu/VgB/wZwHJoxcfLvhd19T6
         2Es1i/kC6Mtj/VPJHA1Bb7lxGfPh/n+XnlfR6j8W0k6iQP6mDU2iadIQzWECAoIRV6qn
         +QPXYXegcgxJUvW76RrFnkMyb7gy4x9cpx7AiHI9Ro4U09Q/XdGIKw7TZFVHe0ziGuO6
         MV2+tmFcV+bae8c/ndTgP4dWLRlxoKkbZLgqthY3Tvqnn6zWjB+mgSuLXhymua4TrK+d
         AaCxMXYPRUOH2ItZYqPUUVaGa5gl6FVUVxDtFVSuVfhEtpdPmo0xSUA9MICgLtPQhPG9
         2Tfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718649688; x=1719254488;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uDZBQxFwJSRGYNBX0hFLwz3/tSY+g7T/c9HLL1Z7Ik=;
        b=OjSIJtViiI6aJQqfBsOvSqGe+Ii04AKGfA0fs9egwOe372DeB4+SgJUPw7ZhjyxYOi
         fTfI9VBLpvQphxTin/QqJ9Dsh6Y+HrMv/3RlFHyG9/QJyK/MARzH4ubCuZJDl3Wvuq1d
         OWma1RbqIAHTK5+QxafBn78XIf325LkaPS7+KRFPDMiMk5PXvtgPCo340NPjiqAgqoOo
         /nHV8DWYCea1dmp76QGBqMoPkTKZWivfveMhA5B8/WFkiG3USiRbXKB4UNVYaJDYPXpR
         ev1jjQJeMO8toP5Mkv+Qc5z3O5l/KDLJv2XgKFTWuk/ijlDyTpAk3w+edzoNLMR24sNl
         tlEA==
X-Gm-Message-State: AOJu0YzbfxALbwwEECLnqMBs36yOFYpeKtT6Iy89Wby0y6d4AVCHYVAI
	xoM77htO/41cZATgM3ptQ1RuzTEKWh7ldEBL6O1q+sUXII+pWsXdXwWLnQ==
X-Google-Smtp-Source: AGHT+IEZpafrHmtVfdjdwrQaoLrr/S3f7krumYVH/odZG9YxMUJ0XMhYZyLENc9FPKPLw38OvAGx+w==
X-Received: by 2002:a17:90a:f183:b0:2c5:3f35:9f90 with SMTP id 98e67ed59e1d1-2c53f35a69dmr1287813a91.19.1718649687483;
        Mon, 17 Jun 2024 11:41:27 -0700 (PDT)
Received: from [172.17.0.2] ([52.238.29.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4dc5f7e0esm7349360a91.48.2024.06.17.11.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:41:27 -0700 (PDT)
Message-ID: <66708357.170a0220.437ff.3ba3@mx.google.com>
Date: Mon, 17 Jun 2024 11:41:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0017730178757689818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] shared/bap: make BT_BAP_* direction defines valid bitmasks
In-Reply-To: <8dded7c01676b68e3042dbd0021e97c198a03b49.1718643571.git.pav@iki.fi>
References: <8dded7c01676b68e3042dbd0021e97c198a03b49.1718643571.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0017730178757689818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=862686

---Test result---

Test Summary:
CheckPatch                    PASS      0.28 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      25.54 seconds
BluezMake                     PASS      1745.05 seconds
MakeCheck                     PASS      13.08 seconds
MakeDistcheck                 PASS      180.54 seconds
CheckValgrind                 PASS      254.51 seconds
CheckSmatch                   PASS      354.05 seconds
bluezmakeextell               PASS      120.31 seconds
IncrementalBuild              PASS      1474.31 seconds
ScanBuild                     PASS      1047.81 seconds



---
Regards,
Linux Bluetooth


--===============0017730178757689818==--
