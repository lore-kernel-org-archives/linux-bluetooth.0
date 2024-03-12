Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DFE13C9F7
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710263020; cv=none; b=jCYBF9TCoMzuZguxqoQLpDprRB+jz2UW0De2oVgVoqIoPBvweMP/fvCQwQtbcLvpWbP8oLj1uAbwY8E1nSJt4J7twUbIVpdCcvSF9367d9TLKZzgtTZV2SBdbpy3OB1mYihAh/ev7wpILCPCGY2RPOujRNww9XRHddZv5pTaKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710263020; c=relaxed/simple;
	bh=ODqr1m61GG6b8j2yA4FpaacTNSnLFiGMdBhX8ZUJJvg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QkMIOQJLe+MLOZJoWV/oeRI4anGdyZwomdLNm/wDcjsMz+1t7pTvGqwlgS15pyhxVIiSgY4MW4B7Jl4YouozbFok2FcGw0FdRP+QPXqAtRt+VpIG3rHKxkFHTq9Gdd1h/M4VNR3bW5WT8JU2bbKs6/u4AtmnU72STYMd2PYeiec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASOeuprh; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASOeuprh"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e622b46f45so3449685b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 10:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710263018; x=1710867818; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VtVaXt+o5+6QdmKMl3LmrSaxnLxwg97RTKpb29oV8n0=;
        b=ASOeuprhuppp7un5p6jlNaVySdrKoUZbdX93GJnDpDN8KdUfJmh0qxXNorTa5xqYAG
         7E7a0qGtert/vUN4Ei54v5LAkIu6dXMqXcbsA+HzW+5GDNw2s4glaKTHNThv8k6WxfnG
         shxa4IlpI7PURCwXB/xnykFi3HOANpVbC/7cFhNTpe3jSvo+Na7ajpfOPLb5Dtd20f5b
         2dhjwTdBe22S1kCQU1KjCL/eXb3rawp9Y//W93VOk2pytsFdeq7XhLbnTptam7YKO/UY
         e+c7R5WZTxmV+IjR4PYlAOOH+y3JXNCnhWRqaaoW3f7MIqjTUEm5ZKtkdOup+Thniis7
         5DvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710263018; x=1710867818;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VtVaXt+o5+6QdmKMl3LmrSaxnLxwg97RTKpb29oV8n0=;
        b=ivXvs2uP7tQptaPhNd1nDlV1bj0pzOEcDBZnpXYGVrcyx//zg4Q6TnpLWcMV7kqnpG
         uKym168epB8hRc5YFdaqoBNclGvdv0SBJuGdPG2gt7xiloEPB1ji/JxXlmJbUzY6dtbV
         6pee8ljS4si9isk4SmsA5F9rbANYprhVOhkamTdQlw94eYz85LTbsjCDhkzJg4KjPSVh
         nD6RliTTUtrQXTfJv2UHyTYVnAn3NbrOWoNvCMzWQCDZj6pJ4VeuZLqw5DMgQsyIzA1P
         FFl/+Qx6eJrKlS9LPtl471724lTookXv/ocrAIzcCkCWBWIHFT9UqSLu1yFhi0w6HIvZ
         CNPA==
X-Gm-Message-State: AOJu0YwAgoE5qPUpaVyZ/fl+yfvC09gUxHhZvuf2eDAfLpw+cfjzxAqP
	HfsWz8Th5qqd4gAgDQfYzWwb0tQZ29TftpAspdMLffqDVU7YAIYTvhyO4jlE
X-Google-Smtp-Source: AGHT+IFIbJTNua1pJ2jwsr4hNQZbC4n5KI2rR3QLGvG7cg7UC9O9aIdjdRFwmIyQ1o+jeGM7dRUUQg==
X-Received: by 2002:a05:6a20:3d89:b0:1a1:6db8:1a6c with SMTP id s9-20020a056a203d8900b001a16db81a6cmr8552367pzi.14.1710263018046;
        Tue, 12 Mar 2024 10:03:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.172.17.139])
        by smtp.gmail.com with ESMTPSA id t6-20020a056a0021c600b006e689b25e38sm4783657pfj.90.2024.03.12.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 10:03:37 -0700 (PDT)
Message-ID: <65f08ae9.050a0220.1e8c0.e965@mx.google.com>
Date: Tue, 12 Mar 2024 10:03:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1141950838404519819=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] client/player: Split unicast and broadcast presets
In-Reply-To: <20240312151740.1105289-1-luiz.dentz@gmail.com>
References: <20240312151740.1105289-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1141950838404519819==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=834682

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.21 seconds
BuildEll                      PASS      23.93 seconds
BluezMake                     PASS      1711.76 seconds
MakeCheck                     PASS      12.78 seconds
MakeDistcheck                 PASS      175.10 seconds
CheckValgrind                 PASS      243.82 seconds
CheckSmatch                   PASS      343.98 seconds
bluezmakeextell               PASS      117.54 seconds
IncrementalBuild              PASS      1424.34 seconds
ScanBuild                     PASS      973.80 seconds



---
Regards,
Linux Bluetooth


--===============1141950838404519819==--
