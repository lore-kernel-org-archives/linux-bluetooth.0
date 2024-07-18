Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F923DDB8
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721312659; cv=none; b=BJ5wRE5xC87gx3bE6Gh7OG7ydEM2ki4er+W+tIw3CymyCAhTE7fY3N27Be6n9l5sZb3RG6c/hzCh3s0GqiNt3UVbI4mSBem7xOeoUERD4vVs7ExipZrR03FNMi/bMPVn9nNVCcnmeBqc0NZUfBuku7Mj28htUGl7ngaGYPLuMH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721312659; c=relaxed/simple;
	bh=DEFKkXDQlyGsiKBGLEa0zsLifE8teUXywbeNhD8znlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uv/ZmtqxOXGBdgjVnFcNcg7qTJHxDhZMWBtPsBLLNjTHCs25y0QNCoQjzA2MQUZtKofxBo43JMbRJQ2LhZCcyOLPOyLlRPq3//YHb3PHAefJkzmJRrTZlZ56czdhzlWUtvYHxU89ExW5JBg/LIXB6SG/0E/WOS/72SsAk+Tx510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsh01yda; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsh01yda"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eee1384e0aso11570881fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 07:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721312655; x=1721917455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SO+IA4w+B0eKwnfI8b8L6Kzp4ykBtet+GyFuIETOooY=;
        b=Jsh01ydaCwNMZxZYw0op1CgkRYF9ey4LHH3Oym0d08wfJ9OAdSFdh2lcQpSrd0pnq5
         tb/xhwd4GtpYB4ot10VatrPQl3Nya93umD4DbLVy69/TygqC2mR7r7kSxVd18DWH9XBO
         fXDA/BY1CaDm5N+mT+EiF/ibtf6xMP6G2BZu9hv/inE8T1TYEol+iV1R+Kml1udw9AYB
         FUI7KTPetpMdWVrn5JwPLSaaDeboBGyMkNasI6NQkjHIcgPFGuQdezKMpInAur7Gt4Js
         TymAIW/X6qaU9kWrSJ+kXoKFgwfU/bCL5bcEGt1rjlqgV1wHHqTGpXKQWX5xQPPhmcI4
         iv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721312655; x=1721917455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SO+IA4w+B0eKwnfI8b8L6Kzp4ykBtet+GyFuIETOooY=;
        b=UBEnzILV8Wae/Gt/a+RsrInyT51qmxzKhI9+YFHl5k2qJCDvf4tbR6NpPcjbhM+cye
         0xH+ykZO7ZogdBjF1gyOqmsvLY4xRYZ+rD1ZoBX1VCrCRZ+eduhkhjaFToVGDfx27th8
         W5kIP9ALv3SUuBciuNvHjR8cIue29SX/8Ju21BE4j+szzk9QBQoF63XqWdNP3VdNb1Q8
         o6ze05EhoIkIBia80Logq7oJCpqwhfWgvauzjVNP+owqyhMxIGZjuMiSlMecEk0ywU+w
         6YwWNW+MH/RK7ftZBhawFAVEf0lWnk+/Tn84S+YBOVri3tmC4I3AFfbYY1P+eP5QLqGF
         y/pw==
X-Forwarded-Encrypted: i=1; AJvYcCXP55XWrdxXcyyo6NBBqJNCII06qRzVHswP3kGPtwMHUKEsfwHhnLNSXTYpEeLhCwnqddY80apgK2mUY5chGMgunUP3V5X1q0YKC9mnO2IM
X-Gm-Message-State: AOJu0YyK6oE0ERFk/OhUZ58gU2pKR5YqszyAYrX2xEPmQhw+mHBmLvI0
	7Zd51cWBeFyu8zrf4FmFioMOBmq9zKbTsfIcWYTGA8ZZKkE88aH0ATw+87EuDewyhXx0gIC/k2O
	JJW54bpNfXgmIzNFF4kuYgr15HTZt9Q==
X-Google-Smtp-Source: AGHT+IHdZEWSA6wDZ3k5aLBS+kXqPkjQdm4HLtiqVyHX0OZnl9oufdCWz2pGscqp+gmttUz/eJrZfOVSe8QnB37/LlM=
X-Received: by 2002:a2e:9a85:0:b0:2ec:5061:d7d2 with SMTP id
 38308e7fff4ca-2ef05c6ff2bmr16656261fa.18.1721312654832; Thu, 18 Jul 2024
 07:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202407182017.s3aT6Gyx-lkp@intel.com>
