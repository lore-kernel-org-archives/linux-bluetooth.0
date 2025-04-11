Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE582290BD2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 21:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407324; cv=none; b=g8uQz8DlxV6Pg1CZ+pR6x0MmGI+akzUIeuCZ5MmjIbxoE8d9OFifMqXMSjcs6pTtEJdwm4FA4lHpQ2JKgwL9fc4g4WKl4HmDNoL8pMEwYKVImsO5Y77+UvVINkP3ZurzWYmQIZslias8VYa50zhaxcVy0XEQM5k4+/JLOQtXdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407324; c=relaxed/simple;
	bh=zGK1qd6rts8i2Qe0GqSHfL8DfuGip1RXIEACoRDFNjY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BlyFxe/HUpQLYJTI/Ge5OYul3JbNqMbr0RMEX61Nu1qIvSqTo0uLRifym+6c4wCJdwgK5/hwXoatWemSQt2w0cYvYh7dIffeQz5I6/nPL1zCQItqjUNiQZm6Sk+CkgF0VrgBOHf9qyKBUnNDKNIpj8Mp/OUEFrNteTkLp4nG2n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpVaZ47h; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpVaZ47h"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f4c50a8fso21811626d6.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Apr 2025 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744407321; x=1745012121; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1UDTTtynN97HVPwT0WUALQnU/4a1jHk+UFdM3vPgPOw=;
        b=NpVaZ47hLiZI3XXAwjooJyzxBHgZrwmikNJ56NKbPnXiGIus3PVEfQCfWInpxlSnNd
         k34s3zPQI8S6SoaJiI4XgK+worIulun1O8rGKEoeEYQZKRQe962PsyMew+WPBR7LndzB
         23DI1J2j8ffBRx5QDVdyOemfVgIksbgyTL+aFRy9QQI6jcf7FU7hdaSgErjBb5Cbh5w0
         KjaNSUbOalPSaTJsLaP5uHMupm66E7qKKfXmAajpFV+fK44WBD9XZtQ0QNU2bJijHu5F
         lQmYu8S4VOqVkwdSOCL0WapBSfJUoDM8hN4pOiyK3WSqsfVJUA9VozJ4htyU3bnFCVDw
         Hb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407321; x=1745012121;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1UDTTtynN97HVPwT0WUALQnU/4a1jHk+UFdM3vPgPOw=;
        b=AkD52+UIGvwjv49oSeHkTRuiiujM9NL200jPKxiSrNclJifRgVS1K5XpRI6VP25sR7
         UfNjDv0EeGum9AreaH8DrFwnu0oZF0T1mktD+VcMspSizzEIelB6PoG26s1VdmtlaqWC
         sCWTPDeYVt2I7+n4ua/cSmgJzqXEqeOpVsohu1+UkFx4gcl5JxOEp/dzIcTg7Aq+TjPJ
         YQzyvuveg+9P6RHfwLsgtgt5gPjDlDcsU40zkjltduLMKD7yQ0kwLgvYJ+a5au61TN5Z
         2U2sHKB6Q2rAPMIyKZvA+I4/r+Ex2t8CAgsMVOO0XQmzzXF88i8aB+XyhkqG4kAGDN//
         0JBQ==
X-Gm-Message-State: AOJu0YxSSmtCNy400If+2N+xBHefuCdqAzy2bOh22KZzsFQyS2i1aK4n
	rEDEZhQDnEGXWNEAinNMd2sWhi4ihRnfNBxV+h2I3FnueVB0fQjCPkAIXQ==
X-Gm-Gg: ASbGncse0HerCuUXMwyskPOvtfl2ZZLXzRAxbHPO52w8QXyovLauqVzGFdB9y1Wr7Pf
	dThO8P6gchYZTiGyAC8seTTxhzYWwPHGlYgv3my7Wqnv07z2qE49k8U8CBZjTGZvVePEToNUDc7
	qLBhber8Mxul5cwhyqISDfx5FQ5wNFcuqC8LzSZWAYIro06/iUP0lyqOx7kS8grAdvHPjlsqXQM
	5Z2DlbAf5t76pSk/KlR4Cu5e7iM2s3MiWyM73TmWmQDZQOeaqmDlCFygOcnixwOoDulySAHWpGG
	9HsfV2TwA26K52iny8LFiSyijQrHXf6pNmlP3mkphDHrAA==
X-Google-Smtp-Source: AGHT+IFHQ6cwPjqLB1jmyhueNWENojrZqEu7TIYtg2udmiOMlswuagockpEH24gr0anPQojRQKCP5A==
X-Received: by 2002:ad4:5ba1:0:b0:6e6:6c39:cb71 with SMTP id 6a1803df08f44-6f23f18b4bamr58535216d6.45.1744407321357;
        Fri, 11 Apr 2025 14:35:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.47.210])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0dea0806esm41760026d6.69.2025.04.11.14.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 14:35:20 -0700 (PDT)
Message-ID: <67f98b18.d40a0220.35d60d.d60c@mx.google.com>
Date: Fri, 11 Apr 2025 14:35:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4546618065707079601=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2] bap: Fix not setting SID for broadcast receiver
In-Reply-To: <20250411195626.109307-1-luiz.dentz@gmail.com>
References: <20250411195626.109307-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4546618065707079601==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=952626

---Test result---

Test Summary:
CheckPatch                    PENDING   0.19 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.42 seconds
BluezMake                     PASS      2682.13 seconds
MakeCheck                     PASS      20.42 seconds
MakeDistcheck                 PASS      197.76 seconds
CheckValgrind                 PASS      274.01 seconds
CheckSmatch                   PASS      303.52 seconds
bluezmakeextell               PASS      127.62 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      896.94 seconds

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


--===============4546618065707079601==--
