Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3379253341
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378071; cv=none; b=qnHHH2k4AFEeKYRMns/DnljdaL3jmYuBs1i6f/6covLIE9LiQaEh7YfsDP0LB6hMsFnfjwe/ykJtKn2fAYw/5feEa+UTUK8wfmZil1KEnL9XHJwiqbvokm8tJJ4RtROcnIT24Cbe5zwyTqn67xronsvW6RjZZqf8oBAbVxdCP0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378071; c=relaxed/simple;
	bh=l9Dh/SRB3jJItI3XmNeT4eNRrNDhdH7e8YROEygxCK4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Kd5fPKyYkoedu2Km+4Xzm3rdAjbVXKX6V4wUIs2PNsf3Ifjo8HQGp8CF5l84ysXajI3r/keBw204GXt0IB0wbX4QORNLQTmmzt2PaynshCY+fzauwShyavj/Uj1azYnzIqtJRl1aj7mS03Swvvnw8j1j3su3ZXEh7ySuG71M0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3KjIWM1; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3KjIWM1"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c0155af484so914674885a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2025 08:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739378068; x=1739982868; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6e3RFSlSRBZpXdRwFaTT8inumAlNliojCJ4nuLE960w=;
        b=C3KjIWM1s6bSSQbZroXfKZcqAwZQxxxCibLPK5j2ZcKh6JkA6FUTHwpWxxq2HkwjO7
         Nj/faT9Cos0kIjSYHr77Rx4vyFmOGB+zaVeQnyYadyUyRBVrwkIsRn1HPo14vcY5znZc
         OzVfgFcSR1nzHufqp0Kjvo4N5H8hm4mD1DMJbjJ0kYfNQR7ypm92v71Zb+ZInPq2g+kn
         aEzN9wAXpOP07SVb38jmml+5QQMqjtrwAZe1J8wwaVvv4Nzzk6ncx6INJRODmlN/oIop
         6x8VRJrXPBYUHoEVuxe8xTy9R9ynyaiHAsYl4A6uvSpimBRLSWAzCa7WkzR6/SPj4AKt
         WMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378068; x=1739982868;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6e3RFSlSRBZpXdRwFaTT8inumAlNliojCJ4nuLE960w=;
        b=sn42l6iN7TYVHkQy1aabSvQ9P1oNarbFSVzelJWGEY5NiqKk1jDGd3/RXJvfteH+V5
         UWcRCE2hgn18lXYzJC1LBA+TWpEI0M8ZweCjtTgz8nLZ/3IzWcoIOhqTOKoHpiIRMLmT
         fIBH8cPmanj0PdJsxd3hUZa92zU9+IQyrp1S9uStmLk/XdxTBggGdkqK3D5+MvhHCXd/
         IE2K4YMWkZ/nWmJWBnsUHac9eSigEmcWcXXnzm6DnXBG2Ff49JxsKFr9Iaqu7paaKj97
         2SFqdjwclRTlkrfi+/aWg8Dq9ri61VvcMR4idCN90MX6tuXyxGuIccbFGujTwc35v8mc
         NFag==
X-Gm-Message-State: AOJu0Ywvz/61vxWEZCbWTVrZhbE5Z0DIlaWuNkJtN5dOWAmKbY4frDe3
	RJg7FRBMueSck44rdotcCe35UnrTpGa4iEqXj+ehBPI+ZwP5tBT1HHHs+w==
X-Gm-Gg: ASbGncuu0u19tbokjlhKToNhHWR6FMZ6Eye1mUL3l+IAcR3r35RzBgQGlcZi9IEROWe
	KHkPYi1ItSzpNY3l7SgSyJJTb1EY3uuPzh670LlueLmWVKhlFGtwyLemIraQv781hawQ501ZYRO
	IQ68t/mJOFjB9FyYUSVWsH/dM6omvxb/QUiiG1FyS6OmacuymW/5i8+HzJvmc9k+rRwOdQvgy5C
	XvhvlGPLTMa3aYJeRtf2kvowoy1f0NL4I1RaoOeFKOlrIIHjaZM8xu+TZ86kpItEdNZ2CscJ9MP
	K1EVlGc4iQEKHwyevIk=
X-Google-Smtp-Source: AGHT+IGi9JJLfEfgA8zWJTzDwasPpzb5CkT4YIUZHgY4mL3IdUAAMN1vwBsA16TyNgIMg5f4o52jWA==
X-Received: by 2002:a05:620a:86cc:b0:7c0:7725:6b02 with SMTP id af79cd13be357-7c07a11284fmr9184785a.4.1739378068681;
        Wed, 12 Feb 2025 08:34:28 -0800 (PST)
Received: from [172.17.0.2] ([20.39.63.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4718cb6d2b0sm47152581cf.16.2025.02.12.08.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 08:34:28 -0800 (PST)
Message-ID: <67accd94.050a0220.51e13.eb93@mx.google.com>
Date: Wed, 12 Feb 2025 08:34:28 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8370776543616534124=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: [1/4] test-runner: Increase amount of RAM available in VM
In-Reply-To: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
References: <20250212135209.129361-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8370776543616534124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=933153

---Test result---

Test Summary:
CheckPatch                    PENDING   0.21 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.82 seconds
BluezMake                     PASS      1547.50 seconds
MakeCheck                     PASS      13.73 seconds
MakeDistcheck                 PASS      161.08 seconds
CheckValgrind                 PASS      217.41 seconds
CheckSmatch                   PASS      295.20 seconds
bluezmakeextell               PASS      97.85 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      862.48 seconds

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


--===============8370776543616534124==--
