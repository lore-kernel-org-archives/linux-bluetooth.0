Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E04154457
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Mar 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743285204; cv=none; b=lhIZTwXcXqWHsxlrZw2k2HT0NYxtVvv/8ZWulEQax3iJ7hDZc+hDj9Bk3F3+lgdXkDP3ekyOGpBeZUaHzIlgUTzWu4cVoSEWNanK4M1EIR7QOUeVo/E/CalyDco/QHGhpmNohNBMRT4+f/JkIimp4WuHXWviqypZ18DKK/tvSx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743285204; c=relaxed/simple;
	bh=yMtHUudoIyJSqh1XgPH/bO/QL4zPSXnMKbqJ0F50+h0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2bWIiAHCQBIGpYW0tzeH82o4KhN8PcLLIB3FT6TOBXGa/Nu1Ca40waX3Y44Od8u0oF9pKy3RdLPyE8d/bMWLQax8o5Rbdq32UGJCOLoQ60Vmu0/u6xiKH0KQq8rmA95eDsC5jwCKFqtljkeDWV2ULTxG4Tm96h5RrR21ixX44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXwJX0qQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXwJX0qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53D3C4CEE2;
	Sat, 29 Mar 2025 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743285203;
	bh=yMtHUudoIyJSqh1XgPH/bO/QL4zPSXnMKbqJ0F50+h0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXwJX0qQ1zYzzcLv15QU2u2VLJob6hoJH3HmA04FiYQZjfXFp3+AaklXt7shuNByI
	 vANNMqGkbQmDRcq/JYT8wkUnhVxwI4uJQHF5sEPw+FfEZ6soRWK9Bt+aU3lTVnDetb
	 QWzc6gu1uP6DKeSv3tgSV4bsfNTlBXtU1OYAqYZ6gtvFBf9Gd3X+RWupg8SYzINDvD
	 RXnEbQ1xJt54ITIvGSNVd2NfqtnYsr0UbETB3ncvYSueYrpSY3TZi6zODHpaUarW+D
	 NejSQ49FkkYld2g4+ucPZU9WnbaJeIq3/++hSRBL9V0f3vLot0kdnIYyX1tGrQ5cNv
	 zkCgpL3ry60Lg==
Date: Sat, 29 Mar 2025 14:53:22 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>,
	martin.blumenstingl@googlemail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btrtl: split the device initialization
 into smaller parts
Message-ID: <Z-hr0s8xkkM6AEpU@bombadil.infradead.org>
References: <20180806204257.hqrwgufmu6ukq2sj@kili.mountain>
 <109d2b01-3e9a-4410-8f30-e393503ef7f6@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <109d2b01-3e9a-4410-8f30-e393503ef7f6@stanley.mountain>

On Fri, Mar 21, 2025 at 05:35:18PM +0300, Dan Carpenter wrote:
> On Mon, Aug 06, 2018 at 11:42:57PM +0300, Dan Carpenter wrote:
> > Hello Martin Blumenstingl,
> > 
> > The patch 26503ad25de8: "Bluetooth: btrtl: split the device
> > initialization into smaller parts" from Aug 2, 2018, leads to the
> > following static checker warning:
> > 
> > 	drivers/bluetooth/btrtl.c:592 btrtl_initialize()
> > 	warn: passing zero to 'ERR_PTR'
> > 
> > drivers/bluetooth/btrtl.c
> >    559          btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
> >    560                                            &btrtl_dev->fw_data);
> >    561          if (btrtl_dev->fw_len < 0) {
> >    562                  rtl_dev_err(hdev, "firmware file %s not found\n",
> >    563                              btrtl_dev->ic_info->fw_name);
> >    564                  ret = btrtl_dev->fw_len;
> >    565                  goto err_free;
> >    566          }
> >    567  
> >    568          if (btrtl_dev->ic_info->cfg_name) {
> >    569                  if (postfix) {
> >    570                          snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
> >    571                                   btrtl_dev->ic_info->cfg_name, postfix);
> >    572                  } else {
> >    573                          snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
> >    574                                   btrtl_dev->ic_info->cfg_name);
> >    575                  }
> >    576                  btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
> >    577                                                     &btrtl_dev->cfg_data);
> >    578                  if (btrtl_dev->ic_info->config_needed &&
> >    579                      btrtl_dev->cfg_len <= 0) {
> >                             ^^^^^^^^^^^^^^^^^^^^^^^
> > Assume btrtl_dev->cfg_len == 0
> > 
> 
> This is the length of the firmware file.  Does it make sense for
> request_firmware() to load empty files?  Probably there is a test for
> this in the firmware code which rejects zero length files?

We don't know the size of the file until we try to read it. Although
kernel_read_file_from_path_initns() perhaps should allow for empty
files, I do agree it seems odd to use the firmware API for 0 length
files.

We should extend tools/testing/selftests/firmware/ to check for this.
Care for a patch?

  Luis
