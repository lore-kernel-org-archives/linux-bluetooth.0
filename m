Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA724BA88
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 23:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707176448; cv=none; b=NfPXVNGTkuvM95ELyTq0rCG+3nUT7ufanit/QGktvQO3+fbr6EolmS7F+vG4QvyipQCyXZg9WKvLLmHPEfUkgV8bsyQCGEJcxYeJHO9W2+HhfTRoPZsiMeNaeNCasehVTI5k5jeAbp5Xa1ieNrB65xDQDG6gTJldtGkICfFpEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707176448; c=relaxed/simple;
	bh=0gk/PwdJVNTYWfQSzXCANTtcWblEUR9v9SLh3iGMzMI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UyFGn83bFaAKGX3Iu1quVj8km6Hmr4DFXSB5ZMnGwx5n2SY1LycVaW11qNijdZUmZFrkwz6Wtn3m6sKRewZ4vUWvqZ+YQiFHT79mz7QAMZUkrgfrCPKlrgiCoreJGIyuIOSnDjeYBrFydxENP1CD5j7OU0c7dcYHsoB8ZyqzoqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FDu9NFOq; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDu9NFOq"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6868823be58so19366866d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 15:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707176445; x=1707781245; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wC/j5PkDq7s7pX2p+yb9YyWxOLvfm4g6NzIjMy/yU6w=;
        b=FDu9NFOqHn4JFbZgDE7EbOqr1JhYooSDZ66kzExU6+SZoTxQ2Icbie+im82WTobo1y
         5v9NNWWTMZX92QJL57rMW4/8zS/YP6cJAS1zr11lFKmxdsSz/PCk07ZGH23irEvQPWrg
         2XkmCAGdnrBadLYhHV849jzyNHjfiSsIZCN85ctG04Xv11nYUsSyc5Kv+FD12SIaHn6H
         aI8dC+cV/J5ZT1Kh4+bMxDcERg/poPifbfdqjJzETqV4Ousjp9o1qs83CGXZ/uQ9LF+/
         7E9v6oChWf3lqpzXHNVX0mwBovbP80GNOtjAWk1fV1fWtBmXOE6t9jdPj19EKQ4vJ2Qj
         leow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707176445; x=1707781245;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wC/j5PkDq7s7pX2p+yb9YyWxOLvfm4g6NzIjMy/yU6w=;
        b=Hj6uDU8LXb7dsF82ecBiNd0mM0vAAi1C4ywaCIUgW//YCXOYoZ3T0wg08n0J/w1uQ7
         7QNW5Ty1rjb9593xb14pnNXB6WTM3xoRim+SeAIqgGyYKl9pk2bwV7mj6m8YMmYL3Dxk
         aqbzxo2dJ4tknZOlgztEvpIPMxim3RiVi7r4+K3zhndz7IGvuZSotpXi8X7KcWWFCKbC
         Bl1lWjSTgBV1suaP+J9Rp/14hD64c0nI5/2AHcmUzSxl1ZJkPELbEi4emfR8d8XGbqqF
         r78tI2MUBvYR8fu90fD10kPuI1lU8d/wrNAeTvSnVNVJSp1CMj64qMsyorR84ccskrb4
         Du9A==
X-Gm-Message-State: AOJu0Yz8Y2p0f2gx6HRY7UjP6UsWS5YZbHV8Ff3tzQ2mB8kaQ3vwonNz
	8ZHWBLVNpfO4r/m3k+HoO1F18p2/DTVKE7rI5WwXNfJvTG/r+mcqsa9AWIft
X-Google-Smtp-Source: AGHT+IFRGdObDnXAAzeGf2PFaJ1qifaVxTRL45D2FPgv60PJiIMzhSycyopOlrR3ERh9Hn/aLg1AuA==
X-Received: by 2002:a05:6214:ca2:b0:68c:6720:fe8d with SMTP id s2-20020a0562140ca200b0068c6720fe8dmr1170835qvs.5.1707176445573;
        Mon, 05 Feb 2024 15:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUMqun3aDTLRMZlZfZGkfOjNIa6k4w+HKZanIjWw+oUIXUPLb8vsdJk0uOPRL7EHmNn8jBUJ/Jn8d02b+EXryP1njxKOQ==
Received: from [172.17.0.2] ([172.183.32.32])
        by smtp.gmail.com with ESMTPSA id c19-20020a37e113000000b00784046b7862sm388057qkm.113.2024.02.05.15.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 15:40:45 -0800 (PST)
Message-ID: <65c171fd.370a0220.cd9f5.3e84@mx.google.com>
Date: Mon, 05 Feb 2024 15:40:45 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6515045338124256722=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v2,1/2] shared/bap: Rework stream procedures
In-Reply-To: <20240205221057.2349094-1-luiz.dentz@gmail.com>
References: <20240205221057.2349094-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6515045338124256722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=823340

---Test result---

Test Summary:
CheckPatch                    PASS      1.83 seconds
GitLint                       PASS      0.62 seconds
BuildEll                      PASS      24.45 seconds
BluezMake                     PASS      700.20 seconds
MakeCheck                     PASS      11.73 seconds
MakeDistcheck                 PASS      164.79 seconds
CheckValgrind                 PASS      225.65 seconds
CheckSmatch                   PASS      327.47 seconds
bluezmakeextell               PASS      108.49 seconds
IncrementalBuild              PASS      1340.67 seconds
ScanBuild                     WARNING   935.16 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
src/shared/bap.c:1285:8: warning: Use of memory after it is freed
        bap = bt_bap_ref_safe(bap);
              ^~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1698:3: warning: Use of memory after it is freed
                stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:1931:7: warning: Use of memory after it is freed
        if (!bap_queue_req(bap, req)) {
             ^~~~~~~~~~~~~~~~~~~~~~~
src/shared/bap.c:5104:4: warning: Use of memory after it is freed
                        stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
4 warnings generated.



---
Regards,
Linux Bluetooth


--===============6515045338124256722==--
