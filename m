Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6D3AEB39
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740190; cv=none; b=ptN/AnF1divehy0EfRwARpas6roTHMRRLdBB4CXzI7WXohNNjiNjtiXFHpSlbQfk+V5Rwm355oWs2bD2tSOwMV0PjpxGKPdlyXP3uDUvb1G1UmisezBk01Yp9HV4g3EEeEVe2A5Z1TA8C07OSqYj4qB+WbIqCnvs5aQAb5aPx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740190; c=relaxed/simple;
	bh=AzXIS8vwCKzuCzXCNzxGISSSialQnH47UPBPNzVue88=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=BWOBczvLZ5YXXbBQDhdzoOadP4gfl5W9jjnb3WavcWXGUCPCx9C3F8vbt5wYT31kJORsoKgxBnjGCmst770wDiQZTph4Xfzo5GrPXXP/XS+5X1CVT4ZrEeZtC9pzm9oEKgUavGfrliLLhTjMj1VI0uM44eI4d2XeQh+QLpSy7c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h/XLeL+v; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/XLeL+v"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d45ae011aso5911327b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 07:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789740188; x=1790344988; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=01amu/6I7ztE2sTzGC1Ad2l29FKsmbXiZ6uQRauUB/c=;
        b=h/XLeL+vHLEGynauKho3i3k5vFw0Hl5qCdMVC0Txs9v2VnTczRGq2cZxAuKCoM0Wvi
         1Hoh6CQ6VJvHzHAw9OphfBpu5/r19n5lSUIaFDQ4QsHnrv9bJkkENzOzXuWf3V/dPYGe
         u1i4U0nsvBEwOyycxleN0JaJys1Xx0NWK/t8y+4zrv6/U3l+gqVwLDmvrbsbhM2n2Jdt
         rpec75eOTNdmwrYqx1B4l7kn+sw+0hT77jNp72zLLemjq+XFFnW4BaQXM25bIIO7bRSV
         oSl4hasz5w7Zq8OlE527ZDj4efijZE581dVGzHhm1wiGyDtTD12yt3xz7F/o2o6SeFma
         DTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740188; x=1790344988;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=01amu/6I7ztE2sTzGC1Ad2l29FKsmbXiZ6uQRauUB/c=;
        b=iLDt4VijZguegLzU+7IADkm52o6IaaVjfirz0TPZTdxswsd7I4JPEr7kQqC/5aJRS2
         CrbNa8ioL7BpCEyf01l3Aoa6WQG2iL50TuMBeS3DplA4gdtXW3TjOey6XyjP4vdJar0x
         +FN4nOQyYPWRS2ArxiO+A2cuL69ZO5FWfF0n94Cr6X5mWrX9ml3y1favNxg4UErz16dO
         JE21HdId8WumI4AWpN4ezG7g61F9oZsSfq/RQPsnXh3IF91fLk9DT3ayk3dU5hO+vU3C
         s79y/lSoZ8MscDz2QcDC/Vt+xSc//NR1eZB2yAi+NbGdgegAyq2LoPgZDa/xY5z+7FrJ
         AD+A==
X-Gm-Message-State: AFuF++kaGelYiS4RSbVb5EH7gB3Ha+R/lMJSic+HWfzEJpN5bphq6bXt
	P/MaloFB3mnnYapx/GEBeEgLPqWKOyt4PWp+KpXCDhrreWDf+qk6JCFdCQgFmA==
X-Gm-Gg: AYBFou1B9PdPXRxD0mxteMN18GzLaJlckf+st33YunAH79o4pUPaQ8GXNrlhsV0ki0a
	lG9tQh1bN6s76FKDCb3Mf9iZyh4tDFnLj/5W79qPwd536b55FOGRJ8on4BVXlH+g/sXbfAzM4At
	gMWxEVfQl+zeFKseMkT+PBwXXhOU7MWaiIkd3peNuHFwMwpt0yT0uwngjeB8mRpQjy+NVzul7nn
	Wk6c2vQNpdJhD8WRux9B3zO8o94ZGQZa6CgJS0pNNiZ2qo17nRS4VSBxCAIQnOPl2Lhh3M7kbLe
	7brEsVk5eFblxfmA4K7l9J3+zkYgn573+EME6iAePj/8ZoBXghhPpam2/BLCzo2YzOkCejEa2A6
	/ObDBjeOGbtFBnyib5/8H1+xKm0LbWJHhw8Tr9AGdMkjA4tMGagVB2w5IAUmpC8UeosEOpwiDWa
	BPSBEAGbANVtZNoFmzkuNKiks+hLjZ4g2cr/qdWdY9h0TLjS9Gneg8+et1z0a1kc8FPCcCatMl9
	glS7w==
X-Received: by 2002:a05:690c:e682:10b0:873:5bb2:6c3d with SMTP id 00721157ae682-8973701efe1mr6482907b3.68.1789740188183;
        Fri, 18 Sep 2026 07:03:08 -0700 (PDT)
Received: from [172.17.0.2] ([20.127.247.38])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91258056585sm13139336d6.32.2026.09.18.07.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:03:07 -0700 (PDT)
Message-ID: <6aad449b.d2b8f92c.1fbfea.b9bc@mx.google.com>
Date: Fri, 18 Sep 2026 07:03:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0595230926559491727=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, nithibert@gmail.com
Subject: RE: [BlueZ,v2] adapter/advertising: fix mgmt endian bug
In-Reply-To: <20260903091059.161705-1-nithibert@gmail.com>
References: <20260903091059.161705-1-nithibert@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0595230926559491727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2] adapter/advertising: fix mgmt endian bug
   Pull Request: https://github.com/bluez/bluez/pull/2478
   Created:      2026-09-03 11:13:00+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============0595230926559491727==--
