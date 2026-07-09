Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0177740D597;
	Thu,  9 Jul 2026 11:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595166; cv=none; b=G58VCxQjIC+Di76xQEX9qJSQnZn1m5acs4UNJvnS1ugIdUtBT6BxARmwufuoIEj9+oWTczknducI7revEUJDL7okqijg0z2T3hVDCnXqRNBpWe7hW/2KgOhHcCSb9KGzn3cYbULFCcSDNv1g94RVKzcdKum9sdXUL6/4em/n9hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595166; c=relaxed/simple;
	bh=L0ggTBIg+L0Zgsb9SaIua+cfUbpNOZLlpQePBd/bpF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0NQ+Kv/3gaJfX3kmcthQRgEHMjo8rXQ2VaHCP7L/lD5ColcTOIDQ2DrVqmVmFMHfpfdRuDWeMDMjmeKyVQHalw/4MZgmNi35QodTmRZw6a/TGceoxHFUXJ2U1QRY4GhccDBbnzft0JjItj5bamLR/C08ZF1+iUn3etLrVp76Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hps1OtM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hps1OtM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B12D1F000E9;
	Thu,  9 Jul 2026 11:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595164;
	bh=QRCOi1d3juindKV8dv250wRxKWzlLL1Iz7KoGGc0b8M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hps1OtM+WQiybTvEwq7SFT/jX5ykgJD968jK72dCf6FGvtq6M0OL9mtqfmZcMdnvF
	 aMjZ7OaD/Wk3fmDNy3PcSIn+vNN+aWPHAufbRLu84JaGgO8Cfpn6UirTXAjwk+HDuJ
	 GjV7pmIJFIEbaDlyg3aMMUu//jdpe2uL2LNfnxXDdtCeQhWCcbeXxAn6CaDfZ/xedt
	 ahVUhAlPPe4jMSsTi5Tbbl8eTGrlfMuN5zDf/67uYVUGkqcoCD+xJmpuBThZEcjaFF
	 XDMUfQWlssU5ykPRHmgjADymUtFiko5/0JG26KafA7tUEC/EwZhGfQDauS71TQfeMv
	 QoImqTQAruQ6g==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1whmZu-00000003WFh-0HXu;
	Thu, 09 Jul 2026 13:06:02 +0200
Date: Thu, 9 Jul 2026 13:06:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Xiang Mei <xmei5@asu.edu>, Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow
 in TLV parser
Message-ID: <ak-AmguTdGpr04dm@hovoldconsulting.com>
References: <20260704231030.996390-1-xmei5@asu.edu>
 <akomrM-h521h6M0i@hovoldconsulting.com>
 <CAPpSM+Sph2Drdv_HxKTkfkHP-qDPqrRHYQ9eaOhJ5YGE-5cKYQ@mail.gmail.com>
 <ak5czs34RMdBhPkP@hovoldconsulting.com>
 <CABBYNZ+gp57kxcXZTLWgd5n19cmDc1Z8TimW0bv7CQLT7khzug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+gp57kxcXZTLWgd5n19cmDc1Z8TimW0bv7CQLT7khzug@mail.gmail.com>

On Wed, Jul 08, 2026 at 11:15:00AM -0400, Luiz Augusto von Dentz wrote:
> On Wed, Jul 8, 2026 at 10:21 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Jul 07, 2026 at 10:55:23AM -0700, Xiang Mei wrote:
> > > On Sun, Jul 5, 2026 at 2:41 AM Johan Hovold <johan@kernel.org> wrote:
> > > > On Sat, Jul 04, 2026 at 04:10:30PM -0700, Xiang Mei wrote:

> > > > > The loop body
> > > > > then reads a 12-byte struct tlv_type_nvm past the end of the short
> > > > > vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).
> > > >
> > > > No, only four bytes are read before the loop exits without any further
> > > > consequences due to the following check:
> >
> > > Thanks Johan, and you're right. Only the 2-byte tag_id (and at most
> > > the 4 bytes of tag_id/tag_len) is read out of bounds. This commit
> > > message overstated the impact, and I should have caught that.
> > >
> > > Unfortunately, the bot merged this patch when I was preparing the v2
> > > this morning. If you think the inaccurate commit message is worth
> > > fixing on record, I can send a follow-up to the maintainers to correct
> > > the message
> >
> > It was Luiz who applied the patch -- perhaps he did not notice my
> > conditional Reviewed-by tag.
> >
> > I assume the Bluetooth tree is not rebased so I don't think there's
> > anything that can be done here and there is no need to send a v2 (unless
> > Luiz says otherwise).
> 
> If only the commit message that needs updating then I guess we don't
> need to worry about if stating something slightly inaccurate.

It's mostly an issue for backporting and determining the impact of the
fix. The commit message as it stands suggests that the bug can result in
memory corruption when it really is just a 4-byte oob read.

And then the inclusion of my tag makes it look like I failed to spot
this during review.

But let's keep it this way this time.

Johan
