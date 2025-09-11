Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B90E1DD525
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757609221; cv=none; b=uwJ8ibh+v25vP8MTl7/uTton2bVtIzBxsTwkQY1kNKRlJqK7dN5SZYj3TggC+g6w721tqZ5WWgukZEkD8kLQjLCoMJ/spXC7w73ks4aYQxvT3Hia48vpqDiEMp0JDb1c5xSmd4f4CAGgsdIEcF2NHrfaoh/+WXZk09xFx7Haljw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757609221; c=relaxed/simple;
	bh=g9VPlE89uuENpnsyzToDHVpLxg+16G0ZKri73ASxqWk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PX2S2rrMkusHinRUCKKahupAw38VwfPoSgJMS90YBviDVYa3JJwxychJecfmALMaVOeL5ezlk8Usl60RUIrb6/Yc3G/S0tOUVA5UH6RKL4EyKPGDXgpi3ElTJyppXoeSdzhLFYjkx/CYLwbkHcXOGwThB6Slx6FMESbDeZp9DtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS9NxwJv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS9NxwJv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-80a59f06a4fso134665585a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 09:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757609219; x=1758214019; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IqUnRDM8Y4Le7OpV9tu0QHhyLek1Y8wEAHL3vYMh3Ko=;
        b=PS9NxwJvqNIwEaBWvfbIn8YdY/eSExb+sUGgRC2HZ5u5VIsrDX2Z2rdTVgNT+fh+YC
         d/KhD06KqidOdA450wh6Z0wJZi/MoTiyXE/SEVtWkHGw0isxJdPmy3vxBKdPAz97AE+r
         6IDSSD2ERWEM2XB7faLDUe0NewQslxoeh0DFUdvu5+YWmfxFhHWIDpj5BMc4k6+pxJtL
         BzHLyD1Lrnn7TrFafjamLFh3bAWIXcs6wgDtNKECoNxFp6llDd7D2NBXf2RrduAhsnBu
         YkrV9j3d2x6Bmlmv6zxgeJqlvZ84G7yF8jw50hBxjvWZ5wE9oY2KUEs0ozQyl2XB6qM6
         /P/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757609219; x=1758214019;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqUnRDM8Y4Le7OpV9tu0QHhyLek1Y8wEAHL3vYMh3Ko=;
        b=BMaLQPHoBSg58YbcFr/vVQIK3/QzUGDFLyXr8BLVT5lCOdjNmFZQqnzckTRksH/yRj
         P307NdEWlHc6q+2PwNOc0Pst3kLIkP8C+Yk8mjjW48ztsPhdoDsbG2cnbHhi8bcU42KG
         R5JvwNbkz85G7LqMX3UdivGQ6km9hGWqakodbw9NMFnF1G8PGB/WchQ+qjvDthMLEqJd
         xG5zhvt6SxDrhvqMadh6VRcKU++8Qi8voCHAiadfUSS14700GvTMe7XV7HyHQkztDMYp
         YTQVWcAvDIAG7iY4fzeqvTM/TdjSRZ3m0hJ72BaRO5k0t0C6F5N6nvXttCq3KLcC/5bK
         cS4Q==
X-Gm-Message-State: AOJu0Ywp3DJtf9E0XQmKkyhDPNx7yltQo+KMLnUD2eQSl+ZnNeELSjGL
	rSqvG8N+q0fHTIR9Rpv4AJT3R4c26XUZ24+qmkid4dEE7Wv+HueFM6kYHeuFMQ==
X-Gm-Gg: ASbGncth7aa46agYaThUTHcv7XeBfGujdwa2iCbCgG86WBCOEXWMJQ1yoZEvJrPbXW0
	cAaoXGK3pEThUwdHe6S3Zl1O49N2bLy6Q5Kv8P50pBPg1M7G7lZ9DjRzIXBpg30aPCYLkrmVE2T
	Rh+sS4uo3dT1KWxC2UXrR8B9+1v6WtcxTghE9a13vfC1FJl+UOTAKJTbfqri74RxCmyYpXdA72O
	JtXzVEzFp/kD8E3MUillC93d22tPQfSi679njlUCpmTWv6EnEDe5eZj5cGRAi8uHt0MumHITkrv
	0ZlZ6MtLiZuD2VrnBDJfYI86MOb1Xfr1XUOtDZ8kT4IkwPCkMjNd+JZmSmChcgSwuHgA11hzDDy
	+cFrU4nD8dkWDzSwSa+TLEh158wJ29xXRKiBBvV0=
X-Google-Smtp-Source: AGHT+IEIvIYt40r2c7Rf0Lv9FMaOKovJmMWR8FSB+aFK/zBr4ISfppcCPgWNbo5ShOfXIfQWXBs8lg==
X-Received: by 2002:a05:620a:4045:b0:80b:7801:dd98 with SMTP id af79cd13be357-813c3c83bcdmr2007738385a.84.1757609218662;
        Thu, 11 Sep 2025 09:46:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.28.106])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820cf00863esm129591685a.63.2025.09.11.09.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 09:46:58 -0700 (PDT)
Message-ID: <68c2fd02.050a0220.aef60.4282@mx.google.com>
Date: Thu, 11 Sep 2025 09:46:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7126300633329063584=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pwaago@cisco.com
Subject: RE: [BlueZ,v2,1/2] audio: Add support for specific error codes for A2DP configuration
In-Reply-To: <20250911151930.1632922-1-pwaago@cisco.com>
References: <20250911151930.1632922-1-pwaago@cisco.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7126300633329063584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1001420

---Test result---

Test Summary:
CheckPatch                    PENDING   0.28 seconds
GitLint                       PENDING   0.27 seconds
BuildEll                      PASS      20.56 seconds
BluezMake                     PASS      2784.33 seconds
MakeCheck                     PASS      20.54 seconds
MakeDistcheck                 PASS      188.52 seconds
CheckValgrind                 PASS      238.72 seconds
CheckSmatch                   PASS      309.96 seconds
bluezmakeextell               PASS      129.59 seconds
IncrementalBuild              PENDING   0.26 seconds
ScanBuild                     PASS      935.52 seconds

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


--===============7126300633329063584==--
