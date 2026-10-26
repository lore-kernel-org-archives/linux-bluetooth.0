Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026444;
	b=WGInGhuI0zLHltJh7KgEp2UHQ9Ru8DNavpVy1xGn0DYT5O5mNopbKOeTHyys+07gHKmu
	 1IHAf1wJboSltpeni3oKzPx5POlRgoRsPPC39sRj28xYbuLVp62yX7wxOli8BiYJo0c6q
	 UwahxPM7NEeqzlZo0su1d2cZ4m2hXU3hw28eUtxcB6HmVuovTMYVEptF6IXjtAI6IG+il
	 vLG+zUOp1E0HmcrTQQ+uLPACwGdzyWe73We6sejiw6jn7L4sp+x4PtVCHF6LpQPh6RlUo
	 P3jcvrHKWbE4LooTTD2ZdR5SS9uTXa/dM/8qs0Fg4awvhhkp9wd6bubx6g6cFUtGvqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=UQge1J0XoCYRd4krfP9XPgANQHSC4vF6Q1wRG04cUFA=;
	b=tLlfxNJm2ciZNterJxLpWmmofsLdw2D9jviwc+JooGR3ZsWNRXZ5iS8fBU6KTKxZLXbO
	 6Q07sO6r1LjmlvqG20xLRyrovNn9DO4+NApK8vU0e8u9ZWeV4ctBXby5adVm0E4u2C51Y
	 9GEIQe6cO7k++CbKnN1GQyYTXQU15xgUP4t1F6zUan8xogvya8Z3y6G4MBjdX5rgoOq4Q
	 86dsMl4tckEUmExIJ3/5CcRa4ZAq26bK8oswmSbUxlWyTxH65b9iZ/GJU3ezpeiXuo3W/
	 tlN/0dA7slaAHumzGFikGiFH+QOMQdbcN/IYYWiXGRvSg3OFlAeJFF+OxcynTUsyPDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2VVEcTt;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EE2606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 14:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8EE2606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y2VVEcTt
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso5110631eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Oct 2026 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026443; x=1793631243; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UQge1J0XoCYRd4krfP9XPgANQHSC4vF6Q1wRG04cUFA=;
        b=Y2VVEcTtXAgHtyE5Iyq/0CFY9DBGgGmhzqkCGwdKecSVw9LehqP/tiRYnWwO6fffFb
         PKA52Rvgoc7SJBeEE+HSZrAGbr8+C4hiTFQ6mZLcgFdWyc8BBube2WYqEv+pqlD4hUUd
         jLrpmW//OFKo540XcELi98rXNlalQnQGA1KjUc04PCFQ1fVQydHRuwgiOwDv/phUXKjv
         1ytdE9eHgq6XDH3uFfi5j+0aMW570aw3p2G0zVm3pl1lTMWZzWHgThY3Ht5h1a/FT0iV
         PxU+6CaWAqTtNR5MOrqB5yB+499s5Hi2ps9sBXW249rRwRMyf9+c38Su6jA2r9IuXCMb
         xCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026443; x=1793631243;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UQge1J0XoCYRd4krfP9XPgANQHSC4vF6Q1wRG04cUFA=;
        b=q27GOeseB5EBPTw9FzxRwKzDz5tA6W1FxUZF2CiZfkjDZkRazRrAr0c3EXxTZRQGPB
         N0AsMR3eOy/FjrpBfoEszFCsAn/mlquENbzqQt69YsMFwcHHG0CaWP1lmeeExdJPExlP
         pU9tQRB1CpXGDnRxjmlFaGZ0IcrpftVbib5zvn4/1XHfIU1XMgGGVy8+ajsX2+RDr80J
         3bPoeNZBp68e8aagDeCYnER4ZGPSSRz6bDhkchDB72yiXbv1dbp48OotzXYkFwcuHdF4
         qHXDFVIgy4kPMvs0C0uBVGdX4wM5c07QaSOjt+bmnmY20ues4lrfDYHvi4isPnmXsW2F
         nK6Q==
X-Gm-Message-State: AFq9FYKTynKS6Dmahe6squwf0ltuWigDnwn36xjMPQ3dPMBZ9ulp3oIh
	XjBYyfhSbD+gcMrVO2LmVnxGKIT9/whNovD7odHMWcBKLK4trgegHypZ1CjOIw==
X-Gm-Gg: AYBFou2cTdPldpUzI+ONHAL9kLpqJa9+DInqVT82kcKvQHwMggaP4Tx2UcSFkhDmVeG
	mNkLIufXZTNWRbPAvtyiHM/y8NuKa3iacWV1Vh+wotqkwKwzLiswcmK5KEdjz+JtYv6RRoz1YUH
	cYOe98pIqfT7V0NrwD+U4IbkWSFRqunWsEsubh33iwfkqGSuk2CHw/BCYZFah5akonJYxjgIJAt
	JoknA43nUktQosdiW+PVlpOYtongSlJTCUam4UmB1VYZM95z9o/iYv3AGqT8AaDtqYBn5D4rwya
	KE33j3/4A7F/a743g1R/ALrT7oV0ZzzFtgIeVn6F4OqyyslHWvF7rQcTsX7P1wpM12x0HTVdpU+
	aCkjFGuq7YN0SdgEFHHC7ydysC3gtcr+S9T44nXW9IuSVLEjJubClGKGH98kwkej4puUL5xxyXx
	1FTEvxSxvwexFEeonxDb36zaF2OlGapYQafz5I2ceDEkh/nmXyLU0WL2s1CefPrzPK93WGCt2VP
	CkZj3NnFs7KNv/3WymDB2Dm2ZJBg2tS9fIl0qaF2iaMn52VOgU77kOrPIfuqsWILg==
X-Received: by 2002:a05:7301:10c3:b0:35f:2858:aa4b with SMTP id 5a478bee46e88-369e8660376mr14814229eec.30.1793026442743;
        Mon, 26 Oct 2026 07:54:02 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.153.209])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a005c0188sm12386229eec.9.2026.10.26.07.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:54:02 -0700 (PDT)
Message-ID: <6adf698a.afff5b00.30686e.af38@mx.google.com>
Date: Mon, 26 Oct 2026 07:54:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6925455559448755821=="
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
To: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com
Subject: RE: obexd/pbap: Report NewMissedCalls for mch
In-Reply-To: <20261026131504.1016687-2-jinwang.li@oss.qualcomm.com>
References: <20261026131504.1016687-2-jinwang.li@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6925455559448755821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1193772/

---Test result---

Test Summary:
CheckPatch                    FAIL      0.84 seconds
GitLint                       PASS      0.54 seconds
BuildEll                      PASS      17.25 seconds
BluezMake                     PASS      253.49 seconds
CheckSmatch                   PASS      230.96 seconds
bluezmakeextell               PASS      84.24 seconds
TestFunctional                PASS      998.84 seconds
IncrementalBuild              PASS      255.19 seconds
ScanBuild                     PASS      880.29 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1,1/2] obexd/pbap: Fix NewMissedCalls parameter size
WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#166: FILE: obexd/plugins/irmc.c:93:
+				uint8_t missed, gboolean lastpart, void *user_data)

WARNING:LONG_LINE: line length of 83 exceeds 80 columns
#197: FILE: obexd/plugins/pbap.c:197:
+				uint8_t missed, gboolean lastpart, void *user_data)

/home/runner/work/bluez/bluez/src/patch/14915493.patch total: 0 errors, 2 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/home/runner/work/bluez/bluez/src/patch/14915493.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




https://github.com/bluez/bluez/pull/2713

---
Regards,
Linux Bluetooth


--===============6925455559448755821==--
