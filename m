Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C162D47DF8F;
	Wed,  8 Jul 2026 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520466; cv=none; b=u1oeejbtA6RAqpeAKLV0hS/b7s5Y/zPMyI27/BmPp1yuQdfN6YOgcgmnWOFzQfBHpSJsQuDdN/4wesi//qmtTqvCn19VgjN73cuTr4xupNZ6fjDDARF0JB88Hn/B0hNc+A8wg/xusMc4fFHgmyl5j3RIouxLClF8rz8p2/o9G6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520466; c=relaxed/simple;
	bh=I56/eEicbP7fe/QzgOjmFSGKRPmrtufT7a9OsZ7BQNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSqva4t0tUXs8gmAHnyozG+wsx6t/tjXmH5KXlKWMr7IjNf+kEMzGnaPymhVig6H2qdWHoJuURcZUzSQafRlVby2CqHiBRHd0bNQShjHyFscmnrJO3t8EcIFGtqxJG93GfCIfnGKBnaPuCqp98Tsk/CTTcek891DmSSyWi0lK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/5uuNrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/5uuNrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3721F000E9;
	Wed,  8 Jul 2026 14:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783520465;
	bh=Jy7EdWx9a334B9Ln7eoLzGFbJc7c7LSucaiMWWc4wf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d/5uuNrQHw9HfmSzZw27sput1HOJjCK+xE4OXOkJBWsWea/jFkpzGa/UpkY+W4a6k
	 wWGFz4IEOYRJRcuMq1T5Hmik/zg1LXMLEVepY+wFQMIQvBdhElvea/aUawFzXr/UYT
	 O66o8q3shaxZ8xJ5M0quH7StPHf6zgwx2qLq5jCUJYLkCMB/biZhieClSYcyqe2ML+
	 xd6blfgUkI7GnpRDl99l9ao3lopY6hykXtNTQaSRNPumFyRM3H2S6txWyJPbRUI3hv
	 db8RG0z6ETvQAGM3UkLHTncbbgpZ1nk2QoblFz/pmaRfMZpqPcLR1t7HO9Rz6JFSDL
	 hV9kcZHXLVBNQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1whT94-000000035wx-39se;
	Wed, 08 Jul 2026 16:21:02 +0200
Date: Wed, 8 Jul 2026 16:21:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow
 in TLV parser
Message-ID: <ak5czs34RMdBhPkP@hovoldconsulting.com>
References: <20260704231030.996390-1-xmei5@asu.edu>
 <akomrM-h521h6M0i@hovoldconsulting.com>
 <CAPpSM+Sph2Drdv_HxKTkfkHP-qDPqrRHYQ9eaOhJ5YGE-5cKYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPpSM+Sph2Drdv_HxKTkfkHP-qDPqrRHYQ9eaOhJ5YGE-5cKYQ@mail.gmail.com>

On Tue, Jul 07, 2026 at 10:55:23AM -0700, Xiang Mei wrote:
> On Sun, Jul 5, 2026 at 2:41 AM Johan Hovold <johan@kernel.org> wrote:
> > On Sat, Jul 04, 2026 at 04:10:30PM -0700, Xiang Mei wrote:

> > > The loop body
> > > then reads a 12-byte struct tlv_type_nvm past the end of the short
> > > vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).
> >
> > No, only four bytes are read before the loop exits without any further
> > consequences due to the following check:

> Thanks Johan, and you're right. Only the 2-byte tag_id (and at most
> the 4 bytes of tag_id/tag_len) is read out of bounds. This commit
> message overstated the impact, and I should have caught that.
> 
> Unfortunately, the bot merged this patch when I was preparing the v2
> this morning. If you think the inaccurate commit message is worth
> fixing on record, I can send a follow-up to the maintainers to correct
> the message

It was Luiz who applied the patch -- perhaps he did not notice my
conditional Reviewed-by tag.

I assume the Bluetooth tree is not rebased so I don't think there's
anything that can be done here and there is no need to send a v2 (unless
Luiz says otherwise).

> > With the commit message fixed you can add my:
> >
> > Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
