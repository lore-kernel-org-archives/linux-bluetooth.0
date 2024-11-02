Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACF6155741;
	Sat,  2 Nov 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730541829; cv=none; b=j8X+2DL497/pMLxWDkXbx2q//68a3eX1q5eVCU1Hl8vZPA8J0fyEGh1RCNsSDGxmOhDQiMaiI7w0AchQth0PBEqVLhew/j6RDNpAeHZ0ZTzRMHaOIy06XV4kSle9m31kXC5t1vmXkQinqPeR+R3xqSG4p/DDRX5FmJl4lgt35ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730541829; c=relaxed/simple;
	bh=WmFFnHOct1TeZ88vTW4FtRL9RIxbjE5sxscFW0PrKEg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHwB22ilNrIIrIXNzBgjhwmcEEPAEqRBSK341yANtwKuuBk6WHtwdAy+3k9aSuqb7TQfW0czEhr0MgAHDEwkqudkHbnTurG4Soc+gLwGc61hMptBoJ7KzVG8fChwbPkEEjh0WfI+9Xt7ayjeLXfheIiUJezxcu1o3y4ryrA8cfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc0I4KFn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zlo3DVH5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Sc0I4KFn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zlo3DVH5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc0I4KFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zlo3DVH5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Sc0I4KFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zlo3DVH5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6C0E51FD6E;
	Sat,  2 Nov 2024 10:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730541818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlrrDKSmrt84Ub04+c8ECDKmobuqTwGP3c5wB+QEuek=;
	b=Sc0I4KFnkfq2son4OlEK51N1FvGprCvyqT40p+dgXi4XiZqpVQ009TgHWF7lQIpH6iJYGh
	xKYRCfb4O42ZET87nXxgnwBmUKZi3WujYOfkwszcyF955AlmqDqfChlimOEzP15VVxXz96
	akaZnJsVpi6pyulOJjwNpyKT50zxMyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730541818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlrrDKSmrt84Ub04+c8ECDKmobuqTwGP3c5wB+QEuek=;
	b=Zlo3DVH5vkZ+2W/2od1HmLvgLnrVDitE8sNDOUO/W4qYQAr/4Fb7nflm7g2i+l4AEeAClT
	1UKn7mSOgPWj23DA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Sc0I4KFn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zlo3DVH5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730541818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlrrDKSmrt84Ub04+c8ECDKmobuqTwGP3c5wB+QEuek=;
	b=Sc0I4KFnkfq2son4OlEK51N1FvGprCvyqT40p+dgXi4XiZqpVQ009TgHWF7lQIpH6iJYGh
	xKYRCfb4O42ZET87nXxgnwBmUKZi3WujYOfkwszcyF955AlmqDqfChlimOEzP15VVxXz96
	akaZnJsVpi6pyulOJjwNpyKT50zxMyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730541818;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlrrDKSmrt84Ub04+c8ECDKmobuqTwGP3c5wB+QEuek=;
	b=Zlo3DVH5vkZ+2W/2od1HmLvgLnrVDitE8sNDOUO/W4qYQAr/4Fb7nflm7g2i+l4AEeAClT
	1UKn7mSOgPWj23DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EBC3D13736;
	Sat,  2 Nov 2024 10:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yoFJOPn4JWflDQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 02 Nov 2024 10:03:37 +0000
Date: Sat, 02 Nov 2024 11:04:42 +0100
Message-ID: <87ttcqt0hx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,	"tiwai@suse.de"
 <tiwai@suse.de>,	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	=?EUC-KR?B?IkRlcmVuIFd1ICjZ69Ps7NIpIg==?= <Deren.Wu@mediatek.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,	=?ISO-2022-JP?B?IlN0?=
 =?ISO-2022-JP?B?ZXZlIExlZSAoGyRCTXs7a0A/GyhCKSI=?=
 <steve.lee@mediatek.com>,	"marc.payne@mdpsys.co.uk"
 <marc.payne@mdpsys.co.uk>,	Sean Wang <Sean.Wang@mediatek.com>,
	=?ISO-2022-JP?B?IkFhcm9uIEhvdSAoGyRCOHQ9UzZEGyhCKSI=?=
 <Aaron.Hou@mediatek.com>,	=?ISO-2022-JP?B?IkNocmlzIEx1ICgbJEJOJkNVGyhC?=
 =?ISO-2022-JP?B?GyRCXXcbKEIpIg==?= <Chris.Lu@mediatek.com>,
	=?ISO-2022-JP?B?IkhhbyBRaW4gKBskQj9BOUAbKEIpIg==?= <Hao.Qin@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
