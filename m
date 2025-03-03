Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC523F438
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019931; cv=none; b=ufvhAakHUQH2pi8To4Z2mOhnmSmWvc0jfhNwIKT+DhcM8G42KIjZVBMBXkUuuSN1BVh9RB4Bd/GKijEhw5hun+/kl5Aexbbkt43Tcic+GHBYOeisIKwMMdrL8Y9w0RSJI9FrjnA6MEcJ8rPBKozp+xOpDHIG9NrATi8dnClwjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019931; c=relaxed/simple;
	bh=H3kmPxrjEqRSKsCP/c9IsV7h99wyygg/J4KOZ6ryZXc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjwjNl2L0H1SKBJtHLgXH42yo6eMn0LzBdBCrd3RlfhkbcdKXODZNoclvm518J/2F65QiSP79h+gNiI0IFG9RsYMSNm6EVYQCSeA+k098liHImr62jXPxeurTuQSL+TBbDNas/BUDW7WmkZ9/Ic4E+BBWpoYxhkLqmBIzJzVpt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHyVtVuO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eOCOeDgX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qHyVtVuO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eOCOeDgX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHyVtVuO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eOCOeDgX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qHyVtVuO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eOCOeDgX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04D461FB7E;
	Mon,  3 Mar 2025 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741019928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgnVKmG0c0mzx6bPRklDkfLaFDIeU/5GGB/h6KZD1ho=;
	b=qHyVtVuOcbOCIVyHCuFlLoIYc42KRDk3o6KSQfnLTE61deGd2u0Yld/dxXx9U/z3XmF8eH
	ics6QY/OMXk5OeRVse0efMfi+sBUdSxWlBavTo9Wpf36cGk3KX6nopKEYqMGUaxNrVAAxW
	VWR04CxgoGHbCAPg+0yU6lUdMLEDdLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741019928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgnVKmG0c0mzx6bPRklDkfLaFDIeU/5GGB/h6KZD1ho=;
	b=eOCOeDgXmbcDZdqy04bb1x2MpExQ4MXNUTexEFRX0BcM/ZgHXndu7rt8MtScLmh81nfOn+
	ENGpja/B31daSRCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qHyVtVuO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eOCOeDgX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741019928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgnVKmG0c0mzx6bPRklDkfLaFDIeU/5GGB/h6KZD1ho=;
	b=qHyVtVuOcbOCIVyHCuFlLoIYc42KRDk3o6KSQfnLTE61deGd2u0Yld/dxXx9U/z3XmF8eH
	ics6QY/OMXk5OeRVse0efMfi+sBUdSxWlBavTo9Wpf36cGk3KX6nopKEYqMGUaxNrVAAxW
	VWR04CxgoGHbCAPg+0yU6lUdMLEDdLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741019928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dgnVKmG0c0mzx6bPRklDkfLaFDIeU/5GGB/h6KZD1ho=;
	b=eOCOeDgXmbcDZdqy04bb1x2MpExQ4MXNUTexEFRX0BcM/ZgHXndu7rt8MtScLmh81nfOn+
	ENGpja/B31daSRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEAA313939;
	Mon,  3 Mar 2025 16:38:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDvXLBfbxWf/JQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Mar 2025 16:38:47 +0000
Date: Mon, 03 Mar 2025 17:38:47 +0100
Message-ID: <87tt8acbmw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is commit 4d94f0555827 safe?
In-Reply-To: <CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
References: <87a5a3ah2y.wl-tiwai@suse.de>
	<CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
	<877c56dub7.wl-tiwai@suse.de>
	<CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
	<87y0xmcdl4.wl-tiwai@suse.de>
	<CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04D461FB7E
X-Spam-Score: -1.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 03 Mar 2025 17:29:58 +0100,
Luiz Augusto von Dentz wrote:
> 
> Hi,
> 
> On Mon, Mar 3, 2025 at 10:56 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Mon, 03 Mar 2025 16:50:37 +0100,
> > Luiz Augusto von Dentz wrote:
> > >
> > > Hi Takashi,
> > >
> > > On Mon, Mar 3, 2025 at 10:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Mon, 03 Mar 2025 15:57:16 +0100,
> > > > Luiz Augusto von Dentz wrote:
> > > > >
> > > > > Hi Takashi,
> > > > >
> > > > > Well the assumption was that because we are doing a copy of the struct
> > > > > being unregistered/freed would never cause any errors, so to trigger
> > > > > something like UAF like the comment was suggesting the function
> > > > > callback would need to be unmapped so even if the likes of iso_exit is
> > > > > called it function (e.g. iso_connect_cfm) remains in memory.
> > > >
> > > > But it doesn't guarantee that the callback function would really
> > > > work.  e.g. if the callback accesses some memory that was immediately
> > > > freed after the unregister call, it will lead to a UAF, even though
> > > > the function itself is still present on the memory.
> > > >
> > > > That said, the current situation makes hard to judge the object life
> > > > time.
> > > >
> > > > > You can find the previous version here:
> > > > >
> > > > > https://syzkaller.appspot.com/text?tag=Patch&x=100c0de8580000
> > > > >
> > > > > Problem with it was that it is invalid to unlock and relock like that.
> > > >
> > > > Thanks for the pointer!
> > > >
> > > >
> > > > BTW, I saw another patch posted to replace the mutex with spinlock
> > > > (and you replied later on that it's been already fixed).
> > > > Is it an acceptable approach at all?
> > >
> > > I don't remember if I saw that, but yeah anything that makes the issue
> > > go away, and doesn't create new problems, would probably be
> > > acceptable.
> >
> > I saw this one:
> >   https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@huawei.com/
> 
> Ive might have missed it, we will probably need to rebase it but other
> than that it should be acceptable.

Does it mean that you'd revert the change and apply the above one
(with rebase or modification)?  Or would you keep a part of the
current change (e.g. match callback looks neat) while applying the
similar fix using the spinlock?


thanks,

Takashi
