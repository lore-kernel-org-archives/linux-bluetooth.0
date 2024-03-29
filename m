Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890FEC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 03:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711681631; cv=none; b=fZxwjQNiDzl006zyTwr8o5k5c3l1BbnonMwlbDPViKgUT5qlAWUQkpqA2ztTdWy62qWxee+XP3F/q0keJkU7SJLIcpwYpqy4i0XJpK32oEpyZPZFLADfhsim1jEUKzhv/YqQnI6CB9BQ2kR2yi2uBH4zFZmuyxi1GYMZ14oMkSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711681631; c=relaxed/simple;
	bh=ndT73twkiwBnRsrQw6mZ0E4D5+KtwwKAeLjm5NFd16w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWxTN497LlgjDe6hb2cwrk80aigq5WDHSGiIMVTABzn0RsuZ1S9xQFUE97TYCzJBetzT18Bs3PBOKr9z+MJBelLVJjAgtS7ULOk/TgW2cUiEWfyCuuX7V5glanXiNjjO+2Q5+w+W6iWn5eAzqKJTV4WbwRYR/sdGR8tWadSFtr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiFHabsu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiFHabsu"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1185993a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 20:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711681629; x=1712286429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tslkJniC4TLAADyYBc9i/8lvL4XvDXp5MejVUHaFN84=;
        b=TiFHabsudtMShthlWPlVWWR/srgvdWXDa8+xhSi75lhlzgZ7azPUj6BIMar69xs0LD
         d5yFimW++TpTWC2KwH4zJmYF+Lq4Hmtj75gOhX5SujRYuKG1B9tx7V6dMkTsH3f/Xg2K
         3JBeK8f28zksySbFBmn5eh55+KK+g6zIhzcU3cNtmjMzUCRcz1c3zvJWwCMTL+W7Xv0l
         HhTf04xR9lzJm66G/BK0hm+cHEbSTBviUk/3RpTRRM862gpp+nZrnIv60gv/1LMddwoC
         ImG+4gkQ2CI8xGuxzBno5sUTh2kTtv27a7k47F9fdmorhccbdvusunHxM++MepEDAgWP
         81Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711681629; x=1712286429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tslkJniC4TLAADyYBc9i/8lvL4XvDXp5MejVUHaFN84=;
        b=guhd58Alfeqcq6snGrWUwCx/Js7pOU2YpNHwCq+CgBV5TDtLWtmUEQcf/rkFsHHjd9
         fl1W5RPyBE82rVkiuoL+wj46eHIlI8GN0PE/5HDTeFJRueCouul/XlmcHI9xab05yFmK
         d8/iELEZ5n5QTQQto4smMYxWMYJS7A5YDI+7tHz0LmW+1lYnK9H/R5m5VptRYjQV7qpm
         lUVNr48yDIq2PI1b8TetzVNh5TlWsw1nkT2AqMiXnrW1O6sx76cYFn9IXoOqYJiq5W1G
         bo4XbmTNkONL4mSPDnOgB/e0UQznqdsXtolpbsuhlQ0NkV6pKs0jkx5rgjA8C+ODPS2M
         jMvg==
X-Gm-Message-State: AOJu0YwPZe0FoQ1SrMj7LeV6STUrfsRppqnHzati4N3cSRo61qy2D5/J
	HBUjHFcvOlAN5K7V+NORfZJ8Lo+ibfnrci999anVS5f6zQ3HK2txxpnO6xl647+0NJy1dX9Ksgg
	XFCQ3awMShY67/mp/RxheVR8RWyGUgwRWaDpbJQ==
X-Google-Smtp-Source: AGHT+IEg/ZFOlRSDrM0dkk5c4EJbvylGiccs+F4Drhja2EBtTbJC20zlz4xJ2Gf0zRct9ec3LIncdzZ5s+ZvuP1iSWM=
X-Received: by 2002:a17:90a:ce03:b0:29a:9fad:4ad9 with SMTP id
 f3-20020a17090ace0300b0029a9fad4ad9mr1242789pju.3.1711681629230; Thu, 28 Mar
 2024 20:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327142526.332756-1-hadess@hadess.net>
In-Reply-To: <20240327142526.332756-1-hadess@hadess.net>
From: Gui-Dong Han <2045gemini@gmail.com>
Date: Fri, 29 Mar 2024 11:06:32 +0800
Message-ID: <CAOPYjvZwrRp-kB3LGPZmo=jLgkk=W5SR86ktCdpMPizEWyDiAA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix TOCTOU in HCI debugfs implementation
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

Thanks for the updates to the December 2023 patches, including the
shift to identifying the issue as TOCTOU and the corrections made to
the commit messages and CVE references.

I see the merit in distinguishing between TOCTOU and atomicity
violation as you've outlined. Both terms provide valid frameworks for
categorizing concurrency issues=E2=80=94atomicity violation from a broad
program analysis standpoint and TOCTOU focusing on the timing
discrepancies. I'm on board with this classification and the changes
you've implemented.

I'm good with the changes.

Best regards,
Han

