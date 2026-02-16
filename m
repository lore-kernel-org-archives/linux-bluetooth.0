Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287F72D978A
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 17:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771262167; cv=none; b=GMOowWdwbFGJyHBkpuNBY+6nll8m2Qy8lakCMiG93878M9tvrId7afU1nx6FEdnXpFg8bIr5Qj5yZ+BYtQPLjh+priJE8xERrenzvkMcxrMGIfEd3Psaq8BAmUNoybk2ALaBDhT3gHSkFxQzJxZglkXcrLMzTgUgDDY0UrlZUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771262167; c=relaxed/simple;
	bh=nsXkIT74rFDoGIL44ySMfTYgbL8jabFZZK33quNs6Ro=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=EeGALrwJxlo3lQ9fymnJGuYKU9RjVNH7oMHvHSRsHThgfnpQHi5Ucbm9Ya07dHiUqr2i0aYP/wVycEM9lSFMbvQWalL3CcHJ+DhXDh6SdQ0nUPQQPj2nA34DYeB3mmdlsctZh3uv8vphH7ulpZXBxT9azOrrrxjkBLqLvnjHgFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNP5VhcP; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNP5VhcP"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-2ba68df3687so5914396eec.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Feb 2026 09:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771262164; x=1771866964; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F3GO5cRlEqOqytyhadWXNPZzRJuGYU8Wgh+C2dRuJS8=;
        b=RNP5VhcPagcrFKnupgxqFlqCnEVGSHAN0iHFjeB4YvmnNjFO6m0a9UjS1pp+IFn3iM
         j4GZph1o5cl3MjDjTZBKYzF+scdYWahnE0URd4a/J5ByVfn3X9DF3me1OWiRuKE66Tjd
         ZTWuAQPCdpn0c5XJBuwQ1aGGPVmYNwPHsOxzgOvJqouU3IoVwpEJxn3meVE3yldZxjOt
         3DmGSFJcBPLRVaEh4debFFYjA5lyOvjqYDLS+k4HLwRWPGeAgkcx46BR6dlX4n9XYNrN
         41Xa+HX2wWwlF9AMZCMtzge3SjuA+vip3XLnZghsPGNTfzcEwuEF7yDwdRZs7F2mwRPA
         IsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771262164; x=1771866964;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3GO5cRlEqOqytyhadWXNPZzRJuGYU8Wgh+C2dRuJS8=;
        b=wV0fD2dGr5++zE/JZW3LKr2mqcNtxnm+3MgPw5iHn4p15YLZ9YfwJZ2na0ZOSj307q
         sspUwHamZLRMwvS1jt2ilXwh76UcFS3rztY+BTJw9WF1GZFGuiyVgYdR3yGXPJ6i6Xeo
         FDxsN0w1LIKcCARRk4dR4Ecw6iQcBBRlkKziKr9HfceQUUC7cPt/12VrpN7l14CIwDaj
         WAegf+cnkBhcMNqlVtcTXGGe0dMa7uuUp5iqjgVOyWias1xzqUofu85Dn+me7hnF0o76
         RciOBdnwM6cva1G9UfJxMVVxBsP1Mv7YE8pggDMq0ONJQjDhqktIa0b11zqwAaVRgaAb
         71zA==
X-Gm-Message-State: AOJu0Yz8u8RRxgL3u3Uj/+lbPM8oAV1ym8McZXyfcOMH8/rc/MwB00Y7
	vj6SUO9JWCirNADBMdFPSpi5RWyznKb2KFNwlbFlkPKXcH/tfK3yhIyf0+R8wAzr
X-Gm-Gg: AZuq6aIjyIJlZ/MP2Jpk57U6zc5nCw9gTIDkf3F+7a2qlZlzelzSJYnEEwDA+lVpkvt
	fQAtRP6kwon8wLZgdNtxbjzdNLFK8ecvwbhkKSyNzLEyCa+B1zLVF6P+LSh0lUXDGqZg3t++pVV
	c2I9T0mguamOxLdcnYyhVK80eS/16JqitZpvem2rh7JBU9R+u8IVnIleCDU3g9h0Hye2j6kcgGa
	NO0vko8Lcvlomf2A/7gh3LXcjrkLlTAJ7jYE2KMoc47gcR+Y+s0ip1j5Bx15hONwnYLxTnHnFOg
	HjUikdfDyw7Ta6Muv9A4068H9fKTzy/Vns590g6fsQLJ0fAo6KN39vhITGVwpADJiV+x+qTpnYS
	Q4Hjb4HSYSebLUXu462mcw7pp6Sdq4dVVTuKI5dDa8tdTx9dUOeB//8iSQ8jDRWqZ7Ih2zYTQB+
	BTfhCVkmxtsihGhxpRsZyEqn+3JEJ+HZooWYa0Djk=
X-Received: by 2002:a05:7301:608:b0:2b8:261a:fbdf with SMTP id 5a478bee46e88-2bac97da825mr4536330eec.39.1771262163596;
        Mon, 16 Feb 2026 09:16:03 -0800 (PST)
Received: from [172.17.0.2] ([52.190.183.85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb5575b3sm10081561eec.9.2026.02.16.09.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:16:03 -0800 (PST)
Message-ID: <699350d3.050a0220.3dc4cc.8527@mx.google.com>
Date: Mon, 16 Feb 2026 09:16:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0872676656881246096=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,v2] a2dp: connect source profile after sink
In-Reply-To: <ba0e71b91a24557f088b015a349c6ccee6260ec2.1771258477.git.pav@iki.fi>
References: <ba0e71b91a24557f088b015a349c6ccee6260ec2.1771258477.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0872676656881246096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1054617

---Test result---

Test Summary:
CheckPatch                    PENDING   0.52 seconds
GitLint                       PENDING   0.43 seconds
BuildEll                      PASS      21.07 seconds
BluezMake                     PASS      659.15 seconds
MakeCheck                     PASS      18.73 seconds
MakeDistcheck                 PASS      248.08 seconds
CheckValgrind                 PASS      299.93 seconds
CheckSmatch                   PASS      363.60 seconds
bluezmakeextell               PASS      185.67 seconds
IncrementalBuild              PENDING   0.35 seconds
ScanBuild                     PASS      1048.60 seconds

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


--===============0872676656881246096==--
