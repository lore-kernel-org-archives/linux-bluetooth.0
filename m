Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A900381DF;
	Mon,  6 May 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981798; cv=none; b=sRmPgB7sbcCCiNWbvY91KwOk6ri9PByvrRYcFpjupaRWI0Ah3emR4T0oyPVgzCCQtm6JG851HQxYEYhcCySLK0HPIl5Ag8I2eWLAPx0TKK79X2EhO57ljsRbZ9PLzZ+vsPjblzOmRoS8pzb+pmh4nkoSxVMy7OP9M4/qnJg1nnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981798; c=relaxed/simple;
	bh=AldvdJy6yYm37EF3i71sslpEwK1DSJ9EjAmYdBn40qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDZRsnKtmDhbJhVzt/4iWdiesJF4QAOrFaVObHn0y7I1kTXHiCSGfUiEpvUbNMj6HO0JD7fLXeTYDaiR679C31/a3yprryeta2R5SHIF2QFYtisWcH5A58SI+Ds+wW/FzJdEhICHrR7Z737vbJSov1qvwrsMq5OMebSI57H/0PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNI0+H02; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNI0+H02"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F01EC116B1;
	Mon,  6 May 2024 07:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714981797;
	bh=AldvdJy6yYm37EF3i71sslpEwK1DSJ9EjAmYdBn40qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZNI0+H02XjdjlVmR6Cx3OzWOiBtjcRpk3xgkvyOqbhDCkhMr3vHP0oh+i33tTx/Ma
	 FV8nNda9MLbM3QZGm5z9ZtjgOTO+yw7dj7YUi9TuhDLjepQpIVJPklKABB1S6On5LW
	 oJ5tds7uhKrQJhDZ857sGfoNTlZutt2i/iY/3cvCUzxoZS7Gngrkw54hHdt4axYBSt
	 TU2TYdNBHJnGFHkCJMQnHXAIQdn4l+TT7XZfl1B55vuihq0/UG7H42wGAwwErVRL4n
	 geNSjz9lviHD590Q4TJUXY1fPROtIF2HIQpsm1nanLDDA/Sy+5piOdWJ1+hdj+tU/1
	 APz0SNhKevnhw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s3t6k-000000007nV-09n7;
	Mon, 06 May 2024 09:49:58 +0200
Date: Mon, 6 May 2024 09:49:58 +0200
From: Johan Hovold <johan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: qca: Fix error code in
 qca_read_fw_build_info()
Message-ID: <ZjiLphwtH2RvUChu@hovoldconsulting.com>
References: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <515be96c-4c44-44d5-891f-fe57275e9f47@moroto.mountain>

On Sat, May 04, 2024 at 02:25:43PM +0300, Dan Carpenter wrote:
> Return -ENOMEM on allocation failure.  Don't return success.

Thanks, Dan.

Fortunately this error path is never taken due to the small allocation
size, but if it were it would only lead to a debugfs attribute holding
the fw build id not being created.

That said, it should still be fixed of course even this can wait for
6.10-rc1.

> Fixes: cfc2a7747108 ("Bluetooth: qca: fix info leak when fetching fw build id")

This one should also have a matching:

Cc: stable@vger.kernel.org	# 5.12

> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

> @@ -136,8 +136,10 @@ static int qca_read_fw_build_info(struct hci_dev *hdev)
>  	}
>  
>  	build_label = kstrndup(&edl->data[1], build_lbl_len, GFP_KERNEL);
> -	if (!build_label)
> +	if (!build_label) {
> +		err = -ENOMEM;
>  		goto out;
> +	}
>  
>  	hci_set_fw_info(hdev, "%s", build_label);

Johan
