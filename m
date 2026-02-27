Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F8329361
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772206748; cv=none; b=RmF0Q9P54H3+t0SVzLa0bW+oTv1dpGknWVt6veON34B/3SGkW047o/IF32wrtnZS50hnXaf14PotIsV4JfFq4ntXAXWvdZqxYfIiPenixVRSnJWRXvh0SthyFlNR1PrF2BepY5dONCiADOLvSF1z8Q5ScsZFNuJHgA9TBdvrSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772206748; c=relaxed/simple;
	bh=KhvPKpRYtApRWnBZsvlVUwEwcwPE02vQ8I/Wx1CuNHQ=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=m8ufKuLmdjqIa1ILA0yXFBNSfqzrd3Rtzbo7vFAbUn54InG1cf0iVfDdnIIKODnMtPFaV7ayKaQdiR5GCFVSgYqGJdk+9XQQUfbFRZYTdiV4mUNVPKdJdNH5NG+nadBZmRBO3FrGmhMfeDBkFUAorfNIzq4j8AfRx5+8rU3isKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7GOlctB; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7GOlctB"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2b4520f6b32so2696695eec.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 07:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772206746; x=1772811546; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Te30XgteYNbARorS4CW3mK+N0BfsVDXKLlx/NNzRl1U=;
        b=k7GOlctBxCPnflpmZ25aTUUKmRFuKM10ZbvhFMF31JuaNJbMpVRtLLi+ERGFw2MqI3
         2eAoNaXd04kEu6IvY2wMnhPfa+LRA9ZSke4sox3B/eB2Lh9EgYFcBRIbT8hR7FoN4GMe
         SbI2WndX1gsA+3mhyKoQ0kMBB0LRSmtEI69S8Zr0YNCXg2cuFpicLzxZcFhWgaNwPgkO
         ALhOfBDgeuFWcWF9q6sNvqc5WSol1iQWAd4DO+aHUmo63ArCF4DJZrW1KNKu4kLBSAwH
         7RSAOdMpB6XukLmdBuPlBRRi+BQgFjQ43SGmutN9pN2YLOn1hbzUzZVbl7pKZaCqzx8i
         IMMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772206746; x=1772811546;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Te30XgteYNbARorS4CW3mK+N0BfsVDXKLlx/NNzRl1U=;
        b=PI8zH+eElGzEyNR0p1hrsr8Gne/AXBf0ImWeifBeqAT+S2yoTkvAlyVlvJYTsMzEHF
         XsIipqqYlvPESaZAwXFmHXM8VzmfDv5vt7uPO2Kcp0nu+lVYqxqkBGpsOeMx3pm4lCvG
         kL2yyX8P3dPr8CnVE+TsKLqNzBgz9qa01HZubxdqh4Q/dC/dGF8/V1qB7y6HMPPg+Aaz
         Nrgx9jHHy6MysoCYEu9w7uOIFHtUTfr2DEsosKt+8WQQ+l+fEvH+o2vOYfyCnRH34mlA
         ISfvSBZJEbN+Q/IMhTNcz/72hLGOJCGIToYPaEuEsEKlxUOYlMBfvD1vVY7kEPQDqWIj
         HaJw==
X-Gm-Message-State: AOJu0YzGAB0tcZ7KhK/ubEwy9RgiAf4vaMd6gGReqBG/WXBwFYJaWJVk
	q3HTtbrM6PwSVv+3mm45g84ZVnK8H4csgmkI4dAqNwzUDPCc1dwoa6JXL9pd9A==
X-Gm-Gg: ATEYQzwkkjtzlU6lEmb9Sd5eQ4KnDWkEgqK8lYqisLY5oZnp1mruZe5kgC5NEupYV91
	uddp0ZAcwbsb9bLiGPOqtAUy9xjCn4KPmi1hYSa5fwcfZYr29sbMG46xyWzsLQ7HS1XXtksffE2
	UnX1S71Iq8KqSvXn3kqmwqt+uWuGUFoOpFlDe+5xDkQ2HPQ9PF0BmSSGc3T0gRF4YqPnmtp4YLz
	8UGfuOT0bBeiXUuTn39TDXImys74kzWhRGUqXXD/Ku5aQIqWKmZxgapANj7CgtTSZbfiouIUphY
	WIF2EGXpNFsAslotgYZEN+crSMBPX4B81/RMt7rhAwo5OA32jncrRlXnkC/qYbGhngkBES9h7N/
	3znzG7jPpd9pY8XhuG5hQalcDiq2j9acoqVhMytoPwSoL3NdX1+VUDV0smhCceycWs33wzwfHLe
	mc1uFzBuBxZBSLVheh7l14GLKfpa7t7kGzirNfISYOSA==
X-Received: by 2002:a05:7300:538e:b0:2ba:a2fb:403f with SMTP id 5a478bee46e88-2bde1d31d40mr1488893eec.21.1772206745924;
        Fri, 27 Feb 2026 07:39:05 -0800 (PST)
Received: from [172.17.0.2] ([172.182.195.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1bce276sm4018093eec.3.2026.02.27.07.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:39:05 -0800 (PST)
Message-ID: <69a1ba99.050a0220.5d9da.0b74@mx.google.com>
Date: Fri, 27 Feb 2026 07:39:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2815858879406432003=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ceggers@arri.de
Subject: RE: client: align 'io-cap' and 'pair' cmds with the docs
In-Reply-To: <20260227143242.5204-2-ceggers@arri.de>
References: <20260227143242.5204-2-ceggers@arri.de>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2815858879406432003==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1059044

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.42 seconds
BuildEll                      PASS      20.99 seconds
BluezMake                     PASS      651.68 seconds
MakeCheck                     PASS      18.49 seconds
MakeDistcheck                 PASS      251.61 seconds
CheckValgrind                 PASS      298.14 seconds
CheckSmatch                   PASS      362.41 seconds
bluezmakeextell               PASS      183.70 seconds
IncrementalBuild              PENDING   0.37 seconds
ScanBuild                     PASS      1035.01 seconds

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


--===============2815858879406432003==--
