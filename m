Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC393B9D81
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 15:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354111; cv=pass; b=ppvvdVcL4LRZlZPduCfBuvNyBfPMtJRS4YxSBGATpWpjzxW3I/g7/U3D8RWeIU3DvznLgR2oOpdOcjSNA8osxQIDC+04wLd/x0AJobQAtzDOjoj1LCQhXRVHQ6gJJbBvEu5agRFCOs3TB5K0lYwUzYLSc0qVGxUCS+8BkHThU0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354111; c=relaxed/simple;
	bh=zBGBrZMTwKJ68rCLDRs8azQlORU5x7myV+tVHdcijts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+T/Gha3YKoMatUEtMbvbhVJMExGKQdJ1w1hyrHIytEE3+fAcoTgnG7cGy39EBPcXIYi8oE5QI2XXHqM8iVL9C0OS4lJ/PBXsWSjPj6G5BmxGWpDPeFjec1QxqHv1H8u6TlQVu+w68qrI47kce9vqrwl1GqDj7MCCRrtHwOH+Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5k8RptB; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5k8RptB"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-651b6a003f6so3299197d50.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 08:41:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776354107; cv=none;
        d=google.com; s=arc-20240605;
        b=Ta8trcomUvKqygOFeXXqYmKQEaLDqyRyUYpukSetv84P44+5VtMRU3d5fAp68y29zJ
         jSKYiDfPDD70Y9Aurm2IcrDb2M2UfQiT+5BwkLMJoINDTbz8e9t9AlJSUbH6A3cdoNWY
         y1I3iFrXGARt9npzesGYFVee01rG9ba6r+ZW+tDa84LiuuZSIpZXWQy5LWDtI00i/tKS
         y6N62HjDBwQJKuab62QGIHjGhNp84VBIwLa9/d9XC7/11f7JOfiL4b6dJo3nJbbfStQZ
         WcCyoOnWzMnodu+oO7+Hgkkp+X6P7gQigPGyJ9v7zOKbXsldkoZ+LdmTk6lvzUj8G+rM
         EChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        fh=bzTQUmg2r59+m7DtlsxWNHmZPk1xQ/c/u5Wwh8s+gdc=;
        b=AQ4PIsnlEhz7rcTOuaP8fy0g8sf9XUXOG2g0ZBie1cPWk9iiMticRpvcBUHDWVGIc8
         EWZnPAh7bXsBo3q9s6ikYazi+BEtPG1Z2iygb5yTK/QsOzOSX/rWWOlAlId6/Wd25T82
         NDAET4LPdU5AMR7iBaZChOxXD+9JVPOYYgRF6z1/GKOnKKCUXVoSwj72kMcodpSQ/ElS
         0EpKA0+cPcbdWjit784ArJvSGCUAPDTJXbR+V63L1uwldYRVuZRXEABBJDfHLa3MIMix
         WqOVGM/wa3cS/xwXY0xKTf6j27XBCNmeLekb2VmVUVmsyWlhejGoJR3VZPkEEzYDv4hF
         ydUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776354107; x=1776958907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        b=M5k8RptBKBQylc39mD81QB/Ke4Y2T/5tjiqNXhpXkt0/dgWorzOuzLv6/itt+uoQzw
         npwfwrOHsUzOkhTqp8KCP6oYr7LFjXTrUNzZNPgl2RUKmcjcs+ZxiewM4tzY4U/4qgLz
         4L0wcCgYfKman6YI7/ynhgitzbc4oGWksbSKKt9aVdXGxkn7vjFyBpUNV9/Q+EUSNy5m
         XQ2qP8gWGH5Z85ixnlxrDaJc6VgC5zgOPMC1ybJwUBtiN2Ic2GMkJkyRW5XyMaR8YjPw
         H0MgDNkBqNsOaVKRNVkSSa/dZVSCmYmJ+rraev6g3BKgVrU2UgiiXULh/IvQDGNxNFBC
         7mNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776354107; x=1776958907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OCnOF4+nugCQPZVKQw/7phANXrJTt1mtYs1TJKi/ahA=;
        b=adisVHnOFwgYOQp6hbIgpBXkj1RU9pF14JysE9RodmloOjizFfRIeyhLtP/ovabjUa
         dmwDaM/SIW08t07P+9ZCskgfLgvbuNLz8zUCebFQ1L6Oruxja/JRiqGI63BgU9/h9+pI
         xAnVttyCGvqwhWxNy0Jb9C6MHj/N1FESM1OFGx6Rs4Lrprk35i7U0AtTR1t/zL1uYWzE
         adXxOuoyYL/X+iPpPEbU7bFRkR1vcSoJMmwAyS2sUNTl7nnkuSVZpfouMSBa+3wfFgNu
         u31k5dQjXHD+Kd+2Sz6NGeQLhTI/4lhkZOfzHjotVRvsRhF48B4ScPpYclqnw3jyUM70
         Nddg==
