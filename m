Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56FE15EFDB
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972209; cv=none; b=FaVq2/khjK0WlCrfljQQ3CdP7wFGrLoFlHo0xJZC5nKjQGbWo8BncDcpaF/UuY1NG+DUxC3ssb7VAJZ7v7VZ5gxb3W+qTcdV+GURhK1e6X5y8tbZIthGDu3Kezt6WSetgO9wdB1bJERaLyt4ilNPl4b3+4UmVBCfovVLkjS38JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972209; c=relaxed/simple;
	bh=sCijfIoiWWuO+ID4TbJRdKV8axy5TX4E4LShcWAdV3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YlCee2SgiWKrlBN37vszhHC7gYjJ6aXgWRVb2MrqeLMM6cqOtAph83+J3Llb3nOHw5jQ84hnxadEOMUNOuG4nYRmkcTTGKtDBWtRCA4loTN3svFVrmX8dLrW9wGvAUixDhuD8pUxjb3cYaN1b06hQpA2iSMTrT2XqXMALEhhWhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ev5t56CM; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ev5t56CM"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so53979905e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1713972204; x=1714577004; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VL+zjtnTa4V4GoS3gEyjQ79J0VHTyJiZJ2md1+Efeok=;
        b=Ev5t56CMzhO5PFIR2LgecrKDWP+Szio/jP0qKkNK6+D49fg3RPinZzgGjZRYahzuA2
         MZh2yvRBTJoX2ZZ/Mlrb1tAh/oYiBBSGcViTQNQ6+fHOlMbT08Ua0QxWSqmsbK3LXWAb
         Y0nk6Y5mmYQpU4DWq8MVbiTOXu1A+V9kgcD4ybgU4QM8N5Fg8w/OULwqYBQOb8/po56t
         HnYns2D5+tBCbf1ffGpvP1DwFdKUXruFtiMXKe4DEAp+festqits/tZiFCDAZ+RPpMuZ
         KWynwewORBhn5OWjntkEgPT+efKlZW+MD1ZO28yYUlQnYW1CQc2d5Vebz4NGXZHs7Pde
         IQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972204; x=1714577004;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VL+zjtnTa4V4GoS3gEyjQ79J0VHTyJiZJ2md1+Efeok=;
        b=O85V3d2U3Qr5MeE2GOoQExLmtEGwlZkUmG1Y9+9Q8RIs1Ivb4uzc/6nUnsBYcz2aa5
         2/p//Xkvv3lLVxyHUP8CfvLbecgBtDiFymdH+DOPT9nIrsBpsNxOQrhvcrNCbRwQZA7a
         K8pPLqSLZEwLQkuBkEWd6kYVk2oZAh0iCXABWeyZKM0uhMitUBBBOEceu7Lbw8rmN2MC
         dlbTIjqw1ciSN4He393jRwetOeOtCOiiJ6L4Fh87qnNRCh8AJX6YgPGTcnbBhNm3sFL8
         51/gun1DXi6eHdc8+m5E7ve3gNsZ3vGWkg49uMBVikeMhMMmo1tsF7pMkAPO8Cydae7q
         6BWw==
X-Forwarded-Encrypted: i=1; AJvYcCV8ohE150F99v0KTR3ubt2R4SccF9F8IviMMnu33AgdOtHq0F5IZazuYZLu1IuETkZ4ZCuYZ7rsS7RVgO/iqFv5Mi5ek/58ltOjKiWgFKFf
X-Gm-Message-State: AOJu0YzsdhgJAawJ7RBN2qZJidCQbNbhavwya9q2voWESYO78LSLh9RA
	MZXXXk2eOsTKTKWuFFEGnt/E1i4vR98CdMVLmYJb4kVuY7kDeEXe9xTjR9DsKKY=
X-Google-Smtp-Source: AGHT+IGxx65KCqZ4q/prIN2iszax2XMR/WHT1xZqecy25hagi5Rc/3NljOGJBmCz23kmuErBnt/7ag==
X-Received: by 2002:a05:600c:190b:b0:41a:a5ff:ea3a with SMTP id j11-20020a05600c190b00b0041aa5ffea3amr2116282wmq.19.1713972204035;
        Wed, 24 Apr 2024 08:23:24 -0700 (PDT)