In-Reply-To: <643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
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
	<87iktk4d9l.wl-tiwai@suse.de>
	<75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
	<d0f70e662f5e9329cff43f92a5c191601cc599f1.camel@mediatek.com>
	<0a988691-8c18-4dca-ac78-94e36a9b8b37@leemhuis.info>
	<f3c6f6f857d19c867941c86c644042fa195621ac.camel@mediatek.com>
	<643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-2022-JP
X-Rspamd-Queue-Id: 6C0E51FD6E
X-Spam-Score: -2.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,holtmann.org,lists.infradead.org,vger.kernel.org,mediatek.com,lists.linux.dev,mdpsys.co.uk];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 01 Nov 2024 15:22:13 +0100,
Thorsten Leemhuis wrote:
> 
> Hi. Top-posting for once, to make this easily accessible to everyone.
> 
> Thx for the insights, but it feels like this is not the complete story.
> From Takashi's mail earlier in the thread it appears to me that there is
> a regression that the patch at the start of the thread fixes:
> https://lore.kernel.org/all/87iktk4d9l.wl-tiwai@suse.de/
> 
> So it appears to me (please correct me if I'm wrong, which I might be)
> there is some regression that must be fixed independently of any
> firmware changes; not sure, maybe it's a different regression that the
> one Marc saw.

That's hard to judge, unfortunately.  The only fact is that 6.11 and
6.12-rc are still buggy and fail to boot due to the kernel Oops from
Mediatek BT stuff.  The patch
  https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/
seems working around it, but it doesn't mean that this is the right
fix, either.

My wild guess is that there are substantial problems at btmtk stuff
about the firmware management.  It blocks unbinding if something goes
wrong, and this bug surfaced casually due to another change.

> I just don't know what's the best way forward to resolve the regresson.
> A revert of the culprit? The patch at the start of this thread?
> Something else?

Either a revert of the firmware or the patch that triggered the issue
would be helpful as a temporary workaround, yes.  We need a quick
duct-tape coverage, then fix the fundamental failure.

> Takashi, Luiz, can you help me out here? I guess I otherwise soon will
> have to involve higher level maintainers to sort this out (e.g. the -net
> maintainers and/or Linus).

I can build a test kernel and ask the reporter for testing if once
something is provided, of course.  Just ping me.


thanks,

Takashi

> 
> Ciao, Thorsten
> 
> On 01.11.24 08:11, Chris Lu (陸稚泓) wrote:
> > Hi Thorsten,
> > 
> > On Wed, 2024-10-30 at 12:29 +0100, Thorsten Leemhuis wrote:
> >> External email : Please do not click links or open attachments until
> >> you have verified the sender or the content.
> >> 
> >> 
> >> On 30.10.24 12:03, Chris Lu (陸稚泓) wrote:
> >> > 
> >> > Let me recap and update the status of this problem.
> >> 
> >> Many thx!
> >> 
> >> > Marc feedback that he has some problem with MT7921AUN usb module.
> >> > Originally, we thought it was caused by the change "Fixes:
> >> > ccfc8948d7e4d9 ("Bluetooth: btusb: mediatek: reset the controller
> >> > before downloading the fw")". The change is mainly for MT7922, we
> >> > found some problem with MT7921 on specific platform internally. As
> >> > a result, Hao sent another patch to remove MT7921 from that
> >> > rule(Bluetooth: btmtk: Remove resetting mt7921 before downloading
> >> > the fw).
> >> > 
> >> > However, Marc also mentioned that BT is able to work if changing
> >> > back
> >> > to an old firmware bin. Based on the clue, we found it was caused
> >> > by a
> >> > firmware change that specific MT7921 model will not able to setup
> >> > successfully. (In fact, we didn't expect that MT7921AUN can be get
> >> > by
> >> > normal user.)
> >> > 
> >> > Since we can't predict which model user use and Luiz also suggests
> >> > MediaTek to fix it if that model can work before, we have prepared
> >> > a
> >> > solution. I've verified the solution locally that MT7921AUN model
> >> > can
> >> > work normally on Ubuntu PC. It will be a firmware modification. We
> >> > plan
> >> > to submit new firmware with this modification in 2024 Nov.
> >> 
> >> Great, but due to the kernel's "no regressions" rule this is mostly
> >> irrelevant, as the regression must be fixed in a way that does not
> >> require users to change their firmware.
> >> 
> > 
> > Marc's module(MT7921AUN) is not working is due to a change in specific
> > firmware uploaded last year and we plan to revert that in the next
> > firmware release. Since it's related to controller's behavior, it's
> > quite hard to cover in software side.
> > Additionally, MT7921AUN is an external usb dongle. MediaTek official PC
> > project doesn't use this type of MT7921 model. We uses another type for
> > PC projects that it can be guaranteed bluetooth works normally with any
> > firmware we upload to Kernel. As a result, we believe the impact is
> > minimal to general user.
> > 
> >> So is any such solution in sight? Or should we just revert
> >> ccfc8948d7e4d9 and any related follow up patches for now? Or would
> >> that
> >> just cause regressions for other users?
> >> 
> > 
> > Actually, it's not related to ccfc8948d7e4d9 which make bluetooth can't
> > setup normally if using MT7921AUN model + mismatched firmware. We
> > thought it was the same issue in the beginning, but it's not eventually
> > after getting more and more clue/logs.
> > I think we can keep the change because it's necessary to the change
> > submitter-Hao's project.
> > 
> > Chris Lu
> > 
> >> Ciao, Thorsten
> >> 
> >> > On Wed, 2024-10-30 at 10:21 +0100, Thorsten Leemhuis wrote:
> >> > > External email : Please do not click links or open attachments
> >> > > until
> >> > > you have verified the sender or the content.
> >> > > 
> >> > > 
> >> > > Hi, Thorsten here, the Linux kernel's regression tracker. Top-
> >> > > posting
> >> > > for once, to make this easily accessible to everyone.
> >> > > 
> >> > > I'm a bit lost here, but maybe I'm missing something.
> >> > > 
> >> > > Luiz, can you help out here? Is there a reason why this patch is
> >> > > not
> >> > > making any process?
> >> > > 
> >> > > Chris Lu and/or Hao Qin: Can you maybe help out as well as well
> >> > > and
> >> > > help
> >> > > with resolving some open questions that might or might not be
> >> > > relevant
> >> > > (see below).
> >> > > 
> >> > > From Takashi reply, the bugzilla ticket he linked to, and the
> >> > > mail
> >> > > from
> >> > > the MediaTek folks
> >> > > (
> >> > > 
> > https://lore.kernel.org/lkml/12a344e25b31ec00fe8b57814d43fcb166e71be5.camel@mediatek.com/
> >> > > ) it from the outside looks like this patch should really be
> >> > > merged
> >> > > rather sooner that later as it fixes regressions for some people.
> >> > > Afaics it should get a "Fixes: ccfc8948d7e4d9 ("Bluetooth: btusb:
> >> > > mediatek: reset the controller before downloading the fw")" tag,
> >> > > as
> >> > > it's
> >> > > afaics that commit that causes the regression that is known since
> >> > > more
> >> > > than three months now
> >> > > (https://lore.kernel.org/all/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/ ).
> >> > > 
> >> > > But note, it seems it does not fix the regression completely
> >> > > according
> >> > > to Marc's testing.
> >> > > https://lore.kernel.org/all/ZuCB98DSdtKCgxaL@mdpsys.co.uk/
> >> > > 
> >> > > Marc: Is that still how things are with current mainline?
> >> > > 
> >> > > Ciao, Thorsten
> >> > > 
> >> > > 
> >> > > On 22.10.24 12:56, Takashi Iwai wrote:
> >> > > > On Mon, 14 Oct 2024 11:29:40 +0200,
> >> > > > Linux regression tracking (Thorsten Leemhuis) wrote:
> >> > > > > 
> >> > > > > On 20.09.24 08:27, Chris Lu (陸稚泓) wrote:
> >> > > > > > On Thu, 2024-09-19 at 23:25 +0100, marc.payne@mdpsys.co.uk
> >> > > > > > wrote:
> >> > > > > > > 
> >> > > > > > > External email : Please do not click links or open
> >> > > > > > > attachments until
> >> > > > > > > you have verified the sender or the content.
> >> > > > > > >  Hi Chris and Luiz,
> >> > > > > > > 
> >> > > > > > > What were your thoughts on the findings in my email dated
> >> > > > > > > 18th
> >> > > > > > > September?
> >> > > > > > 
> >> > > > > > Thanks for your suggestion.
> >> > > > > > 
> >> > > > > > I've prepared the same environment (Kernel v6.11 +
> >> > > > > > MT7921AUN
> >> > > > > > dongle) to
> >> > > > > > reproduce the issue, collected necessary logs locally and
> >> > > > > > also
> >> > > > > > initiated an internal discussion to clarify the root cause
> >> > > > > > of
> >> > > > > > this
> >> > > > > > symptom. We'll review the changes between two firmware
> >> > > > > > (20230526/20231109) if it's a bug or not.
> >> > > > > > 
> >> > > > > > It may take some time to investigate. I'll let you know if
> >> > > > > > there is any
> >> > > > > > progress.
> >> > > > > 
> >> > > > > Just wondering: Chris Lu, and Marc, what's the status here?
> >> > > > > From
> >> > > > > here it
> >> > > > > looks like there was no progress to fix this regression for a
> >> > > > > while, but
> >> > > > > it's easy to miss something, that's why I ask.
> >> > > > > 
> >> > > > > Ciao, Thorsten
> >> > > > 
> >> > > > FWIW, the similar bug was reported for the recent 6.11.x kernel
> >> > > > on
> >> > > > openSUSE Tumbleweed, and this patch was confirmed to work
> >> > > > around
> >> > > > the
> >> > > > crash at boot:
> >> > > > 
> >> > > > 
> > https://urldefense.com/v3/__https://bugzilla.suse.com/show_bug.cgi?id=1231599__;!!CTRNKA9wMg0ARbw!jYyH2oubBEtIKXmKl9cI2rrmK-7kSdaiIJQ8xH4NZa5i5YCTQDHaoOxCBhMgdAAY6ROIPAoPwbOV-LNeMRJBlR6u-As$
> >> > > > 
> >> > > > It'd be great if you can go ahead and merge the proper fix to
> >> > > > the
> >> > > > upstream.
> >> > > > 
> >> > > > Let me know if you have another patch to test.  Then I can
> >> > > > create a
> >> > > > test kernel package and ask the bug reporter for testing.
> >> > > > 
> >> > > > 
> >> > > > thanks,
> >> > > > 
> >> > > > Takashi
> >> > > > 
> >> > > 
> >> > > 
> >> > 
> >> > ************* MEDIATEK Confidentiality Notice ********************
> >> > The information contained in this e-mail message (including any
> >> > attachments) may be confidential, proprietary, privileged, or
> >> > otherwise
> >> > exempt from disclosure under applicable laws. It is intended to be
> >> > conveyed only to the designated recipient(s). Any use,
> >> > dissemination,
> >> > distribution, printing, retaining or copying of this e-mail
> >> > (including its
> >> > attachments) by unintended recipient(s) is strictly prohibited and
> >> > may
> >> > be unlawful. If you are not an intended recipient of this e-mail,
> >> > or believe
> >> > that you have received this e-mail in error, please notify the
> >> > sender
> >> > immediately (by replying to this e-mail), delete any and all copies
> >> > of
> >> > this e-mail (including any attachments) from your system, and do
> >> > not
> >> > disclose the content of this e-mail to any other person. Thank you!
> >> > 
> >> 
> >> 
> > 
> > ************* MEDIATEK Confidentiality Notice
> >  ********************
> > The information contained in this e-mail message (including any 
> > attachments) may be confidential, proprietary, privileged, or otherwise
> > exempt from disclosure under applicable laws. It is intended to be 
> > conveyed only to the designated recipient(s). Any use, dissemination, 
> > distribution, printing, retaining or copying of this e-mail (including its 
> > attachments) by unintended recipient(s) is strictly prohibited and may 
> > be unlawful. If you are not an intended recipient of this e-mail, or believe
> >  
> > that you have received this e-mail in error, please notify the sender 
> > immediately (by replying to this e-mail), delete any and all copies of 
> > this e-mail (including any attachments) from your system, and do not
> > disclose the content of this e-mail to any other person. Thank you!
> > 
> 
