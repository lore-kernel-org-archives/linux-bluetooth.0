Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050432;
	b=rSmqDtmKS0TFvcwc5eWYgyamoWI3wXrEVQDFvt85GWR+2vbeEmjkrW7E6K38mJvlyIZX
	 Qv5eVmCGHaVCRZaxuIrC1/j1es9ATtEdxQUdQ0HrXypdIn6BZESXB+70ws0OpR6uG2CR4
	 OUuqhBUnvuH46SWzKiI8zPwo/1JAnULWA46qQgqfOjDGw5OxdOjHQJVRwUWPXt7iE6W4s
	 nLL4WBTIjwcM9DE8yA29MjxBxXxvenFsQG5NbqalIM9LJ+ddo+FFxGVpSlfYWcxQHHdEW
	 aPJcMccSeUYN952fmNyUZ4HBZgssrTrN+N4l5z3XM0ckDwAdpjdzslOwdyzTDOTpktg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=NBOACq9Sy9w2BuaBLEW49gDja9V42HsNdf/IKAMkKIY=;
	b=W1yW8V+fIoIEo/UA8JiFflAvb24x4HVlzhVjkT6oSZdkZ3v//k44y4oFXMVi5qv6ojgL
	 2su2fVeoMi0W9U6LPrLPY7rbizKldCebWrE56jR1p0GeHtka2z+OnD31k0oLEBUjrBJtQ
	 m7Zxh5iuEJxFCUAFTrmKToqPkEYTOvzOShVjgBeTb5y4izfEKEANFevFepqgX5iRDj1sm
	 OHUUzhE7IY0ddRa6wGC56C85LVVSJ9BHdvTcrB7jgT741B2yQZ3iXiKltEXzH1ot9g8r/
	 D4AUeRJgBWd28S/XQaSR3cUzQAk4XGeKZk8UQ7gMCyAP71fq87xhWsOmJTQzl/DHSGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyF5JZUl;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC7F606A32A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 01:07:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EC7F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fyF5JZUl
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-537548b811aso13173021cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795050431; x=1795655231; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NBOACq9Sy9w2BuaBLEW49gDja9V42HsNdf/IKAMkKIY=;
        b=fyF5JZUlD24UFD1fSLOAtjgsWKE4AmoWl5XAPj9EjorY/5BkNHKeS4p+ZVq2btbBm4
         t3b6FbmiC9gZhyRA8NOtApNE/eWI2hS51uc9oFGO20bsxmMfg3MPgNF26nDXxj/S9D+W
         KC18AwaB1XMdpilyyHqzOPAdhmIkdegjt8OnVdfdnIfh4y9TVo8gZMarRTSxFw+OWHCT
         gARHBWgu19B/yTQOtzlGD7zyj1nUGWayiUH9H/B4svNIFl/Ofd2YsgQh5ufk7nOa8O3l
         oXttUMNqlEWKyi1aZFroifWpKaZ2MERuu5JGOqbvCb0DUDDjO/iUTtJoe5ZASP4h4Xsm
         tqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795050431; x=1795655231;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NBOACq9Sy9w2BuaBLEW49gDja9V42HsNdf/IKAMkKIY=;
        b=oISjxhiiDVTe7HRgKLoXLTz+qdDsiwljG4ULyss5M/fz2K/aIbqXhxeG6yqsoRNFv3
         2k2sjor7mF6OevmkZ6yrBu8zSkYr+Uv0YsD1MuM+64CHK8LcJqMxuW8I6EcvW1GeOGp+
         hp0z1XOCMiB/afKJQDF61N3ScdkVgf8o4Xiu4ZFiAAjSyAUbUZRTUmaZdyrOEdXRetJx
         mSuDmBO2bOPpnkr5+bB2PZ0U6++cSMi7BhLdvx28AiIvadu9nwQDoKeh17Bhcul4pGVS
         55hbmsSjL3FOETKd5tJnjyxTxC5WEhkt+YdmC/uT2PgfNLsFur8/xR4qw7SuiQFkPe+p
         d84w==
X-Gm-Message-State: APuU4Z8q8+Hiev7wTbPsZM8z8qVrQQXQGXFuLE9uyIihltE610F3wUSr
	qXrJWSirm4I0/9lUkx8BrGVAGljFmkoDre0GCQMzIEuXwSW8rxl0H4+1fdMfBw==
