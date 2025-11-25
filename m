Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ABC32E75B
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 18:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764095537; cv=none; b=tBlI4xvZ+cOVG3Ycrrns3nS5sdLasenntC873yoLKqHdTH72rxIBzWKmwopnh0bTnJCMpm6PpkJNRab7n4RMaqsg1ZTWYkCtIgXQ/z0wvCls6wrQKrwrtZbj4qyxj6wLP+IJLrx2Wx0AUc0huPtiYJ6e3vTZcycWfVjD+UrOB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764095537; c=relaxed/simple;
	bh=7IhXQpY+HblDn2OeVHq7IvnLN78J3k/fG65zNSBIFVI=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=odyl1Dy3N/xJOVABN8X1Nxghxlw68Hqwv+OYFZ8EYEX9i7hs8cettYFfnOpiMUjnASclIuB+CxCM6bH9FXDiXVXVnjziLd7Z9kNdla+nkcm4H9DTnaDUF3pcb4BRBbBYl9oRTE7ASlSIUGR6v/iSmQR5+JhEoAyxbSoWsK/STKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCAd+yEl; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCAd+yEl"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ed7a7ddc27so48320901cf.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764095529; x=1764700329; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=56keGR2mykwjqqU56vSsuLpvPFw3ljFeME0zqBTFP4k=;
        b=KCAd+yElGvhGEuHbOJk08rGwRcfKXB0LizoQO9QAWfFCODXx6dxwn0ogDTk4ZGTm77
         OhGB5E/7lQp6gtdOLwcRkOQ8G37qfEqA4Yd97Bi9wVz0Y6b8mrCo2BI2Fc+h7yISbbi7
         jbp4ssOsah9Qup/BmaAu87MDe+1LAJsnX1CEutFqFl0DLEcDJh0NNb9LT7UTrthuLAtg
         AgHtyds41g5okMHwIEU1DdVMoKNDFO4rWoWt/K3M077FZldvTKeLzE8JLCd0G3ZhydGt
         HjbHnYSeyc4iKY7YBkgb65Gk/JR3Tnh+G70XLTaCyqoZC0w+HNwtuF8qXe1cUwdpNEXk
         /60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764095529; x=1764700329;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56keGR2mykwjqqU56vSsuLpvPFw3ljFeME0zqBTFP4k=;
        b=u+JjshYI4Cek2tIkx6lB/hFa0Y8HK3iB7jJHtAWqqHpJYRnuPcw+uTiqiHMgX6Yrd/
         1xBBU8K12OZLkIg1LQUgCiNMZojgoaRU1QOPCRcZI+saRrM88zfM5nicp0yL/NDfX4E1
         IQqPtA0tRMBG+G+IprJsZ7t9EEDBcAstKqMpnSY5JJf1PLWSvQFCPmF9QfJeshqta+/e
         xoJFpCv/4NNCwhHVx2J4DQhiXpzyhi45vmnScyKTfdP73qbnAXl9QcjlbRDQgDancVRZ
         OX0j98dUh1+BWTTx+rv3aQv+SH1jtTH4kjE21rvRdzOZwE6KEy1MvxlRIlZMpMp5wzJl
         53+w==
X-Gm-Message-State: AOJu0YyrZu0007cJzPqHZ7nuZJ3ZwTfmga/2Xsv8TMARa29SExkK5+Em
	Ij32KqWpuUFXNdxUc8BfItCpnbru00rHUQcbfXhCD9kzbRbAt7KiBwpLp/bAVw==
X-Gm-Gg: ASbGncuVXF7YT8ui4ON2ToV0rF1t372JMeL0itshIirdsRB6ZjRgHjRKs7mxQUYk6FP
	knhuYUOkQ0nyzzm7HMeLbyyuDuPxTAnDD285hGUk2KxNs0JuULFZ10hu0uaBmHm+EQY2jK5CoUh
	Pla0FbIcVKlJsn999hk4hg/GxcVq2TZuhPAknOKiXPLebyo1sKRMyiFNiVB5c582CKXPXENDOIP
	Vtp7eRwXSppxIZRFyisXpAeXEaGPUG33b8jEeHER/vhVbDa4r0Xxx81G14Q/jFpZBap3Sv6+ySy
	raRLddZHJlUQELrmG7yx+pZME/NA6jctLjrNjObm4a2qUPtgYSVgN3XKyiyREDWEadTeJOYIsmR
	tSgfbn9untJ+PmKyyD6Svb7O4RH1CCDpHLYcrXsP3S8FSopFUHzLYRpwd9/r+KZhLXxETtCdppQ
	ZXZcW2
X-Google-Smtp-Source: AGHT+IHuE77M3qvybkkFCdia48E3IuzIQWb7oQ51Zmy0zPSIEETl4+S6aUw8PvZ/PPINm0AU4rD+cw==
X-Received: by 2002:a05:622a:1a01:b0:4ee:1ec9:f947 with SMTP id d75a77b69052e-4efbd91578emr55345291cf.3.1764095529456;
        Tue, 25 Nov 2025 10:32:09 -0800 (PST)
Received: from [172.17.0.2] ([135.119.132.148])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee48e67fa9sm111982811cf.23.2025.11.25.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 10:32:09 -0800 (PST)
Message-ID: <6925f629.c80a0220.2ad282.e820@mx.google.com>
Date: Tue, 25 Nov 2025 10:32:09 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2654329183289188932=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] transport: fix VCP volume updating and sink volumes
In-Reply-To: <68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
References: <68b8ba8dd63306081aa7630e3b1f8a186e558b6c.1764090857.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2654329183289188932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1027465

---Test result---

Test Summary:
CheckPatch                    PENDING   0.46 seconds
GitLint                       PENDING   0.25 seconds
BuildEll                      PASS      19.97 seconds
BluezMake                     PASS      643.87 seconds
MakeCheck                     PASS      21.82 seconds
MakeDistcheck                 PASS      236.25 seconds
CheckValgrind                 PASS      293.75 seconds
CheckSmatch                   PASS      341.22 seconds
bluezmakeextell               PASS      178.24 seconds
IncrementalBuild              PENDING   0.31 seconds
ScanBuild                     PASS      953.47 seconds

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


--===============2654329183289188932==--