X-Gm-Message-State: AOJu0Yx6TF5iBFEtIpFQtXQYWw98tqDHN5jyU4laT3wdYpCF5yXkqNkx
	dkVwv0Dw+TOFXCdHhmPvGVJNxKfdMGJCvxuspTJQfvtqckOML8GA2SQf1RoPq4AIZcETtNbSSpI
	HZR5MaUDSudcPBn71n7CLDGl6ta70QQc=
X-Gm-Gg: AeBDiet/qCP94kXTO35m9yYdELBLFi+rKkrtiON0GN2cfjq3HKNeTOLScqdHcaAPZZF
	Gnr4mmE999k7VsniNof2b4DePKVuBd6DE7z5mwAwf5d71Qfi4lAZeaM0ZkXfPvEoevc7s7BfnFx
	drEFEI8rP4w6F7CFlP0CdaCdILLPb8emzeeQ/X0oCpK8uFHTzqbvYnjz5mERsQZZEpx7sd6K8np
	qI46Z7pQdoMGJJ/keXYM+VLahokEZiem4quZ9po/u5rcUkUSi0/Zz+eJTN6gVnSCBeKHCWkDqga
	NcOoiD86lOX0Vxw0KNBLTbdI/7MH6kyGz9eYTp7sUFf+yidJTAmOka44Ed7/aEruL43s5kTC3BD
	vDQMe
X-Received: by 2002:a53:bc05:0:b0:650:814:8124 with SMTP id
 956f58d0204a3-65198a88374mr18632177d50.17.1776354107448; Thu, 16 Apr 2026
 08:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
In-Reply-To: <20260416153524.1405955-1-chandrashekar.devegowda@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Apr 2026 11:41:36 -0400
X-Gm-Features: AQROBzBjZjfRaING-KzrTi6Vvj06l3R7e7yZ4kftBDRWWzyE4CVrpze4YP2lhJE
Message-ID: <CABBYNZK7PghZH_hbeftOK0JptRv3-NOatWQ35kKSfYku_RB1cA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Fix build error when
 CONFIG_ACPI is disabled
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, linux-pci@vger.kernel.org, 
	bhelgaas@google.com, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandrashekar,

On Thu, Apr 16, 2026 at 11:39=E2=80=AFAM Chandrashekar Devegowda
<chandrashekar.devegowda@intel.com> wrote:
>
> btintel_pcie_acpi_reset_method() uses ACPI APIs such as
> acpi_evaluate_object() and acpi_has_method() which are not available
> when CONFIG_ACPI is disabled, causing build errors on architectures
> that lack ACPI support.
>
> Guard btintel_pcie_acpi_reset_method() and btintel_pcie_perform_pldr()
> with IS_ENABLED(CONFIG_ACPI). Since PLDR relies entirely on ACPI reset
> methods, skip the entire PLDR flow when ACPI is not enabled instead of
> unnecessarily unbinding and reprobing WiFi with no actual reset.
>
> Fixes: 912a499a7955 ("Bluetooth: btintel_pcie: Support Product level rese=
t")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com=
>
> ---
> v1 -> v2:
>   - Guard btintel_pcie_perform_pldr() along with
>     btintel_pcie_acpi_reset_method() under IS_ENABLED(CONFIG_ACPI)
>     instead of providing a separate stub for the ACPI method, since
>     PLDR is meaningless without ACPI support (Paul).
>   - Tested with CONFIG_ACPI=3Dy, CONFIG_ACPI disabled, and 0day CI
>     alpha config.
>
>  drivers/bluetooth/btintel_pcie.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 076beb45c410..07223965388a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2280,6 +2280,7 @@ static void btintel_pcie_inc_recovery_count(struct =
pci_dev *pdev,
>  static int btintel_pcie_setup_hdev(struct btintel_pcie_data *data);
>  static void btintel_pcie_reset(struct hci_dev *hdev);
>
> +#if IS_ENABLED(CONFIG_ACPI)
>  static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data=
)
>  {
>         union acpi_object *obj, argv4;
> @@ -2389,6 +2390,12 @@ static void btintel_pcie_perform_pldr(struct btint=
el_pcie_data *data)
>                         BT_ERR("BT reprobe failed for BDF:%s", pci_name(p=
dev));
>         }
>  }
> +#else
> +static void btintel_pcie_perform_pldr(struct btintel_pcie_data *data)
> +{
> +       bt_dev_warn(data->hdev, "PLDR not supported, ACPI is disabled");
> +}
> +#endif
>
>  static void btintel_pcie_reset_work(struct work_struct *wk)
>  {
> --
> 2.43.0

Doesn't making btintel_pci depend only on ACPI resolve all of this? Or
do we really need to support systems without ACPI?

--=20
Luiz Augusto von Dentz
