Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1C28EB;
	Wed, 24 Apr 2024 04:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933293; cv=none; b=ORbXI28VDCGGq4LfcA+d9eO+Alq2ZmlkdhrarobCzX6tW3FdH50eoUBYcZ27rm3E0wM6kf0/BFKbbUFf09gjez8MvFtj+IJIJUvjpRKb9Ae+0OWCs5Y+HJUfbqMkjWAp/Lq+6aj9/f2XbCx7O+hD2E8QV4U/uOj/mrDSCmyWZik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933293; c=relaxed/simple;
	bh=RqvuXJw1Gq+4bHe1D+BOkeGEle15EYqoiQqWYPZZ96U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ9+rdtFU31C/stfkTP3wIvHuAigK/+A0MaEgnsQ8CqO2C88vnWb25or0uz6lIgyapC/ir5p/dMjHnnBjGWyh6S8GBllizWkAc95VtLh/1oIV1QQ+Vf8C42HE5K+LkhaCDV+JyQsPerO47AY3ikzupmJSyQQxwpVw7eWBMYOKzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fCBHXk1U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fCBHXk1U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2182EC113CE;
	Wed, 24 Apr 2024 04:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713933293;
	bh=RqvuXJw1Gq+4bHe1D+BOkeGEle15EYqoiQqWYPZZ96U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCBHXk1UAA2q4X7nNCR7LUY6cZfDeLFe1pTyet/FhnOgsTtKiJM8bF9bUECztn/dj
	 NbMM/V/ksmOl3EjV+qc/Zo97vfPgE9zM4kPU1L/LCSYucZbLpNdSduUVnYwojP9AM+
	 ks1oD6z55+cn+sUD9rxt3y02ckzPjbbtJp6G3jFw=
Date: Tue, 23 Apr 2024 21:34:43 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
	krzysztof.kozlowski@linaro.org, wt@penguintechs.org,
	regressions@lists.linux.dev, kernel@quicinc.com,
	stable@vge.kernel.org
Subject: Re: [PATCH v7 2/2] Bluetooth: qca: Fix BT enable failure for QCA6390
 after disable then warm reboot
Message-ID: <2024042330-boat-launch-aaec@gregkh>
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com>

On Wed, Apr 24, 2024 at 12:26:47PM +0800, Zijun Hu wrote:
> From: Zijun Hu <zijuhu@qti.qualcomm.com>
> 
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> during reboot, but also introduces this regression issue regarding above
> steps since the VSC is not sent to reset controller during warm reboot.
> 
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also be fixed
> by this change since serdev is still opened when send to serdev.
> 
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Cc: stable@vge.kernel.org

That is not a valid email address :(
