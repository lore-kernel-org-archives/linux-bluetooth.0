Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50132395D8B
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Sep 2026 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285113; cv=pass; b=fhD9ZGrmeec7eOALFxuoNljZBH9rP0oevr54yv5EmDFuKsJjVdizH72AsovTmt0T2jP/j52Spj/oEzZEciw5swlinANZx4VIW+aGPEAQd9DsviMDuFBe/JK4nbFyq/y1nV5crJxTvmt78MpS8uJ2DHf1XK0hlhKqlyaW7HwM8ho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285113; c=relaxed/simple;
	bh=kvFnBJeULaVm/uVhGyNWBySi4ORvM+a1Vtn+FFnLVmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LvgHtZ1HxgPdEUOpLBhZVxkyZW+kDWazjUrBrbaAm1xqmv2q9q81OZxTbcysM+XFZJ1EXPPGrT1p1MNi/Pz4u8+3KVlSL/kcDMmqMCOzv6PQfZ/hj39OTf/ENtOgzWMgzD/QsjqaeQr/wgKNARsDoKO0WV4BcT5ars5WOV2/D3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=UZN+x6Ws; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="UZN+x6Ws"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-46f415ce6deso31711fac.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Sep 2026 10:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788285110; cv=none;
        d=google.com; s=arc-20260327;
        b=jGOjaGaUDi89H7rxDx/Mp5byUB9J10cKVzGq6VcvHZdy0accLNWSlrahSDSVTt/VJs
         BxYaQm+hFrblx4tbUKgtWaHOWDH0E7tzR+7AObB5jU1ZXcK9qr7P7pgvp9/C1X+FdIO5
         eNo7i/6gL3EOqPJGp/uzuLo0zbxOMNK5x6f5qXYFTpNt10cn4WFcLYKk45qm8PcM0jrd
         Pu8VNFZiW2zu4aSjRmal15quRJqz2I0VIgRimTAmpn1psaeTrNTQN1ZpV3gqA3WvBGz0
         WLFc4nwYUNO2kuGHDbJm4SFPKfraiYUjxspw43z/osG27OgD8nEDyB9ikWfzQZQqWYq5
         /kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=sU9oGXUSflDX61aLIimJd+BpAxgwuYS61cFuI/ULLFE=;
        fh=E1Z79MlpcxsOhsl5ZdiRRAvpoRvJ7yrNR+SNAwfUVxc=;
        b=GO/yMer0EwQcsgHB/rgm36vQH6q+F+tSmKU9cBLaXp4F7KKj2rEaOzImcGKCVvQHP3
         S5T96ZQmbAqTmOawVWo89m5jYNyD8xXc5/o0ptfuthEi4fc9XSmfCAoI6s2+FohgF9YP
         c0ZITPTwrBsQidxf5bRSjWPI9rOJOG5L770tUhIJ6w9XOKmn0WToI+E6GCNEdNO0EVKc
         S5UNjkU8Zq+bmp3e+p4ZKa5xLsh1uZau8jvrCPin1e6vzXb6xCyMXRIDk9a02Hqnmbg6
         RPStiecV9boOO5wlo4Jy1p3xFNqJbnNpG8OlxbifaGIn+Emm5bQ3IbWVTtmcGSdKTLEt
         I/IA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1788285110; x=1788889910; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sU9oGXUSflDX61aLIimJd+BpAxgwuYS61cFuI/ULLFE=;
        b=UZN+x6WsDZcNYDB4WX4938gF20ZF3eS8pKGhr+Y5hUhpy0QHe6u+TmApEStPZv81s1
         Umia9DMxwpT4/2IffoSOZ+wBXpNzjHFZIRWkwBMcuyQtaXgxuXU+3gCBhQ8B2kW0GUWF
         u94Pr4B696LsYbBHq9E2qcwL0L8M7ExcKX6Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285110; x=1788889910;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sU9oGXUSflDX61aLIimJd+BpAxgwuYS61cFuI/ULLFE=;
        b=AljO11LDTyHnJT2mxUCCsjcGKU4Pd38C26CQcjFVtX/grLXe87fpWf+2lRyOmXcULz
         r75PYECRUX7GH+PXxQo+3Sa5AUWfeiqwEA7DY0n4/4zTT/20IiGEZ1pqbGapqTMQDayI
         O0uUfpgc+k1O81m0uY2nDpLW0Iln+iI/7v8Emvo+HSgmfvyQGohcUwspw/mOgS+tEkQc
         PK7x7NBnzCv1gDD/rkuCf+offAbCewLnV7CloA4muHHEGuJdCd0A0VQawIeVHze5KFMj
         5VWUvM5+40otZG0Ya1FTmdgiwgkKuEXmOpuZOBagfmTD+XX0ZMOrDVlDrz8b5NwN5kbx
         73Fg==
