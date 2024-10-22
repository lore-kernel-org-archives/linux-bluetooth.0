Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8FF19924A;
	Tue, 22 Oct 2024 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594525; cv=none; b=aFjowi9bk1O0296RKL/h4/OPF9ck+g9ubl4Zd3U7nO3Pwcr/NQObNS2+uQoAp8DWqer+MZeqhSWFPA/BvLp3HU5z9v5z+eOqegkGEUvWNNsE3/hAbz7F+JjyiZOL1lNFN2Kq2uFOOW01LLmKeOvDmwtB9cSgqM/P27MCCzmjuYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594525; c=relaxed/simple;
	bh=ZutgxfYWu007tyr81o9qTOUfRHXWns04G0vwIgAPdD4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iDI5g+yU9R8Rw/MJpi7G7QoqH0qTqc5bimX913xNYhM1J2E9ShetG4+3TSS/y+WLs66gs1lAC1ZbqFNi8mDtXnSHEzG1AAHjYEjvRRU7x66EExbowLYny9nK52u7TlDFz4TqqxASEsA8StP0n7Nx9fXNgNdw21cOBWbCu5GYXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qN5VJWqU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKINBKKU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qN5VJWqU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kKINBKKU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qN5VJWqU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kKINBKKU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qN5VJWqU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kKINBKKU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5176621ED2;
	Tue, 22 Oct 2024 10:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729594522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIVthrBRayCR9P3OzqnXu2rlaXyTF5KOjNEVPFTU07o=;
	b=qN5VJWqUEJsDLYzBoAbtorm9JDXhQuHw3KD8+gAwVY7bz2O5dst/QOkwUlZcLXOFXB6Ut+
	5NpT5FcoeC0pBe3u1hzMME58fl5bXMbpo5h8fcHIb1RAe82DPl4mz8YiMciO/IEpjmkBvU
	dvmvhQTrVHhcLUTp4goKeL7ekUZ/0cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729594522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIVthrBRayCR9P3OzqnXu2rlaXyTF5KOjNEVPFTU07o=;
	b=kKINBKKUFp5/X+oOBmO5GK/Bw281blSB7U0xpcNBfP9A7DYYG3+iJAT1f3EADt+WQ88MzH
	0bTdcgAwteMM3iBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729594522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIVthrBRayCR9P3OzqnXu2rlaXyTF5KOjNEVPFTU07o=;
	b=qN5VJWqUEJsDLYzBoAbtorm9JDXhQuHw3KD8+gAwVY7bz2O5dst/QOkwUlZcLXOFXB6Ut+
	5NpT5FcoeC0pBe3u1hzMME58fl5bXMbpo5h8fcHIb1RAe82DPl4mz8YiMciO/IEpjmkBvU
	dvmvhQTrVHhcLUTp4goKeL7ekUZ/0cQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729594522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iIVthrBRayCR9P3OzqnXu2rlaXyTF5KOjNEVPFTU07o=;
	b=kKINBKKUFp5/X+oOBmO5GK/Bw281blSB7U0xpcNBfP9A7DYYG3+iJAT1f3EADt+WQ88MzH
	0bTdcgAwteMM3iBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15F3813894;
	Tue, 22 Oct 2024 10:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QaNABJqEF2coLAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 22 Oct 2024 10:55:22 +0000
Date: Tue, 22 Oct 2024 12:56:22 +0200
Message-ID: <87iktk4d9l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Linux regressions mailing list <regressions@lists.linux.dev>,
	"Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: =?ISO-2022-JP?B?IkNocmlzIEx1ICgbJEJOJkNVXXcbKEIpIg==?=
 <Chris.Lu@mediatek.com>,	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>,	"marcel@holtmann.org"
 <marcel@holtmann.org>,	"linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,	"linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,	"linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>,	=?EUC-KR?B?IkRlcmVuIFd1ICjZ69Ps7NIp?=
 =?EUC-KR?B?Ig==?= <Deren.Wu@mediatek.com>,	"johan.hedberg@gmail.com"
 <johan.hedberg@gmail.com>,	=?ISO-2022-JP?B?IlN0ZXZlIExlZSAoGyRCTXsbKEI=?=
 =?ISO-2022-JP?B?GyRCO2tAPxsoQiki?= <steve.lee@mediatek.com>,	Sean Wang
 <Sean.Wang@mediatek.com>,	=?ISO-2022-JP?B?IkFhcm9uIEhvdSAoGyRCOHQbKEI=?=
 =?ISO-2022-JP?B?GyRCPVM2RBsoQiki?= <Aaron.Hou@mediatek.com>,
	=?ISO-2022-JP?B?IkhhbyBRaW4gKBskQj9BOUAbKEIpIg==?= <Hao.Qin@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
In-Reply-To: <ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
	<ZuB3omUkdUHLggYu@mdpsys.co.uk>
	<790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
	<ZuneSM4SvyUFX86j@mdpsys.co.uk>
	<9bfbbf24ac2480d94d3455f7e33e4b5502b38ced.camel@mediatek.com>
	<CABBYNZKYsL9jcF2n9TsA1BjU-CjXOdXu7MDLP9Sz_Ly8hBAf1w@mail.gmail.com>
	<c01e6dfa730dd10a7d4dba60fe31e82b9c296b37.camel@mediatek.com>
	<Zuyk1c6Gkxx3G0PB@mdpsys.co.uk>
	<f9e8688ebe559e10c019d0cbab4e8b1f5a7d2339.camel@mediatek.com>
	<ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Spam-Score: -1.80
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mediatek.com,gmail.com,mdpsys.co.uk,holtmann.org,lists.infradead.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 14 Oct 2024 11:29:40 +0200,
Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> On 20.09.24 08:27, Chris Lu (陸稚泓) wrote:
> > On Thu, 2024-09-19 at 23:25 +0100, marc.payne@mdpsys.co.uk wrote:
> >>  	 
> >> External email : Please do not click links or open attachments until
> >> you have verified the sender or the content.
> >>  Hi Chris and Luiz,
> >>
> >> What were your thoughts on the findings in my email dated 18th
> >> September?
> > 
> > Thanks for your suggestion.
> > 
> > I've prepared the same environment (Kernel v6.11 + MT7921AUN dongle) to
> > reproduce the issue, collected necessary logs locally and also
> > initiated an internal discussion to clarify the root cause of this
> > symptom. We'll review the changes between two firmware
> > (20230526/20231109) if it's a bug or not.
> > 
> > It may take some time to investigate. I'll let you know if there is any
> > progress.
> 
> Just wondering: Chris Lu, and Marc, what's the status here? From here it
> looks like there was no progress to fix this regression for a while, but
> it's easy to miss something, that's why I ask.
> 
> Ciao, Thorsten

FWIW, the similar bug was reported for the recent 6.11.x kernel on
openSUSE Tumbleweed, and this patch was confirmed to work around the
crash at boot:
  https://bugzilla.suse.com/show_bug.cgi?id=1231599

It'd be great if you can go ahead and merge the proper fix to the
upstream.

Let me know if you have another patch to test.  Then I can create a
test kernel package and ask the bug reporter for testing.


thanks,

Takashi
