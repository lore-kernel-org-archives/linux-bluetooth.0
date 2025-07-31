Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCDB644
	for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 18:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753985019; cv=none; b=h4hep4zVYG1gFwpEhJ+q/uiyPUSL2pD4ksq+IucD7rCDbRBUSMRDu3NlXxqboPe8zoRjE/ghGhClAW5gMohXwLd7NL/yN5kwBfwyKZMOiJzxATC+nnkQ0TIF6xTzwT1thqYkGdSoMySAgr/2cBgLe1eq9vv8QGhs1gn2rnyI9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753985019; c=relaxed/simple;
	bh=nrHbrcXBE466RGM5ZaRPfKxCow2byZjKkFucuh1RLlw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Nzt+rf0nR09d/UkT2pNV7Ez5U+205iypXpkUaSeC+405J3eoIXfKnSZwvJAtMinnNaKem7kND6Lo9SKZtj0eaVMy9VJNiw0QqQ94CpMhFmL8DNqjQxfpGauo9DxI3SxoysE8LjqImgS0kTjbIs+/AqiqlXU8dIdDDzs2kXJsiCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kt6WbJlj; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kt6WbJlj"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8811ab2b559so81961239f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Jul 2025 11:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753985016; x=1754589816; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8sgwB6lyRtE8iszhCjhRpmBkCURIfZ6yc3PR996JLOc=;
        b=kt6WbJljDHAXg2udGEEMvtOOZmhOsl7L63IblDUbv2gqTLhg5i8iflHsyq8sD3nmdN
         M7BzM2ifynwVEDt53RkjVP01FDSUIGwvJk3PfFwxIc7IWEr+98ekh7oQEXU3CQm7Rp00
         lhtuht0/+aM84MvXZRVRn0BaKbT2YrTHiGgm4YT6IxOWsH3jKrllWYYL1jZjIa4Slwlo
         ZpqDvJRijd51GJM3niDJfvfg/iS8ScMbErHXTxVdWqdzey0szH1tBZuPYBicyQSaABwo
         /61mkLi1ETMdUB5mieU7Lom9rSUumd2q3nyB2Y2feutsu/Eu3uVVng7rD4T5eIXgtNAx
         meww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753985016; x=1754589816;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8sgwB6lyRtE8iszhCjhRpmBkCURIfZ6yc3PR996JLOc=;
        b=fOWzK1XYObRUl0RK4Hs48fWj9tx8kfmofwNblOaV59Z/ruE48Y5hOg5Qzezc1XMHZb
         U1CILjWmHWaXRAnF8vkQk/27Ib6veDEh21GGNHGklZcjvHV0JfIfrgFOTpbRugKeA9rx
         GIXDm5dzz9CwxzEHSxEGS7Jq4pOaa3a42OHyaDAyAvGYPw7BUcSOQLOHn9ObJSiFPyZf
         tqKW7oEoIfhQb4J4VJC5EOQlyBwxOYJk//eeXbryO77IgA6xt7fb6757dQ+yA4/gbhIk
         HWcYP4hJOcYEc3y3WlnYI1AciY+pjPC3N/Ft06rsfZmYQQcekW7E69lm1gpDrLZSx//r
         SMVA==
X-Gm-Message-State: AOJu0Yy0NY8comDuSYPQJ900OWIltdot3Ly0CtZlLtlufJdbfpe+cG0D
	3FggJG6fj1GXtRfver8G6/zClQWzWcE0ZurfMFqgFjKZnYutoJ8MzHdSstdl/g==
X-Gm-Gg: ASbGncuctphMRpe4k7Dvo0NX0ddkJ1jy2/mJzxe95GJHWcFAYv0UycPdqTiJDnh5GL6
	Myam6wF1BFeDQapYfv9ErmEHDAQV5f25PwpbVJ2KNiBw30EvHkukz4IXsjmLcyRRyRu40kB3n7s
	q9MWyagPCkTGSmcI474ldgiluBJsYoQ/J8V+7Nh+QmFOfh87E0W+tWwTVBmjsy5wemv8IS1ffx4
	zkO8hU8SV9OHqJ4haz0u+NLdgitto1xkpqG1RUCW1rphSxoIECXr8w1rb5OjVVgAuXPam+Kq1Lu
	ZMT2wklrCtD7GO3gofO6C3OXcWncHcTkwGL1VhvAdtlEN/0XeTl2m+XbnIrNWljKA7R6jBPtGUe
	np/UmhE4OSOpzgt+6w/B44UydeOjkDiqG1MGZQNj3jsa/S7zOEmk=
X-Google-Smtp-Source: AGHT+IE+AxCH79HnjCYL7dOMSjNoVVgx7IsYU7S1fP1GxPDZjT5OtFhLQfT3FeZNFEgXLtY9+svjGg==
X-Received: by 2002:a05:6602:6423:b0:864:4890:51e4 with SMTP id ca18e2360f4ac-88138627c00mr1574592839f.14.1753985015675;
        Thu, 31 Jul 2025 11:03:35 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.141.184])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8814df86f92sm53626139f.22.2025.07.31.11.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 11:03:35 -0700 (PDT)
Message-ID: <688baff7.050a0220.eff5f.0ca2@mx.google.com>
Date: Thu, 31 Jul 2025 11:03:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4759387697446606443=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, arkadiusz.bokowy@gmail.com
Subject: RE: shared/asha: Do not start ASHA in case of CoC connection failure
In-Reply-To: <20250731162605.155115-1-arkadiusz.bokowy@gmail.com>
References: <20250731162605.155115-1-arkadiusz.bokowy@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4759387697446606443==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=987426

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.23 seconds
BuildEll                      PASS      20.40 seconds
BluezMake                     PASS      2654.49 seconds
MakeCheck                     PASS      20.23 seconds
MakeDistcheck                 PASS      183.82 seconds
CheckValgrind                 PASS      235.17 seconds
CheckSmatch                   PASS      304.54 seconds
bluezmakeextell               PASS      127.81 seconds
IncrementalBuild              PENDING   0.27 seconds
ScanBuild                     PASS      910.46 seconds

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


--===============4759387697446606443==--
