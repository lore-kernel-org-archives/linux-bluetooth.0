Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792793085;
	b=bHZHREyQWo9f9QAtuFDCY/Fai8mtKLGnnFESnZiB+ixzVt1pnAzMvPgeysYmDcXlfPeb
	 DeaoDeKUzPo1m/jARV/BI8I3HHROACL+1F7pzbnKCJflTfkmSvjMvxw878mCU9qk5sJX+
	 YT8xUaOSB+HOnod3JiuxPs74rt75kRXKrrO1BBlRdWiziFUIP+IW8WqdDsnEGWCoHlapg
	 XC/tB7NQ8mRLG8YZDt7tzlDT4ygiA5pA6rEGm/3Q2kq6ofqMFckLYRq0d1ukfMD7jLtF7
	 790KJ78WC/uPqCFqk7APVDS9ETQivi8+gKmz28S9AKUROSGeR8UlcmS3wg22K8pS7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792793085;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=QFJFgeStOolTrRFZ08SalnTflybnZJiehqaRyUFRN24=;
	b=HJhx+HGr3dA3DKAFChk8RUftdFddpbK8W8EnNq1DVxIaf01hT1LjD71EExVomPHSPPon
	 RNvAJk+gTbhsRgREVxVvsgFevQo9ZMYBTTAqYuxBPmjboiAqoPEdnDCNYZNQN1SR0m3qQ
	 9DtWeBmY+ZFgftYchXwEEt35MDYycXr/GUPK1cetZPgNgLS2RXnB1drfp2P3jimVIjY6Y
	 KcuBjE7GjyHTDuaLyjIW6Pr1Hj6H/pIofjT1DhfJ7zSjw7EcLDbC0S2ZCuQ85qWfYinVx
	 34ngAIzfzASUCJB16fyAhg6MwiFHglPpl0isqqp7e5rVocy74DwbW1x5jrxdweR7Euw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cSfv+4cD;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03156606A325
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 22:04:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03156606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cSfv+4cD
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8198a3a54d7so2027819a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Oct 2026 15:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792793084; x=1793397884; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QFJFgeStOolTrRFZ08SalnTflybnZJiehqaRyUFRN24=;
        b=cSfv+4cDHhQQgnh4I6aTbM1m/wqO9/aLJ+XCrW8cqo5Zn44QMAorHe5YWBaiuX0ErS
         7kmWUvOa7mPe/EojtLQiwRxTn14n+9wGq4+gYNnoqS+oagBKSWcznXEaX32Hojh5YCN4
         JBxEy8TsbH7ihczYsdhDpFA8S3sqi8SBRnKFJVLIsrcqwHdQ1lBIm7FlqKR0oP03/txq
         nEmfZg/AFIoNlKCMbqN+5nNGmYtfBZZF+T/Q7xDW499PuPK3jJhvl9EY5uuuhA3HH80u
         qadujNSeFokTNWlGyp+SVGQKgi9wz9PriZsZHr2oscCjgwYGRccAZ9+G199fDK5mRVKD
         vlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792793084; x=1793397884;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QFJFgeStOolTrRFZ08SalnTflybnZJiehqaRyUFRN24=;
        b=tmcY/hEYkn6JRBMy4t5aBcI8Ay3N06z96BUanBWnHb1Fp1vR9JOR+F5Qo9aQeh1Nwo
         z3Z2FFv+12Qbi5Fg+lODg1YHFFDRWpXbGSTiStfF+9E1AEXG5/zeyNJ8f6M3/eZ50DLV
         7RUaLzPRx/19JtWwzxP87+fsnQ73AUZflZbgiz+LoOR8OJaJSsgNfpkb2PZ3a6cDZrhI
         ELmcVD9TLKXPFA+hmm68BRr/+hq7k32qQozeACMDyvuU+9N02y7ZMsjA5VUuw8yBV40R
         iMtB7i5Aaq0wMFLfv8sbh4iKdEoKi+A6lWMKVNWk2bbWIyEUrLKF2qqVcjCY8TTEr750
         54OQ==
X-Gm-Message-State: AFq9FYKivr8ZXna47P4S0i6ltOLb3u5U2NA7+e9oRHErGkVFslt2S1xv
	X68u3PUyYvp0lFFdGMlM+a5hO1FzxYBFpeeIXP53oB8YgSl9xqk9y9vHeYMi5uMW
X-Gm-Gg: AYBFou1JSFBq41I+5hKsHqXSiLlVE/jCxb4nj1X68D2e/04/78fzdIp4JrYZQOF5smC
	mXt/0Q9A3AjR5/tp9en58W6vz51IKx1L3VweUHZ9Lw9sToIYNM2UaaLZiqdC1gGRlchUnQfxJEl
	S6OJdfC/M468fBeNB8TGztYhT2eTsTu8+Dekp83tlazha6mYXyf9u9qgP3zdTHvgNr2TBdwIjnl
	fkNBP2JPDhP+QapmnB0UciJRbgaa/tMfLtRosdxGPiNtXnj+ccuO7d4ROLacObs4m7UVx86M/e6
	PMovLN8e1DxIANcbl9IuscZa28RZWv5nw17fpvwg+D4N+Eb0ePlUgaj0ZYyRSYcpJ0mkeEyxJFy
	+9bZjYIORMCAkxIHUXSfE+6gUQQZzRYNCiLV9TLWN4xAF/XmSfm+HYn8Ee4focGYkAscKCLvC1W
	PP0RQ3jqaSEOmLSHUMmddj8gj3g36FtfUcZK9Sa41Qki5aOEJTaZ575RZIIMxUKhi3GL6i9OQNb
	hRvOUHoXbjePSA5J7/5gLCGnvy/ZOcI9Zif+BWsJVAs/9W6h8MpPZZqi61C8NgIqE9OWTiZ3Unb
	4TbnCFy+Eg==
X-Received: by 2002:a05:6820:571b:20b0:6f7:2050:a29a with SMTP id 006d021491bc7-70ba1340e89mr42722eaf.7.1792793083828;
        Fri, 23 Oct 2026 15:04:43 -0700 (PDT)
Received: from [172.17.0.2] ([172.202.174.98])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fb64ba34sm653011a34.17.2026.10.23.15.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:04:43 -0700 (PDT)
Message-ID: <6adbd9fb.85e15926.1fa23f.0c10@mx.google.com>
Date: Fri, 23 Oct 2026 15:04:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5356478680421374653=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, gabriel.berfield@gmail.com
Subject: RE: [BlueZ] client: Handle system bus connection failures
In-Reply-To: <CABNtnOZr1q7J6_bY4qr3Sb_jugoEyiR=a+6GMvK0JeK=psw7NQ@mail.gmail.com>
References: <CABNtnOZr1q7J6_bY4qr3Sb_jugoEyiR=a+6GMvK0JeK=psw7NQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5356478680421374653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] client: Handle system bus connection failures
   Pull Request: https://github.com/bluez/bluez/pull/2638
   Created:      2026-10-08 21:43:34+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5356478680421374653==--
