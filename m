Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934684A48
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652720; cv=none; b=c6mmPQFX/9AIK21NeqMlI/TO5OlKNd/JVAosJew2gGUMGy8Oueo1BG6EsAcw4XYQa2Ahl5Gl90bcb+rvGpcywHL2z45IFQiPp/Y5UTLZCD17I9O6v05OcmKqcvG6XndvanFF5BP4S2ip2TBROx2ngzfJQ8jT96NUBGspoul4J3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652720; c=relaxed/simple;
	bh=PFBwbLOvUVbRe6oSjbUSZhoGqzxmT4Y2BJAk9QvFW4E=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=LOKolcuTT9rBBH9iLznZzTGh2JJMo4MQzMFfciqULnukKXPy30wqt/ylWxzJ0HUb2mA4c4GLABxx+W9WwcGM1HbiC+571N8mqRwWrbnL5Zhxs3VGn2MkidrF3O2M5wgxrByJb07+HIBSJMTekNw8cYBi5URh/fak3c1rl3cwXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksBW5tup; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksBW5tup"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6908b5037d5so2322986d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 07:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709652718; x=1710257518; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=afRRELZxqXfKgAE0NZ6OLfHtqUg5k9fG+TUUBCFoITo=;
        b=ksBW5tupwyC1onfdL5eGpuNozJDU9JDULFzqpTHO5ppicxoostQfZDNa8x2xeKB/Vk
         oLUbE9HlZVfgXG+0sgVni00QaFcKg3hcfJlNGSieVmwcKS15AK+Z+h3edzR6/6ss4FEc
         ba6R3uM2ElN6ITgTinNgmv5TQ7wbp/NBXoPfQ7jidz7GDGwxIGWnPI5Jbo+PVjlv0AYy
         11qvkzM/j3dQqZ7Lsmx/SsN8RdYvcjpTvbePM/oz+AHNou75Cx5e180688b2N0CjFdDJ
         uJ5uZpVv7lfVXhgS8CI0Rf1C1zwGWqoeh5s8ttpE05dcrz3/rchq4kD0Y0hp35E9Q1/5
         hivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652718; x=1710257518;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=afRRELZxqXfKgAE0NZ6OLfHtqUg5k9fG+TUUBCFoITo=;
        b=p/anZD9d4oTyOSUlKn8Y5bqg+YMz/6DHUnl/RRkgyGRwphkZFP9pBLjmYQK0FGvvxP
         ca9hvLUkl+L0DL5xJrsywSQ8xT5jvK9Wg7uJTQv0vBpifxzF0xuotvwKBc+EU2YaDsR7
         LoTits3kAMDHcyjw0L2K9Jd/+vEUXF2DhDWuKc0BsQVvb9ozQjo1De65SC740OcocVSr
         xauwuzvuaxP8CEyVsxUQvSlCjRxy2EFn7/wvIDftekqozhsU9gNeQSS43i4uiO2cNX4s
         Ms9p+GpKL18iWvQrEcbs5Cjlub8DlLiEE11B8WjGniFU87r97X6xIJwsjPmpU+3wg/MC
         +hvA==
X-Gm-Message-State: AOJu0YwWu7ZB4BxZ1/IMe4AmxtUDmy01Rw0Sl+OsNlgtCAcRLNZUCzHf
	H2F3ULn9Cup+ewcLitUIj/qC+RfCwtwqtOhAkSUkpy5pGBr5ptPHnC1AYULR
X-Google-Smtp-Source: AGHT+IHmhqFqpie0GXxxJphBHNU0MUD+iL+mU8pkGqjxKn0R7a9rxZccimdR2P2ejRdt5X0cYiyYGQ==
X-Received: by 2002:ad4:4d4f:0:b0:690:8bec:c900 with SMTP id m15-20020ad44d4f000000b006908becc900mr1365144qvm.38.1709652718065;
        Tue, 05 Mar 2024 07:31:58 -0800 (PST)
Received: from [172.17.0.2] ([20.109.38.192])
        by smtp.gmail.com with ESMTPSA id pd6-20020a056214490600b006907801a000sm2076607qvb.26.2024.03.05.07.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:31:57 -0800 (PST)
Message-ID: <65e73aed.050a0220.d854d.9a57@mx.google.com>
Date: Tue, 05 Mar 2024 07:31:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4532094306850190651=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, andrei.istodorescu@nxp.com
Subject: RE: Fix crash in bluetoothctl exit
In-Reply-To: <20240305141521.132865-2-andrei.istodorescu@nxp.com>
References: <20240305141521.132865-2-andrei.istodorescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4532094306850190651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832554

---Test result---

Test Summary:
CheckPatch                    PASS      0.43 seconds
GitLint                       PASS      0.31 seconds
BuildEll                      PASS      24.58 seconds
BluezMake                     PASS      726.55 seconds
MakeCheck                     PASS      11.58 seconds
MakeDistcheck                 PASS      165.41 seconds
CheckValgrind                 PASS      228.10 seconds
CheckSmatch                   WARNING   333.06 seconds
bluezmakeextell               PASS      107.49 seconds
IncrementalBuild              PASS      671.47 seconds
ScanBuild                     PASS      944.14 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):src/shared/shell.c: note: in included file (through /usr/include/readline/readline.h):


---
Regards,
Linux Bluetooth


--===============4532094306850190651==--
