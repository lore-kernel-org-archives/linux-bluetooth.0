Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7B2252298
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638633; cv=none; b=IetyPTISPhEFs3aa0cPb/VUAh8L+3EaQ/q2F2l1XSlZFcD45DSA0f5TLpKpwRuLLG3rtXWd4lMQrXc8Oi49tLDkqlMhkBwmasnsbvVVkxbEsjeqsnznp5nmlPzuxL55w2aleGPKOlyOQKwH/UTaQ3wUxlweydYfpFkR4Sqbnm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638633; c=relaxed/simple;
	bh=Sm0ln284tAKWuNCVlGm6I1n5z6nSyEIbpQDU2Tb8T3g=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H3xvCPVoc94Ul3F/smAGf/60KFsobneCj3PteGW8JPRxSxeaGeAXiS84Dys0P7/jujcKfSu1MN1Krm8PUDqVhU71LYWb3odwT+TSsDC2QesWb4VBI7rlVLKqcE9o84HSJppjnnFn2GRryFlDZH35pGGuYKLJyVmt6i2GTdaVd7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC4AbTxh; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC4AbTxh"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7be49f6b331so484524685a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Apr 2025 06:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744638631; x=1745243431; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c6tu97cu6AA2GIu5QWjiYt7Rrb/qCFxuXLIS2mQZJp0=;
        b=iC4AbTxhOaox+L/GuOF52Epz6zBvQ2eULzSedhQvniXmvtQ+aigVP+/Z98Ag1KmU0Z
         mrVXxhXjIIps8zyH1ouCCs1HGWFkXrysPvUg0AkijSh+qY/Zj0THYRmIn7YjJSjsQeze
         s6FSqZuVq6K2aXAWcaO9MMxmPI8RKoBeYHx4z2AHehKB9tXXYAsK8ASALNCBfbeRLtRL
         FLqA6fkMUwzKVExwwhBiIfo2qKp5jnTjZKyqhhaWRonUhonJGGYGtwYRTM+5+Zb37szf
         ybumfXXLX+w2cNKKGvaZrpwdTVKxbMFKwDh3U7SbXuaMhKFoUSMFpRcEet0M5Z+jiI+f
         QFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744638631; x=1745243431;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6tu97cu6AA2GIu5QWjiYt7Rrb/qCFxuXLIS2mQZJp0=;
        b=NZ/91Yrp2+MmWpTEwBRW0ih0jkYnQTQIM4mECe2XEQPyfDAUNO9pway7DLV52oxc2I
         LQKSyugSmK8YlxYxSeHyRhvHQ3QSKS5UhNtbn3yN8an1EJ5OlrWJGasBzl01f943gTkD
         EcAQAivnntTgGKAIoB9wJpVx7QPAqOLWNeUeYHEH1POJAneiMHEdSXANXwOYQnMTdREY
         gDe1diDouzK7nOlTDqlB8ncSwpr7ZozXtIGotnBQTqMImowbscaDicpbr+fUME77CjRg
         cdTaEpnDfnR8kOLi26Bz84ztOdHe7fJW9B86InN76Jd6BDc/cOXLURERDdnGYBxQCC0U
         rw2Q==
X-Gm-Message-State: AOJu0YzZfICGA2Q53hHeCivTAYN+RzbJNO2t7IEJ05ZeSou+kwvuaM+p
	GDoN8nA85Y2jYHswNWnzKcJ1N/3LsqsuxRHXnyFq/Py+CwQ8IP+EzfoX+Q==
X-Gm-Gg: ASbGncsFIzCe78NLMItbyZ7V6C1hgbVvgBI+U3qKBL9InplXW5GFoaugCMf+w98VRbW
	vzw+ZxJwLgB4+bLomBqgt4HucMJKgynruhXlRULX7AbIq9ssDgx+fBz4/84l5f0ppheivPa5+zI
	NOIStpNr0yN68PdI1YFueZZY9x0J1QjP+DLjpK6Q+adYiN5w8YlGyDyi3xMZfmYTJ8eNTHE6faT
	wVQlTvAtI1ci1s/o597qtF2Rn3TCLYMfyBF4oFf3+hhRWqcgmXPzm8/oUyjv4fV0VuHuoWW4R/m
	j/vK9W3oWl0Xkc3dbDhdCEalIBE/vj87gxrGSBDjYByY
X-Google-Smtp-Source: AGHT+IEEVzjKUpvQq1SOwpii+eTyRArAVDwEowqCHHTtm13ISKahJsS7RlEKDhs9GXOBqIPEKlT0pg==
X-Received: by 2002:a05:620a:4111:b0:7c5:af73:4f72 with SMTP id af79cd13be357-7c7af115b67mr1621136185a.42.1744638630635;
        Mon, 14 Apr 2025 06:50:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.49.61.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0de01sm739560485a.100.2025.04.14.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 06:50:30 -0700 (PDT)
Message-ID: <67fd12a6.050a0220.33d23c.f8e7@mx.google.com>
Date: Mon, 14 Apr 2025 06:50:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1391939332969119330=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ovlevin@salutedevices.com
Subject: RE: device: Fix rare ERR_BREDR_CONN_BUSY during connect
In-Reply-To: <20250414115017.116579-2-ovlevin@salutedevices.com>
References: <20250414115017.116579-2-ovlevin@salutedevices.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1391939332969119330==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=953043

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.24 seconds
BuildEll                      PASS      20.35 seconds
BluezMake                     PASS      2594.14 seconds
MakeCheck                     PASS      20.22 seconds
MakeDistcheck                 PASS      196.59 seconds
CheckValgrind                 PASS      273.29 seconds
CheckSmatch                   PASS      300.77 seconds
bluezmakeextell               PASS      128.38 seconds
IncrementalBuild              PENDING   0.30 seconds
ScanBuild                     PASS      892.02 seconds

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


--===============1391939332969119330==--
