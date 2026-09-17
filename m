Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946E33BB66B
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 06:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627415; cv=none; b=FR8tiNElx2lCbR6gAwj3gMCxSOfVf9cPCC0BAIi1aXpkJNvfAAAggOubRCmj533qwRnnk3Wcg3Rab9czfzzhSzUn059UMtTwapckCfDP3Vt58zH5hPCDJ1wYyIVOzEeElO62jKBBScNZKpAyi9U/Lin5tumSeZTsYNjeRf/oLS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627415; c=relaxed/simple;
	bh=xAmdZ5mNttEIGEvEwPlCxjyqUZ8A2h3B7iJKBBHRM2c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=fpddFArF1tPLWXQ8jIHYI4g4T0tA0l5WOmjCGuTQjQVlsmI5zWBZS3TtWWrTFFflSx5v7sBE3k/ucw83boc9hLsXmyOfYL6E7l5PIvIIW1sUKgdGNt/1QpXtwpSn8UabaKe/XlKP83hygOuPWZqc70KPV2rzLEYqU/nNW/rsd/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BARh86nJ; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BARh86nJ"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47be948a50fso308914fac.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Sep 2026 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789627413; x=1790232213; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tC/POzR/PL+3p4II2GQVYkoJv9NifQxtJbFchp3/19Q=;
        b=BARh86nJANE1b5AdxzTGtdul+7Q3KNy77NDHq/h3jmEtDAWmaH3fE/uWZVeIp2P7G7
         tT3YTUiteyGMZTX2eLCKjeXuWEfnHVHNAeOupypdXQWuiqhlxYOr4aZsAwDRIWRxkXiN
         tG1pceqigSTSzXe28LqJi6K8S7Gw6HqlVIgGdnSN0UmKEgscbh5iTamFKvB3FOvYD4gm
         +TEzPfgspomBtc/zkAzm2KTYbXAFda4G2PiuLVIxaDT+RaGRjJMCF0xY0uqibZiOVW6a
         N/XAmgP85k7pjLmF+G5g1ySZAFqznDtJFwgQAPJYahE0ZmlFKM1Lw1zgn3ZhTl/DkUCW
         zQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627413; x=1790232213;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tC/POzR/PL+3p4II2GQVYkoJv9NifQxtJbFchp3/19Q=;
        b=MCI/IjQprPgPlFX/ltu+QMClDgG+1BstA12Mp31GAyPen8Rf4tlJhlHHBXUaUaeZn/
         yktEEG3VhqS1t1zlWBrg+t4CG/uHbDHBfX8hjQHxLvWEX+Cwkxn8x9P/Tu8zrLV6vuZg
         sIeaQxmEhkJNHGdDymOfAxXvo+KqtzXgF1sl5G4mm/TJDLXzrjInKnw6yUia8RR1j+1/
         J08KXL7TwKEaVKIyluazPsOjHqYerBZRxjIUR3OQH/ZVFIOFv6jPSA5E/N14v7VEn5op
         /7NLR4xmR1i+0tNhjMOO6MvHN58TNzPGi2lxSiVOZaWInNRGXeu/kHuuHbH+1BL5xJ3w
         rqvQ==
X-Gm-Message-State: AFuF++mTcojPrhNlsXNiTJ19N2Vj0fTRVznOSH+i9IBBPFl2HxmGuT9x
	NuOo9BVKrlKe8FfPdNpvmEpggDO5Wj2GHoP7Fj+rQH0s2e6J1QNfjw2zripxLb/Ggv4=
X-Gm-Gg: AYBFou2DlH2ySrWTtGNSrOu4sZqbd4QYYxVoqYeHZ8aVSOCpwEdCBKenhzytPQFGnHx
	zewTLnmEgPljylqaf1sfdCJyuXk8V00t6tDeM1oza1W+FKGZIUc7PIiy2sh6XvWOgAHV/ahRMkU
	GlcWcjcqzxbcQZCcYt3iCS8gK6V7Z/Xjow4cfh7nS/wF9pVVOlNjTNA/7QHyAqxiApUtU7tipta
	KM0E4O9iFiDMKQQPnyzJWyhUrSXc/GseSMpGIZRdfDwJSlwFtjXDRcB3enO19+OSeoWtoQMvpWV
	S7aKOVlHzX8nHC48mg+S1km9NDEV5gpIzKjg1pyBx9JB7NIGWWZ5vthbu+I+cStRz69br85hGKD
	5mcFTxMbpliRTz/4auY9R9A5rz9luIYsGQTgU8OPGFAuZnux5kN+P3GpcIGxa7kA4/GkwScudWo
	oy19uoVZSYOhwtU+Y0ducgDP7ftGj8gfqjgCXCN31Rey3FAvrFvDRcSro+WPEcJctuIde9inpZr
	0YmpA==
X-Received: by 2002:a05:6870:c2b5:b0:475:e066:7717 with SMTP id 586e51a60fabf-48477af4c14mr5466584fac.30.1789627413265;
        Wed, 16 Sep 2026 23:43:33 -0700 (PDT)
Received: from [172.17.0.2] ([158.23.19.148])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4842a788040sm4266524fac.17.2026.09.16.23.43.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 23:43:32 -0700 (PDT)
Message-ID: <6aab8c14.53afd7a3.307036.28dc@mx.google.com>
Date: Wed, 16 Sep 2026 23:43:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8737829685921171025=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2469 was closed: input: retry HOG GATT reads on ATT Unlikely Error (0x0E)
Reply-To: linux-bluetooth@vger.kernel.org

--===============8737829685921171025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2469
   Title:        input: retry HOG GATT reads on ATT Unlikely Error (0x0E)
   Submitter:    monperrus
   Created:      2026-09-02 05:11:52+00:00
   URL:          https://github.com/bluez/bluez/pull/2469

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============8737829685921171025==--
