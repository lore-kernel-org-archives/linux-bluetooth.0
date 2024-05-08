Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1711D8288C;
	Wed,  8 May 2024 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715179073; cv=none; b=ZBbeVEUb/YmWnUHz2azvXaIMac9DbyYDBksTgkcSwdgq8Nsy5ulrbz2V00p2T72nBxSa00sb0IeO2yUp8GzS0cIGFRPXXCTZG6pyrB9llw/lSu6btr+pf/LzAdSM6dI9gw0uCxX1dXO0mEVSjO6QLv2srPacVUp2mHApw+95U/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715179073; c=relaxed/simple;
	bh=LFoKAKHXamXRmqSY6b64pUE2lvxxq13VyPY4udQ2bbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPQQptxVbn8XSr58SMpedDQyuvJBcOkV22cMkFa7Nvoz+0ERLRcn8CEjqswOiSmgl/K6f4fKnrhYGKYmuF6IW1Pklo/NHe1FprUT1r28BpARpREovS3aAyDX3uOcEfVgv86w8fZK9TegjMlQaj8R1QEJIl9CLc1fmvnlYwG0YGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPaVK6mG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPaVK6mG"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2e22a1bed91so57599371fa.0;
        Wed, 08 May 2024 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715179070; x=1715783870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xEsgtjhIb67o8dmnbn0ijNuUBqVJ1mlV7N11u3Yqj0=;
        b=lPaVK6mGBGDcdxJvx4fRyexeKQFXBCcXjhFpgWnOP/YjwTDDN2VUSmjkUoaFzYeIXh
         K7gzGnNVbLb60wqCcaNsfECVzu8/ZfYxQQQdx7/82f8XYGJnoY5kbh0MVzf7JlSLUjQf
         xiefnwfvVtzkobYSXdK3ctJuEFfdwc6qrtAkJHvP4SFpifoObKHWCDSN1M1orFFQ17Bf
         au6CQZM6Ww7SoerdxhRdw82w2jXSWTx241L4cwm7mi3qaS+mN+qhcaC/z8c8TNY0Mh0H
         EWbHM+zkoJ6BbFFIkcbmwTTeUOnd6PISeb8Mkz0rxPHkowHn9LFczlMvZFVOaq//ndHO
         p9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715179070; x=1715783870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xEsgtjhIb67o8dmnbn0ijNuUBqVJ1mlV7N11u3Yqj0=;
        b=wyP/a89eihh8ks74hJIDLd7G31XixcFztK67ggbi6lgHd38cwyA5lHo7qt+CzqJMCN
         znYahvJ7MaSn5vQn/4DgaBF2vQQ8Ca5K+FwY4uwg88IlQyWHVrNQArwwuyVrgccOSz7L
         Rc5NAOjfp1ql3pfvtb/8mxS50im4c6+5GKAXPbDSeRuTKpRGmlTY7MLzwSy2q+Kng5Fp
         whRKxwiAPhcd2E1jpBJ+DjZAF6kEIDBUM48sc+qWuErzbHGreOtM2GY2rvWOYd8sR+RV
         /djokfQgRize9BqAbCQTHfbmq8jogrmK8YRAXs1eZeIklkg6zzJMSbwBuoOhbeDq3XuZ
         7hnA==
X-Forwarded-Encrypted: i=1; AJvYcCX+tO3cJphZqjSpKtgt6RPW4BoQgdU3VgBfpGE4kgPL4ylo+lY08P6oTOskeiLh80eY2hxY3zvbYsxAtW5lwUOWQlcud18xn3pbFWubrPdoEc98T5SuyDEVCA2nXbHfQ8yo6oBXy5uncZ9NGnoF
X-Gm-Message-State: AOJu0YzWvzOV4vRuMPzMdsGKqJFU+gEGVlxUMRccVg3uw0ZTYRvKolIZ
	ufduEx/sp/KDThBLLBJAw1d9FkR6tlWH1Ds+VTxu/KnhUoX3w4gmNsZfJVKsrknqyghBaxR9YT0
	8rTEpGy+JLA3j7IXfcDcAh/Opze4=
X-Google-Smtp-Source: AGHT+IEtd4mai1/RSnx1sodt2ztNxupN11yzK5OtIGIUAo2B68m7Slrvnzjv8SPPecfS9DsZKTC378UPvuO26tKadCs=
X-Received: by 2002:a2e:2286:0:b0:2e1:691b:da0b with SMTP id
 38308e7fff4ca-2e446f772cemr17059791fa.12.1715179070238; Wed, 08 May 2024
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
 <202405081456.v2MvcQ0P-lkp@intel.com>
In-Reply-To: <202405081456.v2MvcQ0P-lkp@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 8 May 2024 10:37:37 -0400
Message-ID: <CABBYNZLH7mGdP7AcdHnY8q=3i=Lupk-D2Af4G5X4o1_XdbTfVw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw name
To: kernel test robot <lkp@intel.com>
Cc: sean.wang@kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, 
	oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Wed, May 8, 2024 at 3:13=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bluetooth/master]
> [also build test WARNING on bluetooth-next/master linus/master v6.9-rc7 n=
ext-20240507]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel-o=
rg/Bluetooth-btmtk-apply-the-common-btmtk_fw_get_filename/20240508-032333
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th.git master
> patch link:    https://lore.kernel.org/r/965cd14922aea67e2750ff2c2ecad773=
f8ba485a.1715109394.git.sean.wang%40kernel.org
> patch subject: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get t=
he fw name
> config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240508=
/202405081456.v2MvcQ0P-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240508/202405081456.v2MvcQ0P-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202405081456.v2MvcQ0P-lkp=
@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    drivers/bluetooth/btmtk.c: In function 'btmtk_fw_get_filename':
> >> drivers/bluetooth/btmtk.c:115:35: warning: 'mediatek/BT_RAM_CODE_MT' d=
irective output truncated writing 23 bytes into a region of size 8 [-Wforma=
t-truncation=3D]
>      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hd=
r.bin",
>          |                           ~~~~~~~~^~~~~~~~~~~~~~~
>    drivers/bluetooth/btmtk.c:115:26: note: directive argument in the rang=
e [1, 256]
>      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hd=
r.bin",
>          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~
>    drivers/bluetooth/btmtk.c:114:17: note: 'snprintf' output between 41 a=
nd 43 bytes into a destination of size 8
>      114 |                 snprintf(buf, sizeof(size),
>          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hd=
r.bin",
>          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
>      116 |                          dev_id & 0xffff, (fw_ver & 0xff) + 1)=
;
>          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
> vim +115 drivers/bluetooth/btmtk.c
>
>    105
>    106  void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u3=
2 fw_ver,
>    107                             u32 fw_flavor)
>    108  {
>    109          if (dev_id =3D=3D 0x7925)
>    110                  snprintf(buf, size,
>    111                           "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_%x=
_hdr.bin",
>    112                           dev_id & 0xffff, dev_id & 0xffff, (fw_ve=
r & 0xff) + 1);
>    113          else if (dev_id =3D=3D 0x7961 && fw_flavor)
>    114                  snprintf(buf, sizeof(size),
>  > 115                           "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr.b=
in",
>    116                           dev_id & 0xffff, (fw_ver & 0xff) + 1);
>    117          else
>    118                  snprintf(buf, size,
>    119                           "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bi=
n",
>    120                           dev_id & 0xffff, (fw_ver & 0xff) + 1);
>    121  }
>    122  EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
>    123

Could you please fix the above?

--=20
Luiz Augusto von Dentz
