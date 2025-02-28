Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C227CCF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740767551; cv=none; b=b+/9ZfraR0sTlpOUssYrRw4JWH+RIix4dnZgxWr/Vn6AzSryxwJ/KWBGETX4vkMLCoKyF6IP+FKtQwa0XlB+RDOJ7nJxQ1+Q0u9WQ+5Yd1V2hfipORlfE2mrQziI0SvZ4R2Yyn+X4E6L5VjUqvdrI3F+4nNoHESB3SdaJdsci/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740767551; c=relaxed/simple;
	bh=3wQuiZVgLXGaEAQbusRoW+8ct68NssYHFpTT56kCqpg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pMDaZ99EI0js/Q2i+UzA5WySt7RQRruWzxD4X1L7g50qunzqer1OECY6IIZjng//QJb2dj6sBpZNLT7rnL2uEKG0KpnPwOElWWdivGDyZadA7jXW2Rkj5QydySwx2Ihl0CO0dFZ0lNehgVUW5nVW2Jw6TgEUtRkla5zJo1/5Etg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kg+KMINP; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kg+KMINP"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4720a115d15so30610011cf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 10:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740767549; x=1741372349; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9Jh3EM/tsxIsTliqoiX0tfQ93fFHHj+dYPXJ5jb41I=;
        b=kg+KMINPZe9iEgMcG5wAAlFf2czHq+8oIDfXa1HHrmylm3eamUpnXKxHwUmaFlDSQY
         H1M1p1z3mFgDME7Oz4fMDJt1GpwBQPOtSTkXO27Zfkj7KipS6CqJ99gKqvJScMTRK2aP
         U1H2N7jjq0CdG+sEg42+V9oWTRo4Nkl/yp18yIY5u428gpotc/qM42kB/l9C10D8pd4I
         MjcJ10DXSmHJiaaYF6kQ9dhOaAqcPJrYi3rPvyJUHsYAiKffbzWNoAdER+VDOhiAjUEZ
         cHFVdqW+TIPdETktfPcyG/TSUslXNL/Fq5i8EWkqCFtxLkp19cvG6e4jt0wJQIfiySQh
         beYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740767549; x=1741372349;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9Jh3EM/tsxIsTliqoiX0tfQ93fFHHj+dYPXJ5jb41I=;
        b=q9rVO3lcfRxbPryKQOcx3IpJPADHKVDBUfNWQ8ZO+7kEEsUELnSke4o4Vt7x54QFAJ
         QxryBjAtBa/jHOC9F0DlXXpOMr6jvCD8Y6yyIPZ4PaPxxzVr4Hx629NXYO36AAe3LQXR
         U5b9msNY+3f25pUUe54MSQbwK765bJOcg5n6w9nNypQaa+JGnQ68fSF/jhWYsGTY494E
         ejwEvtNnL6vv/biu7FqhRxvsywauNq+zHzWqNkTpCFb2hAX/lQiNf3pzhhsO/JPnsxyR
         7VRwz+gIrruEwz2RYVAYGcLPfCF+ewBmb7umBiTvOPErfq1bH+Mp0qUED60QObl51kYG
         uyVQ==
X-Gm-Message-State: AOJu0Yyaktxp8YZpUG7OLrHd58zjOnHjV7USlaq1adiTDqtnn+EqV28U
	9afm6OwIeogZHD9pqfUQWGwTkeOjshqp7/qdSyOezyMXjhfS6UkpQeHiHA==
X-Gm-Gg: ASbGncttYDywSV+oF7LK7QHazAN1pDnh0RwkNgatWZ+WLvI6S9ZSSK2HGQyAoc+zWJx
	Iv5u1LmcHkqy0tAKgAYG1afqaVy9kNzOIGlqg8j5jk5BWma6OvZr2Yb3fE1UU1I9HgNcVyJZRe6
	pmPGyAmnZewjNoCxtrxw1TwQYSZ7NS7W2fpUF3yYXB13jmDSAzqfH3pPZ+WBBHlf/OKDn0wObUm
	16S2pkyDpdZvH1YPiJsYl9nW1NQo6IhgcmgXMhlqWEJ1m+cQLDZDGwxBqq6VcB6q237/I2ULxb6
	fzvg2bGxeKmx2nZC7Rey8p6TBQGh2Q==
X-Google-Smtp-Source: AGHT+IHNjqKExxXERwMt3jZgNjO2IMSsOX4WIpM9VVuW6xPUe3TPiNG91L63sgZLJZ0twJrHORjQZQ==
X-Received: by 2002:a05:6214:4113:b0:6e6:5b8e:7604 with SMTP id 6a1803df08f44-6e8a0d3bbcamr62487506d6.12.1740767549020;
        Fri, 28 Feb 2025 10:32:29 -0800 (PST)
Received: from [172.17.0.2] ([20.57.79.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e89763472bsm24946216d6.18.2025.02.28.10.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 10:32:28 -0800 (PST)
Message-ID: <67c2013c.d40a0220.292a33.a190@mx.google.com>
Date: Fri, 28 Feb 2025 10:32:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2206908712208282274=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/bap: Fix not starting released operation
In-Reply-To: <20250228171321.3465285-1-luiz.dentz@gmail.com>
References: <20250228171321.3465285-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2206908712208282274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=939100

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.22 seconds
BuildEll                      PASS      20.30 seconds
BluezMake                     PASS      1536.37 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      157.14 seconds
CheckValgrind                 PASS      213.05 seconds
CheckSmatch                   WARNING   283.24 seconds
bluezmakeextell               PASS      97.43 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      855.57 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:305:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2206908712208282274==--
