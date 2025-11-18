Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34534D3B8
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 10:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461399; cv=none; b=qSjvt4x4AiHZmlPT1g6ynB0+DlqtuqcB7c/U0OE6IROGSbULhadeG3T7tSmyTnpmriovhYHvkERSuf2sIy77w9oYYC5n5wr6pO2mVYyJRmrVLiTCmYR065rRzM8TaJvpCzcAGtbRWnAbm6FMjFJj40n/ZdQzweUeHsfDHDwyInE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461399; c=relaxed/simple;
	bh=ZvYOnZKdXSOsTbeyOE9O4RJAZTcZ9LqghZerMyOPcK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=AZMrOmjkPCqd3uFEaJ/WR4tLvaLbAaKXk4uE0JEy1N2JBqWlHBtBG/ZmJtDmBdMLqgixeVnF/4OC9ubXYVcnr2X3oV1kFTmhIQX4Lfc5wODy4PDOJcH/4P9EDvprB5oFx4aYTU0MG7znmegaaz7dD7tC9/WU3/2Acf32+l6KkgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iVmo/zxN; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVmo/zxN"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-9490b441c3bso77728339f.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Nov 2025 02:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763461391; x=1764066191; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RDa07ys1xyaJnPD+EjfL0ary2Rp/OdPrWiBj0Vm+6lA=;
        b=iVmo/zxNm9rCtyBRD1IVqgtShAJfUNf3WELFPh57q6Pb/m4Np8dNqL782uvPz259Y2
         RQb2lBSA2RCJfKj7tX8jfe/Kk0EDF+7JxOJ6QogFMzViiD6+J8ZTtCR6Jt9JJj4+AZ4n
         86vz8xrPGac2nR1/yXAn5sTa/wsq1D+gvOvdFiQWpiaANA0XtFSYY4S/iFaXwJd+pHuy
         Q4fdkzmkhkOCVFEJShnraJrH31vBdg9d1aKxURDQ00NGbEsTrkIZao/MZBMady8VBtDV
         YyO+J8dDk+chWkna7DlTmO6YR/POfu4SflO9q0bFFqm2rV4ZCEEwfaIkEM1dK1PNzNE2
         1VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763461391; x=1764066191;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDa07ys1xyaJnPD+EjfL0ary2Rp/OdPrWiBj0Vm+6lA=;
        b=mz2NiqFBRM3krIxbJ6UdNgzOxgVMLeIFy+19T7pB2rfc72SjCne9EdkfKiaXqF/oZH
         ETZU2s7C73vme7Pz6VwmKSC1HEK5inOHIKNGHOOGRof2nZ6aH4WkbLX98DZNUiLdhkN1
         PJEEAx01zorU3pNiUxegvmk7PGo/Fny/zo5Ui/p1rj6+Jkgf9Skamud1SI2PgNtFE3UY
         3Nhs81KECKAKQa1qiUjVIbrBTD7eadZrAcMw9sAXvXoUULmSEYeKOp6uiG8pTL7ik2ZO
         SMsLJEro/m1INNO1COnkT21ZbAQkw7lIEb/pqmxSLkmpZjLxddtTw+axZzzjI1k7ZgqP
         YaVA==
X-Gm-Message-State: AOJu0YxqKrYOO8TBpGEYlUk4BVHMSdO7nFCxfh5ayZsuNTNtpLUQkuU4
	zmfrtBzdEnK0tvxkEEWO9gb4B72wTbtC6ePtr7IHRiDOj5XIVLjvDHu2brxN6w==
X-Gm-Gg: ASbGncsZ1GBb+x6mGoFzpxSsk+Bg90GdwEIQzPPNCrD0hfSiKGUG1kcs58TAQArJ6k4
	Q+eyA7VBH8jEDtPslLGUhjOapI9tYH5fiQRvhBJyj56011gQrBAHLhxm/jaL64Nk/OLerMiYeo3
	8jA3bk8omFBB/tRQ1IS43sclejpH+/6Hb47WL+USMl3VJTR2LuutcKZZS+RSoWB11B3j/CsIVee
	loigfZcZEch6mOTzXhmCjp6prfrTfyFmUE1PfzdbqxUDLYM5XaHoJX/CronRCTr+h2585p8HWfk
	1mMJ+vFsbImHAkjqoqzhQ8pTzdChNG5vlwk9JKRhDbBUz78xGsMexnUU66bjzKwN3W/VqdAkGwu
	SF9w/29unBtxrUlK9QJYf33QHpgvr9d/LaOXoRVv7/2kwXfKMx4R+Cf17xx+dFE9k1/9Q8MLRF7
	iXZBiEcRPBaV0M4SftBMromQyhgPfLcg==
X-Google-Smtp-Source: AGHT+IGIp2Zo/3sCwcDeNDC/qJKmKOqFy6XWpRx0zxVd4QuyVKs7GD35iMam3aif5g9FoJcnfM/xzg==
X-Received: by 2002:a02:a407:0:b0:5b7:c714:f808 with SMTP id 8926c6da1cb9f-5b7c9df8ffemr10712886173.17.1763461391511;
        Tue, 18 Nov 2025 02:23:11 -0800 (PST)
Received: from [172.17.0.2] ([135.232.177.123])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd315e4dsm5841732173.33.2025.11.18.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:23:11 -0800 (PST)
Message-ID: <691c490f.050a0220.e3f29.9b6e@mx.google.com>
Date: Tue, 18 Nov 2025 02:23:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2539567177471224328=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez,v3] bearer: Implement Connect/Disconnect methods
In-Reply-To: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
References: <20251118-bearer-impl-v3-1-dadcd8b0c75d@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2539567177471224328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1024759

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.34 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      628.69 seconds
MakeCheck                     PASS      21.57 seconds
MakeDistcheck                 PASS      244.27 seconds
CheckValgrind                 PASS      307.33 seconds
CheckSmatch                   WARNING   362.04 seconds
bluezmakeextell               PASS      184.85 seconds
IncrementalBuild              PENDING   0.29 seconds
ScanBuild                     PASS      986.43 seconds

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
src/bearer.c: note: in included file:src/device.h:244:61: warning: no newline at end of filesrc/device.c:8180:1: warning: no newline at end of filesrc/device.c: note: in included file:src/device.h:244:61: warning: no newline at end of file
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2539567177471224328==--
