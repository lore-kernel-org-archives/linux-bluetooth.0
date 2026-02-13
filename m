Received: from mail-qv1-f68.google.com (mail-qv1-f68.google.com [209.85.219.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026A1224AFA
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770961478; cv=none; b=r1EPAf3U29xXtasdY6bUr4Ua/IBylp604i7purDenH7Q1AeiOStnEK9Y/vuDEoW3B4uQPJ81bTCs2ToMZ066rKBKfEg4u7IjJ60Jdt6FTD015JecLPfB+j7VmhdO9L1hv5r+jE3lNtjKXpWZj6ehF0MYNme9MiEmXvHjTqmndCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770961478; c=relaxed/simple;
	bh=iLbAYQBW4AJoTUohCYe5bRoqY2AO5uRd+KJK0qBXTUk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bp9rxU2balIBVDccx8bVyrk3JCrX68ueNH5wnT/S6z56guLcESJ4HsygiWz6TFYuzjPFelzfNMgMH3k55Lc4ugbfVWHGjGq6ayaSdHDSN3fm6DluF38tfSw3JTF3CQH/N2ADmO9w93nLUOKRW8M6RCk2rVtHg9HVnD9KAiPdn+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewtkgoif; arc=none smtp.client-ip=209.85.219.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewtkgoif"
Received: by mail-qv1-f68.google.com with SMTP id 6a1803df08f44-89549b2f538so15401676d6.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Feb 2026 21:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770961476; x=1771566276; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iLbAYQBW4AJoTUohCYe5bRoqY2AO5uRd+KJK0qBXTUk=;
        b=ewtkgoifEF0OWuIPrtvmLue5ZXk/51h/nbCxI9qjIzeKy+wPXX8Ww3rSa02gFFzem5
         V5+RLJhU9H8JYz5AiHsw7qF8V8vFe7C8YBrGw9tcQU+nUXVKbT3fo/Q0qYVrspN4fAOV
         rmVb2RIuL9ko4c7a9q1Xlweodg5id+Cu+Ndb09YFOPwR3M1rIx4tbhytUtCIz3w2TFdu
         XC9wpiycQsk+0VPi3+7WZRa2nuUb+8ptpWWaRuKFpg7/JsxNsmu9NJolCmJEsaEr2/j7
         B2QPZ8gyoMW0dts1WRyI+/YRt0nUdrPOVPy810pSTseNwm+SDC54u7uOrRSYaJHVb8I6
         v0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770961476; x=1771566276;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLbAYQBW4AJoTUohCYe5bRoqY2AO5uRd+KJK0qBXTUk=;
        b=dfye/dUNs9cb9G3M53THnHo0/9QNzI9XlW3DzOF9fr8hfNyhftVGJC3o214O783Rkm
         vo+fB2K5NDuKWRseVlr/5tBlX/KOqNk8W5RQByVOvdDpYj1oz8VisRvXnpyPcajPXNO9
         T1quS2RVhWMRb3pyro4rahEUUc332dN4wFBB2d7/fXOuSaedZs4DBclXF95hwscxFFsr
         xbTkQrd+fwnMQU92bfc2mvv29adVmNr/iptqKodkg2NdE0EHp4+4YPOyRA9OkqhrRcEM
         RuqK1pyNeBk94yklXPcNtOEkT+pvFI0KHiw63/HztNCaRqVYPYf3mmW1PutEAn2qMMBI
         vsjg==
X-Gm-Message-State: AOJu0YxnWD7L53V+gXOVAAF70qaKPo8kvYrPjMWY7xTQUeqaZHXGpE5d
	BjbQNvE/OEE7RpUMoOJkfHrEAt5B2m7AzFVruoadm85cawh1SJNHM85/JIi9jC3W
X-Gm-Gg: AZuq6aKfuOkG8ylf6pcvMbBTrxP8UhLUSiabkEljAhweaf1c8rmLpJ8xlYe1f3B7Vm4
	KTzsc6JZj4qaOhzGEC8c+jj8E2q4UEU9HAW9sX7fDzdK4fXpoXpLA5e7AuqwHkb3M42MFEKu96S
	iCHm35vpclBgy5NbXU9XCi4TKt19bggadRq6kLz3irM5Rt6GQx2+8O+yC3rlQfBxStB2FGGwaHu
	Sp95Ta4TRsRZMw2gZ5rrQ0zTamR1SNxtwGyGvMyZ73NQ1T2rarIoN5Cgyx6M3T3XvOj7iQsk5M5
	9PtWdHDgTtSFJvDV4+GQ8S5tziPrzIHkzvzjyFf789ICzQ48dykFofWT8POyfAyTDDBR7fnVcxi
	qekE/mQHkaRsDsaXc6rDl6LyztZFbfR5tCp6W47PijAKgB1nr978QYp746Cx6XvTa9Ij9eY1Fqp
	rcJ0/PwJcOqUqLuat+iqlJSgcaB/EUTH0=
X-Received: by 2002:ad4:5944:0:b0:897:2b66:a1b3 with SMTP id 6a1803df08f44-8973609f596mr9571696d6.15.1770961475643;
        Thu, 12 Feb 2026 21:44:35 -0800 (PST)
Received: from [172.17.0.2] ([172.174.221.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f2a5sm56293666d6.11.2026.02.12.21.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:44:35 -0800 (PST)
Message-ID: <698eba43.d40a0220.1f36ce.1e9a@mx.google.com>
Date: Thu, 12 Feb 2026 21:44:35 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7971432278303623831=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, maiquelpaiva@gmail.com
Subject: RE: mgmt: Fix heap overflow and race condition
In-Reply-To: <20260213051525.10945-2-maiquelpaiva@gmail.com>
References: <20260213051525.10945-2-maiquelpaiva@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7971432278303623831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/mgmt_util.c:413
error: net/bluetooth/mgmt_util.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============7971432278303623831==--
