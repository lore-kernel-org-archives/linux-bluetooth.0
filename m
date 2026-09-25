Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735B36A01A
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 22:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790373814; cv=pass; b=HlWOxg0BioQPKJg8G/Ova9Q97PsOhvn0Jeamjp7ZZjI/6TDfOaqtdxMEEV0ADlSMXHXv/YGV+L+k05zpnejaGnQe3jcJYP0WDu1aoG3Ux9ZV87YRHAHr1Rdq0r1DwwOm5wREwf3vKKZHGVvxMLjwyhbaT01lXnE4KWBYAK8PNwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790373814; c=relaxed/simple;
	bh=Lcao4p+EGJJ0x7aN63ShZBpRflY9ZXYoH+cmzuRxmaI=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Content-Type; b=CSt1avDcI/CB2Zf1SBa5492gVJbEaiIwZfkBHDbK+eSQKIv+xwLm0hUkbEJrbeW5xAnW84N4PMnJuqVqwXDCw9F0HlG5j2ppG2yQgn+PQEw336dUPXGIGsFB/nIe1r6LC5zHYAMuZuXm3h88SAsL3vSHyMajRCoktUu9gf3NoPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQEY1fxb; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQEY1fxb"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85f0fc1fd8eso783835b3a.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:03:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790373812; cv=none;
        d=google.com; s=arc-20260327;
        b=JoLc+jmV1bmA31zbZbU5RSHNlMvhHKAmfj8D49z9qTzG1xcWiCOgIEuOq2eYX+nPIZ
         zzmTKlEirLH3vU5YBjhiIfPQXNayUsojgZQGLiOuQZFB6wbKBVdQK5otpLeaEmQFMTiF
         uglJIkQL0xOAI5y0LIMACNWS2WtGr5HqAd6SGBjFzVNu4zJ65HjghXY60wp/Z1F+dD6d
         tr32DQqNH57aTkfMALY1pD9HY/+VrlazuEEfucCjIju6AHrCN44YjRhJ9efKjGzTrZc0
         x8IN/OQvXzjhqVZcuHfwDKZdGbp6aysY4YA9I3ZQSOtVUSyezXGb8UkHPOkGLIcJGqPZ
         tUTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:references:in-reply-to:from:mime-version
         :dkim-signature;
        bh=YOocwZ/wTH0PVvN8PL1MJRr5ftLydndjljbUNNFN2Mw=;
        fh=4lGQI6056MBa4/oovMyIYaKLn+Wz/24RGvUivMmQP8E=;
        b=EakgSRVTCZxsYU5+inaDkaTbi3Zi1v0u+voFaQzStr19KBYkO3mHHML0FhOElgVEIa
         YR7efsVRhvYH0anjURYKmvlKSbsLChAtV6RtviGju9JVBX/ywrVMXiSUEAKg1fd86RGg
         YJ0DKP0YbUFtW4ekzmraqO/H1Y10iSU6YXdlOuHo0kZH9lmdOPtKlnDBHqIDcwNaEs9t
         PvesMTCnhTH72gPVpv6YPdeGFFehpgJFAmaZnMTjSPDrWHc0M4SOzkDn870Zv03FFn6j
         SCF+Jd0ybv0UeYyJSRhBQrXadvgyabi7yIAi/bKVdg5769qBlwfxyM15Kj1YNGuy2G9w
         DLSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790373812; x=1790978612; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOocwZ/wTH0PVvN8PL1MJRr5ftLydndjljbUNNFN2Mw=;
        b=QQEY1fxbYIXmuZJsbcmEaLP8jDOGVZu/5aavZW6YawlkEMI+TEz4OCx/uHIAaVLIoe
         RcS/xSSjyUIS6qeJkizEH063rniUkggNPTg7sYC0Xrplk5msa0uHDTDBOf08bOH7SItV
         DT0VcEXcl6R+twL5fKmoJn9Fo1jZ06UL9ehTxS+MuvxBDc24nnROlPmKQZ98DJa1+qIu
         dXIYSiD8TT2pUICGNwISfWPXpy1CbPb99kHLsaG8eRBaHnTQrzAb9q9H/JYpAjX3gFe3
         ccY6kFqSL0aP3itLGHBsa+6MNI3YJ4ahEDd/FPB7l/tZcoWtedlDDvIzQHrH7synh7XI
         5YzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790373812; x=1790978612;
        h=content-type:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YOocwZ/wTH0PVvN8PL1MJRr5ftLydndjljbUNNFN2Mw=;
        b=e55hrT/fj3BqA2A5Ht0vozDVH3Pw7rbeYBqY2c0JTDSFX2hIRs+9sGLxpZIr2wtHhA
         Gwj9OJ2Z3ZkDxdPQdbeMouSCZrRsFO0tg8/fy3NyX9cv7Q2Trlz3kJFuG0dJhf0W06by
         A69HVv5XqPdl6Ia59fAkVJyInALc3UZhMFaSjcjenrE5Cg7PvPKev3dh1i7S/GkJhaoM
         vCJpGjdWda4sdfKNnyulKLQPmEhkBAHV+TCRYYE4iekM8d710KfkgP3qil7GnOEzCVme
         i3M1pyIf9bNM238cvD+tg+4Q9jo4FRoxS62EiuN3cEiZp25ndmzDtd1UamEgSf7vGdGz
         55QQ==
