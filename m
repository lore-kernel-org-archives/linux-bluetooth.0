Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419384EA39A
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780394; cv=pass; b=qrLI4AS6zjLL2aQyBM0PSLUaWX6m7zdTaQCOfMpeifsliYyb0IzDbeI6KKgL2mS7upzls++7Nxzyeh+7kEH1LHDPfVYpJDF9X9g9ESvP/qiIVuFRz63ntGvwQYTeBbLZp1i/kaRtK6vCdCCdGC5cTrpqbhEiyXB6hbWdDCkw4A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780394; c=relaxed/simple;
	bh=+2qryLs+HYMctsanqSRc38d4Wf2fFSRREcvmqitqk9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJanHWo1LkmJ99FXNISQwm76LzZ8vGq1eUm7LxN6SgB74wk8NCe29UE51QZaGB7qVTCcx81UlINqOyGbaO3Toz9TWsA0nNvOGkR/r0M9eghmiGCRqqUPyvlIk5G3E8IvS5ofcbY0EX+rXERWMTY1+iOGhmBaYOKJuW9WEmTMbNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlKGhEUR; arc=pass smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlKGhEUR"
Received: by mail-yx2-f40.google.com with SMTP id 00721157ae682-8abc87cbd93so11602487b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:59:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790780380; cv=none;
        d=google.com; s=arc-20260327;
        b=a/BgqdDzl843Pt13qX6I8Cj8g7oXKEbM+tTdKzhZfjVqCfIKZHzO7p7KhsSHi4Sopl
         orbKyFWgf1Lvar+YFpI2Df0XmbU9D+uY7bM4HrkqBWzzn4rvnUb7pP5IKOjRgtmvHtER
         /hAgtFPUdWQrEW721+QvjsfhCZxurAk8gpSXzCvmL3LRndU4E0v0j2J6zs1q75Q5P6WJ
         0HT9B2PvgvV9TRURrQ/Vm/UqZ5hW34e4KlZSkefvvIhbotoEY0VquIzwIoZoZBaAKSr9
         nmtbwQ1g24TUH6YglqYvCoQm/iBt93O3She2kSii6NaJmirR4/dytbLhlwFR6PYKl2qM
         yQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BrPAZR89IJKrNK/gtwxOGhWdPzFeF5kQNgV6Csg05V0=;
        fh=V4qzLf/2rizFG5bxe6AZmHBOruAYbaTCfQ9rBnk3pRs=;
        b=GT3FcAlMvQnRNthGFwYeiWkCtWrK75Uar/ZyAvOfm8eF2hFK0DWOou+EmAYJtxUi3k
         7HXe7qVlboC1qzeyCMkFlGJihFCgfhXnSaPsH+xOUGzWXcoSj5eAAwSaWUAO+h32E435
         9nc/VJTEFCSpoz1GI6033AFMZzXy8VqG4gnz7M0EC78f6rGs74IdSK4aNBmgJxC+axFx
         aCglMCYFL+XWO3enRySv+x2H/3eRFcv8JlOeTntC7OkRD+meiCB6ibtYV2EqL2lDE7W6
         51kCztLidDjHU4h/Fjkr9Q/S2aAwVLtDBmgWUvthU+qcey44ekRKQmTAuPOqUqIV0B+X
         i7Aw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790780380; x=1791385180; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BrPAZR89IJKrNK/gtwxOGhWdPzFeF5kQNgV6Csg05V0=;
        b=RlKGhEURKFyTStTnt9Pb0Q77AqKMEQI279pcXxjiOPMKpHQ0XuQ15truiCUWm+57Gw
         xDn8oUVNFUkGKceZ1Bbbgxv1ZT56unrj/RgbjjTM9viHaeXfOW+R20yljDNlfeMS4Bk5
         e5rJrih7nuMcaVvCX0vw3HPr5FPCl3yTcu+oQjwEAOihWHHIwRK7O9c3EBDxkIo9tg1i
         ma4AuyKt3aSj9kdGjgCmbbndC+W7DoL+NvzlI8OTVwXTFJ90vBPHAn0D68XFmnOg8LNQ
         Teg9ndWACrv74d5uBzu7bzdAwfmvlPPfKjRLyEy+DPKf4V+n1tgIbAuHmih1XxDI8dQE
         rq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790780380; x=1791385180;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BrPAZR89IJKrNK/gtwxOGhWdPzFeF5kQNgV6Csg05V0=;
        b=Y83bfPHo2/yXOvY1HtQjFg6J3JUxHgsiYQCpfgyiD0KU2NPoOyRnln72qaRuNNREKo
         8AJ7UrqaoNok30kwKGX42eEeqTpEkLlSkbZaI+prqxvah+c1cbLfFE+QwDR0w4NV8Jv/
         vlFDzPePtCWnPhfFlBPFdtFWqgz3cITxwWZHOr12KiEwxMmURAqzY+27GHDSAqARjQoc
         T1eMgoc6h6okO+FoNpf9Q9Fo/ylhunQIQ6WH940Htuve06gdohkyP1Up3YuETAHPeK4v
         kndWudC6qCwcHLctA6fFFBY0HzlHb5GS0afuvLfU47qh5JnBnaWV+HBja9TuIVEBhoVW
         SPwg==
