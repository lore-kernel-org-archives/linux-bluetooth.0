Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED224BE45D
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064733; cv=none; b=dDyKXlNzqQu/W0jgSib1U8fz8rZns05Dg3zjbxuh6H/ZxzDiXhpcskyobh3ryAHk9fQkv8ivKvaNZKgd7Okv9miu74qUJiD1qKWyRi415H5nAXcepmP/LTWFlDa/OvCXNDABokmlpgK2n7tKHFacEnnFVDqmD1x5y/CV7mB7fOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064733; c=relaxed/simple;
	bh=uls9LSFrsCT6aD8cY6MMwbCqWJBDkCnuueGhNZAqLeA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=p108GQThI4s0a6/PU6aURUmjKpu4Rh85dnfmurdI4tvVGYAN46/BzvY34ry+Xp5av8vLen+8v2MxecqyVxEWSmXurOUpi9glVG2SWT7O52Yz3TdWXzXmVS1ERajCjVeLdw/nhxya0Ez+ZnbyZGR8CSwrd7QSKgtHuTymT9FseJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC629VPe; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC629VPe"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7f18c0e03e3so39758a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064730; x=1789669530; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KiLFvQgTvOn1ov5UzSS5t4etJ851NTxNb2KQLLjNya4=;
        b=jC629VPewugAHoJYIf0EIltXAuj9om33ObRZWjrORRJcR6TpSSIDRBNfoS4WYVeqYS
         FN1fBJ9j+gZDjkl0alKvFQLsl6+gTq0OSA3OcT1qYxwGEqKijpKjFNLzKqXI6lLKQAgA
         bhc/rNhYIypFvVmWLllJjhL9khOqFpga1p2FnIJfpvaMz9qohRUOWntSj8OCWwCiF/JM
         4umKdA6PwA0lMc1polc/9geOAfDe5tiFh4J1IgToZarhuOReDk0zjNda8oN1J0RDcWyv
         sZGeMGBI2YT0fiHUsOdRLCL10l1OkXOE5bMCnArUyw8WhmUNBQIC5TTAHMQr6ggkISyq
         +uyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064730; x=1789669530;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KiLFvQgTvOn1ov5UzSS5t4etJ851NTxNb2KQLLjNya4=;
        b=oCHSOizPOrzQ/CKtTxrUiwfI2ejJSDnJo5GGzTeZ2fbEocol++38PVxaqfZU7KUqep
         dxVeOJC1RcNBaHWBxTMQIAo+Jfd9Nwtked4hsnnb4EXLud/l1z2nA1o3+8FkrRnCSkCT
         1UeMmn0AB7wUknAEpK9+mHc4jGJrWrhBzgSCOAuATHWDXuTTxlDZAGc5RAumLE4qw+U/
         puyKmviJF+M7+ITaE49wn9GLrKTAoSdRlFtDJ5WBUPP99rerb88lKsjAyeZsNTzkKN9q
         rohP0RHVirsvyNquAFnDdCxrw8be91VbiGMqRyZGUmggR6Q62U07DVzipLtTDeyXRYhy
         SXjg==
X-Gm-Message-State: AFuF++mcyannJESe1cxUd2HgWp200AeTP9zm1iTeGpUpsIgUgtJQMBBn
	Qt0NVQwLSiZynQT+3vW6x1r5g7R5M5642OYMNXmM1px9mL3BKuTqRAHnXR/y5Q==
X-Gm-Gg: AYBFou1ZpMzKGfrHmzNfH+lfu36txbYbEVL9z8SbncC/KDdYWnxUb8yyD2tPak15cex
	/vsFtC8A96my/YFeoIoluKSZkaCc2SweVBw7mqppjhry0q87/n8UmJIzjLxGZAsUgyZd5j0JszI
	OtIPXH+G+PMKoh+7BdUv5tfHoEPVxy3YTUKh+5nHKt+3o9BYLte/l9gmrjFg5isWKHeoKeOn7Qm
	YFmlKJ89a1gafx1z7JDYdaJdA7CHrpYUE+H9ls4h2edkvesBxglQ3AI1BypfKnkKZj5yw8jfdrZ
	MeO0a5vwErVR5dZgDW8ERU20sL6LRkGDYlVmprT9eNLV28lflP5Nqr1NQ1Wj91hcDnTn4Df0m8v
	rzsTbnR2CtAbD9PgoQc/uhAL3pTjpDJisvWwRmaXdE+cSaR55v7QE70ozmdnXvwB3mis7W7QYl3
	tlXiJf5eIb8iAWj2Wyu0EXUqVsilfaRA1L9uI04W8Om849fCj5ouX+sQb2pTc8+ZADhszYPVwJR
	N9lVxNzkLKaf9FNzA==
X-Received: by 2002:a05:6830:368b:b0:7f4:f1f3:da3b with SMTP id 46e09a7af769-803ff55f5cbmr96697a34.4.1789064730397;
        Thu, 10 Sep 2026 11:25:30 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.192.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f5adf677sm200145a34.4.2026.09.10.11.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:25:29 -0700 (PDT)
Message-ID: <6aa2f619.dd89696f.8e5de.df99@mx.google.com>
Date: Thu, 10 Sep 2026 11:25:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7531546259103419276=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] media: fix wrong argument to lp_get_uid() in avrcp-player
In-Reply-To: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
References: <f2c2db83dbe2a47623828db3e5f4baf476336d9e.1786827817.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7531546259103419276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1146603/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      19.79 seconds
BluezMake                     PASS      355.78 seconds
MakeCheck                     PASS      2.83 seconds
MakeDistcheck                 PASS      143.22 seconds
CheckValgrind                 PASS      149.09 seconds
CheckSmatch                   PASS      282.77 seconds
bluezmakeextell               PASS      92.63 seconds
IncrementalBuild              PASS      368.68 seconds
ScanBuild                     PASS      1052.18 seconds



https://github.com/bluez/bluez/pull/2508

---
Regards,
Linux Bluetooth


--===============7531546259103419276==--
