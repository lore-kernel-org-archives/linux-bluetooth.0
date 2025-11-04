Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322E2773C6
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 11:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254388; cv=none; b=fj9ntYcPJ4Iq9QLQ505iRpsoTv/gCKGGjuGykROg5MwkwXbvPmaM0T4L7jnif4AWhtYKcz51QLYD02skE3bcLH1Fk3KXOE25fw1MQZu7cYkxNFbhLoG58UbdYySelZXoSzrQCAchNF3iRsRS5t8uhOevsCG8bRD5lRx1pQWDkxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254388; c=relaxed/simple;
	bh=UcWiyHsJB2Kz5U+kpvC5q7i9YCuZeiYmXezgsAICK5I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g93QUUfzlt3o7PcltvFbjkri3JZh/yXw3GViJcWfSpmHsmNyHvtQZeF2rhjAomuGaoHx1Gpqzv4cSYjDcs+OGg4zeCyEaCnqHynr7jwHI0EPMKDng7YFUVt7U1jUTi682nS3KB3HSCjrxR4nxezOrTKU2wwL/bKEX2RFFq+ChbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dkNm3JJf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yoHw74H; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dkNm3JJf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/yoHw74H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dkNm3JJf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/yoHw74H";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dkNm3JJf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/yoHw74H"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2484A211A2;
	Tue,  4 Nov 2025 11:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762254385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+1w8v93M1maIude84/kjRuohQ/pOk2oTDPQmPP4h1U=;
	b=dkNm3JJfq+Kee5/rpJNwXLRmwDmfR+2NEn4VhAnuIiyT2P8FHk6ojPY/t2TxX7eM/LhfVJ
	fkDrGaN+41eQMNijJMnGl3kNMj6Rn64pduC81lTgk/ZauTjedZWnHmBT1mDng3lp7gDjUr
	lKCw6g6B0PzND6CiPDV64akftQnqfKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762254385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+1w8v93M1maIude84/kjRuohQ/pOk2oTDPQmPP4h1U=;
	b=/yoHw74HeESJTKOlvdXHAUAqs7qhUZqRFrDNTvUrY+FLRKNokXgHY/FXD5/Wl21j3dOn+V
	4AOa/ytJPQpPOwBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762254385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+1w8v93M1maIude84/kjRuohQ/pOk2oTDPQmPP4h1U=;
	b=dkNm3JJfq+Kee5/rpJNwXLRmwDmfR+2NEn4VhAnuIiyT2P8FHk6ojPY/t2TxX7eM/LhfVJ
	fkDrGaN+41eQMNijJMnGl3kNMj6Rn64pduC81lTgk/ZauTjedZWnHmBT1mDng3lp7gDjUr
	lKCw6g6B0PzND6CiPDV64akftQnqfKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762254385;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T+1w8v93M1maIude84/kjRuohQ/pOk2oTDPQmPP4h1U=;
	b=/yoHw74HeESJTKOlvdXHAUAqs7qhUZqRFrDNTvUrY+FLRKNokXgHY/FXD5/Wl21j3dOn+V
	4AOa/ytJPQpPOwBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E540C139A9;
	Tue,  4 Nov 2025 11:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j0yPNjDeCWlefQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Nov 2025 11:06:24 +0000
Date: Tue, 04 Nov 2025 12:06:24 +0100
Message-ID: <87wm46giq7.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: add min_mute quirk for SteelSeries Arctis
In-Reply-To: <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
References: <a83f2694b1f8c37e4667a3cf057ffdc408b0f70d.1762108507.git.pav@iki.fi>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Sun, 02 Nov 2025 20:10:15 +0100,
Pauli Virtanen wrote:
> 
> ID 1038:1294 SteelSeries ApS Arctis Pro Wireless
> is reported to have muted min playback volume. Apply quirk for that.
> 
> Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/4229#note_3174448
> Signed-off-by: Pauli Virtanen <pav@iki.fi>

Thanks, applied now.


Takashi
