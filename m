Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0933E345
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 07:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792308429; cv=none; b=WofNnkNyU2QHmuA+IxQQqM5/8YALUgbX2XM1bEISXIpxGrECp8ziduL72klkPq2QEtHOQ/Z/f0ZEIjKBkRkwH0LTtg95wv8/SAJMT761bcjSjjUdywRIQc1t0I05sIa5alb3NfNKvCAuM6HvSXOfA86XIibmoNvpWtR3DznnUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792308429; c=relaxed/simple;
	bh=/u3CCwpKHCx50yRUxV8cxuwkLqpOGR0uDvl8+uSJruQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=hvV+ADHb9SYCBCjBOgpB12eOZGUdv8PNpxnVhaaFGq0qnJubktJxK2peqd9EeYkeQT4P2Z8+oVYl5gq1hNzbaZwd2yiokMKc3rz1mkC8aSYFTtGHz31JlU9RCEThcqucyajhXjfzed/tbbvLAGmm4kV1xC/dbEXVHC5rVN1a/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4cTQYEh; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4cTQYEh"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-91b8b456dbeso16722086d6.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 00:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792308427; x=1792913227; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=oZi+ui2lKVTnR8i+oCBNS8n58O4DI6oafYFOUxa3E58=;
        b=B4cTQYEhVaokrqdhezGOLu3pUQ2HXzIy7AYbQqjy6Pv0hmCXqcfDkFVUi0XQOEeedu
         2EnYVAQyPZ7cM0ppx8ZXHuWp5v9kXSiNCHb+4Jgl1xNptg+Lwo3/JZP7muh6rDWvJMHe
         llHIvhx7gcYGC68YgLZYQCRDlo7wRItRSDMIDWNkD0rJvvKLtkXKTAqkUgJPKggADFti
         exgxxELIuhtNPJzQyRy1xvp27FdB48Kk2wV24gvoq7u1/osTQh4Fee5FzhciOXNzRhlT
         fpkR4YACvXfFqdDXIVHtR8/Xxpj7Q9wTq+RV90uphJVLdpkttCgXhqVrN1QdQ/I87cI0
         lkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792308427; x=1792913227;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oZi+ui2lKVTnR8i+oCBNS8n58O4DI6oafYFOUxa3E58=;
        b=nHB6i0gnzo4S3cHkY1lbZY+/foIKBAga7GN1oFOZyHLloBqmeFd1W4z3eo9pFnTO+z
         jOce2Og4IJZKO0jQi2mrvf3Px0OJLACiRsWOaD+pUM7uCIVdxsUn4TiDai9fLRcWsq3S
         KoQH2R398dIeo5yjDaZM9ctZAXG4jcCuuwAfDLiYotW1kg15dHWMYxmNMbCf15j9MYgH
         lAo6Hq3l+0ZZNg+ZU3wobuRodrhMAAe3FAdIKsYVm/znjyqQhmRRTVVZ/fh5pzc8wbFE
         JlQVWUolOrjStDJY0lLRKnDVmGGA7VuLYgG75Wgo7bVRVdsJ+hszb9Mm5h26JH+bVyVI
         AGUQ==
X-Gm-Message-State: AFq9FYIuDGCqDBacJlo1jqb0HiR9KvPMG9srEFhMUBelBhjZoSqohPTi
	wPRNiRtAWvUAxfi2EINMTruIrAFd927seEF2IyGeNLJNN6EyfRCQm4eI/cEKoQ==
X-Gm-Gg: AYBFou2aRmQzHM4Jk75rgvjW4LHkQc5qR3LUZMdwxHaIsZDiaMwVu+Hc1zeUh6uxvo5
	gA4u+baeWiqCU+RhgarTVHh9N84g8cnkHGbE5QlCHi/3JsO8fnnsY4M2kQ17Ed8EH9Y9LQSsxNy
	7LTGAMQQsbMJk1J9e8Jm/04BAid6cwtXLbkccJY+HgFOW+QqBlsxMJUp3nqk76t7qH1sva08KbG
	R6wnrbrLCWZYXNnDJBLPXEbSeXV8toOMA++U6NsgosZlt07z1s9FZMGbsoeVkRl3QgwOWuIzMNu
	kM0w8nhqE6nGTr5bS/9rAQCtNcbaU7SaANH7mbIN/d5ejQsKt3mCC4MM0aATUY78BS8U9Sbqis+
	SeF9nIz1vAkF8TdolgItFEDUHNqhhEMxRKriDJ/SzUsH78QE7A+umgw9UQrBrurBFCZ8uKLh+Ml
	7Fgkn0eXwDwaEJNmd7SBmjzKy3/nY9+Wgpq9uGaSsIDlBRoPtpa/q7fziVUFXcJjRUS/TZViJnK
	AzW
X-Received: by 2002:a05:620a:294f:b0:93c:70da:e45e with SMTP id af79cd13be357-93f29d39496mr749732585a.36.1792308426610;
        Sun, 18 Oct 2026 00:27:06 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.123.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a17f226sm639446385a.17.2026.10.18.00.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 00:27:06 -0700 (PDT)
Message-ID: <6ad474ca.f779b19c.21d526.b9b0@mx.google.com>
Date: Sun, 18 Oct 2026 00:27:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4018087841849403415=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yaroslav.voytovych@gmail.com
Subject: RE: [BlueZ] a2dp: Remove duplicate check in transport_cb
In-Reply-To: <20261018043903.1756818-1-yaroslav.voytovych@gmail.com>
References: <20261018043903.1756818-1-yaroslav.voytovych@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4018087841849403415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1188165/

---Test result---

Test Summary:
CheckPatch                    PASS      0.46 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      19.80 seconds
BluezMake                     PASS      300.65 seconds
MakeCheck                     PASS      3.29 seconds
MakeDistcheck                 PASS      143.30 seconds
CheckValgrind                 PASS      156.29 seconds
CheckSmatch                   PASS      296.27 seconds
bluezmakeextell               PASS      95.84 seconds
TestFunctional                PASS      1115.66 seconds
IncrementalBuild              PASS      297.07 seconds
ScanBuild                     PASS      1124.20 seconds



https://github.com/bluez/bluez/pull/2689

---
Regards,
Linux Bluetooth


--===============4018087841849403415==--
