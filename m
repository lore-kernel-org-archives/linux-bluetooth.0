Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1C4653A;
	Wed,  7 Aug 2024 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055694; cv=pass; b=AukP5S08MrJyqGNWKtOJsQwbptpUm+VV4gRNMshSfSSGMKMOZbKfqGQ2z4li9OKGCd6t6ht76SjQEJ+9s+rjYtbDew5cIHIYGvwtLafc9r8kqpsLXQZLJ+UptGs2nyX2OgCh3GJRdZD/TIvEMGtY590tlSZwmJEMMDS1kmGjwO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055694; c=relaxed/simple;
	bh=7CPrCPyCvu9hOYvUuJfwJyfglEWK7ECEaKNeYL08raQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPMFowtzyEdwhz0AiVo5d4XQMZzjsDz5O8r1P7DfS7PTkOrCLwLCtczxKtjiymqQ92E3DZWhJkvzaV4XAWXEvQzxc21JMBuvRsWXhShL7ISvh5/y2aDx6NGCmYTIJkq8Ww+JpBK4O7hctFDYQqRgtKjiEzl2yW9YqdrWH60jZxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=JVsIirB4; arc=pass smtp.client-ip=136.143.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="JVsIirB4"
ARC-Seal: i=1; a=rsa-sha256; t=1723055683; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FAtws9c1nxJmLRqOR2TibflYOpj2ERAviXeqSlUmYVArM0nbv2aRNfh9DutL7y2o2A7d8l1NAzr+djGUZTqbfgiNy3dpKMWdtRLDg3LVzn7Am3vSWfj1HKXrn+A7lQHBLDYkBstOiU9C4KIfUr8YpAPk99aF5M5374ODRxoI8s0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723055683; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kM62/z2qYeVqQKmIbUyDUVJPGPEXspmQtFXBCXxN16g=; 
	b=f8G56NPJmd8JT8Ix93f7PkdQHt0hDfPfYXlfCR7IHpWQCBU+klIff5FTssTW70OvJy2oyn31mjqGc4qJRTmETRcvtdVvEDrxi/jARzvcD/XK0jv6S3PDR+XmOxCw9DFPWBd43+M/Xk39J9OLaeAlbu7ri7UL6Aed2UB577xsBjw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723055683;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=kM62/z2qYeVqQKmIbUyDUVJPGPEXspmQtFXBCXxN16g=;
	b=JVsIirB4uqsMsYXDNKdxEhz4Kh6VXT7mduUY41rTAx4pbX0Kzqf5amN5Qz5EevA2
	AiopsCUrVLXGDnRr3f8keEijwPqJ+x4Tl+AnBaay3yLgZgQYU3w+K0Ihzz364umvEqM
	zouBISzLPrP3jHaJ3zO2PeXhDbsPPxd4w8DperFc=
Received: by mx.zohomail.com with SMTPS id 1723055682371358.71224001733015;
	Wed, 7 Aug 2024 11:34:42 -0700 (PDT)
Date: Wed, 7 Aug 2024 14:34:39 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Wren Turkal <wt@penguintechs.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] Bluetooth: hci_qca: fix a NULL-pointer derefence at
 shutdown
Message-ID: <54aba883-e0d7-4eaf-a9a8-72e37c120ef8@notapiano>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-3-59dad830b243@linaro.org>
 <1723fdc3-33b9-4518-8f25-161ab59ecf21@notapiano>
 <CAMRc=MdSH6n=QKwWnT9zNaBito34t+BpCufQDjnAOaeC5iuD+Q@mail.gmail.com>
 <CABBYNZ+1XpSDvt41zEYYQ4AraCucOM7FDSVhhkGNsCgr9-hc6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZ+1XpSDvt41zEYYQ4AraCucOM7FDSVhhkGNsCgr9-hc6g@mail.gmail.com>
X-ZohoMailClient: External

On Wed, Aug 07, 2024 at 11:03:09AM -0400, Luiz Augusto von Dentz wrote:
> Hi Bartosz, Nicolas,
> 
> On Wed, Aug 7, 2024 at 3:53 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > On Wed, Aug 7, 2024 at 12:44 AM Nícolas F. R. A. Prado
> > <nfraprado@collabora.com> wrote:
> > >
> > > On Wed, Jul 31, 2024 at 05:20:50PM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Unlike qca_regulator_init(), qca_power_shutdown() may be called for
> > > > QCA_ROME which does not have qcadev->bt_power assigned. Add a
> > > > NULL-pointer check before dereferencing the struct qca_power pointer.
> > > >
> > > > Fixes: eba1718717b0 ("Bluetooth: hci_qca: make pwrseq calls the default if available")
> > > > Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > Closes: https://lore.kernel.org/linux-bluetooth/su3wp6s44hrxf4ijvsdfzbvv4unu4ycb7kkvwbx6ltdafkldir@4g7ydqm2ap5j/
> > > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Hi,
> > >
> > > I just noticed we're still hitting this issue in mainline (saw it on the
> > > mt8183-juniper platform in KernelCI). I see this commit was merged 6 days ago to
> > > bluetooth-next, but it seems there wasn't a pull request with this fix yet to
> > > include it in 6.11. I'm wondering if it's still going to be sent.
> > >
> > > Thanks,
> > > Nícolas
> >
> > The patches are in next so I don't see why they wouldn't be sent upstream.
> >
> > Moving Luiz and Marcel to To: to make sure they see this message.
> 
> I was on a business trip last week, will prepare the pull request later today.

Sounds good. And sorry for bothering you about this, I just wanted to make sure
the fix was headed to 6.11.

Thanks,
Nícolas
