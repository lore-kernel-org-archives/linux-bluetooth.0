Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544FD2C237E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781766888; cv=none; b=ptGLcPTqshdAmExJS5hVOjdJIzt04b0IsWeC4eZZQQ4eYp+c+/htEUb/DYn1/2fZZqGLC2CxbauaeK1lpKquLymt4TyVTbQPQDwEY2gqp27P7SJLck9pGX86h5ATfmEcaw0KAogB2SDFiIst7ZEvvGfvdCVhWDUKHr28Ah23DRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781766888; c=relaxed/simple;
	bh=5alJoidOl4EQCloxDJATmRTaS51AIVD9HSkfx3ljNjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EzWt+yXnIVik7/wsC9UDMaQIRAtPOZAJxvRKrpKO1SEjgzdsE8mwxGMRoVkBFNaA/Ov2Ytj6GZukI7bwACJXOymwixOI9hCA6re6egl39RikolwSYpvLAy98WfnKhycFYrY2uh/ovz59w4nJVRq+6GY3/wmCb8N1j7gT85QTSMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uo86h4pP; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uo86h4pP"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so7370316d6.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781766886; x=1782371686; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S+tlccAkF/ZILXwnErTZvF/O73mUx19GSpglbDaXZog=;
        b=Uo86h4pPZMPbbcy9J0EwWo2KZzhx5wW5j2IXYCEuCw9DeOh25u77BMpSbpqrL9k9jB
         lxI2Wq8jtH4TeZZpOvLDSV3gv6uq7+AUUsOXs+EClAiNyrUsCG5Hz1FOl1sm9q5Q6BzG
         KuAodjhG1lgOEImfnCY40SEqUQNRxD+d6+IJ7a31v1SLR+bLheIPHLaZAMA7LEczuq1M
         05sTD/g4FtAhmVOdWr7LRWpYggM2/uoh+EeDg/PWSW3zCYcL3HhU60PMjgYsPN78bw9/
         U/p5amwEIJUgevwl2ZHEaZdY7opaWirSJXtXloa8J+YIqlYgnczSo7Ql/6PtC0tw5mBX
         rVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781766886; x=1782371686;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+tlccAkF/ZILXwnErTZvF/O73mUx19GSpglbDaXZog=;
        b=i4OOwrixVMSp7WGX5B33kTSbSSFrVpFBM9OIHUPYVC3kOHS/vmcckqY6LyKWgFjB3Q
         g0uGWuTkHWbMjU4edV22DHb/5hbf4vMX7PF7l1A2++8F/KFNYxxLqnbfTIPIXpYy5C/Z
         aE7FlXk0eaog07lcI1PZ7VxnH8usxP9QsRWEvzyu3kUSSdi5jUBo1VV+cNWvQACFaqTw
         /xcPYmaaKVbWG6nf1kbz9ISuyiKo7KfHmgUdH+DXjX1PL9VXy4snkywG1NmGZk9Qtl21
         baxj1Glnw+BK2ZYdDLg2ZnTdrlzG/JdDyx2pqVof1mEt7oSwXDzTF1NMs9wqw3vJ7plc
         h6Tw==
X-Gm-Message-State: AOJu0YzCgx+q4Ddn2dTYa5lmPR9xMtXU2deS0Nbr6oEkHqpxO/4c9/31
	P2zcwDkZ7SSGpsfNPibmnQmKGHGy/hlAGZl4f0wspAKf/vjgDqXBHVzWrhD3hA==
X-Gm-Gg: AfdE7cnhSwWuFEsOYhhQPb2AqeDlvUoiilJg6phurO+aB8U+K/ar/adG/Gte6xX+O2D
	nVldRQMDj1P+u4ZtoAX3nllHIPLEYCOLKVU2ZWJvlK5DBY91dNZOXQ6XZaKIPFa6b9YcBfTtHPo
	iUxNbKqi/i6dTIn0P05S/vEExkW8E1rEVhNIRE2AOl0Km2rw5/EcPl1eI+ITeN+53TUShqk5zif
	blZCIKOU8pbQmLo8XUbnbgAAli1IxcIBRlHtCbsrRRYN0NJbjtweXUCfcpjmQJEwq6dv+6o1oea
	FEXtqnbl4AzUebDdPVRpv7CJQH7rV5X0AXynJpTPZcnsXuE7OOyWXK41L4D6bGJmPCpA9anDsPy
	WOhIgs1FdLjWg2GA1uplkV7u8NAJKQ5c++SUNy1bcROKkikIsO/JDqNY8NMw07DiYFmKHeDGtY3
	qps6We8pPbsffl0G6uYPg=
X-Received: by 2002:a05:6214:40d:b0:8dd:492a:5ab0 with SMTP id 6a1803df08f44-8dd492a5b58mr18179976d6.14.1781766886175;
        Thu, 18 Jun 2026 00:14:46 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.117.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8dd26760029sm12854366d6.11.2026.06.18.00.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:14:45 -0700 (PDT)
Message-ID: <6a339ae5.44ff7526.25d00c.0956@mx.google.com>
Date: Thu, 18 Jun 2026 00:14:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5705407358752549900=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [BlueZ] set: Abandon the use of the existing set gatt-db
In-Reply-To: <20260618025239.420860-1-zhangchen200426@163.com>
References: <20260618025239.420860-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5705407358752549900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1113188

---Test result---

Test Summary:
CheckPatch                    FAIL      0.43 seconds
GitLint                       PASS      0.33 seconds
BuildEll                      PASS      20.57 seconds
BluezMake                     PASS      667.03 seconds
CheckSmatch                   PASS      355.38 seconds
bluezmakeextell               PASS      184.89 seconds
IncrementalBuild              PASS      654.82 seconds
ScanBuild                     PASS      1045.56 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] set: Abandon the use of the existing set gatt-db
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#65: 
When pairing and connecting a pair of earbuds, if you attempt to connect the

/github/workspace/src/patch/14634422.patch total: 0 errors, 1 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14634422.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2238

---
Regards,
Linux Bluetooth


--===============5705407358752549900==--
