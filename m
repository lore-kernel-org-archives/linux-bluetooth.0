Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60BF47F7F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 22:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712876274; cv=none; b=UFQEAUaNZrda5D5JFS/8d7jtojfPIH303M+xuxhwQBSRylwPgwyvB9ihGn5nZwZG11A3nUlpf0FF0rORgmDnrT0qWMNy4VLLCbOsWa68GKHZdY9f3862VJVSNvz1t8XlWvhp1rjE83e/4lcYmmu/3wD82Hw9kj3D+aICsprSSeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712876274; c=relaxed/simple;
	bh=bFZprlrRBI+wWI1dEy/raOfSTAEnIh+Ih03uRNzl7+4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=rUSrqVOvAAD7+pxzb2qoh8/j+Fv64h60HShz+Iulmoj2fcu4mxt61uRp980nOhCB0UJMApD5RC7EtYVWuI9eVXABKhY9kYKHQI/9REIl6aDt3u88I3aJPp2Dm5YO1dnwhPEkgq61V7HU3UFr0MJzpMLpCx2dcSCYO3ljMZO//do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESvWi9JV; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESvWi9JV"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbc649c275so153828b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Apr 2024 15:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712876272; x=1713481072; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=k3W7yT0z897YKJ6vSi6KACa7IF3wTUTyqSZ8KoknmoQ=;
        b=ESvWi9JVt6NYoFBhc+w6uMloikzusjPOopF2C/LFbNnWat7Oghrs9F1Fzz0KNTU5EB
         d4VVSw3Rxa6onj/2nswqJUl60nr6ZoWNXzTlwUayr/iMR0AYLzyjihYzI4VsTzdiBGhE
         kRL94/L0qQ7tNdTvmOrqxtXjbThuZvBtAcyGDbjCmqDCaKqnjWU7NIHNm2EtsgTw5Bjv
         v4X3cOR17ZCiUP3oSLvrZ2iJA6dFdFle8Ac9qtNB934PDopvE6xiDO/Kcvzu4mTs/bTt
         nyZ5KNx5sQBvLGn6nDt5HGeloJkhOpf6o5MzlMtEVb5q3Aaht3n2vlbHA3cLY6XRvi0B
         I6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712876272; x=1713481072;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3W7yT0z897YKJ6vSi6KACa7IF3wTUTyqSZ8KoknmoQ=;
        b=fNp8A6wPNDKTY+aKgYV054wb5sC3CV1tQZFspDYB6S/wI49l+805fe1UcYKhK/bZeK
         TwUF1KNRqjgVPMA6NmOxQSNW+nHL5Lg7t3Oxmpr6li8U48q4OtgQGpdCsxgJFvaLL8jY
         fC3Ej/aodg439F5rJoNdAtDUHb8nAVNTwl6fM15ig0d0fFxumomSbZ8pJJ2RomESYvpO
         BTc1A9Uv4WO1/XzW7IVId91dQRB/YBJ8LVTFtyPm7mkRgkNtp6DD2oh3xFjSa4EcL66k
         M2uPL098jiXGoyPAZMM+5JR/eL0pB+FBMmkf3IS16MtTkSAwgV1JQeybckSMwFXN3UjY
         pvog==
X-Gm-Message-State: AOJu0Yxb7bh+O6v4qIBYDm78n+iN4YJg5mEHNnn6fdv+RdJsx3m1mwjI
	vyk5cbJTxYELjSIwvIZzo2bD/8598Td3xOJNq6kJwkdh2lgqO8zmmmpwCw==
X-Google-Smtp-Source: AGHT+IFcm9AOlYR5kBIN838Vgin300+W1BMwiQLZYwzQV9U68N4l4F60thpYJocJUf8C/hea8GhZ+A==
X-Received: by 2002:aca:1205:0:b0:3c5:f8bb:58eb with SMTP id 5-20020aca1205000000b003c5f8bb58ebmr1052119ois.32.1712876271902;
        Thu, 11 Apr 2024 15:57:51 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.55.100])
        by smtp.gmail.com with ESMTPSA id xx1-20020a05620a5d8100b0078d6e468099sm1589214qkn.113.2024.04.11.15.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 15:57:51 -0700 (PDT)
Message-ID: <66186aef.050a0220.7c6d3.3d6e@mx.google.com>
Date: Thu, 11 Apr 2024 15:57:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0937844175417978718=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v4,1/4] shared/bap: Fix not updating location
In-Reply-To: <20240411200305.183703-1-luiz.dentz@gmail.com>
References: <20240411200305.183703-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0937844175417978718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=843758

---Test result---

Test Summary:
CheckPatch                    PASS      1.85 seconds
GitLint                       FAIL      1.44 seconds
BuildEll                      PASS      25.04 seconds
BluezMake                     PASS      1714.50 seconds
MakeCheck                     PASS      13.76 seconds
MakeDistcheck                 PASS      179.88 seconds
CheckValgrind                 PASS      249.74 seconds
CheckSmatch                   WARNING   354.55 seconds
bluezmakeextell               PASS      121.59 seconds
IncrementalBuild              PASS      6157.17 seconds
ScanBuild                     PASS      996.33 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[BlueZ,v4,2/4] shared/bap: Make bt_bap_select fallback in case of no channel allocation

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (87>80): "[BlueZ,v4,2/4] shared/bap: Make bt_bap_select fallback in case of no channel allocation"
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:282:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============0937844175417978718==--
