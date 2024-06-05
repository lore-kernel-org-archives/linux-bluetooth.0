Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9514E2EF;
	Wed,  5 Jun 2024 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717610817; cv=none; b=r/hSecgmOUH/BieLsFh2+tzrkmcx1W5mVa4alOOyXGNmXuUhwFtvfFYudPvfDzSqiGVVepMq3amSJ1ZN6h4CLPYOkZqsUAaDuoKY4GnIUm3OnmHOVTKdkwAydcpnPYUrU85FvzSesoLPXlqA2k2pOtAi0W6z3BKZerLUxszn7JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717610817; c=relaxed/simple;
	bh=FZkniz16S/wXYq4h8od8IQiQQSFnwCyc2d/V7Rd8qsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETModIFReEAMu/xY9hQdYE8eKVkc1K/wiOfaXa3qMAv9Lme75F9Sq3320RYBoubgK6C7iM3kQyMnCPOwxmhV6/G28xxfXbu+qXhiny7ohuyK0nMcDPpo4OhSk20o0jFHHvSU9b+JHMBot1GSs5BFylCF0VJihuXF2XmyPndGQ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O5Akmg90; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O5Akmg90"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eabd22d441so1490851fa.2;
        Wed, 05 Jun 2024 11:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717610814; x=1718215614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQPi1Wj70Oupw3S1Uh8a0kVTS9NCfvHSV4FIWEU0DCI=;
        b=O5Akmg90ohfhUPF27mZEEGDqoSnyNnmfN8vcRRcTqVRZzt9XQX4ybqTYtMInFXqKXu
         EhskqbQP/onLTpHzghNtNKu/2nZZUDl1uugs6BMzVmcXZbethOFiwP9D/BfRerA7X7/V
         DpRxINecqIn7xHQ1RLrBkia3OaW5dd4UZwTAAxyFIdTuYEID5SXfnJWhPAFrohnJk9Ex
         U46uzr1BUO9zTqjWZ5GzIYysvfY5ZLPWzuz9rWJ2AnNs2Jt3mpSUFdZefcxZXf3AtqWv
         3rKJl8jPRAdzg2KVXc0nYWPYWaUmemtFNXrZVTKTDAkKFGdG0wSGYTdamlDsGGnA3GPW
         RYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717610814; x=1718215614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQPi1Wj70Oupw3S1Uh8a0kVTS9NCfvHSV4FIWEU0DCI=;
        b=GNOujoMlUDUOg7HOrvxGOsXIDfyqEhWgCNT3JrtDRc8ckG5MSeCL4toNl8HnM2oaFf
         uuYmHm50Zm+6x5Ox0kUvG1EaEENxu/vCXpGAI1viPSmY4SuBb47dzZACt/wsiJruq5xp
         s4X2m93vzkIPZg9snxDVGK5MS5i4Es0nIm1oSvB7mbvqza0CduxD1+B8Klgss/YEhkvC
         ZrG2En23D+hgUKecW6OaY8ZPyh5h+ZZMBsObabK+fAdXIsSCKzW/F/hcC6pfZoe3I/tq
         g05BIVe1D7l7YggEUS3UpgGFfsOiUAP6LbWzueM1JI25kXSVzQjEhjD67dX4EIengo1g
         YBhg==
X-Forwarded-Encrypted: i=1; AJvYcCXmd5QSj3eHcgIrm1My1nCrqzCKn1v3NoeM7U/orhDC5TRsGG5FEHdTwnxa3xgFKFbCoTbbUmNX0Z71dB15LkHlVAeN+bRZvq+mbR7SA7BFJuqlpPzedFsF4GOZS3XsrrqLjTaclVNnOUQA65Lz
X-Gm-Message-State: AOJu0YzLtEMoXCFA3g99MyBpmXWZFHSZI27Ftf7jeRkoEtq+QKsrU5Tf
	VAYpuduRCBDA2sH8voaZ1PdSi33KDxNoOG5rWf49472tM941eaZV4m8dpX+lKzXkcmSsCuv4h3V
	MGNaSqFQAZvaddQB6tdODnaNWaBc=
X-Google-Smtp-Source: AGHT+IFWST8ze+N1VpaqPM/3uL4sma2IzWxZluNfA2aUcgK/aGhvbZkVOWJpbYGfeGvQzByQV8DY+V2TKm/l0+o9t+M=
X-Received: by 2002:a2e:a78f:0:b0:2de:8697:e08b with SMTP id
 38308e7fff4ca-2eac79c888dmr29788511fa.26.1717610814048; Wed, 05 Jun 2024
 11:06:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529062946.5655-4-chris.lu@mediatek.com> <202405300602.AUh9Yu96-lkp@intel.com>
In-Reply-To: <202405300602.AUh9Yu96-lkp@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 5 Jun 2024 14:06:41 -0400
Message-ID: <CABBYNZK53Fx8rmanh6fsLsNjppEtThtis8naKa11nLk3gCHbLQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek ISO data
 transmission function
To: kernel test robot <lkp@intel.com>
Cc: Chris Lu <chris.lu@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, Sean Wang <sean.wang@mediatek.com>, 
	Deren Wu <deren.Wu@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, May 29, 2024 at 7:10=E2=80=AFPM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Chris,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on bluetooth-next/master]
> [also build test ERROR on next-20240529]
> [cannot apply to bluetooth/master linus/master v6.10-rc1]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Lu/Bluetooth=
-net-add-hci_iso_hdr-function-for-iso-data/20240529-143216
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git master
> patch link:    https://lore.kernel.org/r/20240529062946.5655-4-chris.lu%4=
0mediatek.com
> patch subject: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek IS=
O data transmission function
> config: i386-randconfig-014-20240530 (https://download.01.org/0day-ci/arc=
hive/20240530/202405300602.AUh9Yu96-lkp@intel.com/config)
> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a=
15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240530/202405300602.AUh9Yu96-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405300602.AUh9Yu96-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: undefined symbol: btmtk_isopkt_pad
>    >>> referenced by btusb.c:2267 (drivers/bluetooth/btusb.c:2267)
>    >>>               drivers/bluetooth/btusb.o:(btusb_send_frame) in arch=
ive vmlinux.a

Please have the above fixed and while at move the vendor specific
handling of the new endpoint to btmtk.c since that is not standard it
shall not be part of btusb.c


--=20
Luiz Augusto von Dentz
