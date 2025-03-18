Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6ED20E32B
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308711; cv=none; b=GSGXpSnZVkgZEp5GkdUqZahPaIjLjNdWxAtCbejf5hTF9ir1wLOlFN9lb93Bdro9vayZQ8DNoFHTMOBF9d8dqwkz24nwTMkQcQpnY7WlLtrVo8iKXj2dHxnTwZw+DJIO9SMrDTohjD0Xmsc9Sh6PTUwhboK1U1BA6CfVynWXMkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308711; c=relaxed/simple;
	bh=mgXCp+t83QxcUgFuPzZmH6sBxuskd1FpRzKw26Eoj+8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K9DMlbTDa6bSdSknkX3Fvp9olREVXVLHV/LKKA0w7yjYHCHwpzZHOG7W/cVgdMYRnVNQ6LDbuIYg895IwYvCCCo+NNZ78aehY7FIeI1eP7kSYNSyG+aP2lpVOhfj4s+jIcb9nOuzcSsTYVuDP8JF/7tcLNtvCEURMfkpw8b2c24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbu1B/f0; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbu1B/f0"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c08b14baa9so451856085a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 07:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308708; x=1742913508; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c7+JpL2OBktHTBtMI++7w5SZEPMFapkC+mb3CFdfLB8=;
        b=mbu1B/f01VRgThSEjIz3KuKzMynR1OfnjZIk9/DnfV7LG2XOW1lb+WEK/As2DCNmTL
         Tuc4kYekUTzPnFnqDDRlQi/uSbvDqyYaMozQ2sQD64rLcX3ZPh4xYVFbZpo6zK9Xt9tp
         ibHpaSMjdSeBQeFOnxMkTZfUa2t+QOxM1WL94qLuK085LNPaALYuVO1nBGmeuCXQHSvw
         3a7+RCQY/k5kOn9QgzVLP5bGMfJkwR0hsSEpQLFr3FHm5JdxkegcmqUlQ7gY0Szw5cwP
         pj9xbfDxB0kBqMp3yJ1SAlB+7cxnYJZsYdfk4BP7YR/4SAhMaRdsD7mrlstCNmBeZMaq
         OcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308708; x=1742913508;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c7+JpL2OBktHTBtMI++7w5SZEPMFapkC+mb3CFdfLB8=;
        b=JPSN3ZEBL1qq+vp2i8GogaazKdcV53UGAq89ep+fj0jeuga4TGCHUcRrGUKNWslXGC
         LyKUNjfzyrqHY2C+XpAfpBLOVUqdIpmN/qfEyTLBrrvGYx+D35us1SKM3w4IFeveTk3C
         AbNGWPai9WagtqPnSaIai6P4INr6aU2J+CREdf07JIC/1Pdc878RZMDJ4A0EEdqOV1EQ
         r3L8OjfEazTGRfXpUg64eJs2zwOVDAr2NVG2lIhEL93/Iil16zllGtIf04IhEk9R5eRt
         LRH6VIzdDVTf3cvGrJSh4uajxv63iFzOu0T9SDbJbu5tayDEGB1KlDjUlzKF8De4Bath
         JLBg==
X-Gm-Message-State: AOJu0YxhKv16V4d+wuXI9OdbO3aqs67xOF7priFA296s5kSSu72tNk9s
	Uio8kXRZkxt3vQek+UlItI7QPy73m0tt1ctiOeDQkDMhjZCV4NvDyoiaUA==
X-Gm-Gg: ASbGncsiBKMSt00o3OUPYfGBxBR/+1hKoQ2/nT4OauJz7wYZh1fnOkD4HgBeVxJ/Euk
	6FoYfFhG8szeWf3XOw7Kdu8V2wR7ZHS+HHLd75Z3OptqrsRAjCnGtlWRtv+YIYZdrQkRIHvL2qK
	DrsMqhYN64CNu6btFh5E+Sm1f9mNv1vkQ0miEWsLnq93emqkDIwUaH4tBmOOuU7VD48mUxIX4Dd
	RSEwQ65Ns6wxYv9AP1TPFism13RwtHEya/zVTVv7KGJ1wi02ZodEUHGJWaIa1u2vh2Hn/uvt8bB
	CD+DdfG2eR9nOaRPlAjrSUleEME/n+LBLc7SaHvR0mj4CAKJ9w==
X-Google-Smtp-Source: AGHT+IH6nYbt+Mbq5LzWiSI64A49DUeu9Ymhp2bcQw0lhCOuX2bUjCuRk2NtXj8VpC2E9hAIBkl9uQ==
X-Received: by 2002:a05:620a:bc1:b0:7c5:6375:1450 with SMTP id af79cd13be357-7c57c79c06cmr2235146585a.18.1742308708331;
        Tue, 18 Mar 2025 07:38:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.57.79.181])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d9256asm727072785a.106.2025.03.18.07.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:38:27 -0700 (PDT)
Message-ID: <67d98563.e90a0220.276345.9eb7@mx.google.com>
Date: Tue, 18 Mar 2025 07:38:27 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6008245717534889755=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] obex: Publish SDP record for Phonebook Access Client
In-Reply-To: <20250318132741.92320-1-frederic.danis@collabora.com>
References: <20250318132741.92320-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6008245717534889755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=945153

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      1556.55 seconds
MakeCheck                     PASS      13.35 seconds
MakeDistcheck                 PASS      158.91 seconds
CheckValgrind                 PASS      215.02 seconds
CheckSmatch                   PASS      284.27 seconds
bluezmakeextell               PASS      98.26 seconds
IncrementalBuild              PENDING   0.33 seconds
ScanBuild                     PASS      880.70 seconds

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


--===============6008245717534889755==--
