Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345EB25B0B7
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 22:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978843; cv=none; b=YNzpHwL6fHgCTJocKooCtzb8JoTtxMyD+ocLo4HP1gtu8amC9GclCmy4+entRjbqyKDsjepNjI/3OLKMvloHSOKAo/vkZC4jr1ipELY0LJq4Ag3DwPkyw5L/bipzQ31ptjxWNelkG+va0Nit8ZJlX00EfSys5UnrgHFHeVLR4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978843; c=relaxed/simple;
	bh=L//qiXheCydEx3jQTQauQJf53qp+KfHzqwh6qjLJT70=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KOwUTINojejXc/ckLXzkY7WHdLIpQmO2WuTBrnOALqvWcJ2aC1cANqK2J3qOlyLrA5+lf6nFPjnSq6IDYkOsbqrUMY7OgY9Ie2axvBw0CeOJg97hrqy9XCvujBWGy275c4q+EXzPHRMGyTf/c8//4yda6oSJGZoRlK6TUhpspPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPHc1b4S; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPHc1b4S"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a2adb9bc3cso197393a91.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 02 Oct 2026 15:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790978841; x=1791583641; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nlTWaQ1gfPQ6ygz2DAkKBsCuIPu2VDWnDRdcmIsccKc=;
        b=NPHc1b4So9VtG07nNgZZSyngKIamWGnJ/uoe+UiT6sdRUOuVZfhdVNKULQFJEtxz4g
         C6Abmao/5nGg5KUqEb2w/rh9oeLAx2AoHU4hu7uA3c6RUmsBYg2XGGYO0cuT4nF1RJXx
         Fw9swsUqfnhl0ZVjXB+qLfFJA+llD4Z8ea1ItRgEw2fNsgtdQ0cr4jlvw4xMRVMniPT8
         l88NkGokoTWMVEGPmy3QZY33q00UGc9UOjVGOxKmMnsfyu/OxxNJzYdh5Q71b0v4Jbqs
         HA0wCEpuPAvtLw7aA/fchIBz8Nj7qW7u0iVWyMAeU5kmBv2n7dFjqtHgnpXlaxSgvIo+
         ZSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790978841; x=1791583641;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nlTWaQ1gfPQ6ygz2DAkKBsCuIPu2VDWnDRdcmIsccKc=;
        b=cvtTtf5z3kEuwoubWeKnjqUFoi2ezEx6WZTcwD2o6OAV1I3Fr1wL/s/9lNXzlsR9gq
         uengrNDZV9SQilA402vz5dIdJISV7sK+XGsd72B4fr9XxL6wppcwZ6hLLkMpvrlCf4D5
         n3r2qjgl8+4H9AzBZ08PUfDbzZtLtTyOxcEJln9/ZV6BruEdxYiFWaiI2cu/iNqruhOR
         9gzmFr/MnojxOS9jOWgFzKWk7REsdpgyC4OvQnL/Odz67GeuzVXqcDOwN+uguIIIAN0W
         J0VFZTdscv2ux500P1wmla2M4HN4H/wpy/TFzEZaNIhzeEE7v4t8lLiU8XOEFmCw/S9W
         6hNg==
X-Gm-Message-State: AFq9FYIBk45eEEzCBazc3XJo9tHoyWrqiTATO+XV8qCJpKHdhJ7wSV4k
	rnOXKPPXgaD2qgteJwBr2+RsliN68Gfh7ffeDYKX4LsoNG197UsSyGxqwaRdEQ==
X-Gm-Gg: AYBFou1cdXuKievWQMkUqbGg4GfC/BjXRDTBZ8Y74tla6BDCyDI/YTngp9J3C/9KAar
	IUOTxH35ePQPpYGHkKwJGh1Qob7fmBJ5+JYuMlv8xVFrRELLNgCNTHCRepmj2VeVbXsPTglhQra
	5PhlNF5vmorOllCbwFh1IVqm4EvARyXP/q6QZDFqMIinkS6r01hnfM1STQnE6BiLF1jqR49Hckx
	fsJ97auFoRpH0MJ0EH4/fJDdLjjX98dzpQqBtkM+NhZFoDlN7L/dW/GK0nQppKEls0C4XsEbnLU
	IUd99/D86j4O0E4ke97nmI/MBMy6g/dC3u/P29yXk0BGyssyZmGwTOXeXQImyIfRe9rs0TLulro
	+W4UTEumtzQPvF210Zh6jk34OU26un/xrL1uniG5rpQfnOljbI3WdmXp0JtQ/2a9EJqKO+ZU0UE
	kIYcdOTXX5wpSljBvvNCeF0IH9soBFK+MocWJvzUc190wzIa1dZuZQ/cuhTBKZVH/ocaGCVjyz4
	+NsJfc=
X-Received: by 2002:a17:90b:1a90:b0:3a0:aa50:48bb with SMTP id 98e67ed59e1d1-3a6ce79881bmr1780475a91.29.1790978841214;
        Fri, 02 Oct 2026 15:07:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.29.206.229])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e4cd01asm199788a91.14.2026.10.02.15.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 15:07:20 -0700 (PDT)
Message-ID: <6ac02b18.713ba3bd.c1377.b124@mx.google.com>
Date: Fri, 02 Oct 2026 15:07:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3719423893693654193=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kevin@simpleble.org
Subject: RE: [BlueZ] monitor: Fix legacy SCAN_RSP PDU type names
In-Reply-To: <20261002200025.4418-1-kevin@simpleble.org>
References: <20261002200025.4418-1-kevin@simpleble.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3719423893693654193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1178588/

---Test result---

Test Summary:
CheckPatch                    PASS      0.29 seconds
GitLint                       PASS      0.22 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      400.93 seconds
MakeCheck                     PASS      0.83 seconds
MakeDistcheck                 PASS      143.06 seconds
CheckValgrind                 PASS      148.04 seconds
CheckSmatch                   WARNING   292.34 seconds
bluezmakeextell               PASS      93.70 seconds
TestFunctional                PASS      1158.36 seconds
IncrementalBuild              PASS      404.38 seconds
ScanBuild                     PASS      1157.22 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2624

---
Regards,
Linux Bluetooth


--===============3719423893693654193==--
