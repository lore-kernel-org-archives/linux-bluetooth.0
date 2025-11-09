Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333072F7ADF
	for <linux-bluetooth@vger.kernel.org>; Sun,  9 Nov 2025 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762696962; cv=none; b=aiv3nhMN/Ud3G1xMps83OqkvIODJ481VtF1xA+FBcfVmZTG8+uCSvON7BIbY5ytL+otPoh3kDb6hB905J7IelPCD7rZV8qJ8/fl4MTBTcI9rlddyW1hj/ExyybS6Bk4x72P8fiSBNiTUt6ncUnkxmHifuGU6X7SR2qtKdzQ/0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762696962; c=relaxed/simple;
	bh=myOITsv8s/CX5HFXhIvA0qAhxeWayMhuUvrJ1aGBj1w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=cmUUPGb9O4xTCdG3EqHny7E1e+ff4l+ls2Jj21wCP2oGhE76uQyv/cBnDOyLBoCMs0MLbIC/2rTb4dZWqL+zEkRCbdz3FESjpQPHkuJStz+lOwmzJVJO9PsRA96RRFtU7fUTQnxY5JMbDX5CJZHxULS/YPXpZQC1JKAYsfYhng4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCiOKnho; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCiOKnho"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-882390f7952so12505676d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 09 Nov 2025 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762696960; x=1763301760; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tuc6v/Hq8W4bt8xjlVrslc/zkKNN/kXH6xSlOTpYWLM=;
        b=LCiOKnhoXFn/o2HjbwXGy4bUYNqMb1TT5vHkxUuzm923RJcMX7bpPic+B6vLam2D6x
         YvuCeLhJcNyzYdrI/jJHMT7nGeCQPG/SGbJbch8rO6kYQGP4PKfRnJe002Cz5Yi/WfVI
         RPamfZQMKqTF+YY3Z//QwGoW85KFDzuioC8H3YxZfvikxf210PwBhjgro9yVT801tT42
         CSG7H2rh6JfIypNLnOELXoeQQhxdqmwinJuNbUOodKR2adqDfLrdOyfIwS3UrEkhMP+L
         iBh5TNsc+yb8646OcNh82/FhkasXjdDBeRrSc2nIyO0EsWMawPEx6FLYlv83CshpfiZJ
         H/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762696960; x=1763301760;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuc6v/Hq8W4bt8xjlVrslc/zkKNN/kXH6xSlOTpYWLM=;
        b=eaXpkol7Or+/Byqa5MO1Ez3A7ZjEmp5NK7OZFokL5JUP5jKMTR8ZWac5H125n1c1sj
         YtUZvOWn5oGn0nc1DlaXxzb1R8HsNHIz3a2TKOlO2nQej6OkXvNNq0/6xbXpUdLDeae0
         hG0oGd0SyIiIjKgaKH0mDbh7c60EvAjVzH5ebQjym+56UdIhHmtU+PuniLMlszY/PR/r
         or1KrlyvgYCy4dvnxTJoY3yloLVNmLckO7ZcyTR25CmbVv37qjjCh3xthdudU6V7Q0fj
         3rXc5AUj8qkkoRDeNm32/xtlmJMauerOu2DOF0cUM3gW80yLlel/ceXFt4T19VCdV5B/
         pVlQ==
X-Gm-Message-State: AOJu0Yyr7G84y+YoujcYtYKzWgY5MSIoA1Y46ICfYt4ML3tlOnX3AxpM
	Pns6Oj6dkOiRN/Q94uG2Q5MzL3cQNbme/nKu/6TmesAHmS2gMAv4YF69i3wGQw==
X-Gm-Gg: ASbGncsOvzgFFuITtzPK1jxNDMCwWtQc/5QWkRhBdP78zjXknB7Pdxk965S6OF2Ukru
	cAzFFU19zOpAol/Eckqy4TM43ebwwFRIedo5Cu9a4ZOnNrsbvUkRnR/bzLMA+3TI3SGiaQxTbpl
	gXdP32byMbOZAZk5Q6clVF8f3t+VF0ckcP0rcWVwsvah+2AZOjj70tsIbQxwrhFmiAASLg8JFL3
	XuHH+UZMisWG4yPu/lHmHlHtI2Dg4x7djG2Bn/N62d03wGB+uuvln4N7UFgoqlwl584DZ9hgIUC
	aQIQAn9IvViDU4Ul4k8Fbm2JIv9YS6Zr/J1f7nYBZ4nLrqdTylORuOAPdkSv4tL0hw9XRH5raG6
	CvOdRlrDUGL6NB4iIspF0xpEyaw/lYPQKI/uzTWCq9PZcNuIqPcOKFcyXqN9kVIEV/r0cM1tj2L
	3E4h4f1t8E
X-Google-Smtp-Source: AGHT+IHU96KJ5RT0ChDCIL3VODlD8ihXA+VJhT2Z0AoleTk4BzohHaE49+6OtSxjtx1uMr99peIA8Q==
X-Received: by 2002:ad4:5d49:0:b0:7d4:e416:ac05 with SMTP id 6a1803df08f44-882384c41f4mr50244766d6.0.1762696959804;
        Sun, 09 Nov 2025 06:02:39 -0800 (PST)
Received: from [172.17.0.2] ([172.174.221.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88238ba462esm31505446d6.59.2025.11.09.06.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 06:02:39 -0800 (PST)
Message-ID: <69109eff.050a0220.674c7.5d44@mx.google.com>
Date: Sun, 09 Nov 2025 06:02:39 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3687544022742527635=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ] shared/bap: fix keeping PAC caps <-> metadata correspondence
In-Reply-To: <ca208acb9133b0bae7b2134313a05d68036e6ef9.1762691320.git.pav@iki.fi>
References: <ca208acb9133b0bae7b2134313a05d68036e6ef9.1762691320.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3687544022742527635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1021294

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.71 seconds
BluezMake                     PASS      2728.59 seconds
MakeCheck                     PASS      20.24 seconds
MakeDistcheck                 PASS      188.88 seconds
CheckValgrind                 PASS      240.71 seconds
CheckSmatch                   WARNING   312.80 seconds
bluezmakeextell               PASS      130.57 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      932.36 seconds

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
src/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structuressrc/shared/bap.c:317:25: warning: array of flexible structuressrc/shared/bap.c: note: in included file:./src/shared/ascs.h:88:25: warning: array of flexible structures
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============3687544022742527635==--
