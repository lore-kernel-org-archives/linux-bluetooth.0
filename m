Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646564D5967
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350867; cv=none; b=Gi49YW7Puf57xW9lvtPb4IMcZArj7rov8mcdEDZptfTf1uh8rapZLWzJ8bCEfNyiy8t8WVbSx8Z8cxwPr2MWbB1r7Iqyu85UCUC3beaw9e1FPf3GH1jnKnI3kSWn3xdHOa8ys9BLuprSfKctVCkGo3P4jWQDirDg16R3d6K+KUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350867; c=relaxed/simple;
	bh=p2qHuGbZAcIpyAKL2E/ggGI7UtUUkC5/yfqTIEaad6Q=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=KNqlSSMvUTogI+5nsuPyN/vPOdOauD2GljDIaj8FaSujvKB7f++dmViALCnouHd6Q4EgSqAcJy8C83eA7zjIVh7UqFkoqZxtYj+IELwYwPOKYW/WSZhIAlBogJ6Q+aL22pS0fi0j+IIh3lfQ8OhU/mG27x+frwZ4f+GUcHJjEFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ONFGJvpt; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONFGJvpt"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-3396cec93b6so1157475eec.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Sep 2026 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790350862; x=1790955662; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cBX2JrHYFJ7wdu4T2kMiOj9/0VoI6PLQdl4LFQsv/40=;
        b=ONFGJvptzBU7/0y0WUKf18AMj70bhsdBBKmLdreLMc8T3FGVxDyOAYLkZkqfnLbG44
         DYp+FyeRra5jP/eqrYIZtwOeQHnRSl6TsiehDtvZDNZKgtryKrUhiWVctJSK6MLh+74T
         FytuF1BQZTT2XuYU4mlBq6foUMjxS7a9AC/ZNiHKl58QsqisowTFi7Uk3C7ysitM8tmO
         d0N+LQlds5Plf1Lk7V5Q1ABBQ+R+7gRcnjV5stNbxrEtdcWax+Ypgew3srRxhkTrPGKE
         TENuWBdfLmudZ5dQlvOrzcbvDYc+PB/2/p61A18dXWidn48qX63CILTPvHVXuZbQPm19
         vy1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350862; x=1790955662;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cBX2JrHYFJ7wdu4T2kMiOj9/0VoI6PLQdl4LFQsv/40=;
        b=wrUe9K9TnV1ypidOiW5sKjfONQ06cBvgSev2oRCSOWG88tm4M5tv4H0TA3GjVJOhSF
         PefY0XTuJziRWBeqQ2mFJUnq9PxSVM+zeTd3lbcAEnnVfucvMreD0dgkIgfpvxKeFu2g
         XcUN7e6gJ1F/m0uZcEvQ5M03Fia0Mscn0qTuhZRXiFHKAZOI3lUU9pGoJ7MAcUrBVI+A
         7CDNw+9PNxosfmTDa4UtjDlnzfr0D7z8m7CMzCwIZ01kbXCw+jvJmS46WUeB1hP7OthA
         xUpViSeCJS9RH4Y+zwBw1Zcml9E/g/2BwUtd7zurJ9On6IxksXfxboe2B6HkxhhkaiTz
         jBFg==
X-Gm-Message-State: AFuF++kjByrBUCK2PISd/ku2/hgU7ARg4C7JHDSy+8FrdqyN/7YQEH/h
	efIT6ayv9AFXBysnTJJIT1AbiWzci6exI+ku/sgSYUtgWJZ2Mhr3VjjIACG51aBn
X-Gm-Gg: AYBFou2GzaOvP+mN+u6fGnMOy9/ydPFcktqHZeKCWSSTtSerS+yxMXzcm9CGVrp2Y8f
	Xyx6miyfHyt3fMkZXYcoRKb1kidARzApHfev7Vlb0CV5NU9exqDa9UwAuBks7XGdoG5YNKvjsK9
	TJzk8eSmSmsnu1rdM/BRQhLw3kckVSsU53+z7yBZAMPzqenrYC+sQAM5BFQ05N+r2tguJG2QO2U
	wMNTl8ViatkJ2bwzFrTvYbsf7QMKRaqYgwSYbVO5Xy9yPfRwWXo2bPeHNQ5KHs+FUbfF19jtEH9
	xCZwClV6WZThJiHxzS4qi7F+luuIdZVsfNCJWNn31QRnViJMTXy6XVWOswq6Atrz42jFosCW0t6
	NITBC6KuubhocK0Q6DdaHZYXidaVxVCZZSI9/KZdEbIQV6wy+jrXQ3nsbVDWD3NgSrMpkzwzfv2
	0f2dg1xZT9byGUvTJnb6fSlPD8fKKVsZwFSaFmj2H1ctTuI3iWsK1/eIFam97AnnlCicN26C99i
	88T
X-Received: by 2002:a05:7301:1a02:b0:33c:e9d:6d49 with SMTP id 5a478bee46e88-34272e524a1mr473870eec.39.1790350861776;
        Fri, 25 Sep 2026 08:41:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.65.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144b4ae50sm6904709eec.17.2026.09.25.08.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 08:41:00 -0700 (PDT)
Message-ID: <6ab6960c.17b2f02a.51de4.9415@mx.google.com>
Date: Fri, 25 Sep 2026 08:41:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8025159951098544800=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, frederic.danis@collabora.com
Subject: RE: mgmt/device: report link security level to D-Bus clients
In-Reply-To: <20260925102914.3282319-2-frederic.danis@collabora.com>
References: <20260925102914.3282319-2-frederic.danis@collabora.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8025159951098544800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1173703/

---Test result---

Test Summary:
CheckPatch                    PASS      2.27 seconds
GitLint                       PASS      1.48 seconds
BuildEll                      PASS      16.45 seconds
BluezMake                     PASS      278.23 seconds
MakeCheck                     PASS      14.50 seconds
MakeDistcheck                 PASS      116.51 seconds
CheckValgrind                 PASS      182.99 seconds
CheckSmatch                   WARNING   217.58 seconds
bluezmakeextell               PASS      71.93 seconds
TestFunctional                PASS      895.09 seconds
IncrementalBuild              PASS      351.02 seconds
ScanBuild                     PASS      809.74 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
monitor/packet.c:2289:26: warning: Variable length array is used.monitor/packet.c: note: in included file:monitor/bt.h:3924:52: warning: array of flexible structuresmonitor/bt.h:3912:40: warning: array of flexible structures


https://github.com/bluez/bluez/pull/2583

---
Regards,
Linux Bluetooth


--===============8025159951098544800==--
