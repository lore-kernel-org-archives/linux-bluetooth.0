Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF97A2066D6;
	Thu, 13 Feb 2025 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739440904; cv=none; b=JhuCoJ5HeVODN65vH1pC85sfb7kVV6paqhr0XaJvE5fN3JsVIBVSC7dogujYN2zAtPCCwDtRdw/Uxsf89Wtzw4KAhBPNrL05NLUQItESSt4537n6+GP1cqu5LBvRk5LnqUcKGCmmR6e23xMPOI9fwVrdblXlrfb0LjqevXj7MeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739440904; c=relaxed/simple;
	bh=EoGJfc9ifR6hXmDHsanG9hhvpDo5weaiWEA0/w0WM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo6/WTxq9GdJh2IkKgATUJ4pvz36gHbwZr3WoXszxw/xqEBy091FlcEQrRHRqMTVlJXZRJH2FoNujxjji2p93z23tgM2GFojkRzfWNTjlFsEAypS38OgrtkGlSMQWB/JeGN7n1SyIwJKzPJm/NYCv7HCc8OoHpHVCVsKLAFqmsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O0TPH38G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O0TPH38G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8274C4CEE2;
	Thu, 13 Feb 2025 10:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739440904;
	bh=EoGJfc9ifR6hXmDHsanG9hhvpDo5weaiWEA0/w0WM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O0TPH38GR/EpP2CpV7/w6E72VcgkuwpX3MknLXLIUez4Gk5qe2damJYpDjuBa9gfC
	 v98W1ZKU+7blVsgurfOaVS6mfqnebqCUj2jt8eGcZXl2uKAgbgZtr+RfYnK0EOLXes
	 euDtXiS+jg5ucC+B7SGxvppc4AuYGVaYBPaius0c=
Date: Thu, 13 Feb 2025 11:01:41 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
Message-ID: <2025021325-faction-upward-6395@gregkh>
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213034413.3808375-1-chharry@google.com>

On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth: Fix
> possible race with userspace of sysfs isoc_alt")
> 
> Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace of sysfs isoc_alt")

Where is this git id?  I don't see it in linux-next, are you sure it is
correct?

thanks,

greg k-h
