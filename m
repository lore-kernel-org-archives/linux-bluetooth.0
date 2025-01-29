Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FC2481CD;
	Wed, 29 Jan 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738157224; cv=none; b=WMKoFQ/Z49CyIh5HxTQ0ZUqo0JpdNNkiqx9m7I29K69jtsCdvxSHCavueTABIghZ01Ai99fSZJbcl6fohUmqf6d8WGFx/bbjaq0DwZKMjzDQMhSmHpMc9jFuxNb793QFcd/zQGjphE7fR9DJ5DDCy7N0gcg71fzhlNP1jmDxKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738157224; c=relaxed/simple;
	bh=Mfa12/3dagFXIQxteRwucVkVBHF3oQe15nLtcgIC8A8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Qba9EtD3bDg0DEHnAOprOWfMGl2AVkgmIYgSC8JvbfMxVdJr+VKJrNUzAUxbtPH/AigAxDGBfzcYyiUfHGMaVUF3vVQAaxjW0SpMDPgW+ZXSxOMtc+pFdSlFzdmTNu88NHE6yq+tHsQxbTkwUWjK/koDiwyIbkoMnOce7ZJErfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khVPXUQU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khVPXUQU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC823C4CEE1;
	Wed, 29 Jan 2025 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738157223;
	bh=Mfa12/3dagFXIQxteRwucVkVBHF3oQe15nLtcgIC8A8=;
	h=From:Date:Subject:To:Cc:From;
	b=khVPXUQUlfZnMM6lWe4W8g38X7Hyh2LanI5TyAuf0mIlM5cVfTqnniwyifmR0Y57G
	 b3WD9C/BSm2tGOxWlg3O+bUEHdS18uCdy7kjXwo2MW61RnKD1nMTP6UUwg1vgwjmLD
	 bLbvV7rIGYtrMiDb4JNVQjErFUTCyi+1Ba8bWW1859DpribNfLLVlAiucDi35OQblr
	 BcSd9VUu7YfR6jDSedFJaU4pDwE+nRHeV6nr48culReg3C8WNOzdn8nRGj4sYZ/TsG
	 LoIndqsjMETzVbpSIq7FhYRT0EfRvTP7skvynLjfT7qCOMhQ63aY1NgMLT/1k+y4Bo
	 JD9rvXrXcYY6w==
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-467b086e0easo37522641cf.1;
        Wed, 29 Jan 2025 05:27:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVb0Ds6XTWl1LLxKXcrEccbUcvC2FjBZGi0EXo2gv/6zrLoSSSuke7bSOTTQYsEFf8mwKtsZH3b5xqxbkeC@vger.kernel.org, AJvYcCXpeq1w4h3nKqmUuxL7Jotblmc6C0PMSG6gbNE8VRJsQzXDJWLCkDuJPTxeyGsmw5sZCsOMH7l8O2kcumfUu/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA3qw48KIHRnsjzP7kf316Jf+C4BmOpyCK9jbMTWo5PPpMgv1Y
	imvDTeeFsTgMK+kKwmQ+ElzRM3nvUCq+3QByzEDuDFDZQ2lxXBL2asBEdDOwytgzqFo6VALsA2T
	4qD3C5RbpZXT1nLGgRp4El44zLu8=
X-Google-Smtp-Source: AGHT+IF3V7pM2KPee3yamrKIEOQ80b0zyd5llLfBZYhtv36o50dOFjY/3cn1Hu5CUiMEsdWQuZM16IX1FTiLcwrsJKk=
X-Received: by 2002:a05:6214:3007:b0:6e1:69ba:346 with SMTP id
 6a1803df08f44-6e243bb8251mr53436316d6.10.1738157222765; Wed, 29 Jan 2025
 05:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 29 Jan 2025 14:26:51 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNj0i_gxiuZFFY=87s+h4GV43u+ORiTi0CHOxe-R3eGrQg@mail.gmail.com>
X-Gm-Features: AWEUYZnw9SGuU_33W5iHB0as5Z81p9h24noU0-XoMxGpZkxFiqwh8rH5CpVCeDw
Message-ID: <CAJ+HfNj0i_gxiuZFFY=87s+h4GV43u+ORiTi0CHOxe-R3eGrQg@mail.gmail.com>
Subject: Linux RISC-V Patchwork CI updates
To: linux-riscv <linux-riscv@lists.infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <mail@conchuod.ie>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Charlie Jenkins <charlie@rivosinc.com>, Tedd An <tedd.an@intel.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, LKML <linux-kernel@vger.kernel.org>, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

I just deployed a new, and hopefully improved, version of the Linux
RISC-V Patchwork CI.

The PW CI is the thing that posts the "check stoplights" to the Linux
RISC-V Patchwork instance [1]. IOW, a pre-commit CI.

Changes
-------

* The test framework is now using Python, instead of a pile of Bash. A
  lot of the code is heavily based on bzcafe [2]. Bash only takes you
  that far. ;-)

* Email support; The framework will mail the submitter(s) with the CI
  results, for better visibility. Currently, I'm the only recipient of
  mails to make sure that the framework doesn't spam too much. I'll
  flip the switch sometime this week.

* Failed tests will have the details in a Github Gist page, linked
  from the Patchwork patch view.

* The framework will post updates/results as comments to the pull
  request corresponding to the Patchwork series, e.g. [3]. This is in
  addition to the Gist links above.

* Moved from Meta's KDP daemon (external Python daemon that
  synchronizes the mailing list with Github), in favor of the
  Bluetooth folks bzcafe scripts [2]. This change makes the whole PW CI
  self-contained as a set of Github Action set of files, and hopefully
  open up for other folks to hack the CI (nudge, nudge).

Details (for those who care, or would like to push PRs)
-------------------------------------------------------

The CI code resides in linux-riscv/github-ci [4]. Additions to this
repo will automatically be picked up the linux-riscv/linux [5] where
the CI is run.

Currently, there are 6 branches:
  master, workflow
  {master,workflow}__riscv__fixes
  {master,workflow}__riscv__for-next

master is a mirror of Linus' master [6], and fixes/for-next is the
RISC-V tree [7]. The "workflow" is the master, but with the PW CI [4]
applied as one commit on top.

The branches above are synched by a Github cronjob, run by sync.yml
[8]. The sync.yml action synchronizes all the branches, and then
fetches the latest "New" patches from Patchwork in the last 7 days.

The script then tries to apply the series in the following order:
  1. workflow__riscv__fixes
  2. workflow__riscv__for-next
  3. workflow

If all three fail, the submitter will be notified. If any of them
succeeds, a Github PR is created for the series. IOW, all the ongoing
tests for patches can be found here [9].

The test for a series will be run in the context of a PR, and all
information can be found there. The code for the Patchwork tests can be
followed from the workflow [10].

RISE is continuing to sponsor the self hosted Github Runners, and soon
we'll move from 4 to 8 instances, which will allow for more tests.


Cheers,
Bj=C3=B6rn

[1] https://patchwork.kernel.org/project/linux-riscv/list/
[2] https://github.com/tedd-an/bzcafe
[3] https://github.com/linux-riscv/linux/pull/2
[4] https://github.com/linux-riscv/github-ci/
[5] https://github.com/linux-riscv/linux/
[6] git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
[7] git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
[8] https://github.com/linux-riscv/github-ci/blob/main/.github/workflows/sy=
nc.yml
[9] https://github.com/linux-riscv/linux/pulls
[10] https://github.com/linux-riscv/github-ci/blob/main/.github/workflows/p=
atchwork.yml
