Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5C421373;
	Wed,  8 May 2024 20:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715200707; cv=none; b=aDCeQYooxkQ/XAB0vR+s7Potm4witx7P6sYzyvNcX08i9rvwvLcQtUmo2b8waWohO9k0lzXOKRn8I+91j0z4ptDb11FH/ooQAXezi4P7bs34yNgI4iyYDKowZYQMwbH3YpwjI95xkjoXcqd+pOvbIJT+d+PkLsD4Fsy+Z/Iunvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715200707; c=relaxed/simple;
	bh=iELKPKEBdzp99N3dT3F0Gig++k6H1GB9X40m4RmGOXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYdE9qB14Qf44qjx91M9s2bf2uClj6qmtTjyhwga2zYdPG604hV/lwrz/WTCfR/molBbANymgbPdGtoQtWm4ZuP3ETKsdOEnzOBklFeZKUkH7yMgiQxBxQCN4Jo4psUq1/Kt+VoEg9kxiJMRgh5rqSJo2h2EvHOxrv0qxNeTeh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBNAqTg4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBNAqTg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EABC32781;
	Wed,  8 May 2024 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715200707;
	bh=iELKPKEBdzp99N3dT3F0Gig++k6H1GB9X40m4RmGOXA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kBNAqTg4HplcgEYFfj01exaT7HAJ7N+FPWaC/TIuRtChjY8DK2FRDaX93GhxSEBw7
	 FAqPYf0Z18yxPQAcd9/CTsXCX3Iu9+hhdjy2Bw+6EehEFvSs0k/YeYRowDbHru8Stb
	 MdErkMNhjlkl+hEmuA9AgEQ8V0nS8H+G5C+FWaD/c1iH9sBWOReEbWP4GrqW7VmnZ5
	 DNuz5abzNzoJPXy3uXPuJNUpC4KgjvtX4pUNY+0OaQIMsU3ww6uMWEsn9Hn2OibqCt
	 JFqASvEe7AAt9FyFBGujWXAB5TJF2A/wWAlcHSz/kj3VrEB+8Xnh+7pbYPcfdlq6w+
	 +X3hN60qFmhfA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59a0906a7aso4850866b.1;
        Wed, 08 May 2024 13:38:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAijkNLekEGLzMvNPljSC2ZTHkH4+REHzUGN2DJEi6330ZtFx24cOeiwuJFQdK0PklMlT1dDzy3Yr9XsqeJoXUtHm6evkf5uOkrYZzCv87Ej4lPcpbosKS7JazcHF31fD0hufWX67KNye4U9vL
X-Gm-Message-State: AOJu0YySI0rWf4wM7UwJa5KSV1BlSmt2KBo78LkRaskr4hCex/elJoC8
	uCdXPjdvVaZhy7qzp0FdEu3dhoup5McFsSWCZOu7/WKefo3P7X+BZe3e+UIYdM+E6CTD7tZYfUc
	N5e0C4OK4bVNKpBu7vy75jnFdR2s=
X-Google-Smtp-Source: AGHT+IGl3o8/eHyjVt0T4UwXGfTaWvH2xFalvsf84UytUpmXoRi9teX9R7b2iY+GS6HtUaWKgNUfBGoI1uT+V5ZO1m8=
X-Received: by 2002:a17:906:df14:b0:a59:bce9:8454 with SMTP id
 a640c23a62f3a-a59fb94f6d3mr232661766b.1.1715200705917; Wed, 08 May 2024
 13:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <965cd14922aea67e2750ff2c2ecad773f8ba485a.1715109394.git.sean.wang@kernel.org>
 <202405081456.v2MvcQ0P-lkp@intel.com> <CABBYNZLH7mGdP7AcdHnY8q=3i=Lupk-D2Af4G5X4o1_XdbTfVw@mail.gmail.com>