X-Gm-Gg: AYBFou2f9MigbJOvLS+tgJV/ldlOsDwTz/F3gn6YWOCAFMkzo/ZM5TUbPSJwH4RreWA
	XWm5dqJXIO6RUHThxy6yHeF79ExU+7zgJsjFUiPPG7Fsccfjlk0qrnJ44hoRWg9DDm/JgenKJ0w
	3TuJw5+DrZcYzk3XW5XTm3IMPobmyTkdkYHMKTM8+zT2iph2T/C9fBAtsyi9Di5l8gISsOz356M
	pZwtvNOt+BAFh4dXCgJBNsv/m3fa01cjNiniNIwiNZGFLgcXeJ6bITpapVHLchxjXDwYJb0oUOp
	+jT7juucA2wFPpEkKFLIU6wCxlsnJxVHXFI8c0EhpaQALUfEGXEpMM6RQiX6n0tpiPPeYYrbDbY
	bc7lEkWkMhg1YfnEFgtHg991Uoy4VqTAv1JdbJSQcHGxFCuKjuFQ/ah7+T88EyYelWePIA1BT4o
	Zm6NbfsU0ncGrJ2Tp9woh8PtZq34+5XuxlMk4mx/yfF5pqO+DB+3F4jooZAF2B6W2nxhIGXsQSR
	k3z/8Uqx+bqGXh6pcyQ6ZH9SDzCfI7uL2Qiiy6URv78zl2OJsWl53cqol5WSVVo
X-Received: by 2002:a05:622a:13cb:b0:55c:abad:a72c with SMTP id d75a77b69052e-55d5a692289mr66523721cf.56.1795050430899;
        Wed, 18 Nov 2026 17:07:10 -0800 (PST)
Received: from [172.17.0.2] ([48.217.251.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d679f237dsm10429221cf.23.2026.11.18.17.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 17:07:10 -0800 (PST)
Message-ID: <6afe4bbe.5da39d67.21e96f.ecd1@mx.google.com>
Date: Wed, 18 Nov 2026 17:07:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0109675946481164662=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, mohammed.saad.alquraini@gmail.com
Subject: RE: Bluetooth: L2CAP: check security before completing a deferred BR/EDR accept
In-Reply-To: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
References: <20261118213322.60067-1-mohammed.saad.alquraini@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0109675946481164662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1215445/

---Test result---

Test Summary:
CheckPatch                    FAIL      1.26 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.69 seconds
CheckAllWarning               PASS      35.07 seconds
CheckSparse                   PASS      37.80 seconds
BuildKernel32                 PASS      31.01 seconds
CheckKernelLLVM               FAIL      27.00 seconds
TestRunnerSetup               PASS      746.24 seconds
TestRunner_l2cap-tester       PASS      15.07 seconds
TestRunner_iso-tester         PASS      13.16 seconds
TestRunner_bnep-tester        PASS      3.20 seconds
TestRunner_mgmt-tester        PASS      89.06 seconds
TestRunner_rfcomm-tester      PASS      4.51 seconds
TestRunner_sco-tester         PASS      5.66 seconds
TestRunner_ioctl-tester       PASS      4.72 seconds
TestRunner_mesh-tester        PASS      5.57 seconds
TestRunner_smp-tester         PASS      4.37 seconds
TestRunner_userchan-tester    PASS      3.24 seconds
TestRunner_6lowpan-tester     PASS      4.47 seconds
IncrementalBuild              PASS      28.98 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: check security before completing a deferred BR/EDR accept
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#122: 
The child channel is placed on the parent's accept queue at CONN_REQ time and

total: 0 errors, 1 warnings, 0 checks, 36 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluetooth-next/bluetooth-next/src/patch/14998992.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - FAIL
Desc: Build kernel with LLVM + context analysis
Output:

net/bluetooth/l2cap_sock.c:1277:14: error: acquiring mutex 'sk->chan->conn->lock' that is already held [-Werror,-Wthread-safety-analysis]
 1277 |         have_conn = l2cap_chan_lock_conn(chan);
      |                     ^
net/bluetooth/l2cap_sock.c:1277:14: note: mutex acquired here
net/bluetooth/l2cap_sock.c:1302:5: error: mutex 'sk->chan->conn->lock' is not held on every path through here [-Werror,-Wthread-safety-analysis]
 1302 |                                 l2cap_chan_unlock_conn(chan, have_conn);
      |                                 ^
./include/net/bluetooth/l2cap.h:1025:2: note: expanded from macro 'l2cap_chan_unlock_conn'
 1025 |         ({                                                              \
      |         ^
net/bluetooth/l2cap_sock.c:1277:14: note: mutex acquired here
 1277 |         have_conn = l2cap_chan_lock_conn(chan);
      |                     ^
2 errors generated.
make[4]: *** [scripts/Makefile.build:290: net/bluetooth/l2cap_sock.o] Error 1
make[4]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:572: net/bluetooth] Error 2
make[2]: *** [scripts/Makefile.build:572: net] Error 2
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/home/runner/work/bluetooth-next/bluetooth-next/src/src/Makefile:2243: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2


https://github.com/bluez/bluetooth-next/pull/1153

---
Regards,
Linux Bluetooth


--===============0109675946481164662==--
