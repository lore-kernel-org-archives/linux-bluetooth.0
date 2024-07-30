Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE64197A83;
	Tue, 30 Jul 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353896; cv=none; b=Py2JnWjq7ph7NQ0fa3lGZ1phHVqMxdUiIfyMAwzvdtZenIUVm9NIf4fBAlcQ1ix0ASM3tMmQJrTkGfR0YZWkz7ghDpAnlsJcQA4HIL5hxUPoace7dfOsAxKrZZu3SakxGL8HzZCJUflhH6J8TlTIWBEgfXQS/3T1zXpPkcqo+kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353896; c=relaxed/simple;
	bh=xXFjtGCvB3jw9r5d2Ci29zrADIaI+wUIH9WGTHNxLwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/sXIAvyUfljP2GFHgHDwtojx/1YtmgkcZCqd89jyWRP71Ah1JwO847XG6xgvkt/QDk6B86qN83T9TGqGn3cLiJZ4se1FdGQsgPwRqXFw3y9S6q894iMK5UGo7knNdqGqf6hQgfYOWIxqBaXxJgM7Wp4cb0f287gtYT15HrHncI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pdqh2AOE; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pdqh2AOE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722353893;
	bh=xXFjtGCvB3jw9r5d2Ci29zrADIaI+wUIH9WGTHNxLwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdqh2AOE/X6L98VB19J/mS17tNPr+cEov9didJwrYLmS/Y7E3unbnze2RoDtDXREt
	 GsVd+kQuqQDDr2FAigtkXCKtlD4N/LuWYgWnjyZ3Uy3rG66UCCIuo0Sk+ykzMrUNb4
	 mQIMdkRetXXolEEiQMpuJwGk4IxumSxwqyJFtliPF+F+2f9b4eZZd2aoKh/XzEg99l
	 QYTwst8mcKGTmNsjliv8vB3Fk8+isihNxfxRZjrttpnD3MarVzdFdm80QRt88ka+0E
	 NMj3Ia7XabkVWCvIHuYTRa7CQcMXKOQvPi83EFonyMePAXqPCMzccQfGY//919UEOh
	 hLtclEDo0lDnw==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E6CBB37809CE;
	Tue, 30 Jul 2024 15:38:09 +0000 (UTC)
Date: Tue, 30 Jul 2024 11:38:07 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	Steve Lee =?utf-8?B?KOadjuimluiqoCk=?= <steve.lee@mediatek.com>,
	"kernel@collabora.com" <kernel@collabora.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Aaron Hou =?utf-8?B?KOS+r+S/iuS7sCk=?= <Aaron.Hou@mediatek.com>
Subject: Re: [PATCH v7 8/8] Bluetooth: btusb: mediatek: add ISO data
 transmission functions
Message-ID: <9a1697ef-27d9-452c-89ea-159ec3d028d7@notapiano>
References: <20240704060116.16600-1-chris.lu@mediatek.com>
 <20240704060116.16600-9-chris.lu@mediatek.com>
 <7851401b-e884-4ed4-998d-7651f427ad37@notapiano>
 <6a6dc0b081e8caa99172666c71b0826c1cb17a1c.camel@mediatek.com>
 <e9bdcf44-e20a-4824-a0d4-8c6c52ed1e9b@notapiano>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9bdcf44-e20a-4824-a0d4-8c6c52ed1e9b@notapiano>

On Tue, Jul 16, 2024 at 08:20:46AM -0400, Nícolas F. R. A. Prado wrote:
> On Tue, Jul 16, 2024 at 07:59:53AM +0000, Chris Lu (陸稚泓) wrote:
> > Hi Nicolas,
> > 
> > Thanks for reporting the crash issue, I've sent another patc to avoid
> > this crash issue happened. kill anchor function wasn't protect well if
> > MediaTek Bluetooth failed to setup. Add a flag check when running into
> > btmtk_usb_suspend function.
> 
> Hi Chris,
> 
> thanks for the quick follow up! I see the patch at
> https://lore.kernel.org/all/20240716074947.23073-1-chris.lu@mediatek.com/

That patch was merged without the Closes tag, so manually closing the
regression:

#regzbot fix: 'Bluetooth: btmtk: Fix kernel crash when entering btmtk_usb_suspend'

Thanks,
Nícolas
