Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9D0366071
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773697790; cv=none; b=lFlyChOjKi8m+NvbBuHKsnlodW527fMtb/NJZU5bF28xxIv0wsHRdYGvXtLdbIe32S6ORtgneTF/SUgRXtIQZuhEi4whPe2ONUOr2+LRWyRmolQm+8eq5HNl7Nyf9nVofVwofP3Y3vXZCOUuTGV3vDs9vXMu2HPo7p/3mtd9MsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773697790; c=relaxed/simple;
	bh=ElsCIPQDIOY7BRShgiAvD+Z9zwMtuOkrhOp7SYuAFik=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=ib1uPd+mw2O1FV3alVXgd9uuFELPX+EybVeSC4F3H/K2MWV0NWJb3TqUdO9Ci0lZPoaVyGyZB08Kv614HlfVG8GHwzpvGAxLrCczjwF8cUTMrdi/qrv2QQjQBEiEQwvkebVlavRq0F3rZbsooTTKMSDrXwzwSVhVUq/a+itEChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnhAEl5b; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnhAEl5b"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd767d2d70so511450685a.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Mar 2026 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773697788; x=1774302588; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5o1MPA7RavOpbUrEczplKukqLrclisa9m2w9lqNfHBQ=;
        b=nnhAEl5b3oK3ZLMdWwO6V298vdVZDmlZmV1ZDkuPx4aXOUZdZR6Le4D2aqXGHlEe7S
         3ZCVeGY8gTyQGUXNiyixtAqoMa8WGJuGzMghaLORsuOM92npL8dArYtuYEkyZH4KTMNS
         20wZCanuLo7B8CH+e0DyY94fVX9drZ3aQU0hgzpGDhbYjEszzu4Uph4oA/7i7S0X7g+2
         7nkn24bBoWxHauPL4lXZk04FounppeAMvUNbCcqgyrLPjD8YezxMrO4WostPytEK4nbT
         XHzU41lp990o4miv7oui7axISCuK9FRAhe0SZifs3CVhVz+68zMUHTPj9YnjR19pyYl0
         T0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773697788; x=1774302588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5o1MPA7RavOpbUrEczplKukqLrclisa9m2w9lqNfHBQ=;
        b=ddnAVtOKFW3jeyNfaZGT/WgBYLBH8YVauX1ruPAn21JlhYKmkxFNbEatG1IG456oRG
         3p91et+TXurI8aqD3mgv5TKLMm5rj7M9SIKsCEtnf5u9kKvsAz0qyYQNzIu1Jeo7hEdR
         ca+zAeLwPfqk/G4pulsfavT1hF4fdsb7fKOAUn+jejf8Buh+s+9or0bNhQIoZRlH4Iou
         gUKcRXnR74TiOn1TNBOpsAQ/igVUCX4WTF3EOl0jAdfzN+fa17Wr6gnEcNx57mw1hmVs
         KwlMgiXKylvajqSTlTat+MqgsUsj9GLNJ2PA4offSKAltDx0VM4Sqds2jXg3OloWH5Z4
         8hnw==
X-Gm-Message-State: AOJu0YwzvNCIHCutLgjmX7q6I3n7qGi6I0gHh3T03+MHpOi6ELWTBht1
	E3kKFU8UEhG2n32mil6/kQzfy5z6zr+rCgybhfaxWyC4hwM2nhJeVbTLq2hPkQ==
X-Gm-Gg: ATEYQzzR5R79phyjYjJEjuhk6DwwWzhaQ7F8/rgnkTGQWiNo+yhPmZUBWLhDBA35n+b
	gnE25mZ4708D6YxQgvJBITJYKDa8oDDmvzmsuxDZSGJhiACRvSh9D83g0lGRKwwCjF+I5f5y/A7
	tgPZ61U1EwYNqyp5xQMdAzInxIuOeo3NGXmAh6kEn+anTennHgl5PKT88oo4btTfhCBX7IGgdx+
	FMIXEBnDekdiSRw4NA6j0tCerbKyPLpX4jRtEh0IwbRZCcXIEdbK3q7HOqRX9mMRVav3OkQVGUr
	e9cMEPBJAFmCV5W/CFu1sWUIQq7iPg6OhkC79AMbzfRgOrxxzfxOvRUiXZ5F4yEnA76zniLZt5f
	oYyIGYNFdEh+BXkavpFRzYfrS6OAJY6PYDO84kZ/ugof7Nn5tTRkRn/ZU/iN04RhmdN/R+qirmG
	djMiBufbI2xhj4SblpHL8C9ksjm/Ynjg==
X-Received: by 2002:a05:620a:44c7:b0:8cb:4d18:bb6b with SMTP id af79cd13be357-8cdb5bd0ff0mr1937137285a.73.1773697787856;
        Mon, 16 Mar 2026 14:49:47 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.200.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c4169dc56sm54836826d6.18.2026.03.16.14.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:49:47 -0700 (PDT)
Message-ID: <69b87afb.050a0220.184b6.fee5@mx.google.com>
Date: Mon, 16 Mar 2026 14:49:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4767367003151471014=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v1] shared/ad: Fix not checking length on ad_replace_name
In-Reply-To: <20260316204320.57220-1-luiz.dentz@gmail.com>
References: <20260316204320.57220-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4767367003151471014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1067554

---Test result---

Test Summary:
CheckPatch                    PENDING   0.31 seconds
GitLint                       PENDING   0.40 seconds
BuildEll                      PASS      21.13 seconds
BluezMake                     PASS      649.12 seconds
MakeCheck                     PASS      19.28 seconds
MakeDistcheck                 PASS      246.81 seconds
CheckValgrind                 PASS      292.70 seconds
CheckSmatch                   PASS      355.11 seconds
bluezmakeextell               PASS      182.65 seconds
IncrementalBuild              PENDING   0.38 seconds
ScanBuild                     PASS      1018.38 seconds

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



https://github.com/bluez/bluez/pull/1966/checks

---
Regards,
Linux Bluetooth


--===============4767367003151471014==--
