Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5271BC26
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665022; cv=none; b=UlsnVmIYoLm+D/OB4cTZqRmiys7S6beJtyH369Xk7m0qYTAs6Wx3nmDRYtjrPwBLljdxk4uYsv5+tPqyMHte/GIGgcHtTjhUdbT+yPfoC5mnKRNnaFiEtZQO96IhHfvvZmLTui2aBR+CVcP/tcPuAkHEL9s+kg6bTMv/oLX/PvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665022; c=relaxed/simple;
	bh=uc01dxAC3q5klt9pETtP0dVmZuYjK5uXLI5r2Ae8vjU=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=bANm59q+/sp7CXRVWMqSxeAJ98xfbBpCGj5Fuanr+XOqA/al7V4xi83A1VlN6+2sX8AgPZdzet6+/WsB5q9QXKm26avfuggY79eXS7lX/Zfq+OK8kWyXTic5IsuaO2b0AICwULWvQY/nQSFbmvH3n03Uq0vuGQFyiXHLPQKGN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jU03YLqv; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jU03YLqv"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-68facd7ea4bso532916d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 05 Mar 2024 10:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709665020; x=1710269820; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WvU8l3z03GQsByI/0kiHJ3yUj/x9DQHa8SB4R4r23+Q=;
        b=jU03YLqvaSDZ/00yDu+BeSfABkFSytBBYbMuVUjKclS1kXu7DYZyhl/Bphhayr8NZL
         /cNMthOQ9ibzjXxQOCcJHGrZDUmkat9q0ZsZrXEi5GcXPNAiQveJvazKu4hBngRJ7lnE
         rS6y3UP4wiW/7GKmOkJuAUN4UTAP9rfUOZSzRTIbabGZtKxx4SSH1Uik7IN9LHsF754e
         YdUkH3Bib9F8y2mKHkMe/ob9UkHHPrSW1qg6905jPpC0V7TZTAtOgpUz9ytrS0w7NF7p
         VlZBzN11nqMcMjU+jhjxe72dVu+c6a8U4gcNd+uWN+f08yrPDR1JArIw3ybmSoRhoJBO
         8g0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665020; x=1710269820;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WvU8l3z03GQsByI/0kiHJ3yUj/x9DQHa8SB4R4r23+Q=;
        b=DrF7o3fuVvNtPu5fqUezfVWsW7+HiE8xfiK3JqDhohsVejTCkxI3v/REZEW3k3pA72
         8c9z4DXj6fRUlHCXJ/Kyrfaq88/YdxnNNnVolX46RLPh/ZRQnFUIXd6bCAhPHrq2W3c0
         BUnp6tYsj+nm1WnrUDvlxwjBY5A/fzvRaY8k8Qq5zsYCTJI6Q+HcsE/GrW2eglQiwvM/
         MqCoIVSgA58cF4CyTJaisC2oP6B4319c+wI96bvKNkikDe7vSc1+o/MOqHgQq+oFiqGs
         f2tEp7Kn/9PTlQcbKwMud5JN/r9AxL9sF5dvyavau2tHHWk+8eZSdcvX17EFyKl3nWQh
         wxBg==
X-Gm-Message-State: AOJu0YwskFzRCwAaI7ie8JSUvMA26SYhhNhevH4HFHTuEswYJ31K965o
	XPyyItTheO0vkMZX0kKRrwkTkCDMv/lN8EHKRk7irXwsVPalB8635YntpItD
X-Google-Smtp-Source: AGHT+IE3W02QRqqtAK4wpzpg5+YI+O5GvicrdCrZZjs8g0AbJTOhL3ZHP8hV+rmTQGX9ezD/BC3iHA==
X-Received: by 2002:a05:6214:5484:b0:690:7b7e:18e1 with SMTP id lg4-20020a056214548400b006907b7e18e1mr2797527qvb.29.1709665020115;
        Tue, 05 Mar 2024 10:57:00 -0800 (PST)
Received: from [172.17.0.2] ([40.76.117.204])
        by smtp.gmail.com with ESMTPSA id r8-20020a0ccc08000000b0068f6e1c3582sm6411800qvk.146.2024.03.05.10.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 10:57:00 -0800 (PST)
Message-ID: <65e76afb.0c0a0220.19579.b556@mx.google.com>
Date: Tue, 05 Mar 2024 10:57:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0586287350580115067=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, yuxinwang9999@gmail.com
Subject: RE: Bluetooth: Fix inconsistent LE packet sending behaviors
In-Reply-To: <20240305182349.4182578-1-yuxinwang9999@gmail.com>
References: <20240305182349.4182578-1-yuxinwang9999@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0586287350580115067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=832651

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      28.46 seconds
CheckAllWarning               PASS      32.23 seconds
CheckSparse                   PASS      37.71 seconds
CheckSmatch                   PASS      101.28 seconds
BuildKernel32                 PASS      28.33 seconds
TestRunnerSetup               PASS      509.11 seconds
TestRunner_l2cap-tester       PASS      18.12 seconds
TestRunner_iso-tester         FAIL      32.80 seconds
TestRunner_bnep-tester        PASS      4.85 seconds
TestRunner_mgmt-tester        PASS      111.60 seconds
TestRunner_rfcomm-tester      PASS      7.40 seconds
TestRunner_sco-tester         PASS      14.96 seconds
TestRunner_ioctl-tester       PASS      7.87 seconds
TestRunner_mesh-tester        PASS      5.88 seconds
TestRunner_smp-tester         PASS      6.88 seconds
TestRunner_userchan-tester    PASS      4.99 seconds
IncrementalBuild              PASS      26.17 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 117, Passed: 116 (99.1%), Failed: 1, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.189 seconds


---
Regards,
Linux Bluetooth


--===============0586287350580115067==--
