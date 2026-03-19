Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70A137EFF4
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 12:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773923833; cv=none; b=hAu8Wc2ABgwis7eBcrqzdnZnyfooabToRumDNbWpPS9uunsUEZat3MHqBpQXTC3Nmzw0kg6Sz3XA0nrX/elU0PrTzTklsWV1tUNtlcM3yLXCcvVPXB7D2h0Wwpd9w87CgRMRIOnfatI4Y2mPm/ggUEqh0WX/EdJQUuuWP00eVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773923833; c=relaxed/simple;
	bh=i5NlhfFpyFn/aTOEOlcAovx5rI5WBPcNrn655yz3CwQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=nYHvDD2R7FHkJi5yYNkTweV/DMZjeT+kQ9u1MPDLVcN40YafutCm5CqWE8hosM4LJ5j4BFkLxNjBSOOcm8MWLX7IxCIRTNbAaDnLDX69clFw+GjyJilPuARNmDoVc4jzlP3B+fso00ODBBu6rN879pQ2RWI9YGeaCypPjomJeFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awcGSv9i; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awcGSv9i"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so973291eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773923831; x=1774528631; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fvA0LFeknFKZO6jEIBsE8lOrN4za6vu3NIiwEBWWsIE=;
        b=awcGSv9i5vJ/RNDTfSI7Dfik0axB3pkguSmj+mnrIz5IjMzV4WdWcoOdGST9ZX5lHF
         b/hc/vvT3Yug12K+IDQo1TT70cmErdI/6nwM9P64+O7guewcMbZAo3gLmtlvwHJJGMQJ
         Y/MFEi5Blq+JF3x/F07tqUX6hJxwH4ORfouF6eYBmhBYApxWQd934rLgdlq9vGmc3smJ
         MPepBmFQTHsrWZ9gYnx8LqRRQovdacBxNz+ZVGQ3dxbcmpSIG/yz9NLhVQW/DaRC4b00
         cAix1JlsMfeG5pwmn+HDs/2JG9391q6HoejmLbcPlkPkQQy0xFeJxuK0ifInexOuLSlE
         0M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773923831; x=1774528631;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvA0LFeknFKZO6jEIBsE8lOrN4za6vu3NIiwEBWWsIE=;
        b=kfCA38D2pOTTOzwgDv6908XarXmiFHll456f0ePWCJCJylr9qZvreIwRHz7lIV2lKg
         XqK2TD0fMUnLEuDkSgEYOQiabN28nFuRVRQbOL0JNEg73AYzNmlt8xCbQAWOpLUF5R9n
         g6OjK23F4GIC2MIMR73TMS6fYAHZspn2p+a4Z4qD+bnfzRyuemCjjsH3B2Ed7ac5bseh
         oIcrT0uMZN1cJAmXVFh4n38Ru55VZ5ZedAW2mrnXKl9qYJ1Mn3o/V3QWCPllu84ZHhgL
         ikpR+nMN5tklMFGFaCwdgYKurY3/Pyqkh985CHrTVUUwtMj/2Uo4YanIx8kxaSqbxs0h
         2FCA==
X-Gm-Message-State: AOJu0YxrDfbyO9Mkja4V3O4Ou74VHOSjp+rg38s+o3CR1n4Y+/hTBfZz
	8YXJBZzpeztA9bXpKAZDhidpG4iplHsvJFVptoHxz1wP8nLJL+4gRBIK9g6E/w==
X-Gm-Gg: ATEYQzyiwW1l+LQxfITb9YlJk1n/vcmR72mFNRv+OEjznsxhnY9RX6JbCSurKXbiIWf
	edneRZtEhEdXpD1WmST+dkHmgH8QnaiZS71WOzJ+7i47oHnuMMHpepwfaPskBt/VmOI2+LVRgcD
	fOHmZSS8Y3FVYMi825uc1okWLLXu4gR/DIo2YxnxR+fyGwDjQTFr8OwfFXX+NmzMketm8fyXY8D
	IFobVmKTteLokotmlRjPWSzX55SUy32Ld2isC1eMwn9cPyhcBPBAAIlABlKbCIy7X0NnrRzBmTw
	rHL1O4QfTOsXNEXYjX/lTuA0kUrpwNssLr/gcCCY3Fo/0FqM8so0J31jpWx+YrL9Cb8Vr2kVgsx
	InHRbnSFFE7HDiXJ+LGD5TMnO/a4hQd/+8i+Gsi5frNZdFHuTswj23bsXG4POAnompnap2UqMD2
	3DrDPjqAOsXc7zZtEpO4MOKMjxyGrT
X-Received: by 2002:a05:7300:3205:b0:2c0:bfe3:b95c with SMTP id 5a478bee46e88-2c0e4f99706mr3142432eec.4.1773923830607;
        Thu, 19 Mar 2026 05:37:10 -0700 (PDT)
Received: from [172.17.0.2] ([68.220.59.226])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0fb178b82sm2271392eec.6.2026.03.19.05.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 05:37:09 -0700 (PDT)
Message-ID: <69bbedf5.050a0220.1588fd.7e49@mx.google.com>
Date: Thu, 19 Mar 2026 05:37:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3672002278115209697=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: adapter: Fix "Failed to set default system config" startup warning
In-Reply-To: <20260319105457.1381098-2-hadess@hadess.net>
References: <20260319105457.1381098-2-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3672002278115209697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069215

---Test result---

Test Summary:
CheckPatch                    PENDING   0.65 seconds
GitLint                       PENDING   0.60 seconds
BuildEll                      PASS      21.09 seconds
BluezMake                     PASS      656.26 seconds
MakeCheck                     PASS      18.46 seconds
MakeDistcheck                 PASS      247.29 seconds
CheckValgrind                 PASS      291.74 seconds
CheckSmatch                   PASS      359.31 seconds
bluezmakeextell               PASS      181.70 seconds
IncrementalBuild              PENDING   0.49 seconds
ScanBuild                     PASS      1045.96 seconds

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



https://github.com/bluez/bluez/pull/1972/checks

---
Regards,
Linux Bluetooth


--===============3672002278115209697==--
