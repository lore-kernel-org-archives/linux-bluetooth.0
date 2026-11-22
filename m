Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795367644;
	b=Hgqppt1lhbPFI5lxqbyCYzyIN1vZ3t/Caz50N82cc3XrTEeB6tKoY9jTZCuiDqWFyCCE
	 A+Vcm/dYJgg48JW12iY1GCoem30X0oo19kP85PNh72VmVMVpWGe8213VXYmEaA/1DN+Gx
	 wqjC8y8y/8GsH8jgyelyBxzaQzWOXf2L52+ACo62HeU7IeGzRf5saHojx7eDObz7YQvEM
	 6qbYavHK0L5UR+pC7PUzcataHBwejz+dYWjVItkuincm+9Q1d8OK70Ga6cNWHv8xx9CHs
	 I9+9HjhcYpNMQDgtgs/YdXMw2AfVardWElPIscPBKCodjljVDZKkQQd9zmvMGhgl8Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367644;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=V1K38TQgHsuSkud7fslaipZoyRFe76SDm130xOdSkyo=;
	b=TmAY1xf8ou7BEjggSJYoQKKrfCk5wAoAC3kS2Mmxcsme+IQrLcrcHP7cfslbiFBK2VZc
	 eLpwsr6raGTClHUAkvifRKd4gE+Ct5qkwpiVK16j1jQDL6chJjU3KlL5qlXhSGYlFsb14
	 WqFx8vpPi35L9MwoyeDQax9IZMkoGBZhXVowb8fjfCJn0wcL1Tgd6ZulEaQkhc3BOvY1y
	 qtAaWRUMul8SO59zQjC8aKMGZhzA8munXZPJYpk70K8aZOMTLmsRDPkA8hDKOAMxkAYsh
	 oY9a1sz2NqiUMOKLCa28RCDukt00w+k629nx9K7Qty5BM0/bSiwSjVRKnmXVAnqSTkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="QJtt/lGI";
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686F606A320
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D686F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJtt/lGI
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b51389f58cso25771227b3.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795367643; x=1795972443; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V1K38TQgHsuSkud7fslaipZoyRFe76SDm130xOdSkyo=;
        b=QJtt/lGID9zcB8DlD2IQzpRX82R+JrE/+uex70MssF7uF4fI5oW7dJCH9SOBfIRE7y
         4Zu31fVQ8RekvhTETmsuYuZpk7JuUauJiTNs/O036dUyy+x9JfZkYT4lF6rdRJezm7J8
         u31S0iePpkTbUNB8wi+G14LHa4Z/a7zJiaI1PWCM+0Hn3/vWB+Dwxuu3aLNSbTuEsXvl
         AwDWPsqqwsHZh49W3NPCaqLCILhQ2qQdpVLMA9VSVHCBoIpbfIwD+Qxoyy4OT9K00kWp
         OyG+kbATMIbE6jc8lwvV65seuL+YQvDc500Dh8Q/1rRrFB0kXyHWdZl+Mvz7bpFtvdzC
         yG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795367643; x=1795972443;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V1K38TQgHsuSkud7fslaipZoyRFe76SDm130xOdSkyo=;
        b=DG+5IFRcxVYfLfa79Tl4aJOOnzeqEh69UNxYjMkcHxSkP4D3f6cZIz8Q9Vu0ZRMBwE
         DE/Si5EUHGdV7nRQC0CXZUTla0xj7MECaGpVmiyGI9iiTovrJP/o+BeLWEtEa07h/c0T
         hZi8Z91ImSacnfS/PceNgeMprd3iS3UnKtoFYWDFatB/O4kvETpd3c60g8699AJFEBte
         N5AyaRe55m1lhFHfz2d0+JtqH60cHRTk/IequjQcosFtvGi8BHtWO79Et9DuPYwouZt4
         9UZ8UywbmbXJiDDbD2o9qk79QYkTPy9KlSZx9hVQtmJFkfu0xks8moC97zEPYhhfR1Aw
         h5Iw==
X-Forwarded-Encrypted: i=1; AL+hErGd+W+1wGzTAg7nbDnoDjpN/NcugXYDOEcRt7qtxQK/tmzghChlv91YY40UdX5WBEIvbzyDuQMm9PQJj6uzBXQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SquD/BeAeTTpmeAJdIarDtxUDRBOjCqpO1Ek0QNu/8Vboua6h
	mpKn4MMFm4LJpSJcN8q8wU+2Is7MQWrFk6xvsQKzmDPILr087PkS3Bvc
