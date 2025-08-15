Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107D1137E
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 12:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755259826; cv=none; b=lKM56J4ppRG96JK8xfFVw7XUvQViCRmQk6BO7M+nIOYRDaXPZ5nUEP1JK6Mf3GoVYusg0ERGSr38dgsglmsymGxygQeTVuk7DPt2U9nGHYJrNMLmAAIYepklRmRdnKfj2/IypS6qtXI1SUiNYf2hEBKgEjSXQGqOht3W5mciitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755259826; c=relaxed/simple;
	bh=7V6/yDwdUr8DeJZYX2ncO8ztm5cxdjK0GHkl5BaCffI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ts5cSh4GMCjhfTxx8rLEZL34w5O7s+AATQPHhMEnw7jja+r2C9KqKCfB16Z5gi9ItDi68xXY9QZ3f+qRfQ9Z3KqirT+30NDeRMCIcdICVkomefFnwIhFL6ZjBMsNJUL925ZzfJO9FzzfXqdJDqncxTKrrSn4SnjqFl6zFoDaXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aF99nelF; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF99nelF"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47052620a6so2304581a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Aug 2025 05:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755259824; x=1755864624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqYjPOaNtULn5MUhe9KZaBksx/fx1hTCgaGoFMkywPY=;
        b=aF99nelFQjZRwyp/espnL8L8ery4nyt/L0F2vOK6+Xcczm6wpXvdKhC7+bbdT7T8FU
         DCL+wYqDxoBeWItGD1mYAs3EoiPCs82znANG0L/zBGOWv2bCUoVNi0kYSAd4z54ZzSMv
         oKIU2SctbWCmuMvjJGqeFzb95h2/QtynUWgwXvibL8k0funp8pEWTZPdVJepvGHbnb5i
         S7eYFAAq6HSwRniGEGxYuUMQlzSIRHV0ABP8rvyzX8bUWxTwlkuoJHquBFokKiFKnTYv
         0uBAcRU+ua3+IpAEYv6OAfp/cekbx74KA8D5FVlM6O+9Am/uA02uLQOevXsra18Oz1+B
         sF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755259824; x=1755864624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqYjPOaNtULn5MUhe9KZaBksx/fx1hTCgaGoFMkywPY=;
        b=kS1JjpdfbWLrAug6oagmEBpvrBpqQlkgqhm1jZY8lxvmZrPYMhILAQtnvWt3mdzcQi
         6zAyYhiyHmhcg9ZVOjPwv1UnFIyMJsZBiuiycJpOaIzMLGf610463r4l66djzk7Z1dLZ
         sHwamnYMJFwtXD97Vyh19Y5gC4g0B24YKq3NUitkCGun8IubcuLvOCuvjdnm0tKoc/C+
         LZEs38aOdFje4Lt+nVmF9Shh3FNf2sL7GhhghUlkN1y8ihpJf7725cWXcY/5AjMjkVqk
         Htp0bd90Rve5V2kLfXNLdiw58qeqZ2PVv9rxU/aUkPfFp+xSo8fcOFUwdEreGJoPzCk4
         yT0Q==
X-Gm-Message-State: AOJu0Yy1MD7TetJfK9trd2aWd9DOQzPA2q3LPEfWQer2PRkWhZ1ZGSvN
	JF7Ef9pusZNVt79giMN+XxPZgMqiEw2Qf2hy1jDqxBcqiQ8Rdkzk92ovFYDukW0m
X-Gm-Gg: ASbGncvjZlT4PCeApoWa5fRCMYhk/yKeZhDnWD5oKTg/ht5xmjSEzHpY/mJVwSDpccM
	o2NGS+/qrUygQ6n/9aXSOl6or5e5rJqnaeiomMoXdTbFgFwxwjgx88sGjdtyI4F5Y84fGtlW2AZ
	GmEO9S0TfMRSDjQzf57MUslFFeE5SF1IPFY4REhyBCAVqUOoiH0wmSG3EZJ8jU/EOblMadlbLdE
	rGDeIWGSK9500UftZpj2qlxs1vrusQPMW2WkQHvK2O6grHvi3zM0YIHL17zxwUw3IFJchDlTWAS
	XbripRNtRj0i+/3uN9njTxlCHu25JncbJKJzhvAtjzIslZlzrml4+HSdctxtHGILQ5oxsPIk6D7
	H6r+UIWPv3JBAPKs5GB+vLiHT2HHeqg==
X-Google-Smtp-Source: AGHT+IHUS0HoCkQ4+M2+snY5ymtX/iXrNpFW9AaLfJUeBAJpOp8o2xhWPlcE9WlIIBtU2sFuJIy7Gg==
X-Received: by 2002:a17:903:2a87:b0:240:4d19:8774 with SMTP id d9443c01a7336-2446bdfd3fcmr30991765ad.24.1755259823897;
        Fri, 15 Aug 2025 05:10:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d53bb62sm12845595ad.116.2025.08.15.05.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:10:23 -0700 (PDT)
Message-ID: <689f23af.170a0220.240106.3432@mx.google.com>
Date: Fri, 15 Aug 2025 05:10:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2022083666917015307=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ye.he@amlogic.com
Subject: RE: [bluez] device: allow selecting target broadcast device for synchronization
In-Reply-To: <20250815-adapter-sync-broadcast-v1-1-40cb1c92a5d1@amlogic.com>
References: <20250815-adapter-sync-broadcast-v1-1-40cb1c92a5d1@amlogic.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2022083666917015307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=991899

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.01 seconds
BluezMake                     PASS      2525.37 seconds
MakeCheck                     PASS      19.81 seconds
MakeDistcheck                 PASS      183.37 seconds
CheckValgrind                 PASS      233.70 seconds
CheckSmatch                   PASS      304.65 seconds
bluezmakeextell               PASS      127.28 seconds
IncrementalBuild              PENDING   0.32 seconds
ScanBuild                     PASS      903.29 seconds

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


--===============2022083666917015307==--
