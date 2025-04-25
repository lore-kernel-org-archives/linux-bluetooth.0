Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4A1A2545
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 18:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745604465; cv=none; b=ufpvDxguaqQpGsuDXGgiXDm+n6aK9uCZGnCMlAOmhguwfhBA2WYNZo4MySZYIWh1hAz+1xvFNOEiRrLonFQw8pteKTzF7kjhSnrOS3CFV658hj50lKoCuAZvXDdn3qoMy53svYkFkUy0ox3+JsZLdXIBVcacjWUD4SuzXDzlGW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745604465; c=relaxed/simple;
	bh=BExdrVAoaHPZSQbOLn//lDaZFuKbKB9uCx4OMWHdJl0=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hP1i2wJz8X9Uc50Ssi+f1A074TXeQzUkAJ+xWyrYAWkrkYogFcCMnR77MAINaTaDVGUWtNEJeh30LtXmjaZJPZy25jUQSPV6w0P67R/QcXnero5ZcA/mAREWyy++zAcNHuGIvhPqIR9bObyjYv+0V2nbj6Tafni+io00G9Dnv3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBrTclsd; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBrTclsd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-476b89782c3so31074161cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745604462; x=1746209262; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3AeMeVDNdrIRNgYutB5gheAU5HG2Mm5++Oc2F86R9ls=;
        b=YBrTclsdGsO/YBejoexSThGgQ+nF/OSJw1XnTU8g8vv8ZgJAoS13Nh32ojR/gpwNzU
         Nal6/BoHApJ2W11K2TFLloqN0nI6S5YgdQWHc932/JIlAq5F4MTTmt/HH7H0t1yK5Bd0
         THzUHff8lJYML0dHA6nBk8GVhI0a3zvjq4I34GZSnFmRmHq/qX+KMofGigrLczE0rbOJ
         fb3Nt7+tlTKOeLFv8KyWasLbZoN0DHadfw6JC9wf5wgtlbYdmL8fXhf3aAyoGE5HTazP
         oIahaEFgHgO/v8NBwvf0ltJRn+dkTswWgWI9gM7OCHhpImrU9U9nYHDupHm0eQSCPoZA
         QamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745604462; x=1746209262;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AeMeVDNdrIRNgYutB5gheAU5HG2Mm5++Oc2F86R9ls=;
        b=TUgc527+O5RA9gUWWl56nb9BA2VdWotZ+/vtH/KqXMtPrjZ9UmMXywyNaRXnIjbVKs
         mnjezkDhuMMV3Vum12i8UpgIxam9m6ixGYPoFlZ6wWCj7Mb4m9tnXPyP9HdFPhrnUEqc
         Stew6gw2CEkasoK5tWvYf4Uq4WJoGCKoXuImUdyZusFzvv6fb0Jzydte3LKrD9KjLLA8
         h4s0ch6eGG8IwN6MUB63GTAT9E2kpedvJVY9PjF8PD8gKPQsKMsFoB6/Eql46YbwEM52
         bCoOgEJivfTBbsbzFRjXgfNppaSO18KdMV0ZZL50L0jJo0LHqtfMwymSArhRyivcoq1W
         BPtg==
X-Gm-Message-State: AOJu0YzvbeBGJgLk+LnMP60ReYPfdKfY2ZMYYlVrlMNbsxgyKgK0nskP
	SPpEjwxV5b6ZjuHIAJyIYu+9iGZUk7KbaTaSXBrp+Ux10EZ+CHZmku0TSw==
X-Gm-Gg: ASbGnctIaZ0Fk/ch48+Ry5OVdT1gWnK3kvCD9NR0g+EnEx6EbKqRv9KIX0nIYH8mrQz
	jsGw6fSQs5H4Nrf+UfdD4E/ACqUSsZboNGdOIl6BuCUCEaNuSGDuqPj5yG/8khRNlUdo+LMPMXo
	PZX6gz/WPyECjJ3SIVYOMXkY7rnaD+L0RLKpG48UdmsAMC4rzm3yGQ6rLpTj0eXwR5GHc4XKBu1
	1iu6XlBitucukLyJgCs9AVIOaQuZJRGETMq6/Tj8DZmaEeyBUGI2cZqnCMXrhcxA9a7PkTxWqUk
	Nh+mNpIAhaEgSHsN5b0t0oRIJIedZrvuCYk3kOUBAzkpRrrg
X-Google-Smtp-Source: AGHT+IFK54UGD4rql/fcq4/PYl7eO2D5jlgAwgTDo71L9k/bDZVRlCmELwIvQ8t7JjfQzzG3UtAh2Q==
X-Received: by 2002:ac8:5fc5:0:b0:474:f97d:51c7 with SMTP id d75a77b69052e-480232175e3mr47770571cf.14.1745604462400;
        Fri, 25 Apr 2025 11:07:42 -0700 (PDT)
Received: from [172.17.0.2] ([48.217.140.171])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9f7ab516sm27924941cf.38.2025.04.25.11.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 11:07:42 -0700 (PDT)
Message-ID: <680bcf6e.050a0220.2b5032.0b38@mx.google.com>
Date: Fri, 25 Apr 2025 11:07:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6377000001377903517=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] Add support clang-format
In-Reply-To: <20250425164435.1482617-1-luiz.dentz@gmail.com>
References: <20250425164435.1482617-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6377000001377903517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957118

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.48 seconds
BluezMake                     PASS      2689.64 seconds
MakeCheck                     PASS      20.56 seconds
MakeDistcheck                 PASS      195.86 seconds
CheckValgrind                 PASS      272.67 seconds
CheckSmatch                   PASS      300.07 seconds
bluezmakeextell               PASS      127.11 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      898.34 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6377000001377903517==--
