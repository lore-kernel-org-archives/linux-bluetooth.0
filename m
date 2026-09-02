Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CEE37A83B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788372565; cv=none; b=pRDtzj8wrFhe20qzLXZ7v2fJj46i1SViHrm8PJDbs8llOa0gtgQa3CmPo8pCdglLJbPQlbk/OrSvaSs4h7Z88NNyCOdb4FONX2P0VsLSTPnuLEa7C26JmIfYDf4b+3mXqrRYSBERuDr8jVMKiSV6iflt6AiZTQcjdB002Ff600s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788372565; c=relaxed/simple;
	bh=8iSBiB85fRUbzxYisYV+I2gNtXABKDgE009yyuUjRxI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VxWT9PUGKK/BPTPwaXTwZSf1VgEuuufjWfFvFn7jyqz/F93dgmLsnd/KXubz9OCi+wjdnnEi2RaN1kJ4rSv2k4bFSbz3a9P10P/GUWcNDxUziGEhHndkwdlNxo3CK7oKlm6Sfl0BYBMQ3UNeKZAI6U7h5SbOAN5TBlCnPoIsgno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bSrDdN0O; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSrDdN0O"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1243963a91.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Sep 2026 11:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788372564; x=1788977364; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rW1/HVbJv3dtXldMOGB1gge3TUDnub7A0kD5LUGafhk=;
        b=bSrDdN0Osx2x002gs3ys3Kw01QFeo1ueGJqxzhDNCm9/rjv7Syhvp3iU0N3m9LMyd7
         y+BYkFBssB0qg2od1lBJstyOZ5bYjaQ5D6zaEcDyvAmz83RH5cEC9lkP4c7hbOW1KLKQ
         PBHqiTq+xVjC5pL7KoFM1Y4ofKXvrLSW12DQsAo7XLLOpgLVKG8CHZa/CKclP+BepJbP
         GS3mBfrw4YJlp3cANtm97MnMaTY0c6gp9mjkoontGhb88aylkXi4bYInBqOYH45oUb3u
         rtcrjWt9rESRwL7QlNf4R+qN+hBmIQL4zOvbXAQ9UOh9GY8OrItXGSt4QpBCKqsCNJFj
         /I/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788372564; x=1788977364;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rW1/HVbJv3dtXldMOGB1gge3TUDnub7A0kD5LUGafhk=;
        b=ATsMKwRYShQ3aI5FgVGZ4nWwhLN5NzC7m5qqtwnXEV5KAVyVBoEL0fqzjOVfdJgY6g
         AiGV9oTvJ1jilpEZi0rWXw3thI/Soy5XxpkNmh3LCNG7cdQb0oXONtwKDpu9QgzKCR4H
         beELrlMdKQvE5yxLAgXJdBIlBg08YO97N3W4KXqPjToPobXMKNC5VvQE788X1oxsuavn
         9OLoL0OHQt0WVE7eYbwmKR2Mqe8bxTJ01sP8BT617iicsSxGdMLduapuZ2VEN/+xXFsW
         PzRaR79FmJSEANtPMOk91QaAGgWaGrxt+m3NHH9Q8dr8uhSURO60UdXwknrFwiTDPWsN
         Aq/Q==
X-Gm-Message-State: AFuF++k67BTRuCopvFu6j6wqUBwCnCL6b+dn0SSJnENHGyC0cAoFFIGt
	RQWJJuWmVk/WB2/D8bHVBgkzUxs069bFoAPLNjXr2iRRgXgi5fCU0LPXEUqmhQ==
X-Gm-Gg: AYBFou35XEydQwrEVBmToo4/YVps/RVHMVE47nRWBMyrm+9iSkvv2iNhDux5rpamJXc
	jzQd5W4lUlfieoxQsECqsiHS2kQor4sXc+AFqHcBlImffuH7oTuE1ovopdAw7tzc1xFE9NdK/CN
	bfTfspQwDrrIZtD3QRgswKqwfenmMvwiBC8OXFASe/WLxXN89hf/QFumUxXirnBVEdd7DzI20jo
	7QXOYq5fbFe6nGk9qscmEx0w02108rpJXgGZ3gwmPCqsg7pfKiWNJVYrDZ9yVVn5AUxk9oy4uLH
	UpvWHf8zTDfq4ZtmdqvVUQ3tICfhnL6ewV4Z4Hk6XGmrO//7vIpJxp8pzevsNhfehFnCNVGwjuj
	UoirxE9BEraPFDUaLcQPVN61vO2gWTQ49pIi3WNIXvAyRs3daHbljTogwpp68f5+6rXkZZNO3j9
	WA8bCdapG/jnWaJGmhYvy7MBD2A02q54DoctWBSpLr12z6ElRGCUjJnGRqtQk+ElFaxlwP
X-Received: by 2002:a17:90b:1d0a:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-39aee084173mr10970785a91.16.1788372563948;
        Wed, 02 Sep 2026 11:09:23 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.219.82])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07beb704sm8904392eec.30.2026.09.02.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 11:09:23 -0700 (PDT)
Message-ID: <6a986653.fb0efb2a.6d405.4bd0@mx.google.com>
Date: Wed, 02 Sep 2026 11:09:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8264132027720428500=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1,1/2] monitor: Check valid range of CE Length
In-Reply-To: <20260902150951.1583184-1-luiz.dentz@gmail.com>
References: <20260902150951.1583184-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8264132027720428500==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1156272

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.45 seconds
BuildEll                      PASS      23.58 seconds
BluezMake                     PASS      641.40 seconds
MakeCheck                     PASS      0.94 seconds
MakeDistcheck                 PASS      162.41 seconds
CheckValgrind                 PASS      160.63 seconds
CheckSmatch                   WARNING   322.58 seconds
bluezmakeextell               PASS      103.55 seconds
IncrementalBuild              PASS      638.06 seconds
ScanBuild                     PASS      1021.13 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2002:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structuresemulator/btdev.c:478:29: warning: Variable length array is used.


https://github.com/bluez/bluez/pull/2472

---
Regards,
Linux Bluetooth


--===============8264132027720428500==--