In-Reply-To: <202407182017.s3aT6Gyx-lkp@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 18 Jul 2024 10:24:02 -0400
Message-ID: <CABBYNZKGokegMmMZ+_4z_o5kRpRGeMAOXbUmKWhMnYtF90=ZmQ@mail.gmail.com>
Subject: Re: [bluetooth-next:master] BUILD REGRESSION 54dd4796336de8ce5cbf344db837f9b8448ebcf8
To: kernel test robot <lkp@intel.com>, Chris Lu <chris.lu@mediatek.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Thu, Jul 18, 2024 at 8:10=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bl=
uetooth-next.git master
> branch HEAD: 54dd4796336de8ce5cbf344db837f9b8448ebcf8  Bluetooth: hci_syn=
c: Fix suspending with wrong filter policy
>
> Error/Warning ids grouped by kconfigs:
>
> recent_errors
> |-- arm64-randconfig-051-20240718
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetoo=
th:vddbtcmx-supply-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetoo=
th:vddrfa0p8-supply-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetoo=
th:vddrfa1p2-supply-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetoo=
th:vddrfa1p7-supply-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5-vision-mezzanine.dtb:bluetoo=
th:vddrfacmn-supply-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddbtcmx-suppl=
y-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa0p8-supp=
ly-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p2-supp=
ly-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfa1p7-supp=
ly-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-qrb5165-rb5.dtb:bluetooth:vddrfacmn-supp=
ly-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfa1p8-suppl=
y-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddrfacmn-suppl=
y-is-a-required-property
> |   |-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlcx-supply-=
is-a-required-property
> |   `-- arch-arm64-boot-dts-qcom-sm8650-qrd.dtb:bluetooth:vddwlmx-supply-=
is-a-required-property
> `-- i386-randconfig-006-20240718
>     |-- ERROR:usb_alloc_urb-drivers-bluetooth-btmtk.ko-undefined
>     |-- ERROR:usb_anchor_urb-drivers-bluetooth-btmtk.ko-undefined
>     |-- ERROR:usb_control_msg-drivers-bluetooth-btmtk.ko-undefined
>     |-- ERROR:usb_free_urb-drivers-bluetooth-btmtk.ko-undefined
>     `-- ERROR:usb_submit_urb-drivers-bluetooth-btmtk.ko-undefined


Looks like there are still problems with btmtk.c, is that file
exclusive to interface to btusb.c?

> elapsed time: 937m
>
> configs tested: 184
> configs skipped: 4
>
> tested configs:
> alpha                            alldefconfig   gcc-13.3.0
> alpha                             allnoconfig   gcc-13.2.0
> alpha                             allnoconfig   gcc-13.3.0
> alpha                            allyesconfig   gcc-13.3.0
> alpha                               defconfig   gcc-13.2.0
> arc                              allmodconfig   gcc-13.2.0
> arc                               allnoconfig   gcc-13.2.0
> arc                              allyesconfig   gcc-13.2.0
> arc                                 defconfig   gcc-13.2.0
> arm                              allmodconfig   gcc-13.2.0
> arm                              allmodconfig   gcc-14.1.0
> arm                               allnoconfig   clang-19
> arm                               allnoconfig   gcc-13.2.0
> arm                              allyesconfig   gcc-13.2.0
> arm                              allyesconfig   gcc-14.1.0
> arm                                 defconfig   gcc-13.2.0
> arm                            hisi_defconfig   gcc-13.3.0
> arm                          moxart_defconfig   gcc-14.1.0
> arm                         nhk8815_defconfig   gcc-14.1.0
> arm                           spitz_defconfig   gcc-13.3.0
> arm                       versatile_defconfig   gcc-13.3.0
> arm                        vexpress_defconfig   gcc-14.1.0
> arm                         vf610m4_defconfig   gcc-13.3.0
> arm64                            allmodconfig   clang-19
> arm64                            allmodconfig   gcc-13.2.0
> arm64                             allnoconfig   gcc-13.2.0
> arm64                             allnoconfig   gcc-14.1.0
> arm64                               defconfig   gcc-13.2.0
> csky                              allnoconfig   gcc-13.2.0
> csky                              allnoconfig   gcc-14.1.0
> csky                                defconfig   gcc-13.2.0
> hexagon                          allmodconfig   clang-19
> hexagon                           allnoconfig   clang-19
> hexagon                          allyesconfig   clang-19
> i386                             allmodconfig   clang-18
> i386                             allmodconfig   gcc-13
> i386                              allnoconfig   clang-18
> i386                              allnoconfig   gcc-13
> i386                             allyesconfig   clang-18
> i386                             allyesconfig   gcc-13
> i386         buildonly-randconfig-001-20240718   gcc-11
> i386         buildonly-randconfig-002-20240718   gcc-11
> i386         buildonly-randconfig-002-20240718   gcc-7
> i386         buildonly-randconfig-003-20240718   gcc-11
> i386         buildonly-randconfig-003-20240718   gcc-13
> i386         buildonly-randconfig-004-20240718   clang-18
> i386         buildonly-randconfig-004-20240718   gcc-11
> i386         buildonly-randconfig-005-20240718   gcc-11
> i386         buildonly-randconfig-005-20240718   gcc-9
> i386         buildonly-randconfig-006-20240718   gcc-11
> i386         buildonly-randconfig-006-20240718   gcc-13
> i386                                defconfig   clang-18
> i386                  randconfig-001-20240718   gcc-11
> i386                  randconfig-001-20240718   gcc-13
> i386                  randconfig-002-20240718   gcc-11
> i386                  randconfig-002-20240718   gcc-13
> i386                  randconfig-003-20240718   clang-18
> i386                  randconfig-003-20240718   gcc-11
> i386                  randconfig-004-20240718   clang-18
> i386                  randconfig-004-20240718   gcc-11
> i386                  randconfig-005-20240718   clang-18
> i386                  randconfig-005-20240718   gcc-11
> i386                  randconfig-006-20240718   clang-18
> i386                  randconfig-006-20240718   gcc-11
> i386                  randconfig-011-20240718   gcc-11
> i386                  randconfig-011-20240718   gcc-13
> i386                  randconfig-012-20240718   gcc-11
> i386                  randconfig-012-20240718   gcc-13
> i386                  randconfig-013-20240718   gcc-10
> i386                  randconfig-013-20240718   gcc-11
> i386                  randconfig-014-20240718   clang-18
> i386                  randconfig-014-20240718   gcc-11
> i386                  randconfig-015-20240718   clang-18
> i386                  randconfig-015-20240718   gcc-11
> i386                  randconfig-016-20240718   gcc-11
> i386                  randconfig-016-20240718   gcc-13
> loongarch                        alldefconfig   gcc-14.1.0
> loongarch                        allmodconfig   gcc-14.1.0
> loongarch                         allnoconfig   gcc-13.2.0
> loongarch                         allnoconfig   gcc-14.1.0
> loongarch                           defconfig   gcc-13.2.0
> m68k                             allmodconfig   gcc-14.1.0
> m68k                              allnoconfig   gcc-13.2.0
> m68k                              allnoconfig   gcc-14.1.0
> m68k                             allyesconfig   gcc-14.1.0
> m68k                         amcore_defconfig   gcc-13.3.0
> m68k                                defconfig   gcc-13.2.0
> m68k                        mvme16x_defconfig   gcc-14.1.0
> m68k                           virt_defconfig   gcc-13.3.0
> microblaze                       allmodconfig   gcc-14.1.0
> microblaze                        allnoconfig   gcc-13.2.0
> microblaze                        allnoconfig   gcc-14.1.0
> microblaze                       allyesconfig   gcc-14.1.0
> microblaze                          defconfig   gcc-13.2.0
> mips                              allnoconfig   gcc-13.2.0
> mips                              allnoconfig   gcc-14.1.0
> mips                         cobalt_defconfig   gcc-13.3.0
> mips                         db1xxx_defconfig   gcc-14.1.0
> mips                  decstation_64_defconfig   gcc-14.1.0
> mips                           ip27_defconfig   gcc-13.3.0
> mips                        maltaup_defconfig   gcc-14.1.0
> nios2                             allnoconfig   gcc-13.2.0
> nios2                             allnoconfig   gcc-14.1.0
> nios2                               defconfig   gcc-13.2.0
> openrisc                          allnoconfig   gcc-14.1.0
> openrisc                         allyesconfig   gcc-14.1.0
> openrisc                            defconfig   gcc-14.1.0
> parisc                           allmodconfig   gcc-14.1.0
> parisc                            allnoconfig   gcc-14.1.0
> parisc                           allyesconfig   gcc-14.1.0
> parisc                              defconfig   gcc-14.1.0
> parisc64                            defconfig   gcc-13.2.0
> powerpc                          allmodconfig   gcc-14.1.0
> powerpc                           allnoconfig   gcc-14.1.0
> powerpc                          allyesconfig   clang-19
> powerpc                          allyesconfig   gcc-14.1.0
> powerpc                 canyonlands_defconfig   gcc-13.3.0
> powerpc                   microwatt_defconfig   gcc-13.3.0
> powerpc                 mpc834x_itx_defconfig   gcc-13.3.0
> powerpc                  mpc866_ads_defconfig   gcc-14.1.0
> powerpc                      ppc64e_defconfig   gcc-14.1.0
> powerpc                      ppc6xx_defconfig   gcc-13.3.0
> powerpc                     tqm8548_defconfig   gcc-13.3.0
> powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
> riscv                            allmodconfig   clang-19
> riscv                            allmodconfig   gcc-14.1.0
> riscv                             allnoconfig   gcc-14.1.0
> riscv                            allyesconfig   clang-19
> riscv                            allyesconfig   gcc-14.1.0
> riscv                               defconfig   gcc-14.1.0
> s390                             allmodconfig   clang-19
> s390                              allnoconfig   clang-19
> s390                             allyesconfig   clang-19
> s390                             allyesconfig   gcc-14.1.0
> s390                                defconfig   gcc-14.1.0
> sh                               allmodconfig   gcc-14.1.0
> sh                                allnoconfig   gcc-13.2.0
> sh                                allnoconfig   gcc-14.1.0
> sh                               allyesconfig   gcc-14.1.0
> sh                         apsh4a3a_defconfig   gcc-13.3.0
> sh                        apsh4ad0a_defconfig   gcc-13.3.0
> sh                                  defconfig   gcc-14.1.0
> sh                         ecovec24_defconfig   gcc-14.1.0
> sh                        sh7763rdp_defconfig   gcc-13.3.0
> sparc                            allmodconfig   gcc-14.1.0
> sparc64                             defconfig   gcc-14.1.0
> um                               allmodconfig   clang-19
> um                                allnoconfig   clang-17
> um                               allyesconfig   gcc-13
> um                                  defconfig   gcc-14.1.0
> um                             i386_defconfig   gcc-14.1.0
> um                           x86_64_defconfig   gcc-14.1.0
> x86_64                            allnoconfig   clang-18
> x86_64                           allyesconfig   clang-18
> x86_64       buildonly-randconfig-001-20240718   gcc-11
> x86_64       buildonly-randconfig-002-20240718   gcc-11
> x86_64       buildonly-randconfig-003-20240718   gcc-11
> x86_64       buildonly-randconfig-004-20240718   gcc-11
> x86_64       buildonly-randconfig-005-20240718   gcc-11
> x86_64       buildonly-randconfig-006-20240718   gcc-11
> x86_64                              defconfig   clang-18
> x86_64                              defconfig   gcc-13
> x86_64                randconfig-001-20240718   gcc-11
> x86_64                randconfig-002-20240718   gcc-11
> x86_64                randconfig-003-20240718   gcc-11
> x86_64                randconfig-004-20240718   gcc-11
> x86_64                randconfig-005-20240718   gcc-11
> x86_64                randconfig-006-20240718   gcc-11
> x86_64                randconfig-011-20240718   gcc-11
> x86_64                randconfig-012-20240718   gcc-11
> x86_64                randconfig-013-20240718   gcc-11
> x86_64                randconfig-014-20240718   gcc-11
> x86_64                randconfig-015-20240718   gcc-11
> x86_64                randconfig-016-20240718   gcc-11
> x86_64                randconfig-071-20240718   gcc-11
> x86_64                randconfig-072-20240718   gcc-11
> x86_64                randconfig-073-20240718   gcc-11
> x86_64                randconfig-074-20240718   gcc-11
> x86_64                randconfig-075-20240718   gcc-11
> x86_64                randconfig-076-20240718   gcc-11
> x86_64                          rhel-8.3-rust   clang-18
> xtensa                            allnoconfig   gcc-13.2.0
> xtensa                            allnoconfig   gcc-14.1.0
> xtensa                  audio_kc705_defconfig   gcc-14.1.0
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>


--=20
Luiz Augusto von Dentz