X-Gm-Message-State: AFq9FYLE5gHZ+YYm4VEEtJDC5OANi8V2cURBy8kXx9y2h5T5bMs3gjaW
	TgnosM8gZLGOUqYNYNGQjguajB5KGSZsu+tmQm3HCNphzjdN/psQ5fDG7Azm3rkyERI1su5O6tJ
	5Jfz+EkJ4fzLsjzUrWZ0dvuN2tXiDRZU=
X-Gm-Gg: AYBFou3LKWIEyej3gtnTT5vdc8+oXtGOd7VCNgGrjL6eeIU3JTQVCJeeHrzW/o6ltgC
	Py3Olt1O/Uy+oK329VIOOpMY09XPF56YvVe0YweSyqDVsNpH+7hv+rDPC60pyrGMB/z9zxdH154
	2226q+MRMfoysxmQByVsHDHytLJfcICvbnxv84Sn4v/vnHjWHSOLYt6+ZEuT6vqt5YPHl1vaFGo
	WiWsmgof0eDck584X0+5ELxtjjbpehQqvIDKv1VNWA9TaJw52fY2KEmSdypfm9lpfXeyT1e7mjm
	0bkphEiKaDs8Vj3/P1jKjDNWRoMe5IqUpKTjHuHpO5jHxEZAiwyrX7gsw6sOws69wg7yVrdXC+O
	SDmvO7knTq3MPtijSVDtjv4cz/N5ORKnv4u+d4YnNGg==
X-Received: by 2002:a05:690c:620c:b0:88c:b280:543c with SMTP id
 00721157ae682-8ac948c85dbmr7546567b3.66.1790780379615; Wed, 30 Sep 2026
 07:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790752800.git.aluvala.sai.teja@intel.com>
 <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
 <CABBYNZ+_ZMd9fh2K8ESe5V9NKuZjBcbBsqsnLVuXkTZ4YXm6-g@mail.gmail.com> <MW5PR11MB5881A5CB72305C8003502B0ECC8B2@MW5PR11MB5881.namprd11.prod.outlook.com>