X-Gm-Message-State: AFuF++nO4FRRsqqOF58Zn/g6sL6XYPiZ7VputkM0VRuxYhEeVIq/5QqR
	+JeZf2Tr2e4w99XvRoZ9DyORxweKnn3W6dRL+F/tZVnWVXa7862N/NqBPdbipCVNmNPdyYa81F8
	feH2nXjUiHPJSQZJ8JpRUiUSbzrCeL1FKGZ+zyhRvU1p3ZeN6j9nvxX5uRQ==
X-Gm-Gg: AR+sD13fySA+n36tWCtGm+7as9w3TdLzC6Vk3P/4gXOLjJoh9JRX30ZRfL5xPAUS87b
	NxRoNJKB8uB8Wmui5L5R1mrJdh0X2Ypm3RDS5y1wDwloJqm6kzX6xkSbd1WXkWZ08oulgPSWiDQ
	tGcNzfNesKHQl6QwP/E7eZII7ZWiuQjNa4mfE2tDyPzzMisE6kE5Ya9CLbIWBLMROotk8qZhxPK
	2cA8ywFS3ryvkqSGwCKp53Bvd3PtMvAMpw/0ABolJMcyolsB0Dxx37ttt+UmiTJyG6gU6mMp12j
	6Lr7/6mOnAsR4uaXSYBxfhLQw6OCn6Rnu6ETYYpeRC/UYJdbnlWmln3Y3vbe1O0qlay5GI1bxpj
	ZAzmVPfa3wH1NYwPU1WXnA14BfiwRJDpHVmau7oDmhzFSE8r5PviBkM5SvPNTab4=
X-Received: by 2002:a05:6871:89d9:20b0:469:fb51:b351 with SMTP id
 586e51a60fabf-469fb51d5b7mr16447432fac.17.1788285110029; Tue, 01 Sep 2026
 10:51:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787327795.git.m.kurz@irregular.at> <CAO=2mx7zXHmahddsPMaDAZ=2zOdonYOE2nvJB__S6ORU_by3-A@mail.gmail.com>
 <CABBYNZLBvSo+gM5tjRL052tuhj+Ki+Zb7KucAWqs=2nszreoAA@mail.gmail.com>
In-Reply-To: <CABBYNZLBvSo+gM5tjRL052tuhj+Ki+Zb7KucAWqs=2nszreoAA@mail.gmail.com>
From: Matthias Kurz <m.kurz@irregular.at>
Date: Tue, 1 Sep 2026 19:51:35 +0200
X-Gm-Features: AcwNN1XPuB28OYYA-LBQwMa7h8wg8GUof0WZ1vVGIiivO47ssSU73Pouo8PajJ8
Message-ID: <CAO=2mx6PV0B5i289kEz24mqhvdm2rhUttPqVEJRHYxkYgK5m8g@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 0/4] Add component batteries and Fast Pair
 Message Stream
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

Thanks for taking a look.

I captured the HFP negotiation with the Pixel Buds Pro. The session
negotiates the standard HF Indicator 2 (Battery Level), and the buds
send:

    AT+BIEV=2,93

The existing stack publishes this through a single Battery1 interface
on the Device1 path. The standard HFP battery indicator has no component
identifier, so it cannot distinguish the left bud, right bud, and case.
The Fast Pair Device Information message is the only source I have
observed for those three separate values.

Although Fast Pair is Google-specific, the relevant Message Stream and
battery wire formats are publicly documented. The battery path works
after ordinary Bluetooth pairing; it does not use Google's account-based
pairing flow or a cloud service.

I am willing to maintain the Fast Pair code long-term and follow up on
bugs, review feedback, and protocol changes.

If the Fast Pair plugin remains in BlueZ, I will move the unit-testable
parser to src/shared/fastpair.{c,h} as a separate commit. Google
publishes wire-format examples and certification guidance containing
applicable battery scenarios, but I have not found a public
protocol-level parser-vector suite. I can mirror the published examples
and applicable certification cases in the unit tests.

The complete path has been tested with real Pixel Buds Pro through
BlueZ, UPower, and KDE Plasma. The related downstream work is here:

UPower:
https://gitlab.freedesktop.org/mkurz/upower/-/commits/fastpair-multi-battery

Solid:
https://invent.kde.org/frameworks/solid/-/merge_requests/264

PowerDevil:
https://invent.kde.org/plasma/powerdevil/-/merge_requests/666

To reduce the review size, I can split the next revision into a core
multiple-battery Battery1/BatteryProvider1 series and a separate Fast
Pair RFC while we decide where the latter belongs.

If Fast Pair should live outside BlueZ, is there an existing component
you have in mind? PipeWire's BlueZ backend already uses the external
Profile1 and BatteryProvider1 interfaces, but a vendor-specific,
non-audio battery protocol may also be outside its scope. Otherwise,
would you expect this to become a new standalone daemon?

The external architecture is viable: test/test-fastpair already
demonstrates using RegisterProfile together with BatteryProvider1.

Would that split be your preferred direction?

Regards,
Matthias
