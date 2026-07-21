Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E942980C
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 09:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627322; cv=none; b=Brji5BwvKqySRIO551sikHryGYrb1hJrkvb1SuI2KevsJSaDAjD2filBuqFqjIDIDyKj0uqelTjhzLgUYsKND9bXdzGjY8LhhKPwgkbuOgq+Ou2LzqKnNygtut2l4K4/AvX8VAyWtgefcIdMWMWTzEa/4KC0eRwVEH8OjqHU/6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627322; c=relaxed/simple;
	bh=UscHAw23KQqc9SHVJXD9V8KXPx6UgoLJhfl9J/qpU10=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=e6ZERiEj+uKgIDjQCRn74CRnZ2gA7icR3qxHha6boGbGAAR6mpVjZGKzoKmM2vc+wD15Xp+YDF+7/lfzhCdW6xjk38/1PcmkuXo69x0FB7b+xO9ncWR7JR8F8ydwF1/HjRshFIP6dUm6YfsPVssYHfzNqj/Qst+1nBQV/g4JFc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajrDAjV6; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajrDAjV6"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb545db3afso4641123a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jul 2026 02:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784627320; x=1785232120; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BiiwDzuglBKc/pAIRukKvHTRVFus+P+bX3FWVm/3gYk=;
        b=ajrDAjV6dqHmaXNq6IUdFKKHlO+9hlbUH4z3YLrPWH1QyW26evKaQ1mVvEcPLviqKE
         9ms9oHebpxIlH/AfaNcLld6UazeBpyVAYC7R6Lz7QgaqH60d/V0CUZyugA/rdeTxOQ8D
         yZbXpg40pQ4HUe21RXl2SEMq+p+jhL6+fSk5kjqk3XKHTj4ZXdtnyd2IFAaIjQ1MR7/n
         cJcIrhvw9jSLhIKz0WNyOqS7KiVK0nOogi4g2dccOpSOry2wmDChFmHvtY77abGUF3Sl
         1+1fRUzUGBhQ8MZChXDEGMPOgfQI/IKxdw2mfgDBqKnzwaplrfH5+wTNpowSFsKCe0Zs
         Bdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784627320; x=1785232120;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BiiwDzuglBKc/pAIRukKvHTRVFus+P+bX3FWVm/3gYk=;
        b=LIuhl1ZAfhNzd8FJipwn0hwH6o0wjzAR2hZqciE7Y3a44nxMLLrxOKAm6JkgDx4uNc
         EPC2Bl0Wyr9fprIGEtGTf/zYr8TLhlsmt5ivfBhlJNNXYL50X+g55fuc3cZAkpR/BAOD
         brlCZ9weVGcQtygAsZMAbLKHYM2RvlG2mE2ZVqBiZlfuS+4Ccgn9Z6ZUKJEqDyQ3mIE3
         x7FURMB9qUdV1s7rfR1Vjms7EwBOmdi/pVZ3TUVSCXpxT+7dEfIp3VWxX0tjSrFS6Fg6
         BvmRElwU3mqHPiYNppYswq/zOYOKjyvGCNUTmaDqcscQAXrLBGaYHm6BTsIRzGwQMMtT
         +pcA==
X-Gm-Message-State: AOJu0YzlQ1U3Mk25W8ziARAu8mKhbpoTjST0Nd0U9SZmiL+KZ/YywvBu
	kH+MxYkFNMLtYjUzLv4H+JpkUeBFmihVvyX5Nro+wT91wItkyF/i/nFRQKSeYgE1
X-Gm-Gg: AfdE7cnYVUOviKZgSeEONTAvv/k9n2y3zA2vUF+XbiLvC+ZGySidc3HLd0C/gE6xQwv
	jEnRWbgqyrQbcD+yZ5BT04GP8N7GAWKgnbgRAZgYdDhAq07G8L9sNj/JtXdVqNdaxbbiH9W2ebD
	LHiLRWU1NhVpTpC3ZLXLHknGhyt4wW78wf78NXotki7F80IURucVkE2PyFFttREao5YFFHwtB90
	tfBjlqIEEOcZIy0qmNZ8hV5jq+o3889kRPUUK/M4E2loh9BdzIy1S4L5iF8TXVSgngV/wzRkmfj
	V1M/VK89GSMaxh0PC0PrmL//pI/K3nj2278GkVEVBvhtcddEBSdV58ZX5sq03uvOAeMXAQiOhwq
	ATB2fSCazT3E+bH6qPfb+F1/xpNJUrQV+mvQoOhx2ZzjYLgtudf4/kMTWgEhk0jVQ5M6fwQBVog
	KSN9K2LOs=
X-Received: by 2002:a05:6830:8290:b0:7eb:c8ed:71d5 with SMTP id 46e09a7af769-7ed9aa62f7dmr9959407a34.14.1784627320208;
        Tue, 21 Jul 2026 02:48:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.186.237.8])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7edad918e81sm10522969a34.6.2026.07.21.02.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 02:48:39 -0700 (PDT)
Message-ID: <6a5f4077.b2d2c3b2.48f81.4265@mx.google.com>
Date: Tue, 21 Jul 2026 02:48:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4825465665321704789=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, naga.akella@oss.qualcomm.com
Subject: RE: RAP: streamline session handling, reflector setup
In-Reply-To: <20260721084121.688467-2-naga.akella@oss.qualcomm.com>
References: <20260721084121.688467-2-naga.akella@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4825465665321704789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1131452

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       PASS      0.50 seconds
BuildEll                      PASS      14.91 seconds
BluezMake                     PASS      369.85 seconds
MakeCheck                     PASS      0.83 seconds
MakeDistcheck                 PASS      118.70 seconds
CheckValgrind                 PASS      112.98 seconds
CheckSmatch                   PASS      203.48 seconds
bluezmakeextell               PASS      73.27 seconds
IncrementalBuild              PASS      371.90 seconds
ScanBuild                     PASS      626.25 seconds



https://github.com/bluez/bluez/pull/2336

---
Regards,
Linux Bluetooth


--===============4825465665321704789==--