Received: from linux-l9pv.suse (2a02:9130:80a6:db2c:2677:3ff:fecf:2660.red-2a02-9130.customerbam.ipv6.rima-tde.net. [2a02:9130:80a6:db2c:2677:3ff:fecf:2660])
        by smtp.gmail.com with ESMTPSA id ay32-20020a05600c1e2000b0041ae995b926sm3736399wmb.3.2024.04.24.08.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:23:23 -0700 (PDT)
Date: Wed, 24 Apr 2024 23:23:19 +0800
From: joeyli <jlee@suse.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Manish Mandlik <mmandlik@google.com>,
	Archie Pusaka <apusaka@chromium.org>,
	Miao-chen Chou <mcchou@chromium.org>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_sync: Using hci_cmd_sync_submit when
 removing Adv Monitor
Message-ID: <20240424152319.GD26307@linux-l9pv.suse>
References: <20240424135903.24169-1-jlee@suse.com>
 <0391b306-1368-47ea-9602-26ff6df48921@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0391b306-1368-47ea-9602-26ff6df48921@molgen.mpg.de>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Paul,

Thanks for your review. I will follow your suggestion to update
my v2 patch. 

Joey Lee

On Wed, Apr 24, 2024 at 04:13:09PM +0200, Paul Menzel wrote:
> Dear Chun-Yi,
> 
> 
> Thank you for your patch.
> 
> Am 24.04.24 um 15:59 schrieb Lee, Chun-Yi:
> > From: Chun-Yi Lee <jlee@suse.com>
> 
> Please use imperative mood in the commit message summary:
> 
> Use hci_cmd_sync_submit() when removing Adv Monitor
> 
> > Since the d883a4669a1de be introduced in v6.4, bluetooth daemon
> > got the following failed message of MGMT_OP_REMOVE_ADV_MONITOR
> > command when controller is power-off:
> 
> Maybe:
> 
> Since commit d883a4669a1de, present since Linux v6.4, the daemon bluetoothd
> logs the failure below, if the command MGMT_OP_REMOVE_ADV_MONITOR is sent
> when the controller is powered off.
> 
> > bluetoothd[20976]:
> > src/adapter.c:reset_adv_monitors_complete() Failed to reset Adv
> > Monitors: Failed>
> 
> Please make this one line and indent it with four spaces.
> 
> > Normally this situation is happened when the bluetoothd deamon
> 
> 1.  happen*s*
> 2.  d*ae*mon
> 
> > be started manually after system booting. Which means that
> 
> is started
> 
> > bluetoothd received MGMT_EV_INDEX_ADDED event after kernel
> 
> receive*s*
> 
> > runs hci_power_off().
> > 
> > Base on doc/mgmt-api.txt, the MGMT_OP_REMOVE_ADV_MONITOR command
> 
> Base*d*
> 
> > can be used when the controller is not powered. This patch changes
> 
> “This patch …” is redundant. Use: Change the code …
> 
> > the code in remove_adv_monitor() to use hci_cmd_sync_submit()
> > instead of hci_cmd_sync_queue().
> 
> Please document the test setup.
> 
> > Fixes: d883a4669a1de ("Bluetooth: hci_sync: Only allow hci_cmd_sync_queue if running")
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Cc: Manish Mandlik <mmandlik@google.com>
> > Cc: Archie Pusaka <apusaka@chromium.org>
> > Cc: Miao-chen Chou <mcchou@chromium.org>
> > Signed-off-by: Chun-Yi Lee <jlee@suse.com>
> > ---
> >   net/bluetooth/mgmt.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 32ed6e9245a3..21962969411d 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -5475,7 +5475,7 @@ static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
> >   		goto unlock;
> >   	}
> > -	err = hci_cmd_sync_queue(hdev, mgmt_remove_adv_monitor_sync, cmd,
> > +	err = hci_cmd_sync_submit(hdev, mgmt_remove_adv_monitor_sync, cmd,
> >   				 mgmt_remove_adv_monitor_complete);
> >   	if (err) {
> 
> 
> Kind regards,
> 
> Paul
