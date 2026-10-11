Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9496C8D9
	for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 01:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791681606; cv=none; b=iFSZV5X5P9S+gNq8JjsvvtWWXGFDKtPPtrP1A081dRioE0SqcRZz6+4zC2ymexN83N80cYrAhoEjqmoWO9N08mVV8waoWwppgnvq3vso7bY1+TAYPAv95nBYbubdISmlQpR50hhCePGAlhNJFM0T76VpX1ND1zSLPCKXVu65kgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791681606; c=relaxed/simple;
	bh=+n92VAMgMjaZJDdW1W5Oei3Cdfp1Ar7bZfE1Wn5Onjs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=kUXaIqC6j6qG/k/heszbHBCg/V1rrRLlZUeFY+97aibxMKLxR3s1lKYsOtWoohLmmhfOiglrVJmsI7AUvxStpwtE78sdJ38+ZvH+0yNq+QStHP6+8Xcr1IO66ZobbubZjGXwWeKj1JHuIWSQaEEFnBuwepnFZep4LNWigoNxMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBpLoLrk; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBpLoLrk"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35943f55c06so293924eec.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 10 Oct 2026 18:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791681605; x=1792286405; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+E2p+RAbcgfb/p7nI0r33bK4yyV3HEOpuRhlyUHArvw=;
        b=CBpLoLrkFEBj+mnnfMMMYHImruUe6ObQ+zIgB7IuKTpfPDLj8sHn8zqYO9P4OhSxzj
         rDKm5VQHN2uL87Su2KlBP7O+XW+NRW+C44DfiFV2FVm9TYYvfsRqf7nKQV+U8DVwjjAq
         B6H0KJxD9HusTRsTzbnzHyS1K0fo02Qas221k/zGSAihhCqKHvrjBv7zGR++TU8FRuef
         TuIuh4bWvmoTVNMpeZsRReRqpcfrv4jqUII1zarBAZUEMi/whejpj3SuYKmG5uCz3h30
         1BFfdm8ntZWiGxTIVuXTMV8SYcoXLcIFK49c1vpAZJFFA1kqglxjxigHIW5dIb1QDm72
         afaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791681605; x=1792286405;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+E2p+RAbcgfb/p7nI0r33bK4yyV3HEOpuRhlyUHArvw=;
        b=nYggTqDKJN8qO81bNhUsApmpMVlUZhewwjL66isOAEIcti2ZjdWanzvJrJ4s4iUT3k
         txFoRUS9MuPBKA/LiN+R7gvkFK14CAqYr+fk6RhHbePljsDCOf2T9x8Ud5H7hF/ooFmP
         sBOhmCgpg2o1Gv9DXWxlstGNK2oy8Ko0RYWXVaKHw9QfsHQKNkoHUz+PxApC9lT7jTAZ
         IY2yCfpj6KazlUp4IzEE3W+2YQ8tDJh2b4YUUjyAT4e9R+wkmA6O+2JFIFbFEetcgHf6
         tA98tuvvLAmTSJytDvr9l2yJmF+fVLUvmClCW7+JbV6d/jia5TXATxpKnRGEed9SDX4y
         F5EQ==
X-Gm-Message-State: AFq9FYJrwDVpoLu3/foagbDcEgp0zllwRXT7EmyJbrXWqkVPzQGeWX+2
	R+a1GooSCiiswMmoou/PTYcLyiF2FtOyLagEKbg61dBZ4OwPE8fW5wnu+Ph1tw==
X-Gm-Gg: AYBFou2al3BHWAKyaJSxL9x/ZzElUj9zIaCPLT0KJiB3eRjhsBNwf9jfEdt1pfIOZBs
	nUfJD+zsBzVZsiTe+wSfQSoEEKIujvHasfRQImkwPC22acGKfCx7R4flqWnAKhS3g9mvIInPedh
	18RJCSlLnblocBS0DEu6QArVsbzcHvXfRibT4i9kvf9keNszvvJrNRfdtNKEb0F4xsa8eYGKOSz
	wW1zR12oiDY3iojyWpwvGCmIjYKvdkkamqyqUgNg1Qz22lk86dG+3PljTDWA/sP6KiAv6XbBAEG
	WYaaxFOIHWoCSecu/mPSogsqpIg7FyzzkAWaysofkLtbTDtdHDPh6UqISvfMuq+98Dp/lemgEmr
	4h000iiH7jJQnYfaCdw5U7qEk+3JZDOBYkLApU9ldfZuiNzeAGN6T+ZpPFqDxdM5NBgwukHV5VO
	0zaOv0kaVrwtRT9Y/suifr0wHysIbjiZzc/L+fmxE8pzjhnSPnFpalAosoCF/RgyipeBrSsKsVA
	QwlrQ==
X-Received: by 2002:a05:7301:241c:b0:353:7f47:8168 with SMTP id 5a478bee46e88-3537f479117mr8881262eec.17.1791681604289;
        Sat, 10 Oct 2026 18:20:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.126.214])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm20290154eec.10.2026.10.10.18.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 18:20:03 -0700 (PDT)
Message-ID: <6acae443.1c58379a.310d0.aee7@mx.google.com>
Date: Sat, 10 Oct 2026 18:20:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4296865147177804807=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ooonea@gmail.com
Subject: RE: [BlueZ,v2,1/2] input: Reset report map state on detach
In-Reply-To: <CACmoRBZ-pHuzAUrGK39O_1s1xkbvH5GubRnqtuOELU-Cv8Q6uQ@mail.gmail.com>
References: <CACmoRBZ-pHuzAUrGK39O_1s1xkbvH5GubRnqtuOELU-Cv8Q6uQ@mail.gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4296865147177804807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

This series was picked up by the CI more than 2 weeks ago and the pull
request created for it is still open, which means the series was never
applied to the tree.

   Series:       [BlueZ,v2,1/2] input: Reset report map state on detach
   Pull Request: https://github.com/bluez/bluez/pull/2592
   Created:      2026-09-26 00:38:16+00:00

The pull request has been closed and no further action is taken on this
series.

If the change should still be considered, it must be resent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) so that it is
picked up again.

---
Regards,
Linux Bluetooth

--===============4296865147177804807==--
