Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DEF25783C
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384604; cv=none; b=OJOMV5dRv/+viqaYkb4Mr1NMB9mJPfMjXL1k6q+6R8z8FGmXywBLpxhikbDTGqfKTIiGHxp1Hhwjwle9cqjq/WqALGK1jBpWTjIn6hM4G8SUjGXoxwKQ8U+9WFMgmrx6I5pz8I35o3Qmh7FILEyXqbeaFnXDMkSYlxLrQq4VRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384604; c=relaxed/simple;
	bh=UnXHZD6U+uu8W3YbZ56izj5cujTSK2u4sCzogIYFM4U=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=YHluZa4yQOpmG0g1OOSJRfksPIWwbijDX3v8Rv5XOQqXSmfiDK9RL5zH/QSTNBaSv7+ixUKzg3//WoOMJQ+XKAVx1Lfwz6MQuRsPRFPgckEChv7NZ16+1+c4/GHg9P80ohKU/dqBp4z0h3ZWD8cZfEaT9/VE0h4LXFn+DtGl868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/AkYEDg; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/AkYEDg"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-855733c47baso884339885a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 12:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760384602; x=1760989402; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mRx1NS2VCaY+x3aS3qbOULw7sZbCdxoSkaa9SBMfypQ=;
        b=I/AkYEDg+Hr9UM4FKZh8fiLaKis7OdKRedk9Kv8uzpxoX37LUpq/44d9ZAKADl/bG8
         kSf+XJVUyoxwN4815SOxKTdHbwYJczfskTkgwkQNRTKN12LakW5JVDdtsMtexXzrBm5s
         7qmYasCtYqqCG8G2AP1yxLT/BpSM43BJGPNJ/dGqAdUrWdY8IBV/ASz2sscZX4FSxFmo
         bDJUZbT14v6KnAh5UnDrGX5f3Lztr6h0wr/p1tK0vHjfdCz2kF+dGBHd6hgDIyd4SzVj
         dOKE3zwCf0vyHbdRk5ONc7P4bMHrLBO/1YjIxCOfq5Qvn6+s9m/VVmN8pkDUsixZ83s/
         dsKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760384602; x=1760989402;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRx1NS2VCaY+x3aS3qbOULw7sZbCdxoSkaa9SBMfypQ=;
        b=vhpcARJdDGyhBTCJU9VWPiez9hg6JYSzdVKEC6UrXWV4qIglw41rHqTZYrk7MVmiDw
         AKBNlf68H4AksbYND8rusCse241LRuDk8aRKWgo9km0G3Y4lIqupoDGNQpMhYc8tMMHW
         q7pGmhv/VeZQGmiCP7CozJduX9wh0+np2/ht8o99ecBx9QzuDY6khwH92042sjmPGiyP
         VDaYYrH0tY8a8C/QQJVEW3ytbhKZOhg/v40PEC8IeEJqCUpjll6U4VXoAXjBpB/37k+e
         8pcXnghtM493bvXi8/mLNW0DPbnEX+K1+/G63wgwkIKSxCk/YMB0TJ4ZHnHdNIOfxTaH
         a8aw==
X-Gm-Message-State: AOJu0YyjIxdd13E9O6G04bGfgPRlcqAWenvre8O8L/Ug7W9cxtddDSZ/
	pl5J4sEOT/FkWrvwOOonmZUwY6zbmvnQXaooUawhf3AOZ/Ssot3/3vqvf7a9ig==
X-Gm-Gg: ASbGnct0RhPB9e/FZNCziflTkou0jAXeyDHQkmjT5CCkLEZZ1uVqFlDlMcs195pDixX
	iBTcPPr+tbIrF7tdJkuJiJlY+pYTrBTFl7XRaxDovgUPqOh4/J8jYKfQR8MCcvRwUfUO7YZ3Gyp
	LAjnCSi3eQ1zpUr8LIETR6JBhoTFEoxF8Dr8KhnrqKJa6+Qb3txDhc612Qyb6MtLIQzw4xj00mw
	40AYJTNv7pfBPFx04G6oPhGYhuMekY4cwcbVPZKxIiSTO4slcvmAdWDKdkV5Axy/9MOXK/goFog
	rTNXdLB4j1/oy3bAqvzxN4LQUnB75jg7QHdIolLi1PUExqBYxQ57RTYxob7w9pTfNfvyOXQ5Xd6
	0OHHkHLz5bZ2TvlDQD7wKxw3YOuijImF0tSKpPNHl0Y5ycxchFBaHEDak
X-Google-Smtp-Source: AGHT+IF9lbkq/KsDwS7Jd/URoKie8OwaoolgmH2o7+NzrpXw/FjyWKODsCGeSA/+QB268DMqIQy1HQ==
X-Received: by 2002:a05:620a:690e:b0:85f:40ef:4aa8 with SMTP id af79cd13be357-883525c1336mr3008112585a.49.1760384601620;
        Mon, 13 Oct 2025 12:43:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.81.183.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-884a22746dcsm1039986085a.54.2025.10.13.12.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:43:21 -0700 (PDT)
Message-ID: <68ed5659.050a0220.3cdbe9.9fea@mx.google.com>
Date: Mon, 13 Oct 2025 12:43:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7535851195647350844=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2,1/2] tools: add 6lowpan-tester
In-Reply-To: <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
References: <ced3d6d6e7591bbce715a683a3902cc564c6d3fc.1760378120.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7535851195647350844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1010888

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.26 seconds
BuildEll                      PASS      20.02 seconds
BluezMake                     PASS      2778.86 seconds
MakeCheck                     PASS      19.95 seconds
MakeDistcheck                 PASS      185.48 seconds
CheckValgrind                 PASS      237.90 seconds
CheckSmatch                   PASS      309.57 seconds
bluezmakeextell               PASS      128.87 seconds
IncrementalBuild              PENDING   0.20 seconds
ScanBuild                     PASS      918.40 seconds

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


--===============7535851195647350844==--
