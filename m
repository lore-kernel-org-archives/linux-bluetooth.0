Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE3F378D9A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792162497; cv=none; b=sixueTnIR54rUgaXp7P3HPY7CIxtIulK7rPicrrGgbWrToGq/o3ZAx9Xq0xO7Qngk6TZRjIDjeLkRdhqpGrbSzHEXKZCIKHQ3oU66stGtmj75ACEamxM7LiZmtRVGLbrdh6vXBXiHuv6ZVSkA0x5Nbd+YxUPJicEm5caWRgW3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792162497; c=relaxed/simple;
	bh=Um+RVS2+ZI0W0EJBlTkUWQlqPhR9dbanCbYUNKdNoCM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=H4pYkNThXPZm3OCk782EQxJycqeaTybWgQym11bzv8e6Sp62M9RDaYlJujJXCPpsUPVQE6sRqojdlo+p7vBgUNbglDfSHYMgKX5YxO1+RALt6grdu7284aJRnVQN67na4I0GVoXJJwGADCSzsnm6gVdSrYxWQg80LN92d7Vf3fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UDxGp6HR; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDxGp6HR"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-843a4ca671eso245477a34.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Oct 2026 07:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792162496; x=1792767296; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+wbd47awYJ3MTXn9mDNCRphm+dGQQI3Bq/+8FgUZwZE=;
        b=UDxGp6HRuz66Vq9QnSc8zfnvlS0bFSI2f70Qwvi9R7KH/HMBg3gB/sObatmBDA6tPk
         9jTuVEeJFymxu38LrHpsaM3GWwpKQeZfegpv1HzBOkMvPS4ap7TMQ2ZlPV5NhZ38pcrx
         Y3735DjExeCmlBCdpCt46gDRCV6ScmjD0THtApw48n2rt628RaEBrMD2l1clTlRhB3Wy
         Mu2BqScseuOVyjg53PsZl20rxsEBuxhSx8fp4gb0cUoSi5QnwgRJBbH0sD0iujjvtWOy
         4WpI8fGpWYJTeh+53lrS3+SR5u1L6Bk1J5uSvQ/yAXT4ALLpZpgyseWtobrVVb0PfO8Y
         64yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792162496; x=1792767296;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+wbd47awYJ3MTXn9mDNCRphm+dGQQI3Bq/+8FgUZwZE=;
        b=AGlV7VHhC8q25WnE97BhWYkEh4S1V7hKDEnFX5M9pxQxUhnaptLkrKb1wMOtfGozk0
         uLsI5jKC109SmcHnmvcy5hE8OI5jfmienX1sLixhax3x0gBbUSRDQ9yca+Wrcr0drBgd
         Mi0W2ML0SJWPjrxsuh+D3FybMD9EAA1SBckscrdxtAmqU1YrzpoB6AvIcga/uf71NEuK
         tk4PGkLNgyVzKbsdmguk7eJOpNtljA9GU3Aa91rcqARYOhq+ZqXeP05Ok4dtaQhgjIyr
         Wbc3DU1E6cMjeYpNLnbTwrD8/kuSWhNSgXb7Sk1+OPcY+eXevRmipEvWuFh7FaBYpaQN
         orQQ==
X-Gm-Message-State: AFq9FYJCZXjxE6brmfzQr8Wle7CMc9DfcdJRTp3AUrmRj2LBTLg9Fw6Z
	kwGI8hm51kl6bZl58VxP7TP9Bwnqm4e0TG7x9uLmlfq4WvgjVUJQ1VBDhI/q8g==
X-Gm-Gg: AYBFou2rFGe9LvPS0eHNxyuR6cYfsYhmMuw2KhVtAAlQTarMaxbqZkb/9JK+xqcm2XX
	HDwqSxyHwUhl5ZmyXMrPwzhvc/+ZJjM0Ose0jELhA73oXaT6U0DxROgp5Vb0I6r4jzFTGUIAUMZ
	euG+vLrFdm3YVbT7Adyh98oG8szvU4oy+OlbWm3YZxWNJItPw0hAIiLmdJyE4rrTOfktNyTBNj6
	jmHna54JU+wo1aDSzhlZdJY+d5I5mui95eTkC+boh3ia3eEVS3jjT6i3Emy/8eIWAGFUTqUC6u8
	qAMbsLiOVrV42owEBcDqvfBUeyttXB2Ewr3k7dxasZGE6pLV0DC1GvDHlkYC7KO6e6KnIncNlVV
	ZmbRmpJlU+vhB0d53bH4TwkPEj1gqQ4LAErjAkJny5HHNg6GRlqi6FVRdrRPSKjHCHL5Lybl/o0
	OoItzRlakHT0+i8LZdkb26yhsXuQcxaiijUE6Affy/W9yv4gd+VlOxOKsykJaaSWNMspaLc+CHS
	U8iwnc=
X-Received: by 2002:a05:6830:3698:b0:81b:bfb5:26cb with SMTP id 46e09a7af769-8309093be73mr19725676a34.3.1792162495578;
        Fri, 16 Oct 2026 07:54:55 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.146.115])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a6e12dfasm1892376a34.24.2026.10.16.07.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:54:55 -0700 (PDT)
Message-ID: <6ad23abf.674ba918.386c29.6b88@mx.google.com>
Date: Fri, 16 Oct 2026 07:54:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8412685826839166961=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, 26rote@gmail.com
Subject: RE: Bluetooth: qca: check the device address on every setup
In-Reply-To: <20261016124615.61-1-26rote@gmail.com>
References: <20261016124615.61-1-26rote@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8412685826839166961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1187309/

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      22.21 seconds
CheckAllWarning               PASS      26.11 seconds
CheckSparse                   PASS      27.67 seconds
BuildKernel32                 PASS      22.39 seconds
CheckKernelLLVM               PASS      26.39 seconds
TestRunnerSetup               PASS      517.15 seconds
IncrementalBuild              PASS      21.33 seconds



https://github.com/bluez/bluetooth-next/pull/957

---
Regards,
Linux Bluetooth


--===============8412685826839166961==--
