Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA70189F5A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968917; cv=none; b=Pon2MtjpkNJmqAfQoo1e2/ro6f6cQpYuJnALHfW97OfmjkIy4bQx049Rknwcjd4vcrDJB5GI22RNx3a95d73H1X0vFFMEmrj9+oY3TW5LSwayfsHvJOQAj6e1GIV0SuLEXg6HEaIG71pSCya71b23kZeGtT/rkmTJRnmel2dX50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968917; c=relaxed/simple;
	bh=XTqS0AGaUIZZ7OABh5XjmoJJ4KT+DoKVW8pvGIObXVE=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=aDgIHF5bd4kvAlEzO9LDL0YDdkXT0rD2jNewmtmaPYj+7z0+TSnNFE08pY3FK9wsWs1umQRH4+A8kUG8EERvNr0E2vepS9bstB36oYai2cjGxzCQEPBRcw9q1CIL1DNH5feKDIcpgP2PAvUseFWTMVMisqM5oxDY+ZRTQLHS8LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFihBUdB; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFihBUdB"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7a7fef9a5fdso117359185a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 15:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724968915; x=1725573715; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O77ZDQrrEf4SMnAz0+FAUV51QYmB8bnPyvcW9PCbEIQ=;
        b=bFihBUdBd24IKMhtVluyk+jjOMdw0Rnmu01zu8SWVCXC7pVyU5En8N9K+/NyEfOj0C
         7DQ1+11H3ZtZo7CqnXveVBPCd8Isgw7b4U745eoxP1KZtumZrwyKBs3XP138Z0Qo7m4u
         wucOEF5BpUBKiUP/Xeb7J8jPL8+Dohyrqf8m1G1PUfQ8DMt6nWF0QuKbxHg9wS0YduIm
         Rn/I6lSsrCuzitEytQCOt4F90JrPbnOZL1DjKhNQQVAnr368fwWQ00f6wtSI67MMwoB7
         DfikggMvuLrglYXX9rTH9n//aakl3vlUumk1ZQYUqXUjwpcY7lRJvfSLLoGwuJ15PZ6P
         vCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724968915; x=1725573715;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O77ZDQrrEf4SMnAz0+FAUV51QYmB8bnPyvcW9PCbEIQ=;
        b=az1qQeqjch8DCKZVKruWlsdAqpnu4Tnwcra4fA1CyCjcgt205QTiHM5e7N1XQp88pQ
         /LRkdCheXLfeTE42/A3XYYo4lIg5kQozMwlbSrwBdinWwiTBI25fJk5uDPiSliprr/b0
         qD1zadCOwdG4OkZWvzpgRKubsMmgPIgLtE4RhqDCnlECu4dIYSZfxE9KtgM1nupIxhx9
         4GFNnNAmgppQPkG/hLyWS29UXoCNiGnuAqRIJxEYqYLk6ldJyLzN5wa4vfXfq1I8urI0
         HbSSXq7Lx5XfYyLSCHAE+uBHV/UtpqASoSjofoOj/fypYeJqiT/4FQXhQ5RM8GZKhISi
         dRhQ==
X-Gm-Message-State: AOJu0YwxAnsZZsXF6Nru5Ik/tjjFqIDUC8uYDwPzIOOMg63rc3II+Jm2
	3d0CCQ3o+/2xN32mQUN81rg2l1hjnsTLH4Ot2xIHuUQA/T79ABQ3KDfFAg==
X-Google-Smtp-Source: AGHT+IFMVuBm7sxBxj0upvwfejf80U+K2bQres7yxs6eo+k29dz8FQFm0hF8kMH5+lwO8+zwhqNhRA==
X-Received: by 2002:a05:620a:2993:b0:79f:1352:8318 with SMTP id af79cd13be357-7a811ed13e3mr57271885a.4.1724968914504;
        Thu, 29 Aug 2024 15:01:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.98.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d881ecsm87716185a.132.2024.08.29.15.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 15:01:54 -0700 (PDT)
Message-ID: <66d0efd2.050a0220.90407.38c8@mx.google.com>
Date: Thu, 29 Aug 2024 15:01:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0423103465029481208=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] device: Fix Pair method not setting auto_connect
In-Reply-To: <20240829201803.1103129-1-luiz.dentz@gmail.com>
References: <20240829201803.1103129-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0423103465029481208==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=884907

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      24.67 seconds
BluezMake                     PASS      1648.16 seconds
MakeCheck                     PASS      13.38 seconds
MakeDistcheck                 PASS      178.87 seconds
CheckValgrind                 PASS      276.23 seconds
CheckSmatch                   PASS      357.27 seconds
bluezmakeextell               PASS      119.89 seconds
IncrementalBuild              PASS      1419.79 seconds
ScanBuild                     PASS      1009.37 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ,v1] device: Fix Pair method not setting auto_connect
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '507ba12483c3', maybe rebased or not pulled?
#91: 
Due to commit 507ba12483c3 ("profile: Remove probe_on_discover")

/github/workspace/src/src/13783802.patch total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13783802.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0423103465029481208==--