Bastien Nocera <hadess@hadess.net> =E4=BA=8E2024=E5=B9=B43=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=89 22:25=E5=86=99=E9=81=93=EF=BC=9A
>
> struct hci_dev members conn_info_max_age, conn_info_min_age,
> le_conn_max_interval, le_conn_min_interval, le_adv_max_interval,
> and le_adv_min_interval can be modified from the HCI core code, as well
> through debugfs.
>
> The debugfs implementation, that's only available to privileged users,
> will check for boundaries, making sure that the minimum value being set
> is strictly above the maximum value that already exists, and vice-versa.
>
> However, as both minimum and maximum values can be changed concurrently
> to us modifying them, we need to make sure that the value we check is
> the value we end up using.
>
> For example, with ->conn_info_max_age set to 10, conn_info_min_age_set()
> gets called from vfs handlers to set conn_info_min_age to 8.
>
> In conn_info_min_age_set(), this goes through:
>         if (val =3D=3D 0 || val > hdev->conn_info_max_age)
>                 return -EINVAL;
>
> Concurrently, conn_info_max_age_set() gets called to set to set the
> conn_info_max_age to 7:
>         if (val =3D=3D 0 || val > hdev->conn_info_max_age)
>                 return -EINVAL;
> That check will also pass because we used the old value (10) for
> conn_info_max_age.
>
> After those checks that both passed, the struct hci_dev access
> is mutex-locked, disabling concurrent access, but that does not matter
> because the invalid value checks both passed, and we'll end up with
> conn_info_min_age =3D 8 and conn_info_max_age =3D 7
>
> To fix this problem, we need to lock the structure access before so the
> check and assignment are not interrupted.
>
> This fix was originally devised by the BassCheck[1] team, and
> considered the problem to be an atomicity one. This isn't the case as
> there aren't any concerns about the variable changing while we check it,
> but rather after we check it parallel to another change.
>
> This patch fixes CVE-2024-24858 and CVE-2024-24857.
>
> [1] https://sites.google.com/view/basscheck/
>
> Co-developed-by: Gui-Dong Han <2045gemini@gmail.com>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
> Link: https://lore.kernel.org/linux-bluetooth/20231222161317.6255-1-2045g=
emini@gmail.com/
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24858
> Link: https://lore.kernel.org/linux-bluetooth/20231222162931.6553-1-2045g=
emini@gmail.com/
> Link: https://lore.kernel.org/linux-bluetooth/20231222162310.6461-1-2045g=
emini@gmail.com/
> Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24857
> Fixes: 31ad169148df ("Bluetooth: Add conn info lifetime parameters to deb=
ugfs")
> Fixes: 729a1051da6f ("Bluetooth: Expose default LE advertising interval v=
ia debugfs")
> Fixes: 71c3b60ec6d2 ("Bluetooth: Move BR/EDR debugfs file creation into h=
ci_debugfs.c")
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> Hello Gui-Dong Han,
>
> I've made changes to the patches that you submitted in December 2023 and =
that are
> linked above to:
> - correct the commit message and description, this isn't an atomicity
>   problem, but a TOCTOU problem
> - corrected the "fixes" references to be of the original code
> - added CVE references for the changes that warranted it
>
> I've kept you as the co-author of this patch and kept the references to
> BassCheck as well.
>
> Let me know what you think.
>
> Regards
>
>  net/bluetooth/hci_debugfs.c | 48 ++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 16 deletions(-)
>
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 233453807b50..ce3ff2fa72e5 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -218,10 +218,12 @@ static int conn_info_min_age_set(void *data, u64 va=
l)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val =3D=3D 0 || val > hdev->conn_info_max_age)
> +       hci_dev_lock(hdev);
> +       if (val =3D=3D 0 || val > hdev->conn_info_max_age) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->conn_info_min_age =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -246,10 +248,12 @@ static int conn_info_max_age_set(void *data, u64 va=
l)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val =3D=3D 0 || val < hdev->conn_info_min_age)
> +       hci_dev_lock(hdev);
> +       if (val =3D=3D 0 || val < hdev->conn_info_min_age) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->conn_info_max_age =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -567,10 +571,12 @@ static int sniff_min_interval_set(void *data, u64 v=
al)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val =3D=3D 0 || val % 2 || val > hdev->sniff_max_interval)
> +       hci_dev_lock(hdev);
> +       if (val =3D=3D 0 || val % 2 || val > hdev->sniff_max_interval) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->sniff_min_interval =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -595,10 +601,12 @@ static int sniff_max_interval_set(void *data, u64 v=
al)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val =3D=3D 0 || val % 2 || val < hdev->sniff_min_interval)
> +       hci_dev_lock(hdev);
> +       if (val =3D=3D 0 || val % 2 || val < hdev->sniff_min_interval) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->sniff_max_interval =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -850,10 +858,12 @@ static int conn_min_interval_set(void *data, u64 va=
l)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_inter=
val)
> +       hci_dev_lock(hdev);
> +       if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_inter=
val) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->le_conn_min_interval =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -878,10 +888,12 @@ static int conn_max_interval_set(void *data, u64 va=
l)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_inter=
val)
> +       hci_dev_lock(hdev);
> +       if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_inter=
val) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->le_conn_max_interval =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -990,10 +1002,12 @@ static int adv_min_interval_set(void *data, u64 va=
l)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interv=
al)
> +       hci_dev_lock(hdev);
> +       if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interv=
al) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->le_adv_min_interval =3D val;
>         hci_dev_unlock(hdev);
>
> @@ -1018,10 +1032,12 @@ static int adv_max_interval_set(void *data, u64 v=
al)
>  {
>         struct hci_dev *hdev =3D data;
>
> -       if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interv=
al)
> +       hci_dev_lock(hdev);
> +       if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interv=
al) {
> +               hci_dev_unlock(hdev);
>                 return -EINVAL;
> +       }
>
> -       hci_dev_lock(hdev);
>         hdev->le_adv_max_interval =3D val;
>         hci_dev_unlock(hdev);
>
> --
> 2.44.0
>
