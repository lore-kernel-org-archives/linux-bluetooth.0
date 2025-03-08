Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142312BB15
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741443564; cv=none; b=h2+KAUu1CsDVKUMo22fF2aPxvULU4iqesLCI+d6ExpqLRgxGSCp57MIwG5S63RONctSBHiIf6jlACFhEvweMQtExcLZ+Skl2eKRKF4lC4D4acHIYKb2d29acUwPe36GBJlWx7ruzIa2qziz/+Ly2esyGjDzQ05wJpPLXRR0hlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741443564; c=relaxed/simple;
	bh=w60pK7iRtMJibvDaks8pzEZtdVfGfKauvUrv+LMtCkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QepUbObz/E9i/qF9ngWAsqEsOmodE9sGwmH1MztVJ1jasZmqc0G2ZZ23zSoze5/XSIseuWDAmEspNC74JLruwidGcj6aYT2e2R2qIMsHQvCwtJ21U637V+XoP8/SOgVbWA6dkdTQN7R/VnndWhd8RlH+DBD1SnDXBR/ElArgieo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=fzKCZnim; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="fzKCZnim"
Received: from localhost (unknown [10.10.165.3])
	by mail.ispras.ru (Postfix) with ESMTPSA id 22C1A40737D5;
	Sat,  8 Mar 2025 14:19:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 22C1A40737D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1741443556;
	bh=X/J2leWO+9MM9flBpxUO7gh0UL9/3BSaHMGu7b2coEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzKCZnimaYudyauDVq3R9ZLmi9OwwQndaPeYWO9aigtQy/RVIqlO+BPZPzSjCeLaB
	 LgVZtOThXp3X3gsPJ9PqA0er71HROeKmh0TpbyP+Rrx5P0+FOYRki80x2CResoXT1i
	 yY5qIyVSmH/YTpK22Pp7tUrNny929kQs/YeIRZKU=
Date: Sat, 8 Mar 2025 17:19:16 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Manish Mandlik <mmandlik@google.com>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	linux-bluetooth@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>, 
	lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] Bluetooth: fix error handling path in
 __add_adv_patterns_monitor()
Message-ID: <hf6wflnvlo5pz3r7ggmuc5eq2kbzic2bwwwpu6caaixajjb2xi@hyzdrsrinvis>
References: <20241022115434.1513930-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241022115434.1513930-1-dmantipov@yandex.ru>

Hi Luiz,

On Tue, 22. Oct 14:54, Dmitry Antipov wrote:
> Add missing call to 'mgmt_pending_remove()' on 'hci_cmd_sync_queue()'
> error handling path in '__add_adv_patterns_monitor()'. Compile tested
> only.
> 
> Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---

Would you consider the patch, please?

It looks reasonable and is still applicable to the mainline AFAICS.

Thanks!

>  net/bluetooth/mgmt.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index a429661b676a..92c9808e419b 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5301,6 +5301,7 @@ static int __add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
>  		else
>  			status = MGMT_STATUS_FAILED;
>  
> +		mgmt_pending_remove(cmd);
>  		goto unlock;
>  	}
>  
> -- 
> 2.47.0
