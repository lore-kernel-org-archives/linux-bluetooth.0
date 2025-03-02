Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E105661
	for <linux-bluetooth@vger.kernel.org>; Sun,  2 Mar 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740909430; cv=none; b=OW/qVP2p5NbMXvD50HrAtj2bvjZsHNvmESg+gFgfWhEeC8FAyQFqveSZ1sSV8wpZ8tWdX+dlH1sKtrFsXsGC5+8zH7cjmnVzo6RmBBy7nfezDS+IwQ5IMmS/YIGCX9SW343yM4VFXbizM6RZExAxgCj98NujTWSVICjF/aNzaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740909430; c=relaxed/simple;
	bh=F2bSlXgEgNakqQ1JWbxDZXpZvYe3wC7021/9+BWfo1s=;
	h=Date:Message-ID:From:To:Cc:MIME-Version:Content-Type; b=enGEqdJoC7blYIodb4+9urj92bnfZzdJjF6iZXklbzW7GmYD5xeW2z3JhF228FffwRBqFIljn9ToGkI9hNNgNrKPtNqT5n5s6BA+2dJoAn50XgjkKtno7TbFKZxDTtoaMdKto+zUm20oDWxPnkdlCEhFNVXuDtB/DVA4nbccOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dGxCWBZO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SoaP6W6X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dGxCWBZO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SoaP6W6X; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dGxCWBZO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SoaP6W6X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dGxCWBZO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SoaP6W6X"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C3E9D1F393;
	Sun,  2 Mar 2025 09:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740909426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UU4kSuYr0BBp7PcHBL0L87SvV39sRhs0XIg+qJ9I6rI=;
	b=dGxCWBZOyHgeyMXCcpYgirklgKFK5Jg31CjQR+tkWsDsySUKYQ7GL0gCbm5yIhosxF4xZq
	pvOJI9ojaEQ1eNUOFEvOAZG0XOoE5yWIkaJdIFep6EvZ4FevpShHlLT1+gyd/+IQq8SRSB
	tAq+IqdqSDQNOzy8YuVkASVNGnA55xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740909426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UU4kSuYr0BBp7PcHBL0L87SvV39sRhs0XIg+qJ9I6rI=;
	b=SoaP6W6XpDnHyl1Z/IIxCcfGwucSjs070iPK5rpUv2o/ygQdDrnhMkegwZ6zzByf45oqfy
	bRkmhIcmGJxAYCBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740909426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UU4kSuYr0BBp7PcHBL0L87SvV39sRhs0XIg+qJ9I6rI=;
	b=dGxCWBZOyHgeyMXCcpYgirklgKFK5Jg31CjQR+tkWsDsySUKYQ7GL0gCbm5yIhosxF4xZq
	pvOJI9ojaEQ1eNUOFEvOAZG0XOoE5yWIkaJdIFep6EvZ4FevpShHlLT1+gyd/+IQq8SRSB
	tAq+IqdqSDQNOzy8YuVkASVNGnA55xs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740909426;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=UU4kSuYr0BBp7PcHBL0L87SvV39sRhs0XIg+qJ9I6rI=;
	b=SoaP6W6XpDnHyl1Z/IIxCcfGwucSjs070iPK5rpUv2o/ygQdDrnhMkegwZ6zzByf45oqfy
	bRkmhIcmGJxAYCBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9743B1395B;
	Sun,  2 Mar 2025 09:57:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /Yt+InIrxGc1CgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 02 Mar 2025 09:57:06 +0000
Date: Sun, 02 Mar 2025 10:57:06 +0100
Message-ID: <87cyezah71.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: linux-bluetooth@vger.kernel.org,
    linux-kernel@vger.kernel.org
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MISSING_SUBJECT(2.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 

Hi Luiz,

due to the CVE assignment, I stumbled on the recent fix for BT
hci_core, the commit 4d94f0555827 ("Bluetooth: hci_core: Fix sleeping
function called from invalid context"), and wonder whether it's really
safe.

As already asked question at the patch review:
  https://patchwork.kernel.org/comment/26147087/
the code allows the callbacks to be called even after
hci_unregister_cb() returns.

Your assumption was that it's never called without the module removal,
but isn't hci_unregister_cb() also called from iso_exit() which can be
triggered via set_iso_socket_func() in mgmt.c?  Also, any 3rd party
module could call hci_unregister_cb() in a wild way, too -- even if
the function still remains, it doesn't mean that you can call it
safely if the caller already assumes it being unregistered.

In addition to that, I feel what the patch does as a bit too
heavy-lifting: it does kmalloc() and copy the whole hci_cb object,
which isn't quite small for each.  If the callback is still safe to
call after RCU protection, you may just keep the hci_cb pointer
instead of copying the whole content, too?

I couldn't find v1 patch in the patchwork, so not sure whether this
has been already discussed.  If so, let me know.


Thanks!

Takashi
