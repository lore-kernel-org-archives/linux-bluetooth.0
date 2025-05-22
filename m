Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6C328C86F
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 May 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925744; cv=pass; b=THdBDgANIVvoxhvwFr/RKME0KEXWXe49tKJm/ZTgW8R7JlcxnEWjnpherZzSkTWS79IS/WLhIFWqrPwAr/ZnrNSniHylMaF4VrI6KSKE4vv63azxYp2ikEF0GtQNf8JonuFDfK7ha4PVsGiB/dyv7E+YboTpBr2GJzti2ZXf/SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925744; c=relaxed/simple;
	bh=wO13b0dilFPE4eoL9gqsgHtqST8Mh+2p65q69inTdDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c592VZZ4bTdhGoCfMpr8J3IBnmCpzpxbgde7MRScWh7Jp744Cu03UM4hxY4F7GXvTeMSaDbGPtQI/gP/O6Rosz3IDtm+cowAaBCVji2LZ2J4H+/PQ7Xs0ZUMiLLq5CvOlSb11RAHGBxv1gLrv+o71TlvuMl9ObH8njCDldrq3Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=Vx6qkP5u; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="Vx6qkP5u"
ARC-Seal: i=1; a=rsa-sha256; t=1747925727; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Tip0w5lqcvtFxgVj1FowWnlF9FgcBxE5KyGb6D3IfSQSHC02E9GTgfUJAoWFvVzl7HUGQ9TNH92IU27eDltRWsniHeD+NWnrprsqvRcsCd5hQKRDDbZASEMkslHqeACWP6zLM2RGYtNovGfK5H9jw1tsaDyg7djmu+2h+zA4lGU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747925727; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=5cd1tK8ryDQ+w80rRSHRfRc1rDWsujdACTVfL9Vsf94=; 
	b=Kz0OQriVpsJHsG4sewel6P1FYRc9F3lO9zNiz30BrMxIx4ntJf37cEYdbyt2c+Pjf5+BF6yoYHs8IWjRX2t8YqBVvsRyiY7La3wpcu96a5NxcF5oEPVEg+plYk1fsluy2li8DdFqT9U7FY/162PXRXT5tlGUro+9zqk3Ow3g9tc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747925727;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=5cd1tK8ryDQ+w80rRSHRfRc1rDWsujdACTVfL9Vsf94=;
	b=Vx6qkP5uHNqAGWKeKQTnJJ2GDj5l5BA1yGviso9jUTqjmwliz3Fk9hvGPT05sbLu
	NFtaVu3UHOPPC2SdiatjAsgEp1L4en1W6yRl5iReQGFhW+QG6WFI1pumh3PofZ+Auzp
	/IEyM8vxdRuKIcZLpy/vkQmmGw78IVtD7u75Y06A=
Received: by mx.zohomail.com with SMTPS id 1747925724933510.570269543818;
	Thu, 22 May 2025 07:55:24 -0700 (PDT)
Message-ID: <333ad76e-0aba-4f93-b141-8e69fb47535f@collabora.com>
Date: Thu, 22 May 2025 16:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ v6 1/3] obexd: Unregister profiles when the user is
 inactive
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: luiz.dentz@gmail.com, pav@iki.fi, linux-bluetooth@vger.kernel.org
References: <20250430131648.1291354-1-kernel.org@pileofstuff.org>
 <20250430131648.1291354-2-kernel.org@pileofstuff.org>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <20250430131648.1291354-2-kernel.org@pileofstuff.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Andrew,

On 30/04/2025 15:14, Andrew Sayers wrote:

> Obexd is usually run as a user service, and can exhibit surprising
> behaviour if two users are logged in at the same time.
>
> Unregister profiles when the user is detected to be off-seat.
>
> It may be impossible to detect whether a user is on-seat in some cases.
> For example, a version of obexd compiled with systemd support might be
> run outside of a systemd environment.  Warn and leave services
> registered if that happens.
>
> Obexd can be run as a system service, in which case this check makes no
> sense.  Disable this check when called with `--system-bus`.
>
> Obexd can also be run by a user that does not have an active session.
> For example, someone could use `ssh` to access the system.  There might
> be a use case where someone needs Bluetooth access but can't log in with
> a keyboard, or there might be a security issue with doing so.  This isn't
> handled explicitly by this patch, but a future patch could add support
> by calling `logind_set(FALSE)` in the same way as is currently done
> with `--system-bus`.
>
> Unregister profiles by closing private connections instead of sending
> UnregisterProfile on the shared connection.  Pipewire has apparently
> found the latter to cause long shutdown delays, because bluetoothd
> may be shutting down and unable to handle this message.
>
> Based in large part on the wireplumber code mentioned by Pauli Virtanen:
> https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/modules/module-logind.c#L52
>
> Other services are likely to need similar functionality,
> so I have created a gist to demonstrate the basic technique:
> https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1e
>
> Suggested-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>

I have a problem to connect PBAP profile using obexctl, using upstream
bluetoothd and obexd built on Ubuntu 24.04, the org.bluez.obex.PhonebookAccess1
interface doesn't appear.

After bisecting I found that this commit cause this issue.

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