In-Reply-To: <MW5PR11MB5881A5CB72305C8003502B0ECC8B2@MW5PR11MB5881.namprd11.prod.outlook.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 30 Sep 2026 10:59:28 -0400
X-Gm-Features: AclHuK-1U4--Iz-oHvcH_CHUc7Tl8Qq5uD83FB7ihcMEZLAO_x45jMbQXdoR09Q
Message-ID: <CABBYNZJxKFpojqCFFmT08CUzcs97wsduBGWzKjw3fyPsn8iw=g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] emulator: add generic HW rfkill test tool
To: Aluvala Sai Teja <aluvala.sai.teja@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "K, Kiran" <kiran.k@intel.com>, 
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On Wed, Sep 30, 2026 at 10:42=E2=80=AFAM Aluvala Sai Teja
<aluvala.sai.teja@intel.com> wrote:
>
> Hi Sai,
>
> On Wed, Sep 30, 2026 at 3:53=E2=80=AFAM Sai Teja Aluvala <aluvala.sai.tej=
a@intel.com> wrote:
> >
> > Add emulator/hci_rfkill, a standalone tool that drives the
> > force_hw_rfkill debugfs hook for an hciN device and verifies the
> > reported hardware-block state against /sys/class/rfkill. The hook
> > exercises the generic net/bluetooth rfkill path for any HCI transport;
> > it does not test the driver's hardware interrupt or register handling.
> >
> > Support assert-only, deassert-only, and toggle modes. Validate the
> > hciN argument before using it in filesystem paths. In toggle mode, if
> > asserting the block was written successfully but subsequent
> > verification fails, still attempt a verified unblock while preserving
> > the failure result. Do not attempt an unblock when the assert write
> > itself fails.
> >
> > The optional -r/--restore mode snapshots the adapter's up/down state
> > via HCIGETDEVINFO and restores it via HCIDEVUP/HCIDEVDOWN, following
> > the raw HCI control-socket approach used by tools/hciconfig.c.
> >
> > Usage: hci_rfkill [-e|-d|-t] [-r] hciN
>
> I have a hard time understanding why we can't just use the `rfkill` tool =
for this purpose, or does it not support hardware-block? It seems it does:
>
> rfkill --help
>
> Usage:
>  rfkill [options] command [identifier ...]
>
> Tool for enabling and disabling wireless devices.
>
> Options:
>  -J, --json             use JSON output format
>  -n, --noheadings       don't print headings
>  -o, --output <list>    define which output columns to use
>      --output-all       output all columns
>  -r, --raw              use the raw output format
>
>  -h, --help             display this help
>  -V, --version          display version
>
> Available output columns:
>  DEVICE      kernel device name
>  ID          device identifier value
>  TYPE        device type name that can be used as identifier
>  TYPE-DESC   device type description
>  SOFT        status of software block
> -> HARD        status of hardware block
>
> [Sai]: The rfkill tool can list RFKILL devices and control the software
> block with `rfkill block` and `rfkill unblock`, but it cannot synthesize =
a
> hardware rfkill block. The hardware state is normally reported by the tra=
nsport
> driver and is read-only from userspace.
>
> To simulate a hardware block for testing, we still need a kernel-side
> injection point, such as a debugfs entry, that invokes the same HCI
> hardware-state notification path used by the driver.
>
> however, The test tool does not need a separate RFKILL-core API for valid=
ation. After
> writing the simulated state through debugfs, userspace can read the exist=
ing
> `/sys/class/rfkill/rfkillN/hard` entry. Therefore, the debugfs entry woul=
d
> only provide event injection; the sysfs interface would provide validatio=
n.
>
> The debugfs read operation and the separate `rfkill_hard_blocked()` helpe=
r
> are not required. we can drop them
>
> The reason I considered the emulator tool is that the existing `rfkill`
> injection path, changes in `net/bluetooth` such as the HCI RFKILL
> notification, `HCI_RFKILLED` handling, and the resulting controller
> power-transition work are not directly validated for hw rfkill.they are
> validated for sw rfkill path
>
> my understanding is that the existing `rfkill` command is useful for
> testing the software block/unblock path, while
> `/sys/class/rfkill/rfkillN/hard` allows userspace to inspect the hardware
> block bit. Neither interface injects a hardware event or exercises the
> complete Bluetooth stack path.
>
> Do you think it is worthwhile to keep a small `hci_rfkill` emulator tool =
to
> inject the hardware state and validate the HCI RFKILL notification,
> `HCI_RFKILLED` handling, and controller power-transition path in stack? I=
f only
> SW RFKILL state validation is needed, then the emulator can be dropped; i=
f the
> goal is complete Bluetooth stack validation for hw rfkill, I think keepin=
g it is
> worthwhile. I would appreciate your suggestion on which scope is preferre=
d.

My assumption is that if this functionality were needed, it should be
part of `rfkill` directly. Alternatively, if you really want to
exercise this code, Id probably recommend doing it via platform layer
which implements the actual hardware line, thus exercising the code
path exactly as real hardware would, rather than through a
Bluetooth-specific debugfs entry.
