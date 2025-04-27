Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C035E4A18
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 12:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757845; cv=none; b=hT08kKmbe9ASg1cQGMiUwomuSVVcoIF5DNp1d26f+pWE1rWHkLGVEelb+zM0aRHHrs1kPN4fqd4aDg7Gqvdv4lWGdtNG1VRG7VxHUUH17AQEiZEjDr1RkyeJlRgacfqgyPIFQDOKBfVjxZf350mh1+lgYy1/Kacws+g5KYKU8m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757845; c=relaxed/simple;
	bh=erwLLK6RzBmFLea4XmfxYSBw84lQujQceCVkveTK3DI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=l4LYx6d78ZLY03Dm2R+Xx+jyAhfDdTtvguNMYdSXxngOvSi9HR0dNwPY2I47CcyD3DwLR5Nl5Xl+fXM6jd2cwtBSaOVyefnwUSufClnSyH8Sf9ZRYQxHOhaMfSCmwJUuU5Vi/mgev6LYdtFczTN/OFf6ywTltVXRR+C1VfTPh7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSIwcI1q; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSIwcI1q"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6f0ad744811so28679626d6.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Apr 2025 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745757842; x=1746362642; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LvMkg1IWeClvvaScShhHVMDyleAqqrBQLICBurzCMDA=;
        b=jSIwcI1qrJna0PIiLQ/qSBBspoU2bAXSrbtUqdUm6TKRPqiwSc3e+1kJf+R2S/z0OJ
         OIXkZJiA9YQQxH7o/xtcdQWJ2jgiOVnTWku9H0tRgnCmf8yGyestqkrTUlZr2sG+wRka
         MrPSBAXb5ZEZ21Daub0nfls5vEr+djqtOsRpFHUrhTRUeKuLMg2sMA7wx1AvGOMLnKoI
         rlm88tYUX/6oP63PBJ4pXOA9/XDzJP+CItlaYcX2YXzReqMddiZLMuy1aAb47lgHfqJh
         gUW6TwSFSvRyynyMnbZ2xiMJruN8a/HhFGGdQV+ESHgYuB6dWM1v4bzC0Kq4Rqua1Pfz
         oA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745757842; x=1746362642;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LvMkg1IWeClvvaScShhHVMDyleAqqrBQLICBurzCMDA=;
        b=KRoVguB29vhD6DNK+LoWP8m4CReb4jjkq2wk9Sz/7XBZ9Ac2zKjtn+KQJ6JajF5xUq
         CvZ+4PLZVpHvTO6a3ZzPMvFteTfWZ1/MDi6cBITd8nfL4lCup2nvWQTuGtJ/oic2KlUw
         kWQ4pLRPamsXHswECvVSSQhYfgSB/CXHSuwkTIX/7DBXXtZuqtX0sD+y/6ywXE0KRnJm
         aK8tKzTbfI5w9Nu0vt/OxwaXJMLEa/WubYxI7eNxkSTf8Qa+0Fx3L/OMRlPQQbjQYIio
         Rrz9O0zCotq/G3KAdrxLPvdhu/qbnMVBuB3nTVcTpvAIBbItkM395cC00XXnWPxDp+3S
         nydA==
X-Gm-Message-State: AOJu0Yxecrjzpg9pbpetHDrC/Le+Co99HHtNcStgX+bI2TcFJnoAvqd5
	nxgriCYst1vekBg27x/WWTtcuwIQM/Mqhr19Z1Ra30Xd28UQjounHZ1fyw==
X-Gm-Gg: ASbGncvXGGxeY9tu8GfffJTAjAHX/JcEsxECqPzjEaG5IDYBEPVyD69JF+VYQYTSDhX
	DzsiJX66X0f52thuN82HROQFeJHs7XQsnPRCRl1ofTerSKYBaTtDD9YNjfM8IhMXNveb+Nu+0xp
	U0ZW0/XYKHziWBnBxglMhWcMIxLRVPvB8tdiE25c45TZ/ZLjbichqXSkysNXXa5vROT/O65NM0/
	7DM9j8MgtPqfeyaMnuX+7M61WDo9JDmvpE5yVdBtBsM3PPTqjZiOa5laGbmCkhySZVgbk47nQNR
	N2uCJgmF6yRCoibvjbo9Ph1lPWk8/xgWreDedKy8iv4PrvkiW+oqUFUcTw==
X-Google-Smtp-Source: AGHT+IGTT7A6uxgk5mfEamKOer8tLAzNhRtGvAGnu1qPIFQyFfL84HKYLvcU9V9GTHiYVlpNkSECuQ==
X-Received: by 2002:a05:6214:29e2:b0:6ea:d033:2853 with SMTP id 6a1803df08f44-6f4cb9bf0abmr156707586d6.16.1745757842347;
        Sun, 27 Apr 2025 05:44:02 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.77.230])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f4c0969657sm44514326d6.65.2025.04.27.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 05:44:01 -0700 (PDT)
Message-ID: <680e2691.050a0220.1f53cc.bd2e@mx.google.com>
Date: Sun, 27 Apr 2025 05:44:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5695946250245703488=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] tools: add tests for SIOCETHTOOL ETHTOOL_GET_TS_INFO
In-Reply-To: <fb7b09305a729369d1755569d4e7bdda48d94327.1745751513.git.pav@iki.fi>
References: <fb7b09305a729369d1755569d4e7bdda48d94327.1745751513.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5695946250245703488==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=957489

---Test result---

Test Summary:
CheckPatch                    PENDING   0.20 seconds
GitLint                       PENDING   0.20 seconds
BuildEll                      PASS      20.63 seconds
BluezMake                     PASS      2609.23 seconds
MakeCheck                     PASS      20.80 seconds
MakeDistcheck                 PASS      196.62 seconds
CheckValgrind                 PASS      272.88 seconds
CheckSmatch                   WARNING   300.34 seconds
bluezmakeextell               PASS      127.32 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      893.36 seconds

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
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
tools/sco-tester.c: note: in included file:./lib/bluetooth.h:232:15: warning: array of flexible structures./lib/bluetooth.h:237:31: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5695946250245703488==--
