Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB513C3D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Mar 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711478808; cv=none; b=eIgSy/5wK8qIvsa1jdO+RE4LVnvEWZT9ZTMT1gyDaWbWAn2gdqVHdAZvXjDVTfzR8jmJnqGyWlanI/YAo4Uf3ljqDPozt4K1M/E+nmA3fplcOE6Z6eQFJaacLOf6lWrJ2cVonHNMxR+aUtVmeZzpHuKfTaLsaIAadu9rZ1PhZ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711478808; c=relaxed/simple;
	bh=Lfpy+o0TDJ1LR4DY+MLKXblS1exEVtPSo+x6Lgx0wFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WZJJ1DNZaM0BCcXaV/H09B6VE9aAuwMBwfFg6nfih3bHAjJHPj+LLcIz13ncmgdvJ+pBktp2vtIoh/k9GXSBDX50TSJBmj0EbrVaJXolOPGoBdzCTL4dI6wFIVx09DEyqzBg+nhB/l4ChpSiYtAn6QlCqydVuGw5M3XmkvruhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ryFfH1jJ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ryFfH1jJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:Reply-To:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=VEYyKzV+7KLu8j1+bYTwS2eazaf/OrVv59VycEAU/Os=; t=1711478806;
	x=1711910806; b=ryFfH1jJZXwKrgz5t28n3k8NRC3fM2MsJQ6a4Whb49IxFl15TmiCbovVVf0eZ
	ili8i4e249m1W5WmgdXdTLkGaVbiroV0kTDhtjoMJQeQYeMEL0F1wbIPNI+TY6FLvfNQPYf+CMghR
	63inpu1+MsH6vrjxlMJPgGS7HIlKrsFvRSWw7oUaYiAR9BU4/We/vAWrcSdmaX0sABQ7HX2gY9ohR
	Aqpw5GlWiDuiOrl54H2Qd86NfitulX8qKBQTKWEe6fbfvUJ2gULcixsPuCs4zxxo/ykQC9cjnKSjI
	aDBmRgHS1C8DejqjY9z7A1BbNaMpmzZKTne414WzGENcEcddrQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rpBop-00059j-VT; Tue, 26 Mar 2024 19:46:44 +0100
Message-ID: <7c82b5a5-f2fa-4136-b5f8-9d3874869dbb@leemhuis.info>
Date: Tue, 26 Mar 2024 19:46:43 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix not checking error on
 hci_cmd_sync_cancel_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
References: <20240326164317.1460864-1-luiz.dentz@gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240326164317.1460864-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711478806;cca043ed;
X-HE-SMSGID: 1rpBop-00059j-VT

On 26.03.24 17:43, Luiz Augusto von Dentz wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> hci_cmd_sync_cancel_sync shall check the error passed to it since it
> will be propagated using req_result which is __u32 it needs to be
> properly set to a positive value if it was passed as negative othertise
> IS_ERR will not trigger as -(errno) would be converted to a positive
> value.
> 
> Fixes: 711c35949648 ("Bluetooth: hci_core: Cancel request on command timeout")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixed my problem:

Reported-and-tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Closes:
https://lore.kernel.org/all/08275279-7462-4f4a-a0ee-8aa015f829bc@leemhuis.info/

Ciao, Thorsten