In-Reply-To: <CABBYNZLH7mGdP7AcdHnY8q=3i=Lupk-D2Af4G5X4o1_XdbTfVw@mail.gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Wed, 8 May 2024 13:38:13 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrNE9Hi-a9y8oQMXmug44k7VUsmcDiAiXgbFu8bLbtFTg@mail.gmail.com>
Message-ID: <CAGp9LzrNE9Hi-a9y8oQMXmug44k7VUsmcDiAiXgbFu8bLbtFTg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get the fw name
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: kernel test robot <lkp@intel.com>, marcel@holtmann.org, johan.hedberg@gmail.com, 
	oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Sean Wang <sean.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, May 8, 2024 at 7:37=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sean,
>
> On Wed, May 8, 2024 at 3:13=E2=80=AFAM kernel test robot <lkp@intel.com> =
wrote:
> >
> > Hi,
> >
> > kernel test robot noticed the following build warnings:
> >
> > [auto build test WARNING on bluetooth/master]
> > [also build test WARNING on bluetooth-next/master linus/master v6.9-rc7=
 next-20240507]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/sean-wang-kernel=
-org/Bluetooth-btmtk-apply-the-common-btmtk_fw_get_filename/20240508-032333
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluet=
ooth.git master
> > patch link:    https://lore.kernel.org/r/965cd14922aea67e2750ff2c2ecad7=
73f8ba485a.1715109394.git.sean.wang%40kernel.org
> > patch subject: [PATCH v4 1/5] Bluetooth: btmtk: add the function to get=
 the fw name
> > config: arm64-defconfig (https://download.01.org/0day-ci/archive/202405=
08/202405081456.v2MvcQ0P-lkp@intel.com/config)
> > compiler: aarch64-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20240508/202405081456.v2MvcQ0P-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202405081456.v2MvcQ0P-l=
kp@intel.com/
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/bluetooth/btmtk.c: In function 'btmtk_fw_get_filename':
> > >> drivers/bluetooth/btmtk.c:115:35: warning: 'mediatek/BT_RAM_CODE_MT'=
 directive output truncated writing 23 bytes into a region of size 8 [-Wfor=
mat-truncation=3D]
> >      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_=
hdr.bin",
> >          |                           ~~~~~~~~^~~~~~~~~~~~~~~
> >    drivers/bluetooth/btmtk.c:115:26: note: directive argument in the ra=
nge [1, 256]
> >      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_=
hdr.bin",
> >          |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~
> >    drivers/bluetooth/btmtk.c:114:17: note: 'snprintf' output between 41=
 and 43 bytes into a destination of size 8
> >      114 |                 snprintf(buf, sizeof(size),
> >          |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >      115 |                          "mediatek/BT_RAM_CODE_MT%04x_1a_%x_=
hdr.bin",
> >          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> >      116 |                          dev_id & 0xffff, (fw_ver & 0xff) + =
1);
> >          |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> >
> >
> > vim +115 drivers/bluetooth/btmtk.c
> >
> >    105
> >    106  void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, =
u32 fw_ver,
> >    107                             u32 fw_flavor)
> >    108  {
> >    109          if (dev_id =3D=3D 0x7925)
> >    110                  snprintf(buf, size,
> >    111                           "mediatek/mt%04x/BT_RAM_CODE_MT%04x_1_=
%x_hdr.bin",
> >    112                           dev_id & 0xffff, dev_id & 0xffff, (fw_=
ver & 0xff) + 1);
> >    113          else if (dev_id =3D=3D 0x7961 && fw_flavor)
> >    114                  snprintf(buf, sizeof(size),
> >  > 115                           "mediatek/BT_RAM_CODE_MT%04x_1a_%x_hdr=
.bin",
> >    116                           dev_id & 0xffff, (fw_ver & 0xff) + 1);
> >    117          else
> >    118                  snprintf(buf, size,
> >    119                           "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.=
bin",
> >    120                           dev_id & 0xffff, (fw_ver & 0xff) + 1);
> >    121  }
> >    122  EXPORT_SYMBOL_GPL(btmtk_fw_get_filename);
> >    123
>
> Could you please fix the above?

No problem, I'll take care of it and send it over later.

                 Sean
>
> --
> Luiz Augusto von Dentz
