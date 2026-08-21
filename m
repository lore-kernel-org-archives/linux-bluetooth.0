Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFEA2857FA
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331725; cv=none; b=QI70BZcrXPyUfftYhnhfXyYHIOMUHomghH0SMLKm82Wz7KW4oYZzAq4v2bUG2CTg/kGFLjhub/yJqqmysfuhUjg4mMPOUDiUO90H1UiaWCiaxeyXVaDxwWc6eERJ020wSuirM7HGrw1+Sb/jxl4uFbdXxwocX2j+u+4TrRynP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331725; c=relaxed/simple;
	bh=r68VkrKZbIhScIN49NsOY5qVNlGJaWTqj7FquSabGHY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=GiodCtL3X++/o3m5bTMNVU6mJ+TsyyCrg1VRPzHBzcCKW6/rVP1un1bqpGjgvUTq+PDJqrGVfymGMWfhKfA2d58eyx+k9CzZlH74iz67+JiEbWBoWXSEwTR1UggnG0w0HsjoIEZg4Ns2Nx61sO09S4el28XevUYXM2+RSN8UOH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/Uj59cL; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/Uj59cL"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7eb63dbd229so1038921a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 10:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787331722; x=1787936522; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r68VkrKZbIhScIN49NsOY5qVNlGJaWTqj7FquSabGHY=;
        b=W/Uj59cLqwB1pgVF6ZH0gFtJvOgLB8YTtvehRsSsDPF5LwGmakxY0QUEhYoOkz8tYl
         00vQ0eq280hgc7eFmPFlKAr7Go+ev005jMU3XMpsGfKPsKy1M1z1/rhu8iGVNHfz0KTF
         k0Y81rnB58L0q3ihJ3k162IS5VVpE3F6f6mBiy+j+dJwm9LO1CkT38V1S80dXpLdJ1SE
         4MmG2nq1yfgrdtQyR9t85f8Tov4oIUVOJlchT8lHCWdWkz73SWZYGHS3qWoirbbNs5C3
         vMhOy1xXjxUMB8oHXwgTD8Y92VWGPbqogolbj0FkianiLE+DbOl1e6pblxQmyyohRPh5
         brkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787331722; x=1787936522;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r68VkrKZbIhScIN49NsOY5qVNlGJaWTqj7FquSabGHY=;
        b=RvUvnISTogXjJz6/NEEC+6rQapmCLirGwQ32o31+uvHEdv6rWLCycPtbB3ldDWV/cl
         ZQeIfz/GxQJsXe10Ej5hmmXwWF6xNex2k3nljgdRQb7yRQYDoo3D0DCXW3XYSF3awxfi
         EUXeuVMhUH8dCvzKG2i5snZxYGTF2WQ30x7Sf2mXlcb9DwTkv2eLhuu0DYoxbXuAdmx7
         CfDo5OCUvjUx3jCzB1BQYiXn5rjp8BTMNXYNK5zwEqtEbA69akjBMIYbBy+dsEGSaei8
         bjwO26vX0uALqa1zzb7AHceFO9cuuuansLukWxXk/kE6ieLl8GExBPHFtXSS15+bh7SW
         l/fA==
X-Gm-Message-State: AOJu0YxPCOw6AJCF8SipVXjFX92PrIv7DxGfHdTrQkTIk3SLQ13Pai41
	A42g5vRtoMgHJcX8srZYXvlwjMkrgKTy4PNTUu6ozJzT0wBwosE8+qHyg9myGCV0
X-Gm-Gg: AR+sD12jtBeZy2SMjjVwURfOSrGxOUlc/wV6pTFQnNcNfyhBZBL+MsyHhasXz5S6yLS
	iAZFEwkF/VvLU/e36u7JvhF18hIXnJfdWw8BhxItdYyZezfkpKPTpEjMK79xGn0ehPg8yYzMsK7
	MdgVjIn8qGlxzXKNqOPxp8smgke7ngsz4va5ar5Fm92x3Ps+JryFo6m06BrXx9kaM7WWyBinT6X
	zC3vMVE7Hd6o6k1tXi/taWJh2ftTtQ4gVd3zkyE94U/3vz1ds/otakxgOZyh1gOSt5S7dEKZCUl
	T5sYmSbgzBcGE9JLolVD9M4OxWkhXwd3StAYCIeYVAMjgqMY9z+BDqCJb1HLB3TjF7UiacCw00Z
	WJGcPf0jX2wKnhChcFwyICFh/oxHJI5ohw99BFdlzO5V6VVjbwXZwzJPKr4QU1yUV2pHtsMyr4x
	a7FO6Z/d1fCbFviV1J2YU2/kvs6C/MqJ1SsET8XSYD2nVQs4+ahUpiUj9ZFs2QoElfP/U=
X-Received: by 2002:a05:6830:1155:b0:7e9:e78b:65da with SMTP id 46e09a7af769-7f44c07981bmr12180814a34.11.1787331722396;
        Fri, 21 Aug 2026 10:02:02 -0700 (PDT)
Received: from [172.17.0.2] ([64.236.134.21])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f43fc6c89dsm8071639a34.0.2026.08.21.10.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 10:02:01 -0700 (PDT)
Message-ID: <6a888489.d0742bf5.3d28f.5d38@mx.google.com>
Date: Fri, 21 Aug 2026 10:02:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1903543730379599421=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nicoyip.dev@gmail.com
Subject: RE: [v3] Bluetooth: hci_sync: wait for directed advertising completion
In-Reply-To: <20260821164512.2842464-1-nicoyip.dev@gmail.com>
References: <20260821164512.2842464-1-nicoyip.dev@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1903543730379599421==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: net/bluetooth/hci_event.c:5721
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============1903543730379599421==--