X-Gm-Message-State: AFuF++lD4E5EK9H7OpOaBTPCTuxHP1X9pDX6pQocbsBBiVf2NGMlSQzL
	Wvn4M79NS5lZPdHqi6xwwrkZKXnM7SwENAiPlIdsHM+2RoWRrlnkiRvhrAgVOAP50/JN6iFKcam
	SOUaQ+9DXusLB9WFSYWAbGrYW+ow4ewxEzg==
X-Gm-Gg: AYBFou2vp3TuoSDUCsqf3qJ8eLx/FnVPfPxSaOHdcFqT07ktE9ObHMQPB/q7pOp2Pp4
	bFR91V4UN7mmEgu8lAgdQdQ2E4ucTSKzom3IdgfDcAXQq0DW/4zcRjWq6EXla4ldUGT2BJVX6le
	eJJvnYF56AVcnqtYi/t4HGx3+8NIX7U9Yz68YScoqPv88dH6Nak+8iUt6wuxdsIO93BhO5NA4XJ
	DcORo1uHTgkMj/9diUUo10B5OrlNHawXzTEAoZrY4n6fvBn8fzrRZtQpYtFXwjiqhLBb9TU38Em
	HMxF4aTWhyUkRbCCzQK4kmmURTEvC2mun6R3cnRDRQT0Z+EGeS5Upg==
X-Received: by 2002:a05:6a00:7606:b0:87f:1e06:8843 with SMTP id
 d2e1a72fcca58-87f1e068aa7mr4015621b3a.35.1790373812090; Fri, 25 Sep 2026
 15:03:32 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 17:03:30 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 25 Sep 2026 16:58:14 -0500
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Fri, 25 Sep 2026 14:57:57 -0700
From: Giuseppe Piscitelli <ooonea@gmail.com>
In-Reply-To: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
References: <CACmoRBYhQg2kAp04fFeNyArgQRoMHpBwpNX3b0-1knp6RiLpWw@mail.gmail.com>
Date: Fri, 25 Sep 2026 17:03:30 -0500
X-Gm-Features: AclHuK8B0PnGO3S0x1B4Bmioguu3GRsYdY5amTT3YRUrJyDywy2I8PYd4IgJyqw
Message-ID: <CACmoRBZ-pHuzAUrGK39O_1s1xkbvH5GubRnqtuOELU-Cv8Q6uQ@mail.gmail.com>
Subject: [PATCH BlueZ v2 1/2] input: Reset report map state on detach
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Giuseppe Piscitelli <35407790+ooonea@users.noreply.github.com>

read_report_map() leaves report_map_id set after a failed read. Detach
cancels queued GATT operations but retains that ID, so a later attach
cannot request the report map again and never creates the UHID device.

Clear the ID when cancelling GATT operations on detach. This also lets
a reconnect retry a read that was still pending at disconnection.

A socketpair reproducer fails to read the map after either an ATT error
or cancellation before this change; both cases create UHID afterwards.
The existing HoG and UHID unit tests also pass.

Assisted-by: OpenAI Codex:gpt-6
---
v2: Resend without quoted email history; code unchanged.

 profiles/input/hog-lib.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index 6c75c60..2b6dcae 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1908,6 +1908,7 @@ void bt_hog_detach(struct bt_hog *hog, bool force)
 	}

 	queue_remove_all(hog->gatt_op, cancel_gatt_req, hog, destroy_gatt_req);
+	hog->report_map_id = 0;
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
