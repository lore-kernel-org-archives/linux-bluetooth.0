Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B481422AF
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971929; cv=none; b=m0OwdLl5Tn+ZcepkbSBRQeMro5Uth+s1VZAMCMN39ZcWFJ35prFAJy40lKatSw0HxD9BgdGns6rFG+Nq85LTSKy+ftCtivW/5RB3ugzhLh4lwRwnzgw/N5dV/ugwpAh/6CngP9jW+rhEFQJsGLrbsSYfeoLfTmfHDVibpXldvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971929; c=relaxed/simple;
	bh=M63E0tMhKBinoFpfE0iZhVXwg7IZ76XYz5gZimOItUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dj1Dj5Pmuzas3Ra1C5rP9DDnqlukBkOl4C1dkU/HXW0YzNp20DzMS4fBlA4kc14J7Xsf/1vRUbycynehDiHkCjCfMCCszF9FhCxqFmlOVrntc/i4iAVDYuCEoReWdaSNQvjhe38ItJpwLWeoD2JFbIZVHUuyO/b+K1o/53wrg0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VsPE7VDY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VsPE7VDY"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-346b96f1483so4189f8f.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713971925; x=1714576725; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuYr4KgNywTXy9y1Q53gxMNmb62o0OX3DJK15yRq5k0=;
        b=VsPE7VDYVZKyCHMYPXMMp0HK9qz/dG269xT6chBDTt1cnNN1eWb3BcyrxLEK+7X4pV
         4e4XaBitWc4cH8ptH7/v7qAnn+SFfXkNeud5jEF1jNx4GcULzN9WqNch8CO3Q2fRp5/p
         AETZsLO86mLf837LReoXhR3hJVWDRVYQB/LaY+P4mIy3Rp7EKOYc6HiV7Qo8p0Gl4qTi
         DJQoldLi+e5J2nz2s6thGjjdxscl0GNYm/L98xx5hfp44Mydp4YjVV4aZwjtqaODeli/
         ADG7PBitBVEebeeh8nDsaDVZBPotNx3pi/oRya3zsWH+LdI7k6YnNfY/D82/XCwUnWsk
         Z+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971925; x=1714576725;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuYr4KgNywTXy9y1Q53gxMNmb62o0OX3DJK15yRq5k0=;
        b=sDzsDr9bq1r9Jmb6YwhzAiwdKk4UdSNiDVovCfuN3J9IhZI0ugXRysKcg9wMa5MtQ6
         3sH1PJO90zFOBjL1ZUcUO9WbmxuYC4MIjU38dALw1wSdHe7TAm9NPcFFCpAEPps9ag/+
         cLYkqIVKo7KvPvFO5N0QY/R60co4/UpZsR76/y0X1LB3riO9yHHVhCnNYuSNOkVKqnsX
         HB20BmWzh9mD9T5zyMQWHcwifDcpeqDl+xqgsq/7/tNTWHBBPdd4E9s9qmbPdvWPnacX
         MUy4tISn8YzpaOpPaCAaFM0/sm0wobDZ+Dxuu8aIimMAbpiX5d9L0QX5UonJkHefNQcJ
         OKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGvbIwFAlFE6k9EnpWSL1LYA8+i3ixfYsudQHTTDuNMcDcSKlZv6Rl8PiAopwGO9cs8/MGOXXZXXhra4ZIuNtq88esiiOpUcQlzKM8JnKW
X-Gm-Message-State: AOJu0Yx/8dU/iIGa7/sTXzmDD3PdS6tg7giEcobJJROfWLn6NU0HgnDw
	udh49r12hYh3HHmKBWOcMhHvjySKrxaknjfqgC4K/oZtejPGp+C6hn4NoEfQ9Zg=
X-Google-Smtp-Source: AGHT+IHrTZes4repzI/TqtRAFq22spYaopD+HHCcD+Hl/jKc5zEscQV3hZR8dTAwwSk95WCxhp61Ow==
X-Received: by 2002:adf:e5c2:0:b0:343:d2e4:78b6 with SMTP id a2-20020adfe5c2000000b00343d2e478b6mr4562797wrn.32.1713971925361;
        Wed, 24 Apr 2024 08:18:45 -0700 (PDT)
Received: from linux-l9pv.suse (2a02:9130:80a6:db2c:2677:3ff:fecf:2660.red-2a02-9130.customerbam.ipv6.rima-tde.net. [2a02:9130:80a6:db2c:2677:3ff:fecf:2660])
        by smtp.gmail.com with ESMTPSA id z9-20020a05600c0a0900b00418916f5848sm23740344wmp.43.2024.04.24.08.18.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:18:45 -0700 (PDT)
Date: Wed, 24 Apr 2024 23:18:41 +0800
From: joeyli <jlee@suse.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Manish Mandlik <mmandlik@google.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Miao-chen Chou <mcchou@chromium.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when
 removing Adv Monitor
Message-ID: <20240424151841.GC26307@linux-l9pv.suse>
References: <20240424135903.24169-1-jlee@suse.com>
 <87cyqedfk2.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyqedfk2.wl-tiwai@suse.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Takashi,

Thanks for your reviewing and comment!

On Wed, Apr 24, 2024 at 04:02:37PM +0200, Takashi Iwai wrote:
> On Wed, 24 Apr 2024 15:59:03 +0200,
> Lee, Chun-Yi wrote:
> > 
> > From: Chun-Yi Lee <jlee@suse.com>
> > 
> > Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
> > got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
> > command when controller is power-off:
> > 
> > bluetoothd[20976]:
> > src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> > Monitors: Failed>
> > 
> > Normally this situation is happened when the bluetoothd deamon
> > be started manually after system booting. Which means that
> > bluetoothd received MGMT_EV_INDEX_ADDED event after kernel
> > runs hci_power_off().
> > 
> > Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command
> > can be used when the controller is not powered. This patch changes
> > the code in remove_adv_monitor() to use hci_cmd_sync_submit()
> > instead of hci_cmd_sync_queue().
> > 
> > Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Manish Mandlik <mmandlik@google.com>
> > Cc: Archie Pusaka <apusaka@chromium.org>
> > Cc: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> 
> Is it a same issue tracked in
>   https://github.com/bluez/bluez/issues/809
> ??

It's similar problem but for different MGMT command.

The above issue and patch are against MGMT_OP_ADD_UUID/
MGMT_OP_REMOVE_UUID. My patch is against
MGMT_OP_REMOVE_ADV_MONITOR command.

Thanks
Joey Lee

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  net/bluetooth/mgmt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 32ed6e9245a3..21962969411d 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
> >  		goto unlock;
> >  	}
> >  
> > -	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
> > +	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
> >  				 mgmt_remove_adv_monitor_complete);
> >  
> >  	if (err) {
> > -- 
> > 2.35.3
> > 
> > 
