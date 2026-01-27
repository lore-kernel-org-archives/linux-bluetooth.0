Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com [209.85.160.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EB2E11D2
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537620; cv=none; b=mGtVGKO+kp1CbhmaMBDVbK6bQ5lSr6rELMnFTqLS/3uIMT+GB4zBZoER/nFBB2qkvVjmzkszVeHhGS3sjJsEpYdJ/LJgDE71hey/7b0I4115+qUvbDKaWPHSvSXJhbAdj/bga3DpMYo3+7TWqzmzGnpNFvuNzfecz6PpkmMEcjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537620; c=relaxed/simple;
	bh=A7Emh/QMX4PmisZZiGxlIuMR27NHenK1Gwg1l89y9FE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=RiSkOEcgP+JvfLFBJD0+APawHpL3AwTktlSBhvb8hdVMk3xvT8LznHFhM3o5ThY03ggXCjambfFN+IFmBc1JEBZx2R7/NvqHr7L7cXJBq9N9IinerRgq9KR3XV+gALbmT25dHAbtS6McHVuDUKrTQHsCBN94AH5IJcXqb5L5kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJbSBBtI; arc=none smtp.client-ip=209.85.160.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJbSBBtI"
Received: by mail-qt1-f196.google.com with SMTP id d75a77b69052e-5014f383df6so51208961cf.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537618; x=1770142418; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yjTzryUKY1KouUSFygymN5lKVcPjxNWr+eqvWpkXMgY=;
        b=nJbSBBtIWWVH+kvrUqBs9De6Qukzv2DPgdGX4ZWyeb8iIcdItxO5I5f6FnWWbE34b4
         dz8RpFXwQ9jr17sOjK1wL0ztA3JsWP8uNwKTOaby4rOYubZQdjInQN10Mmsfv2jqL0Sa
         Al5WY7zna9PT4yD6TmEynBdddxwbrpWbO7hOJkq8tMg5P/EgWrwGkFww8KSGgWztAUsA
         Op2yFuaOR3n8E09QjdWsYPnfs8yR3yjX3+A8iexUtMg7M2OP3UtMCrX5Zr4bpnjKXRGs
         kAcjNO23BB7WxXeE+lQvfcivOHdwBqNdlC7LQQC6TGJkhbOpupPfrKaUMObD5DUe93eK
         9k8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537618; x=1770142418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjTzryUKY1KouUSFygymN5lKVcPjxNWr+eqvWpkXMgY=;
        b=kpwcFJNjYe188ROx7N6PUEYNKQe9TeFeEX84xi8hjQpY2xkT/y/T0InxlTOOZ6n8a5
         bDXAyIEFTcNgqsRjqPOSw267S5E3/xgcPi0Gybli+WmWL3vcpRye+b3r1hxrt2O6ssaW
         A4Fq/eBDCrfmFFc0wbw717JkDibTkk4sJjsYm8cVgQqlRN526nvTzuF5HW2ri5Jyiy4W
         Fl5Cp80qNp0ODLrsCUiIh6Xdgh1Uh8gIDnrKOZbGxi6d2kEgAZ/wCb/ZJ84MA46KnIBe
         KXIfdQQumxS+jsUFPpCTyTd/RkamrLK+RWq2jpnTtZp6CtsLVvgPzZE8Rz4cbjASswBv
         bvWw==
X-Gm-Message-State: AOJu0Yx5b2o2iIZSmb84VLUjjv9nYDBAfKB4szROBh43QLygw+1R8U2r
	j94gkwyLLdfM/zrMB/v5Jsfs+sMtmaJ+2JoHsN9xzOh4+ickGbl6oyUw6haq9Lxk
X-Gm-Gg: AZuq6aJwl68iinYwn08aIfu+No3U5+yd4c3+kTxLhnvx4yJ1QCnTXD8VxG37TDi+lfd
	Jdt5K806loMu8i4jviejqnj1EwcV4C7sXYbMXy2blx8BHuaTAw35fy+ye1hU4wsdDDT36nVrikH
	Y1QQnzFRfnQbBC6AMC11oBLTJ7k1AAkSLs4ncZszcHwZQK/nWDBXz4c1vJz32Lh+RVtD9oqK8Fb
	PCNxWHqXeWjo5lmqIiOER9XaGyR++FnXyBQEku4BIlG/lK3vCk21OuVjhvu77KLlW0QaxJW3IMQ
	nvMBXIGVSuv5/yL+oe+LL6Rm3IYb26JaHXrlbhe7YQNnYwkUbrIz/o65o3JxOf5cib8dE4qQ6eT
	8Wlr655fV5hXe/YTxrVVPdXqYPqJR7Cs42663FuO0OZF1v5+NTEM3jfz0LYEEyDob32SF7qs+Fg
	t2bhHNzzxnA9AogX2gdA==
X-Received: by 2002:ac8:7f55:0:b0:4ed:8ab:e7aa with SMTP id d75a77b69052e-5032f76f375mr33059541cf.11.1769537618092;
        Tue, 27 Jan 2026 10:13:38 -0800 (PST)
Received: from [172.17.0.2] ([64.236.135.133])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50337bbb66dsm552321cf.29.2026.01.27.10.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:13:37 -0800 (PST)
Message-ID: <69790051.050a0220.1201c.c2dc@mx.google.com>
Date: Tue, 27 Jan 2026 10:13:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5709127657404541064=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: [BlueZ] doc/qualification: Add PICS and howto for the RFComm qualification
In-Reply-To: <20260127171306.151311-1-frederic.danis@collabora.com>
References: <20260127171306.151311-1-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5709127657404541064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1047696

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.36 seconds
BuildEll                      PASS      20.13 seconds
BluezMake                     PASS      638.65 seconds
MakeCheck                     PASS      18.51 seconds
MakeDistcheck                 PASS      243.98 seconds
CheckValgrind                 PASS      294.79 seconds
CheckSmatch                   PASS      349.01 seconds
bluezmakeextell               PASS      182.08 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      1037.43 seconds

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


--===============5709127657404541064==--
