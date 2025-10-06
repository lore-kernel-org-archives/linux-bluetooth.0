Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25CA19E83C;
	Mon,  6 Oct 2025 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720116; cv=none; b=MtU7S2eSrC04yDR8A2e+hDOJERnBBm28RP8vEDAFdiP+lduVAxEkITFnTngBoCiWvwrXXi3dknQerWf2LRi+h0B5RavqrSSJy2RTKoTw4lFN5FAp86bz9mQJhtdpvhiuJoJr/Y8CEI0FZSyhHWZKTtOmK9JMWhbpQCf1+rC8/XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720116; c=relaxed/simple;
	bh=vfSIvl6/GkrSHfKsccvYeAqdNzEkhewgrRNtGC4SeM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1LVNBARsN9Kyap7ojdVTh3RSnVUFxRggdqQNwh9Pnu4747djHw9MLQKK3+WRUH7+HY08NUhdhN+bZWdjFuKpbnz7Nw42LKVVDXLkGDbO7IDD/idNHSo1VrU0+x0VxspjE+uwPvVsG+gQac4ZvMa8N82yJjQZIxImvbT+d9BpNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=C1TtITTB; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="C1TtITTB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0u3X6cbMUB3hZGnkQUCH2FqUSPSC5bwDf/auwFkVBps=;
	b=C1TtITTBi5orDp6BF1PvM99IX3mGW/S2khT5jgmM7YOwOQV4/w1KanBEcQLIdg
	SIBZp60nbOvoe3SZrWLs9fzwVrKjZrdGkPA42uZgbCvl+3lm3eCywp3NvzReD5ng
	kTjS3POzUn96ZvxkntKNvbcYSHDumMtArPQA+h3sdB9Ow=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX15mVMuNoHtR_CQ--.65018S2;
	Mon, 06 Oct 2025 11:08:06 +0800 (CST)
Date: Mon, 6 Oct 2025 11:08:05 +0800
From: Chingbin Li <liqb365@163.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for
 RTL8761BUV
Message-ID: <2tzwvc2d7kydrvfpljkplvitx3ynoo44757x7owuvd7o5bgbet@xqeytlbki4oq>
References: <aOIyJOnP55mmZUut@9950x-Ubunbu-24-04-dev>
 <72f869f4-8320-4bdb-a7ba-714e46928a69@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72f869f4-8320-4bdb-a7ba-714e46928a69@molgen.mpg.de>
X-CM-TRANSID:_____wDX15mVMuNoHtR_CQ--.65018S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Ri8nODUUUU
X-CM-SenderInfo: xoltujiwv6il2tof0z/1tbiUQXecGjjKiqIKgABsS

Thanks, Paul. I will.

On Sun, Oct 05, 2025 at 11:12:08AM +0200, Paul Menzel wrote:
> Dear Chingbin,
> 
> 
> Thank you for your patch.
> 
> Am 05.10.25 um 10:53 schrieb Chingbin Li:
> >  From 5676b7b1029c11ec99b119a3b56945ba8a766c0a Mon Sep 17 00:00:00 2001
> > From: Chingbin Li <liqb365@163.com>
> > Date: Sun, 5 Oct 2025 16:28:28 +0800
> > Subject: [PATCH] Bluetooth: btusb: Add new VID/PID 2b89/6275 for RTL8761BUV
> 
> Having these additional lines is incorrect. Please use `git send-email` or
> b4 to submit your patch.
> 
> […]
> 
> 
> Kind regards,
> 
> Paul

