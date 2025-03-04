Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7251DFD8B
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077157; cv=none; b=YtuXRWoa1NBJIQ4n3F90i+Al6f4qwaTIRfu1s1N+f+InebVLTiXQln6xHTSTVUTvgM09iFMoQ5vfskPcog7wsDfknf8qeyKHEg19AXcoKl/q86tyYI4shVjyst3yQmFXfyoepwyM/HYpRhT1zEGqThZIpedOEDhmcPoOZF1Qv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077157; c=relaxed/simple;
	bh=bTkTBr7l6nTcb4akvwbTaL+3vTIjzPW+zgzBssEWyzE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifDypix9sQp5yRVFVQ+PfBRzkT5oG6RRv1JOV24CUSDKBsjmE670V4xaKdnJwLdeXNW1gLVzbvR7g8yQxowqyvEDpzEKkTQcD/+yHn3kZgHduqGtXLqwkLfy+ndeBLGSK3OLi89cwn+iRqjo/pM5zbGWb9vUR1kSWvEFZeUN0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hNxwfRun; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yia7avhs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=M4P1BZlk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ChZ1sXn/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hNxwfRun";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yia7avhs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="M4P1BZlk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ChZ1sXn/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E2E4B1F387;
	Tue,  4 Mar 2025 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741077153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmGXXnAiQxl2wGU8Qmfdp+ymPe+1BOtAwR9ux0MeBFE=;
	b=hNxwfRunnrjvpB5qwse1fwuz97KDvvSC3+Lh5kSVCHO0yL1G1eLEE+Gau5AkdtOkK/oyd9
	9qUU/fXqvGXIXRz6CLMOcZhOf0FckGJv4/9WsNphjCs6aVo8wqBwUEs5BIAY6CeXmHnMI1
	sQRnKIlUy6AZ6kuCjm2nqjsMOC7YNo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741077153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmGXXnAiQxl2wGU8Qmfdp+ymPe+1BOtAwR9ux0MeBFE=;
	b=yia7avhs9pgQYX9LKGnksQtbFMc/heEmldJBakhjFUwFjaO1H1lAqcwNv2YI4D+ZaEH+Pb
	cfd1RzLP/mixehCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741077152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmGXXnAiQxl2wGU8Qmfdp+ymPe+1BOtAwR9ux0MeBFE=;
	b=M4P1BZlkJcUtuYnnu6ZqU8LUNZIGS11nQOWEUHC3mDS18F85/HebCPxdpdd4ALREOVoo3+
	PUYSB0uil2EWCI1XZk91KGM+Lyh7SjFCfx6QGnVTEytIj+5gtbbm7wg/7ixibU/erwPfoP
	iY9Cvz+UwptGmGr0TN/qSWVEfQtZdaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741077152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmGXXnAiQxl2wGU8Qmfdp+ymPe+1BOtAwR9ux0MeBFE=;
	b=ChZ1sXn/seQ8AUk2oR+4B84AxIv+7EJ7f9HI6ysKHN3CUVyu1funrED25nyXHlTAasMwS6
	mOs2Vhu9G1gSN6BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A57D21393C;
	Tue,  4 Mar 2025 08:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bu3NJqC6xmdgOgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Mar 2025 08:32:32 +0000
Date: Tue, 04 Mar 2025 09:32:32 +0100
Message-ID: <877c55ci1r.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Pauli Virtanen <pav@iki.fi>,
	Takashi Iwai <tiwai@suse.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is commit 4d94f0555827 safe?
In-Reply-To: <CABBYNZJHSoDzo7DmB84LrBw3Zi+F_QsNcD5MBJHijCo-v_KzGw@mail.gmail.com>
References: <87a5a3ah2y.wl-tiwai@suse.de>
	<CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
	<877c56dub7.wl-tiwai@suse.de>
	<CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
	<87y0xmcdl4.wl-tiwai@suse.de>
	<CABBYNZJsqXLRuY6ZMPujio7-tx82SHRZyZh=tChonVs-XiWMjw@mail.gmail.com>
	<87tt8acbmw.wl-tiwai@suse.de>
	<52df2ea6bac070c015987547840c78ac27538def.camel@iki.fi>
	<CABBYNZJHSoDzo7DmB84LrBw3Zi+F_QsNcD5MBJHijCo-v_KzGw@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.80