X-Gm-Gg: AZFdTZeN46m4WgUVj5G6feXs0VwBfjSxA9QIU4HbHmqL2fcRaBe/LLN7Pz7XeCc+sgc
	KkhOLzG6DXd0ArCZX9jMer+cNK1fTqHkuSsmn2eQA7WBZgWq/vO07dRd/MOKb8xeO15yKNrO7QU
	uN99+PHW3HOlid3aCtD10Y5V+NzyHnErFRwmrnnddPtfriNnaXy3zkJp9nwA73FRLuaATodg5u7
	Qj2fK2he2v6jqoqgi9AZi5AtfCu4i5xZnOq6nHWpjZSc8oFG6kRSuIscPt8p98clPpaCzzaXczQ
	kqnOYU0KOsKGFPA7W2FkWQ7j2qy07xtaBJsOWARcsUGDBxDKdK8cJ7lWRT29gWGJ6YNWK3GgUD2
	12VhFobLMPF+AUnBCn7SLR80mHfPyLcI6LJB/jE2kZTWWgVa3lOtaKhNcQ2+1nQwNcUvRAk5Mnt
	aUBjuAcvuzEMQ2+pb89XSzh49vIQY4C9ZoIZ8EdctfPWo84PW6PrBSDsUEkh8cTxNM7S8h69DkO
	oLbTKfvQNmDkgSJn2p+IOeEqrhrSxaN2tjTR3UBTTuyDcn2oUJ/zNwJAVJc+1nozCEatYYHhE6x
	ygx0vknQlY9pt7aX470MfRxd/FXzcdzEz6x//ADLYkTkgqcIz5QIzM+9VGNo6l254Hb8XHakXax
	Umf+FY+brQuzu5RzAt7oRwSCQE6I0y2jPlVwKCiViDk8VgDnMrevxSob9/SC1M+d7Y5ystoPxDZ
	SD0xpry0rtHo/ysmehHgr3Ym8JIm9W0nSfzrA9qIWCaQLPoGl7jrd/Tln0vGDHNRlb3Oook2Sel
	TRjisT05EMGqXVQ4EX6rS+9lXThVlHCUKs/RrI56XwGlWCr1CLWzoyux24vbiEwvg==
X-Received: by 2002:a05:690c:3745:b0:8b0:a432:5686 with SMTP id 00721157ae682-8b520496833mr31116367b3.44.1795367642763;
        Sun, 22 Nov 2026 09:14:02 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa (104-12-105-135.lightspeed.miamfl.sbcglobal.net. [104.12.105.135])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52034f7absm36379897b3.41.2026.11.22.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:14:02 -0800 (PST)
From: Jason Perlow <jperlow@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] Bluetooth: btbcm: Add entries for BCM4364B3 UART Bluetooth
Date: Sun, 22 Nov 2026 12:14:00 -0500
Message-ID: <179536764088.21183.18060597598784441550@gmail.com>
In-Reply-To: <6f0b4dfc-4bb3-45f9-81ae-347e345cbe33@molgen.mpg.de>
References: <6f0b4dfc-4bb3-45f9-81ae-347e345cbe33@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Paul,

Thanks for looking at it. (Resending as plain text; the first copy of
this reply bounced from the lists because of an HTML part.)

As tested it is about naming and the firmware lookup. The controller
already came up without the entries, but it was logged without a name
and the driver only tried the generic brcm/BCM.hcd. With the entries it
is named BCM4364B3 and brcm/BCM4364B3.hcd is tried first. I only checked
the log output and that the controller still initialises on both units;
I have not compared pairing or throughput before and after, and I am
not aware of a unit where Bluetooth did not work without this. The
commit message now says that explicitly so it does not read as a bug
fix.

You are right about the order. The table is ascending by subversion
here, so v2 puts 0x3032 and 0x305b between 0x2128 and 0x4119.

v2 is already out as a separate mail
(<20261122165132.14015-1-jperlow@gmail.com>) with your Reviewed-by
added, as you offered.

Thanks,
Jason

