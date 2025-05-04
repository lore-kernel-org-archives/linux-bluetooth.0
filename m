Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C81FDA82
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746380369; cv=none; b=k3lcFG1dwWefE31AxNtjdtg/ZPBUtJnv893gsvoRCgEvhByacaEuduZfS2951yJZGtb4dbwHM9OejQsZrKaHgd0abTsosQUMi3P1YDXvUSNCJwad7D37oSrgNBaP5EHnAGtULQ0R+ubQ+rSp5N7bAjlvtGuoRkSUt4yHcQghxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746380369; c=relaxed/simple;
	bh=V8lhN69nrEb/lWlqK8CniAqjuhYjNe75IKU8chcaE7w=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=UEWa9HODm/MYKGlZNscAUMkZdLS0GQI/uOBB0Gz1ulYU7thkV8CrIqwhloTAoGZyYCOjtXApGp0xjrXKE1J9Jkl8mIMbdlcGyud2R7bLOPbF0a/2ZfOTF4DzkPOYjECXs6zbDfFz0KM2jACh5G+RzNMYnqBAfYPtI6K2tJCKpnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijnPyBWD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijnPyBWD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22c3407a87aso55640555ad.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 04 May 2025 10:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746380367; x=1746985167; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pAoAtDsAx8cUjGIpAYXDLhn3iYgtMSPo7dyg6sgNaFk=;
        b=ijnPyBWDzYF8/se1w6RIi3NKYziMvBE7QE0FFZmmbkKFkS9mNlQfd2CMBxSOH58/oq
         HG0cFNrzyfTwPfyhId8YAmWFeZH5LhycgsnBLpbF2aghAvPUz1ZUPGrSklAb2UqQZguS
         xwaY1D8FpFTeHc6csbq8l1K4iU3+GbhvDQT9E6CeRLR8mRc38DKJIu/mponVXrebGd4I
         jSdt7RDZdDYWao1jVYsR0HM3xIOo/5eF7EHgbMH/kMyH/qfrJhH+tjrlh+ic7w56Y4iP
         qqZ+4qSS9fxeRytmib5ygw8nXvRo+Ib1KL9SVMVA06Rrw7SgXAOeaUlPsagv58vv6RKc
         Rx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746380367; x=1746985167;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pAoAtDsAx8cUjGIpAYXDLhn3iYgtMSPo7dyg6sgNaFk=;
        b=EpH5vVdbLOegSefgNXQSaG/wDwq8evBjjYL3TTjoxspPVYAzcV3E0EkXYxUvXy7LFv
         VUwcPz6Lm3Ly/KmvQzmoR0AkJV/XP3snSINY+azJhgCBxP3+W7LjYOBUEIInuJUElJHC
         EIOl6qK1UDBcbY5rcwZDuBO/k0Xb9V1sC6o1dIrpB5RJaadR+nC8RVlLX/euLQRuH3HG
         ErJpJWLHU0AOXXJ6EGoL5oUCiBQ72v8iD6ER29q28zY/0+GLMeEUk/6OSn/guDP2Q3rF
         xGhn518W9l5NRvO5z78EzFsjF9KSh1Rw4b5PHMX3PDDmuCARdujznl/ljp9oGYkmXpEY
         Ws/A==
X-Gm-Message-State: AOJu0Yy3g5FcDlCkJjQpxI40bMXlSG+AWyZ62sSLpYGG219fS22xKfsF
	meaJfpAlvu4tvB0z8vR1n+VKELG5Otqqns1A2VdCI+Pe/yEEpLaVVmBIBw==
X-Gm-Gg: ASbGncv4HwSnIrmpR0aUczDACAvfFOnsUH5CqxO9mMoi7hxNdr6+i5CCuRVQC4cs2B7
	t6WK85JoQyzQdw79J4jYYWyEoD5qYtpQWP/aUaDLCgRJ19yVkwpdxmSXl9VUcCG2oKDeBVirAxh
	1SHZXv/JvYg16k9HPZOAKfEDYbn13DdGqvqp0/c5NhTr/YoAcAb2unRfgpYvvkGvH3+R4k7O+hz
	sy05fQIIy8r5dGO03r6Ld6ZPTKxbA18sU48LSULY5G3tpEBRIiZWUInoiv3ElJxbGZlF0n/DXIu
	8WSnI6X4Ys4mW3S6vKb2ABbsb8J5y5KqvDxMYL+EQTK321tQRyPlDZHQXw==
X-Google-Smtp-Source: AGHT+IEhRmjU9LViUJazYhrs9HzmfTFREwjhSZYDgjzn7ZvSybQYhMotDT54u6oEEnXxDuuaZFFL3Q==
X-Received: by 2002:a17:903:298b:b0:224:1219:934b with SMTP id d9443c01a7336-22e1eb08721mr76614795ad.50.1746380366984;
        Sun, 04 May 2025 10:39:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.169.15.153])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fb28sm40045745ad.147.2025.05.04.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 May 2025 10:39:26 -0700 (PDT)
Message-ID: <6817a64e.170a0220.209771.09e2@mx.google.com>
Date: Sun, 04 May 2025 10:39:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4298649613400760594=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: [BlueZ,01/11] org.bluez.MediaEndpoint: removing BAP streams with ClearConfiguration
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374483.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374483.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4298649613400760594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=959451

---Test result---

Test Summary:
CheckPatch                    PENDING   0.25 seconds
GitLint                       PENDING   0.29 seconds
BuildEll                      PASS      20.50 seconds
BluezMake                     PASS      2746.48 seconds
MakeCheck                     PASS      20.43 seconds
MakeDistcheck                 PASS      201.44 seconds
CheckValgrind                 PASS      280.04 seconds
CheckSmatch                   PASS      307.29 seconds
bluezmakeextell               PASS      130.10 seconds
IncrementalBuild              PENDING   0.23 seconds
ScanBuild                     PASS      928.49 seconds

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


--===============4298649613400760594==--