X-Spamd-Result: default: False [-0.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 03 Mar 2025 19:19:47 +0100,
Luiz Augusto von Dentz wrote:
> 
> Hi Pauli, Takashi,
> 
> On Mon, Mar 3, 2025 at 12:47 PM Pauli Virtanen <pav@iki.fi> wrote:
> >
> > Hi,
> >
> > ma, 2025-03-03 kello 17:38 +0100, Takashi Iwai kirjoitti:
> > > On Mon, 03 Mar 2025 17:29:58 +0100,
> > > Luiz Augusto von Dentz wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Mon, Mar 3, 2025 at 10:56 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > >
> > > > > On Mon, 03 Mar 2025 16:50:37 +0100,
> > > > > Luiz Augusto von Dentz wrote:
> > > > > >
> > > > > > Hi Takashi,
> > > > > >
> > > > > > On Mon, Mar 3, 2025 at 10:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > > > > >
> > > > > > > On Mon, 03 Mar 2025 15:57:16 +0100,
> > > > > > > Luiz Augusto von Dentz wrote:
> > > > > > > >
> > > > > > > > Hi Takashi,
> > > > > > > >
> > > > > > > > Well the assumption was that because we are doing a copy of the struct
> > > > > > > > being unregistered/freed would never cause any errors, so to trigger
> > > > > > > > something like UAF like the comment was suggesting the function
> > > > > > > > callback would need to be unmapped so even if the likes of iso_exit is
> > > > > > > > called it function (e.g. iso_connect_cfm) remains in memory.
> > > > > > >
> > > > > > > But it doesn't guarantee that the callback function would really
> > > > > > > work.  e.g. if the callback accesses some memory that was immediately
> > > > > > > freed after the unregister call, it will lead to a UAF, even though
> > > > > > > the function itself is still present on the memory.
> > > > > > >
> > > > > > > That said, the current situation makes hard to judge the object life
> > > > > > > time.
> > > > > > >
> > > > > > > > You can find the previous version here:
> > > > > > > >
> > > > > > > > https://syzkaller.appspot.com/text?tag=Patch&x=100c0de8580000
> > > > > > > >
> > > > > > > > Problem with it was that it is invalid to unlock and relock like that.
> > > > > > >
> > > > > > > Thanks for the pointer!
> > > > > > >
> > > > > > >
> > > > > > > BTW, I saw another patch posted to replace the mutex with spinlock
> > > > > > > (and you replied later on that it's been already fixed).
> > > > > > > Is it an acceptable approach at all?
> > > > > >
> > > > > > I don't remember if I saw that, but yeah anything that makes the issue
> > > > > > go away, and doesn't create new problems, would probably be
> > > > > > acceptable.
> > > > >
> > > > > I saw this one:
> > > > >   https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@huawei.com/
> > > >
> > > > Ive might have missed it, we will probably need to rebase it but other
> > > > than that it should be acceptable.
> > >
> > > Does it mean that you'd revert the change and apply the above one
> > > (with rebase or modification)?  Or would you keep a part of the
> > > current change (e.g. match callback looks neat) while applying the
> > > similar fix using the spinlock?
> >
> > My current understanding of this is that the actual problem for
> > 4d94f0555827 was incorrect RCU use at the callsite in
> > hci_le_create_big_complete_evt(). That part was rewritten in
> >
> > commit 581dd2dc168f ("Bluetooth: hci_event: Fix using rcu_read_(un)lock
> > while iterating")
> 
> In that case maybe we can just revert the 4d94f0555827 ("Bluetooth:
> hci_core: Fix sleeping
> function called from invalid context") and see if that works, might
> need to trigger syzbot just to confirm we don't introduce the original
> problem.

Fair enough, it sounds reasonable.


thanks,

Takashi
