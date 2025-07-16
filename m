Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BFA1E766F;
	Wed, 16 Jul 2025 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752636557; cv=none; b=O5+Nlgt5elbgwyq0omYqUYsRnhPupfObnhNcIhuAyrHiX7BuMIE4b/XQ4I1+tfUnS2OVhjnBoBl1oSeSjqSM0jlRNSB9ENlwy+H6eqc2WTnxQ8qRabmKRLpyiuATynXxMMvHtZujQLl9gOgtp6PxAU+hPPBzrBnNej/tkzB+CY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752636557; c=relaxed/simple;
	bh=2yyfZXnNwpXxaoIW6jA0pvTxLtZahm9+hKzkt6um644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr380/knQ+7hX+JIm8GUCHtTaVYck61y/Rq8VxaPENx2/EpgOMksOC7xBxN0FKBIYx8zNx0GdEFfWU1SStQ3LOuIpI+XC6teKvyHepipsxMpQW9vZ2fXzjeIwz63eIT5XOA0fMpuoEvPcxOOQt/gczgk8gqoCnOgcZITBcPr2Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xv3Ncgb8; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xv3Ncgb8"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so461852b3a.1;
        Tue, 15 Jul 2025 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752636555; x=1753241355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+vRklbNelA909tln10p8KYC/sfiwBc8gb3ZDjuapLBY=;
        b=Xv3Ncgb8dPGK6XMVfRER+g9RI9pqag05LxP9eFgEXRNvxcIMGDr4rlMO/ZJ1fB1+Wn
         bO7D9gVBaEA5GkhOPAQOWhBWUjatjQU2w7pr/0H9DQVNNxXkZCo9MBVaCR+x0cbO8tEc
         jVbxIyK+N623bcw30opmXH8R1YPKu5qDZdDTs6lmfApOPy0QhB9WXKR96wz62Ww19ido
         raQGJQJJpp+yvnSE4HW9L7T3v8/4bhFeWBPjRLqGJvfCBJG6o2+7P4BGyCyD3bNPhxy3
         G+Ok6HAMS2BlM/xOJUkI6Q5s15K+Tc+a18t6BDJ3nHkHs10QIpH58vmRKZprtolnoVGB
         YCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636555; x=1753241355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+vRklbNelA909tln10p8KYC/sfiwBc8gb3ZDjuapLBY=;
        b=OotesPUSmIVWlVvVOZXRZvnJV+HlVg4UIQY+DIgGU/9MG94Z4I4ZwnnXt/4wubkmMA
         JsHpR/+iRy3NUMU01qXHhn+04k9syzb58vz3ykx6B9nz3X34a6Urwb+rAZmY0JH5MSzJ
         FX+dzdINSKhHW/Q7AtVrtgsY2w8AC8bKu0QAB/dtzzBrPU1+OI2VnvzXLIyRfI2NLE0S
         zU++CvqPXUKWxyE9sjGqXrqR0VIQSlIYFQUrwMj5Ci7zfvWsYTbiwAso0AD0rtECkv4l
         2qXPaJBlqP+CLAvGxGisSty4+mH8f/SdwBlyQIbzvQXKmZyHTCVLpmDs/SXgMgbT6Ey4
         EX3g==
X-Forwarded-Encrypted: i=1; AJvYcCU0KtjboXqDDVDuhSoO/xocfe71nRzcxg5Gr3owGdUZIiF6S0HT6K/hHsmL2Ceu8BQCXTTtYFhlOg55pH561WE=@vger.kernel.org, AJvYcCWIjMST7aHkVWsffmnTtk9UtnmZgSuTLS6mPfDiMqXCkGpqRV7U0An7dH3G4H7/41PprHvh1XmCrWE+8FwB@vger.kernel.org
X-Gm-Message-State: AOJu0YzON/rR/DYqzikApRcW2u8+nkDZ7agt9EWFY/Oj5O+WY3fRVpBI
	PCck0SkVE6fS5BkgkwOn2V/AwzQLdf404IKTDt1ew4POPe26swdWzNuKlsSxFhzr
X-Gm-Gg: ASbGnct53z6u4DQEjmyDxqpMMSJqZmaAT28HTF4pHCrRNP4uAwoMi8uHWESWALU2sZy
	oEJ5DoilIMBGBOIhxn2ALpRmIwYbTwFoETbvsz9ucpf1H5ZoPW+5cFJMWgL6RU2mXX/EmkxUsJr
	0mOAROoBGYcYy4qOalBrCUZqFoLpa+VXNSQ2njNrk8jk1fWS07Vi8lBN0/EmOQIiVROqot25m9n
	PlyKWczTKh3h1a9Tah1HWeD6k6gV/eQfODWwS7cmY4AZErRHI44E1aN/IdyUbEHOv2DPZWk4bTb
	WF+QHWlFExMqXaYyWJO1tZndo3v+OXSSr8/BOG1FuO6Xhq2dxgHVZKgko8CFFzVqTCjXyBeJdBN
	DGunwUCsyOnIqFbC9p7bZ2ol6TxBrzr0XeUiGYhTJl8QMMM4c
X-Google-Smtp-Source: AGHT+IGddWIBlHnqpRAMxktTf82bmuTo4OCVi2p8MHp1kSJLVfnpOaBFRqeITyeG0O7uNd4MdM10ng==
X-Received: by 2002:a05:6a00:26c9:b0:74a:d2a3:80dd with SMTP id d2e1a72fcca58-7558268ff4amr6995633b3a.3.1752636554919;
        Tue, 15 Jul 2025 20:29:14 -0700 (PDT)
