Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE234390982
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488177; cv=none; b=EV5hcNWA5VwLKFYsweDe0EoTZpWUQCCoflbg5/+lI9b08ycXofuXBnW1Lo+JP0h0rfPPQd6Ns9265xaz2JyVA7q842KiF7ogps38EinE9jivf36tiL786QNpbXePAHufnjn+x6ZOvkSdMqry1601CwtL2ZG2AnnRmF300NqvpUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488177; c=relaxed/simple;
	bh=VEKGk4XPxvaL/QqqH8IZmElyV/2dqP0Cl6MBJXsGg6o=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date:
	 In-Reply-To:References; b=Peb+5jeKMearAJjQpQ7q5s2We0G3AsCjbVwhmOkoFP7wKjLe768zddZMrkiF+yrEbVPe1bGFrzbhW9DXqUcH+18r1fd97LMAhPEy8t+hdCvt/DdNzlHivPiyecU7/Z3maJiGiMnXyQyTrGDYTcXHwuEyKx+5RjD0U16E/qjheEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b=t4mE2mvH; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=martinbts@gmx.net header.b="t4mE2mvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1772488174; x=1773092974; i=martinbts@gmx.net;
	bh=VEKGk4XPxvaL/QqqH8IZmElyV/2dqP0Cl6MBJXsGg6o=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:In-Reply-To:
	 References:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=t4mE2mvHmVf6/5pVZXhpH1tlMwUq48z5kMBfQKXJnShoFOYt7Mdt1MgxtOOFLvW9
	 ylidua5JxFWFg2QX0KcYUELgLiF/mpV2FyEsJliAOJe0/iRdrTuCqc4RGD0dhfSJm
	 h9WvonlN2ejs2YdcEg92X0ZIFUXgnccEWp7c6TWlB5bS57BujpO3AHgFyNsDcBBzV
	 6G0hKI84y4G8Ch8F+BRuZoA6PAl8N+DAuAHQMz9qz0ppgNxJD5AFgUlKOjBv39rzw
	 KsAP7frFsx+WJO9OyklT25Il4WC+ej112kONlgj+9Z2cEI6T/bZR+ZpV3RoDMKm04
	 FOb2TydzJ0eu4oJXbA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [88.76.74.251] ([88.76.74.251]) by
 trinity-msg-rest-gmx-gmx-live-8d9bc96fb-5wc6t (via HTTP); Mon, 2 Mar 2026
 21:49:33 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-fc71755b-6653-4c14-8751-59cf55735dda-1772488173774@trinity-msg-rest-gmx-gmx-live-8d9bc96fb-5wc6t>
From: martinbts@gmx.net
To: linux-bluetooth@vger.kernel.org
Subject: Aw: Re: [PATCH BlueZ 3/5] device: Add btd_device_set_alias()
Content-Type: text/plain; charset=UTF-8
Date: Mon, 2 Mar 2026 21:49:33 +0000
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e4ef2b5dc4789347eb4f3f5005148bd68205b845.camel@hadess.net>
References: <20260301152930.221472-1-martinbts@gmx.net>
 <20260301152930.221472-4-martinbts@gmx.net>
 <e4ef2b5dc4789347eb4f3f5005148bd68205b845.camel@hadess.net>
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:9YMX6vMK+qAUCe+un5TXqg+8luEEdPym8oTKCUXyHl9Wj2bgoLSuKUxGrqr9asoQRy/eK
 kKM7tQeew0lcIslUYOhp97YL93+q9fDA+KQRf+P6nSPdewlLrN4qudt5p5Cp6JE2HuA+rtZBftAv
 HIqjpAipmu2dDgbq8kIkndvPHjAjvU0g7zHMdqy9dszFaG/kNvLejMH/QhVfdE45ProgmUSI4YhQ
 aCtNO98Ipcch5DEJy61SgYMA9R8wAcdE2m+A/zo34/4lGOrbBO+Fx1mIIHGaIzwwau8MoZyNiwuj
 m+fXo0OGAg41aBK5FvyFAYdTcmK74vEKPCW5L+E8tVBhzi8fTtLfKKf28MXNxP6Z0Y=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2MJNwdyFSM0=;67at+s4a04dwfAmFyzSFB6giv2H
 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
 QX7Ev2+MVmOu45FwbfE2VqEVXVrT

> Gesendet: Montag, 2=2E M=C3=A4rz 2026 um 12:42
> Von: "Bastien Nocera" <hadess@hadess=2Enet>
> An: "Martin BTS" <martinbts@gmx=2Enet>, linux-bluetooth@vger=2Ekernel=2E=
org
> Betreff: Re: [PATCH BlueZ 3/5] device: Add btd_device_set_alias()
>
> More generally, is there any way to reduce code duplication with
> set_alias() as well?

I suppose there is=2E I once had btd_device_set_alias simply call
set_alias with NULL as first parameter, but I wasn't sure how much
hacking the existing method would be appreciated, because it would
add this non-DBUS driven invocation=2E I'll remember to put a modified
approach into v2=2E
