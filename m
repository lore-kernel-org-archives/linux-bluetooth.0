Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794541923;
	b=PAnCq/UEEpfSB6xU8pBkyxbeBqh2sAIteXzWNqhvKTJoF21WvtFSmQL7H4kY15z8TXgI
	 o1fL4jY1fNqCU8aa6C7TO/rmuXJQu98OUKFYGdLdX9ZEV5Qe2/G6MhisPm4LtOFJdtzyn
	 6AMo5fTYDL45DjN7ypXeS3ZQCkKmiGYqYQnLkGPGs7oIDoCh9+xhGYN1JKT+4BlH4MQFq
	 Ght4o9/IoEdI2vQKeiiQAO4fvLgtfPL4/qOmLrgJL6Y9zObdx9EEVyIqUbfi3ekxoxgbl
	 6v9JA1w7p9KqNg8TkmCM6VhsI9TMahz4oWS3WU4r80sYxxP/2wDg8klXleLefHSQe/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794541923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=pV/E0aakPJ/QZMvQ2dO7l6uF0996xYa91gFld20wSbc=;
	b=LTfZLMUFUd7L7uaVuMfiL7cyVcX+uj0jN2DQNoo8DPRT3KQLqyRGUKC/VZmNWqGfUnal
	 DJmDfdJ1qn5f3V0qRjSdwiUgk86j+AQnlY+2hjUJ1Hmcc2WYe82h8oa15ShgntSOB/Gd+
	 NouPzIJ4wn9AkM4oclzbCTigZkkaGMIEORoL+XKObd0rBk7QpzSTyurtof8M50zCHggL5
	 +xritKp+chhcp36rRqwrWR6eMUAXgv8fodvYThBN8DtGKzZLaQm2ELGJ7bfMdJvQvfxvy
	 1qTlQhqu3lLd0Ggg9TCbtVu9F5KbeD6B6Ea1+mZeUbCFC5iyl5uXa0tXipxavapYXqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Pn18/5fl";
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA894606A323
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 03:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA894606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pn18/5fl
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93e635220b4so95200185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794541922; x=1795146722; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pV/E0aakPJ/QZMvQ2dO7l6uF0996xYa91gFld20wSbc=;
        b=Pn18/5fl8YkBUugsz2YDB9peGge21vuYkrb9CyIjv14AmyazVvwQnXQ43aKuCzSM+i
         J+WujLPhg4WM5AJBtMtSUzfIRPAs2SJLm6E4Rhua6Ni++h8YAtDRfRWnfT0AKIMWdl7o
         HfMG79BwdC0TTWOuHxlinq1UQ3gqoA/pdg/kJ95DQtJM7YPLaKKqPpwsbuQzZ/Es2Wpr
         MB9pfX4QfreQFH/EWY0cJbcmkEZQvVHd2errb+EGFBUzl52gVlHZUQmFCHf4gUzjFxwm
         e3oFovPB3pZW4BRvG3QnBJKQioJHClRmKZ1P3wg4YPFAE4mJeBRdlhP2KIGfytEyIkXE
         fzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794541922; x=1795146722;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pV/E0aakPJ/QZMvQ2dO7l6uF0996xYa91gFld20wSbc=;
        b=EPkRgrKLAF2+NhoReQdODpRcDVis9RTEoFRXLuWfcgr9Ei4SXeU1k3SOXOBLYmHqe4
         nPBSodEA6bek0g5uaZwtNXrl5felowMGu42J2UidlQ4JbJaCewlQFY5U9kFGmncUMqmR
         OBT5ZqCMcJAVEpsGilDlZeROLqrvBy/QG/fDbHMiyACsZMikFJ174kChD9coSJ3kJY0x
         7wz1ehvFMqezsEKOFznrxtck7LJyKOj49ryjiw5XuSZiql9QykblOBXHSJMueVBdxwaF
         kuuLJ7nQ9UmfLdx/BgDRya4pmX6cx0VL07QiuZGUwraoEGSdBGBDzdqzbjp3UOVZCHzC
         TuUw==
X-Gm-Message-State: APuU4Z+unZnxONEwwHhIUZDdq/F9YM1DaCIsOCtvcGEqvMfpbPmQ9gcF
	qmjLwcjylaUnhGWCNTfpUQsRliygj2AzgxSspsJY9WFBNaWmz75Hpcy1kDVgcg==
X-Gm-Gg: AYBFou1s9BqA6NxzT06S/2YNQxxjdkGT2xqe6ImfvuU4qERfYf32HaKEit/ylHiU7GZ
	gcp4VWNJGlFv5tW/L2CzgNZXj87GYJ1AE7/amcKByZpABYFoJSPq8Sgs9GbY7F/Q+7GUBGRYty4
	64ocYSbJm0RvPDJUR/UchFb9gIKdaFAuUJ85NRrfz4fsJbdQWE3cozxDruNGLw1qO4NJez0xFDa
	yqQE+BmU36/heNtTbhYRUqVqQazzBqxB+xMY0X8Uo7SmH3BfDVDwNAiuxq8Yib+2xDQUa4xFkqn
	A/0FWPrQp6rK+0FzVbXgygn12D0yRwyj4lUmerUBiLUd55mrKgRQsgCwVKt+PX7KRE7iSXTKOQW
	kX7fELfdRTkug9EX9VJ31y7sDDzyBBSTv1CCLrLP413vw9ZNuRPPUtI+q4yYZYWMHyw3/NhT4hU
	3YWxYnzC9NA1yZ1Qtb6sXvKRRgscBUy6zWNeeYpmgc2GIPgl8wqJEHe/UxyvKToVjqqZRfbc6ZV
	1wCuhZxE0q3yg8FmqDNrWVs719BBZswkljU8ScaWeGacCanyt+TPoMqbXHijtY=
X-Received: by 2002:a05:620a:40c1:b0:93f:3829:8492 with SMTP id af79cd13be357-9494bc9b23emr226973485a.78.1794541921662;
        Thu, 12 Nov 2026 19:52:01 -0800 (PST)
Received: from [172.17.0.2] ([48.211.211.43])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c439ea1sm95546585a.0.2026.11.12.19.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 19:52:01 -0800 (PST)
Message-ID: <6af68961.ab57093c.3191a3.e109@mx.google.com>
Date: Thu, 12 Nov 2026 19:52:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4155261684312787750=="
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
To: linux-bluetooth@vger.kernel.org, marianpoltak@gmail.com
Subject: RE: shared/gatt-client: Fix init when Service Changed lacks Indicate
In-Reply-To: <20261112-svc-chngd-notify-only-v1-1-c7db7ac47acf@gmail.com>
References: <20261112-svc-chngd-notify-only-v1-1-c7db7ac47acf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4155261684312787750==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1209830/

---Test result---

Test Summary:
CheckPatch                    PASS      1.06 seconds
GitLint                       PASS      0.70 seconds
BuildEll                      PASS      21.45 seconds
BluezMake                     PASS      334.11 seconds
MakeCheck                     PASS      14.71 seconds
MakeDistcheck                 PASS      158.82 seconds
CheckValgrind                 PASS      370.80 seconds
CheckSmatch                   PASS      333.70 seconds
bluezmakeextell               PASS      100.48 seconds
TestFunctional                PASS      1199.57 seconds
IncrementalBuild              PASS      347.86 seconds
ScanBuild                     PASS      1188.30 seconds



https://github.com/bluez/bluez/pull/2817

---
Regards,
Linux Bluetooth


--===============4155261684312787750==--
