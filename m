Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23D4AA1D6
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369408; cv=none; b=Q/kqfPD+ZQLz7ZL7B5XNWPkIEngifTDNldkq9b9+v37yQ6vJGZU/lUfHQKYritrEHeYSneGxVVUb83JHy7yiuQuaFZThhAGu2ZAezxW10ndB8ZCfmfM+Z440LnlspLvGsGE1OKs4gAo77FXjZ2Ypu7MnJfWMFK5p1Dw4eRaBfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369408; c=relaxed/simple;
	bh=XxYtgLd28dVsQqDutHSDJWN3jcYs1/wnR7UrtQSyGZQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g9aqnozwe3rVKaGl5D+JcdOTAsNo8AlxdfBmpFexOYkdIN3eYUnzzIRdT8/0uIfssOazOAVKKF9k+CMefQNL/jq54D+ouc68WbSD3yxw/+yK3jnTsZ+7ChVAfYe/6JlXP2tZTVtbTE/VhhKcqHv7NRm6DaxXqS0zLoynUQXSczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1rbv+xK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1rbv+xK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-90cd7ad71a9so17938946d6.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 10:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788369406; x=1788974206; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XxYtgLd28dVsQqDutHSDJWN3jcYs1/wnR7UrtQSyGZQ=;
        b=q1rbv+xKkSdoCIuwIY7uscTUExEny+1bj/wh6HLh+20mDLLUlO5zhgyNJURIPvkmRa
         HwDvWhsSpjj6RTyWZCPkJXrwaujIL/S1MYh8MdAcgsxYcFiOYZqBEHGaPrcz7ZMiXU1r
         3YxPfsD1QsIvwU100zVu0tuMhcznxW9hUkoiYZqMb8VPDwlloSP/0aGWBtj3Bm5t2VS1
         uU2W81JW0BxZDuO3A9ogKXKKKesDQrft/Gi5HTBM/g8iZWfWiX5Rhqkf1d8ouLINDid0
         ocMI/ZFgB3BK2dcOWbYveWeRYPvJmypbCiDiwVGjwjRskDN/ZF+1ovr2rtMjG/20lfjL
         gKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369406; x=1788974206;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XxYtgLd28dVsQqDutHSDJWN3jcYs1/wnR7UrtQSyGZQ=;
        b=H8vTMUxXqPI7ubMkC+lqwfFHe23xR5ZH6xKc4uu+fs20qIhv1dWHmoFjAD/7SfbZFh
         fcQqd/xO2m000iTtu6WrXH2yAsX9sPYibSJf3MlGA979Ro5QqXke64CYgnZFZUiOeybJ
         3twk38uqQY/jmqis2oCXpLSzrCSLGmx4yrcowJs2Alf1D6GOozRr0MMk0F8GR65k2KwJ
         1sRtwFYtMlWPKAfvkhs2Oo3sU6iLu6A9Drtrd1+INQG6SunhLMh6HFFt4PeRDPh4nYME
         7MZM9386StCVkb9bv/vsY/jwmQjiNc9K4C/xv4ZrL3nxmtPA4CS7xLGht0ptcb6IceM5
         rX9Q==
X-Gm-Message-State: AFuF++m4PwBpg7Dr0Br6etSceXT2lr/v9dRqAa1A8DTSixaHfm+9UAWB
	plDBb8XgQ2Orj3Cg982c5ciJQhLtHCN4ORLPZ25aN+SLXPKg1TkVkl/xb0r3Dg==
X-Gm-Gg: AYBFou2R7+EuTcvoIxQ5ISNpCJpS6bGQ5Ol72fV0o1piPWILWCYXpITCmQOolsx7ltl
	SO4qpbvspzVD681wupvMIYS27QmEEV3lhHpyXtme3TJMmT8s72sEA8QFRm6dJZj1PhUCvAiZwhn
	O62ckKit7oeayD75U/uvfydh0kuQ6YDVjRLNCOwMutT9H8By9CT4UlZ6sjgT44zh4uvJEEry2/d
	6NYbguHm+4Dlof8ZqWzRAHDZmenpKBaEBNr+7A0I6cJwV8SSS6bMvIZsFlE8+4o9ts8CvjTHlN8
	ELMfaY1dmqX34ahaI1W3MbtB56bnw8mL8IQHzwx+06pY4kPWxOLeVJ83o/UQNs0FbqJ72CFAtaM
	R5IEumYRgYia/nhqHN1c8KYQslOmt3kP+0MPlXTZNTW0Tw1USz/Jf34RxYkPnKeHKOgAFKpPE8G
	8Eh9mz/nmLV1kyKEPaVdXsvWtioe04vjzhsU6Ed76A7XV6GzXNNBzQAlGerh8yB6G7
X-Received: by 2002:a05:6214:1c0c:b0:90c:e89f:14ce with SMTP id 6a1803df08f44-90eca3a79f1mr82072306d6.27.1788369406027;
        Wed, 02 Sep 2026 10:16:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.84.47.36])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90e9f0d998dsm22353656d6.9.2026.09.02.10.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 10:16:45 -0700 (PDT)
Message-ID: <6a9859fd.2f990d9f.3737a0.4cba@mx.google.com>
Date: Wed, 02 Sep 2026 10:16:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2283972825478026818=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: [BlueZ] adapter/advertising: fix mgmt endian bug
In-Reply-To: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
References: <CAKA8V_8QC7u4OsP+f4_h2UfPQ0uAMy9ESzvuNULo1cFkmxyjow@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2283972825478026818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: corrupt patch at line 9
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============2283972825478026818==--
