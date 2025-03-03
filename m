Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A379E3C00
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741017404; cv=none; b=LfFHhrf+GArmD7n1uDllpzjRZr6EB9kJ5F8pqT90v/DrTgIol064xPSf6Tgf9/hvw1TT25Q6qMFdGDsXfBBEEQ+Xiy33pYX6EKjLKUQkjQ4QlZWOs3BqEqTRpfPXGpqQGBMNmo/lXNdOadRWZgflpiP3CUcBKlHtVjqD2ytQDc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741017404; c=relaxed/simple;
	bh=G7BSdB03LBAtyahtt4BVZIxg8odkNnUmGaooKqtAa7I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GF+UpE/mnEnALkwjcjJmvUGHjIk4MkAlnu6291YmIpMcceJQomN8144fa7vt2+oAz45Z/vrGIbzM/HYRbG00i41diGi89fw2VddPx9HWk6bj/MiAnYvL2BW8LyYbVbHMlrpVjQOFT8aVP1+e1M2TeLSd5s98c4eFhvsAYi/gPx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzVTJcJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2PXYwUf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YzVTJcJB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=I2PXYwUf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzVTJcJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2PXYwUf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YzVTJcJB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="I2PXYwUf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ACDA41F444;
	Mon,  3 Mar 2025 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741017400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+P/qw8gmAcXFBrMnwLW4tw4mI2VNNvkWn7a0bjF3VU=;
	b=YzVTJcJBV/lreixXs5LveQ3tzcF5/V7RgszTImCBGDN1QMprEVrdjSDp3DpDX6V22TVfx7
	hcMye9GNKYsbudFuuxVfSzNqf867jKNqNXfxblatc6aLGlO+iLQUgPH7vthfwuhEe8K7Vq
	DPzmp0lmSSemULDtHKqOyCpsYQHUikM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741017400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+P/qw8gmAcXFBrMnwLW4tw4mI2VNNvkWn7a0bjF3VU=;
	b=I2PXYwUfHKVhRd04ZpplziNuij+mxN7EwKy1IMNwb5e+9HDQViAc4JYy+wdvPFEQtW86nA
	E/V4y5vudMbReaDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=YzVTJcJB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=I2PXYwUf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741017400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+P/qw8gmAcXFBrMnwLW4tw4mI2VNNvkWn7a0bjF3VU=;
	b=YzVTJcJBV/lreixXs5LveQ3tzcF5/V7RgszTImCBGDN1QMprEVrdjSDp3DpDX6V22TVfx7
	hcMye9GNKYsbudFuuxVfSzNqf867jKNqNXfxblatc6aLGlO+iLQUgPH7vthfwuhEe8K7Vq
	DPzmp0lmSSemULDtHKqOyCpsYQHUikM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741017400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i+P/qw8gmAcXFBrMnwLW4tw4mI2VNNvkWn7a0bjF3VU=;
	b=I2PXYwUfHKVhRd04ZpplziNuij+mxN7EwKy1IMNwb5e+9HDQViAc4JYy+wdvPFEQtW86nA
	E/V4y5vudMbReaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 689DD13A23;
	Mon,  3 Mar 2025 15:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nrbhFzjRxWccGAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Mar 2025 15:56:40 +0000
Date: Mon, 03 Mar 2025 16:56:39 +0100
Message-ID: <87y0xmcdl4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Is commit 4d94f0555827 safe?
In-Reply-To: <CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
References: <87a5a3ah2y.wl-tiwai@suse.de>
	<CABBYNZJOW-YSOLS0tBdUQmxqbOmgT2n2jVheyxbvWbYmBicqyg@mail.gmail.com>
	<877c56dub7.wl-tiwai@suse.de>
	<CABBYNZJ6Gfmpur2by01B9+XxBX+VBzBY95v+9f5-VpiantunfQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ACDA41F444
X-Spam-Level: 
X-Spamd-Result: default: False [-1.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -1.01
X-Spam-Flag: NO

On Mon, 03 Mar 2025 16:50:37 +0100,
Luiz Augusto von Dentz wrote:
> 
> Hi Takashi,
> 
> On Mon, Mar 3, 2025 at 10:10 AM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Mon, 03 Mar 2025 15:57:16 +0100,
> > Luiz Augusto von Dentz wrote:
> > >
> > > Hi Takashi,
> > >
> > > Well the assumption was that because we are doing a copy of the struct
> > > being unregistered/freed would never cause any errors, so to trigger
> > > something like UAF like the comment was suggesting the function
> > > callback would need to be unmapped so even if the likes of iso_exit is
> > > called it function (e.g. iso_connect_cfm) remains in memory.
> >
> > But it doesn't guarantee that the callback function would really
> > work.  e.g. if the callback accesses some memory that was immediately
> > freed after the unregister call, it will lead to a UAF, even though
> > the function itself is still present on the memory.
> >
> > That said, the current situation makes hard to judge the object life
> > time.
> >
> > > You can find the previous version here:
> > >
> > > https://syzkaller.appspot.com/text?tag=Patch&x=100c0de8580000
> > >
> > > Problem with it was that it is invalid to unlock and relock like that.
> >
> > Thanks for the pointer!
> >
> >
> > BTW, I saw another patch posted to replace the mutex with spinlock
> > (and you replied later on that it's been already fixed).
> > Is it an acceptable approach at all?
> 
> I don't remember if I saw that, but yeah anything that makes the issue
> go away, and doesn't create new problems, would probably be
> acceptable.

I saw this one:
  https://lore.kernel.org/all/20230907122234.146449-1-william.xuanziyang@huawei.com/


Takashi
