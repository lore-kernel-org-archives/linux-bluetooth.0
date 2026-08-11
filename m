Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442E330D2A
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786481013; cv=none; b=n1lDqKXuRjsmXpp6C6me5beULLgSyrNjIqFUQuc3c7EN6wovq7fwzy6Ce7Up7UjWcm3e/fUltCofxsZADX306qLfqbMbW3hDMk12gvcx1JGuD6U8Ieaz9xDW/4+F2pjX+ISm6BUXtP3osgM7z9aGFioQgbm8h/8CyTDQbnd2wNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786481013; c=relaxed/simple;
	bh=tXesJWjeF5uCbVGx+ELyY76HyXUcJVX75wTZD9muvYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK794eo5ZUlRZWy1s0iXU33ePts6PIeToIBLLZZFBp4XRhNs+26vFstPOll0tKC93nv9+rwtTbFjvpO+/fzGt2DoWFS1YRTbm6zN9KX9DlL3EWMkPw6xfpN6q8BikODKO/C5bEw1vCIe0eSW/TWqqxIl8N8SdvH7HGkX4kbxuXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXzEcNVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXzEcNVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B824F1F000E9;
	Tue, 11 Aug 2026 20:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786481011;
	bh=QNGAXvdq6ATKvNxtqQtI2n758q2trxqJ6k9AjfbzSzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YXzEcNVaxCPp3ZSUwdL4KpJy0rWVITH0RK3OUJiPc1cyjG9WQCTjZCVKTYWTqKMB0
	 KlpMmMcahnFTZPIk2U0krX3c/rbsdlc175N+k7csusbdxOH2GXPNtgZ8gvRkr59C+r
	 YD9H7rOa5p3UwY1gNi7F0pz7UXZ1GYXzh42/aEWvhCM4PkKbSknQek4s6yFDQld+F8
	 lRoKm0nwmtVcIyjFoSmyWnJ5qu8ZELBP86xCG1LN9vv0AVDMBmG40p+iXMBR4VG7ME
	 Kivyc/QLM0FB4EQD8qru56IB+zbmOJK4fL4z4+rM8MyhUVIFR4KWR27f5kl9fZ7o6/
	 48mY5OaH6lzbg==
Date: Tue, 11 Aug 2026 13:43:27 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: add conditional locking annotations
Message-ID: <20260811204327.GA1477601@ax162>
References: <528c354dca68f05cfd17df7c80f8b04419c0fb74.1784973709.git.pav@iki.fi>
 <20260731221840.GA4066390@ax162>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731221840.GA4066390@ax162>

On Fri, Jul 31, 2026 at 03:18:45PM -0700, Nathan Chancellor wrote:
> On Sat, Jul 25, 2026 at 01:02:36PM +0300, Pauli Virtanen wrote:
> > Add context analysis annotations to functions doing conditional locking,
> > to suppress analysis warnings.
> > 
> > Fixes: a3ad01d51d4b ("Bluetooth: hci_sync: Fix advertising data UAFs")
> > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org> # build
> 
> It would be nice if this could be applied, as this breaks recent clang
> builds due to context analysis being on by default and -Werror enabled
> by default with many configurations now:
> 
>   https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/30660246388

Ping? Our builds with clang-23 and clang-24 continue to be broken on
-next because of this.

  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/31525203557
  https://github.com/ClangBuiltLinux/continuous-integration2/actions/runs/31526633508

> > ---
> >  net/bluetooth/hci_sync.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index d5554fbf3129..f5545f270f09 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -1255,6 +1255,7 @@ hci_set_ext_adv_params_sync(struct hci_dev *hdev, u8 instance,
> >  }
> >  
> >  static int hci_set_ext_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_ext_adv_data, pdu, data, length,
> >  		    HCI_MAX_EXT_AD_LENGTH);
> > @@ -1343,6 +1344,7 @@ int hci_update_adv_data_sync(struct hci_dev *hdev, u8 instance)
> >  }
> >  
> >  int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	struct hci_cp_le_set_ext_adv_params cp;
> >  	struct hci_rp_le_set_ext_adv_params rp;
> > @@ -1499,6 +1501,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
> >  }
> >  
> >  static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_ext_scan_rsp_data, pdu, data, length,
> >  		    HCI_MAX_EXT_AD_LENGTH);
> > @@ -1552,6 +1555,7 @@ static int hci_set_ext_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
> >  }
> >  
> >  static int __hci_set_scan_rsp_data_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	struct hci_cp_le_set_scan_rsp_data cp;
> >  	u8 len;
> > @@ -1693,6 +1697,7 @@ static int hci_set_per_adv_params_sync(struct hci_dev *hdev, u8 instance,
> >  }
> >  
> >  static int hci_set_per_adv_data_sync(struct hci_dev *hdev, u8 instance)
> > +	__context_unsafe(/* conditional locking */)
> >  {
> >  	DEFINE_FLEX(struct hci_cp_le_set_per_adv_data, pdu, data, length,
> >  		    HCI_MAX_PER_AD_LENGTH);
> > -- 
> > 2.55.0
> > 

-- 
Cheers,
Nathan
