Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6268A238C08
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 21:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765575470; cv=none; b=NEYGUI78CMOP10FkJPvYa+6XWgrCkQ9KqqaJ71lKqbGn9xoD732luSi9Y4qTSqVOop9H4Bl45SvvDEImvCmcx056Ud+ff2aFiiMx5QoIFmxPKxTVPkdKi7OLPAf7wW8FLmIoBbVtWIit9nokXD4V/PX04bFq9aszPsNdytXK1JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765575470; c=relaxed/simple;
	bh=ZVrkfiim3wbx1zeo8abEtQ0AonqgjFPXtCPFkY2wC84=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SoOlzYrSZYu/h5uox7Je/PUg6ivDSam+1uw99teb2WQqGiQM2N21QLieijDRISDGKyvKvWTKBnTELv3DQmRs70FLioEAXiDFeMfoutOPyuoamepnSTD7rZVq1Qc1ArC+E3KAvM73EF1ZNvIfoCOf8vt4Vq/sKYlDrDm0RmYe1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDZ8mfGG; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDZ8mfGG"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2a484a0b7cfso1653050eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 13:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765575468; x=1766180268; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=UhBD4TSDzneKqk6X9R5INqadvL/SqAIc0SSGPKbAAOM=;
        b=HDZ8mfGG0U/Q8CLQxQ53eo2m+XD5J2eZLItLwRPXZocbTQAUA3NoaraBNq0Q3SAJJV
         J5YjwrQdjJE1p/k55puv6uqZe7c9nnEZH8CHT2ioCZGWLFcUm+jsmHiqbXAaLD5jK/M2
         +DQVv0dpuvB6L69GBzZGQwnc5F+w72tbVjLRuG+GatOVP+ghwERFa6/UMG2o9DfF0rTR
         Do8RDbmq36rydCKRavumAxQ5o43IPH+GsbGePRf+s+rcGOMR5g57X3IcjMzDCZOlr8VJ
         3tTEoVXdO2JQkAE7UYKOTPrrWjRMaRSn5+tqormo77Dc6igrRFNKlthJaid6B3WDfcqM
         pT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765575468; x=1766180268;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhBD4TSDzneKqk6X9R5INqadvL/SqAIc0SSGPKbAAOM=;
        b=BZuSbCZt269rKzmyXkT2mdzpYASUNK9ZOhGerGqpiFrHZ4AJJRtoQprD4GycgxWO0A
         qeQaCXO1bN1XOi99srLp6fZ5J+avxAnInBKo8r6IWBVCcz9kiej9W8tCJpKO4b1D/PAg
         rGUzQi+zdCCRDccTkbDzkGv/kJ2Otcql5h1ZS5MujiJWrI6HliX6XXFH/wni1IuqeXlp
         yYcUAnFAevUDXvzXRmXobsCvBPmtCGsIUjrv2jyFm+Vlqey07M+Ny1/m23PgzXKqfsJA
         LpBLJfv8rRxOSJLT+4YDydxyPSKZ/h/el9u8NbImM4a9MbQE8zO9RyHhq9F/8w0ela0h
         72cQ==
X-Gm-Message-State: AOJu0YzQV6EPrakVfIvXgIXUZGpq4hdzZq0moCLAkHbuq23vVhu/efCY
	c3IgBVQVHFUj3yAxk2afTPgdIDtOO4UmJCGbA8Q/HSxBWtzuAvWXt5/+Abnbjw==
X-Gm-Gg: AY/fxX6gcBZtRQ27GKrd+0sUKvvrucBMb/ZZ6zP9G/rMjwgy8jRDjebIgX8PaN7b4DK
	VhkYDID/8C3kbhm3oLeBk7I815TC+LbpBaj/ocB62V1yDYnCVLg6XDXxN5DXn61I5ysFkmRGUCJ
	Lj1Hvr69xbOI8chPosqKcXcUEU2VdEBZM6S/+rVq80ogcoQdP/Jrh+5fRgRyU4lDNDyegTtfv8u
	axSv/6/A2rgJEU9yyPL+NQojfEmvs6X1JYTXK8YoMPlrZBu90Y8gqhwHdEcQHhDhFQl+Ihcq4zh
	0OPX5KClDCeorlduuDxw07QRcFW7DknVC0NF+HM68LVzANiUdVqR8VkzHLyxOegsJVd8tPMk3Jk
	gA10Bb+ijl00dl2+f2o5x+pn4DqJe+Aw5VJRq0MmI4IFcUrIsu4DNWIKD6Rb9xoqoXYWou+NdVH
	Yqk7+xtIqm/kee3VLfEDA=
X-Google-Smtp-Source: AGHT+IHs3iwehxyFl9tUmPWuwDMeLVYSi6SnTtEDRj3IEYbhUHzGp0ts4O53LXEJnNhwD6f7yw6rYQ==
X-Received: by 2002:a05:693c:26c4:b0:2a4:626d:5c38 with SMTP id 5a478bee46e88-2ac1c7af40dmr3255279eec.17.1765575467954;
        Fri, 12 Dec 2025 13:37:47 -0800 (PST)
Received: from [172.17.0.2] ([172.184.214.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac191e1eabsm15893542eec.4.2025.12.12.13.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 13:37:47 -0800 (PST)
Message-ID: <693c8b2b.050a0220.30a6b.c2b0@mx.google.com>
Date: Fri, 12 Dec 2025 13:37:47 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6775278451043952906=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: mcp: support multiple MCP and implement local GMCS
In-Reply-To: <cedc9937c80f336a46ccb6329a909063bb82c50b.1765572338.git.pav@iki.fi>
References: <cedc9937c80f336a46ccb6329a909063bb82c50b.1765572338.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6775278451043952906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1032751

---Test result---

Test Summary:
CheckPatch                    PENDING   0.53 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.00 seconds
BluezMake                     PASS      638.03 seconds
MakeCheck                     PASS      21.89 seconds
MakeDistcheck                 PASS      240.01 seconds
CheckValgrind                 PASS      301.82 seconds
CheckSmatch                   PASS      347.75 seconds
bluezmakeextell               PASS      180.20 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1027.85 seconds

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


--===============6775278451043952906==--
