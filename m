Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5863F2472A2
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787484971; cv=none; b=NjWIPI44HZvSY5C3EBnvPOyBVuwiJgGi3ic2ulHtFjZiio6aspxfMZEhjSkn9h/vrIVjOVfuXxAklRSIefFPsdbHsxYnP/Ki+gC8jyyolgDj5/+UBIPpC9FZEuZsFCt6P2tE0jLK/GVjrwpK2DG1n91thnycGBuFs8evfJ3QiYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787484971; c=relaxed/simple;
	bh=H9FNSIgf7rrq5kbbXRHgXSvOpHmFam1BVDdua6bG2fA=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=SDFdTxjz/W5czgXw3NkNFwn9xD7hTDShHG1jQrZOFF0qgA7YRETypLtWiRKW+j5LpmyG/viKIAmFJZCIFNwM6swGkJrNWIHPnOx76QUNUWCdKqlrK+Gy6NUbi4oFSKgdmMqF9XrxMR7NdO/Q4s0eSdrSeLTkPajdNfVMIgGPkI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka52TnwT; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka52TnwT"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ceb096e675so28916805ad.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Aug 2026 04:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787484970; x=1788089770; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Juf0SwEEXG2GohPjNzdQyGZZno/D/tGGe90n2tkqOns=;
        b=Ka52TnwT6jwGR2jGHCp4JrZ6qfiBf/Xovw+SGNA/lM0+sdoP4Ww5OiOxY0E9lS8O5q
         aw62gjf96P4UxgTr0czkGB/0xPxth+wOJn3mHlI3dxufyHIv7hDP3fYASPil+7ysqWYo
         nKRr6p3ujg/1nRh7RaLgzd2mLdhqLI/Eg+RZKRSGYjfgDu7XtoTW5vQKPRb5hzboql0h
         7fbngtrhtGsE3ApwjIFs7sdziK97HVktwhkSv4KwzTGTkn/YD+61MNZrjf3yuERZXJle
         lWJeTdazzJQbR5WYM8UE76pchjJuiNfM7yThD9JvGDZb2GWqyJPKEjOpkxL899GVtrQQ
         W6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787484970; x=1788089770;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Juf0SwEEXG2GohPjNzdQyGZZno/D/tGGe90n2tkqOns=;
        b=CfaVIaYamuQ+X9SgnqgXHuaGHcJ5nHlsc8I3l2gMOZfpjVfXPYxyyMjxBLtWKGohle
         LcEtRkkAkqjhihYKva+OyN0aGu7c72VGSmHJ0kbTdHuPtI6YbYil+qbRn2LIHBVHSXex
         f1fUQJ8KNIMI+5fE7IvhFc2ZylEFrpe91HWA9+8yTErkXHmpWtn7aZShpLbqC1u6Q5GH
         ksycf4eXNyaS4a0/pBwO1MuCUQjOAUB1idgw8y1c89gg4x0C6fCWZG1gAlCMQz7LyUYl
         xqvGXhIkpgGHlegX5dircVZAVrx9+50bD6vLJgO70qNMb/vEYHIGWmHtw5UeX+P/qXdT
         Secg==
X-Gm-Message-State: AFuF++mw3ge24s5Sa1biu2vjvgLUHC8NiWoT2Y+W/KzZPeLkQA5msbFe
	QaKjt168WQvS8K9jDbG+jjxMvJYQ9mCNm7Tr/+FZAqW+cNaTpI2+wd+LF3wlPQ==
X-Gm-Gg: AR+sD12m9lso6C1zt6SmhVEmaxUxRlB7BjVSCADMsmpnXkqnG627vYb9WItJhw/gezo
	pScRZ/moYYDQHETCuMNZFrgsOkIYhbxjBHtpCHT46YPMNVmHUYEG9w0KXeqw4QoaxuLo6yowHrS
	LFDv9OPujKd2jRbltUfmlVInOPIWjqV5e8SmYGwFyHCOBfbcpWlQwILur8t3jGweSnTXwCxgrpY
	SfbwB8hjpVBZP4qYxveS5VSHuwQD+NN9O1kpDjIJsmRdg/gVxdvB6CuZME4NCKr/3GJop15jFml
	IPW9VCUHHlsRp0cqRoGVHB/zFbVkBkcrQcW0In5x7TCg0jK04K1CC54y2hc0/GyMuqtm5IWq4mK
	T2AXgMVj9rYMAh4tkbjvMBH1b81K3pzz2CuOmAEJo6teQ8Pm8W7yIiTncFZQLt2L25DTzmWeZV+
	cYSZiiUtOdVmJ/x0+f8eMq9eOpH1WnHL/Yx9KQD/+0HnQa+eOrKwQHCZfyZCzRYW98
X-Received: by 2002:a17:902:d48f:b0:2ce:faa6:7cbb with SMTP id d9443c01a7336-2d670b85236mr147741775ad.4.1787484969567;
        Sun, 23 Aug 2026 04:36:09 -0700 (PDT)
Received: from [172.17.0.2] ([52.148.5.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f9236166sm15392166eec.28.2026.08.23.04.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 04:36:08 -0700 (PDT)
Message-ID: <6a8adb28.160324b0.2e71f9.986e@mx.google.com>
Date: Sun, 23 Aug 2026 04:36:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2542909116293525633=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] tools/iso-tester: fix GIOChannel refcounting
In-Reply-To: <a95c6273788e688e4034705305ec0c960739a9c5.1787481678.git.pav@iki.fi>
References: <a95c6273788e688e4034705305ec0c960739a9c5.1787481678.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2542909116293525633==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1150371

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.24 seconds
BuildEll                      PASS      20.21 seconds
BluezMake                     PASS      539.40 seconds
CheckSmatch                   PASS      297.71 seconds
bluezmakeextell               PASS      95.53 seconds
IncrementalBuild              PASS      543.24 seconds
ScanBuild                     WARNING   879.24 seconds

Details
##############################
Test: ScanBuild - WARNING
Desc: Run Scan Build
Output:
1 warning generated.
tools/btgatt-server.c:1204:2: warning: Value stored to 'argv' is never read
tools/btgatt-client.c:1822:2: warning: Value stored to 'argv' is never read
        argv -= optind;
        argv += optind;
        ^       ~~~~~~
        ^       ~~~~~~
1 warning generated.



https://github.com/bluez/bluez/pull/2432

---
Regards,
Linux Bluetooth


--===============2542909116293525633==--
