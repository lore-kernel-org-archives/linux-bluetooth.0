Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB324233954
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781989671; cv=none; b=PLMbN0nCvLequ0CmMrXV9H07W9A/15x2JmsD1hhZdsTKcKnP67hi253EmNF9Ulpkpv8g2yTK06KrpK5QNK1YU0j2aCY4eiDYRGUNYPZrh5vfQpcMKV0/smbvVdUCn4okh3lIeB+hZVv/hdCBwOfnnHw2BamYBgEAB2j2URJrCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781989671; c=relaxed/simple;
	bh=Jw/4rgQl0FjjSPdl2v57/piQxlMumjKPhnoa1KaVtMg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=dVr9qt1oskiZcXf6qi24uooGMQeAePVL2Kg44QbDHmF+IS+tNLYwo9vcpY3qio3nZSd4VsobeImLxZbZO/BSgMKlQAakZd1XRlaOAOL3LlAPviAcDflDcuElcEDmkvDz70ssqTdvK0ruT77LY6JWUL9PQWE+3qcleYjAVdTt/xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmYhyal2; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmYhyal2"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so5397101eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781989669; x=1782594469; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mP3envg4D7UTu7OtXxo3YStvaZfBIYlhV4l0cEm3oLg=;
        b=kmYhyal2BpY6cIdxyrNbBg4VF/qw0Vlvr2EdL+BF5DK9CEjsBjJgbxqwbHoikOlMJi
         fZRKxCcrey/Z0c2d4Q7niNKiFt+oWgDVPZuQ/me0HLf4TJBJnIZyRMoHIvJwSqBYX2m9
         Z1AwVXMMIuRZVwwcaq7m8Q2tSOn/Dw0HAUtYMg/NF6zUSB9Bt0MAHuzSqxEMM2xFdPcy
         kdfQsXzwYaEphITZrUnO0VYBvg0IukrAUIk43gsA/RfGVy5gWKUi4AUal9/3qgTtvp8N
         km9eakzEsEwuVHaORBvQVn60dJb4WFqVG6wvmoWxC2f1Hkxsj6eQAfHf+fu2CpodIG42
         +Ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781989669; x=1782594469;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mP3envg4D7UTu7OtXxo3YStvaZfBIYlhV4l0cEm3oLg=;
        b=i5TiGCwmjpLiqPu1EKnHamalVDPTIO/SpOKr05kgBCkYJCPj6AH8s2DwxNAGikmcqe
         asce+wVK++9zmY1WxIzd+PpJl/EasbJeDiCNnFIsiOwxFPccGzxcpAWQsmqCc26pWVS4
         nKSg/NxiA+Awb8SQaJ0g/W+Lli265yu5PCOY/qLrFev5AvNbBc/Rugbmy63GH2Mr7uVB
         oTJ1WK/BzE0/1sSCj76L+/A1Duly4d0APOqRhbqhoboVuOqLo50hdd2pCJs14ujDgGoG
         2ZPWbGCEKRWd7jlyE2K2o4Qhjz2QHtAsDvf1ek7bD0U8n4HXBSLbJHz+CRWpG8rTaBH4
         Q6Wg==
X-Gm-Message-State: AOJu0YxZe+/LGaaHPfXwEXJfm8cJ0xNHqOoOhgkb11WNvL4bwkG3T+G6
	cRhDB1fgSgcJHBkibWw+hTFRtMNya+L36Q74zz6HwisXPj70lsNG/SfkrZwiQg==
X-Gm-Gg: AfdE7cmI86JqFAeUvG2QYZrlbmwzxvndgmLJ4v1OCGWNWezrEeqoLhsOY8hdxp+0iP5
	6VjaVOulvyDxcFgqHLHQf9pzPLMqlhYobFDYSxLa6Ztx0FgeFkdDzWPQjW8IrJ8ruk1dgKPiXoW
	9fv5ahbcGqrn9gC3rFuZpQ58nYdcterPMny487yIcHi34SDiv/R7r5woz4iqSLEMCBnQhcbHG+h
	bEf90dh6UM34Y1GP8OM1BM6GZTeCPdM3Y8YRUaCP58Cd/W/JiINjRiAFZwcp2BaCreG6wtsR2ZA
	KKlqW5PY+xzlgWglWydwjzExb0gp7LNcLkzZuAMYUbdT0MEmaYbXHRBx98YE1OZ++qhRjDnnRPt
	zw8a0FaWqDMU+gQ297am0zQ/r/DI6kngzk6deVNH02jGoHJThJWFbrr5cSSAxKVwoPu0jNshJwM
	bZ7dAZOcdOwMP/9lvJ/5eEng==
X-Received: by 2002:a05:7300:80cb:b0:2ef:9961:27fa with SMTP id 5a478bee46e88-30c1dbd18d5mr3690921eec.18.1781989668579;
        Sat, 20 Jun 2026 14:07:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.209.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba8fb35sm6314532eec.12.2026.06.20.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 14:07:48 -0700 (PDT)
Message-ID: <6a370124.682706c5.35a730.af98@mx.google.com>
Date: Sat, 20 Jun 2026 14:07:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3745954348687784548=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, geraldonetto@gmail.com
Subject: RE: audio: harden A2DP parser handling
In-Reply-To: <20260620191735.2675946-2-geraldonetto@gmail.com>
References: <20260620191735.2675946-2-geraldonetto@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3745954348687784548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1114241

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       PASS      0.66 seconds
BuildEll                      PASS      20.28 seconds
BluezMake                     PASS      655.58 seconds
MakeCheck                     PASS      18.46 seconds
MakeDistcheck                 PASS      246.91 seconds
CheckValgrind                 PASS      297.01 seconds
CheckSmatch                   PASS      350.72 seconds
bluezmakeextell               PASS      181.74 seconds
IncrementalBuild              PASS      662.39 seconds
ScanBuild                     PASS      1035.90 seconds



https://github.com/bluez/bluez/pull/2244

---
Regards,
Linux Bluetooth


--===============3745954348687784548==--