Received: from ipravd-Nitro-AN515-55 ([2601:646:a000:5fc0:da0d:3451:5a84:c6a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b72dsm13625627b3a.97.2025.07.15.20.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:29:14 -0700 (PDT)
Date: Tue, 15 Jul 2025 23:29:12 -0400
From: Ivan Pravdin <ipravdin.official@gmail.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Bluetooth: vhci: Prevent use-after-free by
 removing debugfs files early
Message-ID: <mctt3nciphct26ogo5xugfigrwrz3tc3mq4qxludpmyfcfszlm@sfgv6c5lq3x4>
References: <20250716004252.125466-2-ipravdin.official@gmail.com>
 <4d79d6f7-5648-43fc-b321-ea130a2fd713@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4d79d6f7-5648-43fc-b321-ea130a2fd713@molgen.mpg.de>

On Wed, Jul 16, 2025 at 05:26:05AM GMT, Paul Menzel wrote:
> Dear Ivan,
> 
> 
> Thank you for your patch.
> 
> Am 16.07.25 um 02:42 schrieb Ivan Pravdin:
> > Move the creation of debugfs files into a dedicated function, and ensure
> > they are explicitly removed during vhci_release(), before associated
> > data structures are freed.
> > 
> > Previously, debugfs files such as "force_suspend", "force_wakeup", and
> > others were created under hdev->debugfs but not removed in
> > vhci_release(). Since vhci_release() frees the backing vhci_data
> > structure, any access to these files after release would result in
> > use-after-free errors.
> > 
> > Although hdev->debugfs is later freed in hci_release_dev(), user can
> > access files after vhci_data is freed but before hdev->debugfs is
> > released.
> > 
> > Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> > Fixes: ab4e4380d4e1 ("Bluetooth: Add vhci devcoredump support")
> 
> Not important, but I’d put the Signed-off-by: tag last.

Not sure how I missed that, sorry!

> 
> > ---
> > Resending because previous patch got archived [1].
> > 
> > [1] https://patchwork.kernel.org/project/bluetooth/patch/20250614235317.304705-1-ipravdin.official@gmail.com/
> > 
> >   drivers/bluetooth/hci_vhci.c | 57 ++++++++++++++++++++++++++----------
> >   1 file changed, 41 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
> > index f7d8c3c00655..2fef08254d78 100644
> > --- a/drivers/bluetooth/hci_vhci.c
> > +++ b/drivers/bluetooth/hci_vhci.c
> > @@ -380,6 +380,28 @@ static const struct file_operations force_devcoredump_fops = {
> >   	.write		= force_devcd_write,
> >   };
> > +static void vhci_debugfs_init(struct vhci_data *data)
> > +{
> > +	struct hci_dev *hdev = data->hdev;
> > +
> > +	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> > +			    &force_suspend_fops);
> > +
> > +	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> > +			    &force_wakeup_fops);
> > +
> > +	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> > +		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> > +				    &msft_opcode_fops);
> > +
> > +	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> > +		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> > +				    &aosp_capable_fops);
> > +
> > +	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
> > +			    &force_devcoredump_fops);
> > +}
> > +
> >   static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> >   {
> >   	struct hci_dev *hdev;
> > @@ -434,22 +456,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
> >   		return -EBUSY;
> >   	}
> > -	debugfs_create_file("force_suspend", 0644, hdev->debugfs, data,
> > -			    &force_suspend_fops);
> > -
> > -	debugfs_create_file("force_wakeup", 0644, hdev->debugfs, data,
> > -			    &force_wakeup_fops);
> > -
> > -	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> > -		debugfs_create_file("msft_opcode", 0644, hdev->debugfs, data,
> > -				    &msft_opcode_fops);
> > -
> > -	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> > -		debugfs_create_file("aosp_capable", 0644, hdev->debugfs, data,
> > -				    &aosp_capable_fops);
> > -
> > -	debugfs_create_file("force_devcoredump", 0644, hdev->debugfs, data,
> > -			    &force_devcoredump_fops);
> > +	if (!IS_ERR_OR_NULL(hdev->debugfs))
> > +		vhci_debugfs_init(data);
> >   	hci_skb_pkt_type(skb) = HCI_VENDOR_PKT;
> > @@ -651,6 +659,21 @@ static int vhci_open(struct inode *inode, struct file *file)
> >   	return 0;
> >   }
> > +static void vhci_debugfs_remove(struct hci_dev *hdev)
> > +{
> > +	debugfs_lookup_and_remove("force_suspend", hdev->debugfs);
> > +
> > +	debugfs_lookup_and_remove("force_wakeup", hdev->debugfs);
> > +
> > +	if (IS_ENABLED(CONFIG_BT_MSFTEXT))
> > +		debugfs_lookup_and_remove("msft_opcode", hdev->debugfs);
> > +
> > +	if (IS_ENABLED(CONFIG_BT_AOSPEXT))
> > +		debugfs_lookup_and_remove("aosp_capable", hdev->debugfs);
> > +
> > +	debugfs_lookup_and_remove("force_devcoredump", hdev->debugfs);
> > +}
> > +
> >   static int vhci_release(struct inode *inode, struct file *file)
> >   {
> >   	struct vhci_data *data = file->private_data;
> > @@ -662,6 +685,8 @@ static int vhci_release(struct inode *inode, struct file *file)
> >   	hdev = data->hdev;
> >   	if (hdev) {
> > +		if (!IS_ERR_OR_NULL(hdev->debugfs))
> > +			vhci_debugfs_remove(hdev);
> >   		hci_unregister_dev(hdev);
> >   		hci_free_dev(hdev);
> >   	}
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks.

> 
> 
> Kind regards,
> 
> Paul

	Ivan Pravdin
