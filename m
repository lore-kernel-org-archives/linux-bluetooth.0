Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE878214A8E
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014611; cv=none; b=VbOGYLCcltC7WkJUZB3AZJQ3b53OAlUtOZqe4J3hcVZiQq4rs16dhwESVrddjMT8L+Ri+MCixXTsf7piKzUosEcQ5NkFlVyN6EyVys7H8+ptdbP/xhAGUKSGzQUxXfSS4yXHcM0730kMkqP/jhCfYtHOM1kuq6VB77nhBVG8RiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014611; c=relaxed/simple;
	bh=QcW7PpCC01xU4vPKyA9JV+v9sdak6KXD5MYTjFXL4Jk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnfsyAso9x1KFgcMlTgU4ufZa9cV3qyymXWOTmNlw99wwBlijetKccftmNOuUFTVxTBKxK9eiUIx3juVpiJp8zBEaxLaPQjqvUXvmqZPbAPchUWYqSwg8leGCObp0GmSxkZg6PUpleVIP5fvwB1PvZoLXsLimoaZ1T/auknmjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Prk+ZpG4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rkO2XO2d; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eBh9gBjf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Gbqsd3jY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Prk+ZpG4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rkO2XO2d";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eBh9gBjf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Gbqsd3jY"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C402B1F393;
	Mon,  3 Mar 2025 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741014607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCEtTCEFqzfpl7NA11IOQEGPKuZR7dVbjsAgL0bPyTE=;
	b=Prk+ZpG4/SltIvzh2X6gMiRTNbn+76qti0m5iqYYK3+xr4QqLaciHOHi69U4wiBnxLWJHz
	HJCYacHkbgWo3NYgJ96Ku0vCDL45i1kLF8V/QKql55RzN4b7cezmtgTEkGR/pTAJ0x2rQ8
	sPU+Tspur87hBSc/fWLwQ4MCZ5roYN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741014607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCEtTCEFqzfpl7NA11IOQEGPKuZR7dVbjsAgL0bPyTE=;
	b=rkO2XO2d740ZE7LrfP85MEEAFqHu1r2wwWI41KQbRUya3cit0SAFsE2lZvS+jsrXKjk5KU
	juWcV5rBPPTbzgAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eBh9gBjf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gbqsd3jY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741014604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCEtTCEFqzfpl7NA11IOQEGPKuZR7dVbjsAgL0bPyTE=;
	b=eBh9gBjflThR651Hi+wb5EGUPEwEedMlNxhNQOq1feUWHJCWsH+eStA6qatlB336ix/0+2
	jWJyfhx2Tb5z5vtbKPTAR7j/7xFR36yghqLROc1bBNTe91tQpPlbnT3gpTvtfeJFUhx32T
	wScPpVR01dARiDo5G2ai/QoHst8cRMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741014604;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yCEtTCEFqzfpl7NA11IOQEGPKuZR7dVbjsAgL0bPyTE=;
	b=Gbqsd3jYybx914qh2NR2lPIxKq97NvesYG8vGaW2O+CKOOMKgRQxKbvlsC0ziDR3NF6FTS
	8/yCaSKc8t6rouDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E78713A23;
	Mon,  3 Mar 2025 15:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VCYpIUzGxWdVCAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Mar 2025 15:10:04 +0000
Date: Mon, 03 Mar 2025 16:10:04 +0100
Message-ID: <877c56dub7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is commit 4d94f0555827 safe?
In-Reply-To: <CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
References: <87a5a3ah2y.wl-tiwai@suse.de>
	<CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C402B1F393
X-Spam-Score: -1.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,syzkaller.appspot.com:url,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, 03 Mar 2025 15:57:16 +0100,
Luiz Augusto von Dentz wrote:
> 
> Hi Takashi,
> 
> Well the assumption was that because we are doing a copy of the struct
> being unregistered/freed would never cause any errors, so to trigger
> something like UAF like the comment was suggesting the function
> callback would need to be unmapped so even if the likes of iso_exit is
> called it function (e.g. iso_connect_cfm) remains in memory.

But it doesn't guarantee that the callback function would really
work.  e.g. if the callback accesses some memory that was immediately
freed after the unregister call, it will lead to a UAF, even though
the function itself is still present on the memory.

That said, the current situation makes hard to judge the object life
time.

> You can find the previous version here:
> 
> https://syzkaller.appspot.com/text?tag=Patch&x=100c0de8580000
> 
> Problem with it was that it is invalid to unlock and relock like that.

Thanks for the pointer!


BTW, I saw another patch posted to replace the mutex with spinlock
(and you replied later on that it's been already fixed).
Is it an acceptable approach at all?


Takashi

> 
> On Sun, Mar 2, 2025 at 4:59 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > [ I posted without the subject line mistakenly, so resent again;
> >   sorry if you have seen already read it ]
> >
> > Hi Luiz,
> >
> > due to the CVE assignment, I stumbled on the recent fix for BT
> > hci_core, the commit 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping
> > function called from invalid context"), and wonder whether it's really
> > safe.
> >
> > As already asked question at the patch review:
> >   https://patchwork.kernel.org/comment/26147087/
> > the code allows the callbacks to be called even after
> > hci_unregister_cb() returns.
> >
> > Your assumption was that it's never called without the module removal,
> > but isn't hci_unregister_cb() also called from iso_exit() which can be
> > triggered via set_iso_socket_func() in mgmt.c?  Also, any 3rd party
> > module could call hci_unregister_cb() in a wild way, too -- even if
> > the function still remains, it doesn't mean that you can call it
> > safely if the caller already assumes it being unregistered.
> >
> > In addition to that, I feel what the patch does as a bit too
> > heavy-lifting: it does kmalloc() and copy the whole hci_cb object,
> > which isn't quite small for each.  If the callback is still safe to
> > call after RCU protection, you may just keep the hci_cb pointer
> > instead of copying the whole content, too?
> >
> > I couldn't find v1 patch in the patchwork, so not sure whether this
> > has been already discussed.  If so, let me know.
> >
> >
> > Thanks!
> >
> > Takashi
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
