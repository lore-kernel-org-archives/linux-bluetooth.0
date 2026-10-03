Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47E34398EB
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Oct 2026 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039209; cv=none; b=NdEwB3qQVLKrkxsw6ZAe8pDIsu26RJjd/G9zg4kxp6sXtqtPMMDtRjedOWwzhoJJefDrjZc4GoFaQsvY1lkVrkw3re1HsZYpY8GuHHAzi/u70dDIy98Z1VbwxWTFh6z20UL6kkCiUhKxOcwS4MagzMQAFdXi4zRn80223CP4zYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039209; c=relaxed/simple;
	bh=rFJKqhS8mHohw0KSj3SlitaR2aQ0zecXqZFiaAgJbPc=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=QRKyaCM902QDmEtl+lyzKfjzGAmJXVKgle2IH7/EjiK+cQLlykqeI+Mm2EPiAR75w6CZ/55eTSwGUZE+VoSYR+t/mFj1+cExzrYt/+i747SEb/H7T3J7V/qPmOh7QN3Zp3Z92czh4D6zJnV2I5omHwNC8PwUNTZAsqFedoeeL94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpKWecqM; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpKWecqM"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-34b1743e9c7so328538eec.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 03 Oct 2026 07:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791039207; x=1791644007; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JIZZr30mT1dzloaWRTkPL8Up2UxyiGM7JHEN4N+quNw=;
        b=rpKWecqMJ42HUJFsKiepfVUwx9OZQs/Xt6J0z27g+R+fAo82DW0oVDWlZ1iUeArWCm
         SQtzWxtp990KL3aTp0eKJyl/g+UvthmjAp8nuReNLNnDkGeiWmS8YfhsSg3o715dD+ZS
         ASaU1c3clpocK4dg1/cRhu4VzkOk33OUPQ4M2uVgotaCy8me5Icfv9xSyAXFyBA6dPyj
         pq3GTWcZLFasp8nRzp+kCG9mIRFqjOmmukh5VfT3wTFAyBzUhQQMlCDMnbNwnGSCX6/0
         7NC/tjY4gh7rQTzjY96Q0I77PLTg3ubSdU8ALGWL1y+p8NaUlyr064/QW8ZM2Saoz8aE
         HNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791039207; x=1791644007;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JIZZr30mT1dzloaWRTkPL8Up2UxyiGM7JHEN4N+quNw=;
        b=fT+JZ9Ya4+ES3LeWyzPpbDSkeWgEJvZwqxKtIt555DZweuO5KK+6oaeSP6f29MQPC6
         Fb8rvOh93cZzW4V2ZU2v8gm2a3bS2KiRmhSupTZWvrfFARcIBhsFNcvxbzzx2wCozkEA
         wQjcMLDubbTmJJfS0cIty1nnoaXBpyn/YthpkzRhOF1V/AXfrjmlqylUUZ3SysjiTg6T
         3kcD3Ibu8kQ162tBJ0J5xzRmu3tgfQq0bT5R8VUDNGMPFXwlqDJJqD3KmENla+jtKky9
         tn8wKCNgga1MI+befKKdhAk7SfPAg4ALoHLvshD/26pXBCZrDQ1bcC4vWTUb23zMsgcW
         ZECg==
X-Gm-Message-State: AFq9FYIvX1xKcW6t+iF1scha0zjpyIyLVIJout3zJT9bx6ziLdijEOZ7
	YLLobe1c4eexZ/819IOVeyFr0HUxGth65QaA/rwKpDb1s9NSbd/ioouj4xDN7Q==
X-Gm-Gg: AYBFou3Bq4BEBgKRthbBgPQsUYGdRwLywBYWE+g3EOuw/lCGLdkUY/iI9YAt6JAm/Im
	63pLtNWTX+x6gzD1lXzF9skT4THQD6OX8D+g5QBWqtpissaN5squ3GXL+f6L7aQD/7sfawunige
	S6XHJAF/WnNGSiLt7UHGZWV95unXpGou3meR6IwTTXLyiPZ9w9hO9M+sTvJUr42cfnHPn7xizJD
	46z1mFPDishMg7lvPSCJrn3x6CWXxGDaQA4u8OwiCEsvbdcnK1LesDnnPCPoQ2ziFisjC2ooP7e
	0C2PRIJnOUnNHaFvAbtD06KvN+rPvXvLaoNzHcToes66+SkZkGwp72Fg9WV3BPjLff+t27AcoEH
	6EPOaafG7Ne77c4fpj+u/J4SfNgdwjBi412eK+Pxk6zqkNFhEjVLK8MN8tLsqIWB6qjmY1kI7Ik
	VQhFsb5sRPOrWshsNKy9SzOGpjYXD1bJFD46iWXy90lNDUDOnTHF6PPjpbJoirPn40C9hK6DlLb
	rs=
X-Received: by 2002:a05:7301:fc10:b0:34f:21b5:5ea8 with SMTP id 5a478bee46e88-34f21b560dcmr6524486eec.27.1791039206629;
        Sat, 03 Oct 2026 07:53:26 -0700 (PDT)
Received: from [172.17.0.2] ([57.154.5.142])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3511b6f3a32sm9024886eec.2.2026.10.03.07.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 07:53:25 -0700 (PDT)
Message-ID: <6ac116e5.c4e819fb.2d9a7f.b126@mx.google.com>
Date: Sat, 03 Oct 2026 07:53:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5248393513686072636=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, MAJO@bang-olufsen.dk
Subject: RE: [BlueZ] adapter: Set Audio service class bit for A2DP sink
In-Reply-To: <ee9afb98a878284f53ec62d5d19a3d34048d3372.camel@bang-olufsen.dk>
References: <ee9afb98a878284f53ec62d5d19a3d34048d3372.camel@bang-olufsen.dk>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5248393513686072636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ] adapter: Set Audio service class bit for A2DP sink
   Pull Request: https://github.com/bluez/bluez/pull/2548
   Created:      2026-09-18 14:04:06+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============5248393513686072636==--
