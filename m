Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508010F2
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 07:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454091; cv=none; b=eWndynF0pH4b0feeLUDjF0ugCp2QupfKCMYQLP5akBi5y86mpwyL11ZM2fWgkwNxBuu4kbI5dZufZplf0MDimjvwEm5EClzKRTYbSKEH6S3+7z/IHOXsjJ0mALlsb8Q5rwobTv8Vk1z8tss7Tq2V4Lv/BDgMQUL0S2yqX5rVzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454091; c=relaxed/simple;
	bh=nkNI5OGWtPHzGenrRiPOu5iblNYkEAyBT32UR18YFuk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kauu+Ofv9G748rn3B22C2GuxSnjs7e2IDH2R2JiFq4Cq/El4YqciRAXAfxPRrLaq1KiV0zswV4G3ts02y4Fwof7/uGTj2CMoomh0CSmH+PBg0xbc4XSR2NcDI3VqOC3qSeGhjUDkGTytW1TuyTs8nzbol0H21Z/bQcLOYQyis1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcrTLV0E; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcrTLV0E"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e864c4615aso301879985a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 00:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756454088; x=1757058888; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NIXY7ZiwkVkhcs41LD0LhPBtOeJA6QoFcPePmIzbn5w=;
        b=jcrTLV0EAccjvYNISczuB5DINLMa2JefYIZ+nxhVKOvHGEkxl8KloZZjrWFofXE6/j
         Zs4auZmJq7MN/Ls776qQslAUGL0YB212REIQo8SODQlhnZAdJGOILkreFGuxQVnPTIxO
         PVso/QbpeWa7VGDgrVhBOjiZXZuww0J5CauJzqUuLshe7SPfZUUlLfmAVmwBTwpVT1QA
         Yjxg1sKDlBJwsvsHNjD0HMXksEwJRW6tzH+ekWqkzxBzyNKDkmsYTp9x+3jK1eCkAGA3
         H5bdpeTF5ZIU2oy+xZr4zn64EDlX/athJCqI1SBTuf8XXSkNSQs4Ye11VGFwSNJ9Edct
         MdXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756454088; x=1757058888;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NIXY7ZiwkVkhcs41LD0LhPBtOeJA6QoFcPePmIzbn5w=;
        b=L9kc1MGQdiyK/UIdhHmdOmDzMLJpC3onW47ACHmOjN1f5lqjXHW5pF03cZN0qCigho
         yXxpXOaDftZZw5OCDSh9D5vikLweKYIAn8P5EzI04hk5B39UShgR/1C/isUeiAMGU9gC
         JGZhMp15thZi9BZOE+L9J4OShqS+WuEpSnEI03Z1xfUdkjVvSYCendlJj/2iZ/iHsUlf
         aA1naOnAA5nULmrIh9zuRWz3ghIQwUbVjqPdzpsYsMvkd2WTE0RVUec2qKmvtDulIHNo
         hUghT4XksjZ8YzxMB0Yxh13T2aQDgWBeXIbdmfMCTqEubsAnrzkBUucHRd4yfJ9W4xxX
         YjfQ==
X-Gm-Message-State: AOJu0YyEGiYpBhayRkHRHjZeBVl/Xh6//VPMOTZM3Nb8YjHZf1FLmLqH
	S//LEDo0UhxQ7PyCIgKEEzWVu1GT7KlRm62xePBHk0FBw8AtCxXCzwvNXX7s8w==
X-Gm-Gg: ASbGncuXnclYhezAs91IDaC4v8AfJXq/zZFBxtGjmy0S3bW42fIgNschtrLw0nQ26gf
	G8Q3//1N2RGR4oMVjSK5m1esv0+Nlb4QKY/X927T8ttFhhJzNNZrvOhNs4nFO3U2xMvBQ2ZF2Q+
	VMJpE0MBXyMxxOXOj9tursX6tq7RA5YRUlFIVqJNWqe/WaDD9l55krRy9DyjSGqf8rUXwYDfZXe
	PgkDtQWdGcsAe9LCux9EZF4yBa4+GQr0GJQ5kMtVQkrc0PKBFIEtJKFIQhtVgINd5cEbkYTuaoK
	ROw/8JqP+nVliSIWwr8o8iKm9KgriPgDKbmzmyYvhIhmqlcvXdpW9SHyBpyiU/LX0T1GoNWNtC8
	ohsGRQkCVnLe/Rax8xwxJYb6+V4ABS4o=
X-Google-Smtp-Source: AGHT+IFdmKmlYikw4QPxdxpasuBfeSdCmyhBO8eaknLRyLv4KVLS7VhoVDDOK9YeJdFkhrOo/lFJog==
X-Received: by 2002:a05:620a:29d4:b0:7fc:a265:9024 with SMTP id af79cd13be357-7fca26591f9mr152809685a.40.1756454088226;
        Fri, 29 Aug 2025 00:54:48 -0700 (PDT)
Received: from [172.17.0.2] ([172.178.110.245])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc0eea9ef7sm135783885a.29.2025.08.29.00.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 00:54:47 -0700 (PDT)
Message-ID: <68b15cc7.050a0220.5c03e.49fe@mx.google.com>
Date: Fri, 29 Aug 2025 00:54:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7172056331788304112=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, fuleyi@uniontech.com
Subject: RE: obexd: Refine error handling for agent authorization reply
In-Reply-To: <5242DC7C99E5FE0F+20250829063342.421365-1-fuleyi@uniontech.com>
References: <5242DC7C99E5FE0F+20250829063342.421365-1-fuleyi@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7172056331788304112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=996765

---Test result---

Test Summary:
CheckPatch                    PENDING   0.38 seconds
GitLint                       PENDING   0.38 seconds
BuildEll                      PASS      20.29 seconds
BluezMake                     PASS      2512.52 seconds
MakeCheck                     PASS      19.88 seconds
MakeDistcheck                 PASS      185.23 seconds
CheckValgrind                 PASS      234.97 seconds
CheckSmatch                   PASS      306.51 seconds
bluezmakeextell               PASS      127.45 seconds
IncrementalBuild              PENDING   0.24 seconds
ScanBuild                     PASS      912.87 seconds

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


--===============7172056331788304112==--
