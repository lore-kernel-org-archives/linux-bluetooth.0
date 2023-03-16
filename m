Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A1BC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Mar 2023 05:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjCPFW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Mar 2023 01:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCPFWZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Mar 2023 01:22:25 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952EEA9082
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 22:22:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id s22so842095lfi.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 22:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678944132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NeO8IdNmPVErzQdQOF62aNodvdOmC4sm0sEBiq6epU=;
        b=JAFDcCaiSv146AdL3zy/hCxJwpjCvnCtAX6KYaGrRk5DVbHy02ws0E/MJRY7kVvVJt
         zLbgo3gkdwexq2Aj5MLzogDHiRE2mlFhAL+bopCY09zTZ69/MbGiT64tEmuA/igZ6s2/
         JqOyez63JPKAlAxsXxa92SwMGlCCM1Pkvz6TPUQWmNsujroKWDKI+u9g8BkI50DQMypr
         1YLGOcvdCQoC11CeP5knk83p4UvcNQ+u6F8iWqFk+WPx9EWsxXY/qZzcEIEILMzgocyZ
         tjWraPR7Sv0fwU+KEDHwhdrDI2bjgDr3udt6FTnpJk2/9XmPL3TBZkFyTRsQJQSd7gj3
         uZIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678944132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NeO8IdNmPVErzQdQOF62aNodvdOmC4sm0sEBiq6epU=;
        b=LMRuUzBR6iq+K3S9SjVNa4cMymf81QXPm9uthNPRoYnyO8XuWoC9AIv+wDv2m7bEPI
         JCrYiPswhYqiJTiH6isiY2L8TyrZ8csRo3VMlkcFCR0bEilM9cmHUuHIRHDl+vPNl25p
         UaDdrgM04m6FThlNxy8iQsIpLeNc/N8TIHiTEvijHe2A1lqXX2EgifOPGt7TXLq5vY63
         O1OMeBwu9SauJXkJMSDo6A0STyYUY5vN+laErsHNhmy6l4bC1Q03Dfl3BqEnH8FZ+GpZ
         C4HDIBKBHQnVnWTh+s9KGGB/6r8/5T2wjUWw/8TKphyf+R29w1Gf/AMUZ/GFV7+VVMZI
         WLeQ==
X-Gm-Message-State: AO0yUKWc2L+sQqMBwUYeAfMXSxtdIeVi37uqMJAJV6Q3AM61LS5jrPhM
        YK0LJ2q2xw8QNqBSeHrt4KgAFZl5aZ3dO/C5pWTwUiER
X-Google-Smtp-Source: AK7set8oJ/TalXJUZJCpWSVV4EO4S1BF7YRc6mz+rhHR67X2U5i/X2gpFBLErx5dBtXbedf+8AeIAe46hZHUX94RerY=
X-Received: by 2002:ac2:5446:0:b0:4d5:ca43:7047 with SMTP id
 d6-20020ac25446000000b004d5ca437047mr2738829lfn.10.1678944131867; Wed, 15 Mar
 2023 22:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230316002559.32562-1-kiran.k@intel.com> <20230316002559.32562-2-kiran.k@intel.com>
In-Reply-To: <20230316002559.32562-2-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 15 Mar 2023 22:22:00 -0700
Message-ID: <CABBYNZKbPqR8W8M8gjSdC2C=QL+A8Xs5w9jOzw=Z3O3R6r4jng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: utils: acpi_evaluate_dsm_typed - fix
 redefinition error
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Wed, Mar 15, 2023 at 5:32=E2=80=AFPM Kiran K <kiran.k@intel.com> wrote:
>
> acpi_evaluate_dsm_typed function needs to be gaurded with CONFIG_ACPI to
> avoid redefintion error when stub is also enabled.
>
> In file included from ../drivers/bluetooth/btintel.c:13:
> ../include/acpi/acpi_bus.h:57:1: error: redefinition of 'acpi_evaluate_ds=
m_typed'
>    57 | acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid,..
>       | ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from ../drivers/bluetooth/btintel.c:12:
> ../include/linux/acpi.h:967:34: note: previous definition of
> 'acpi_evaluate_dsm_typed' with type 'union acpi_object *(void *,
> const guid_t *, u64,  u64,  union acpi_object *, acpi_object_type)'
> {aka 'union acpi_object *(void *, const guid_t *, long long unsigned int,
> long long unsigned int,  union acpi_object *, unsigned int)'}
>   967 | static inline union acpi_object
> *acpi_evaluate_dsm_typed(acpi_handle handle,
>
> Fixes: 1b94ad7ccc21 ("ACPI: utils: Add acpi_evaluate_dsm_typed() and acpi=
_check_dsm() stubs")

This should probably be sent to the ACPI list/maintainer, but first
make sure there isn't already a fix which would mean we have to update
bluetooth-next to stop this kind of error.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>
> changes:
> Fix compilation error when compiled for ARCH=3Darc
> Details here:
> https://patchwork.kernel.org/project/bluetooth/patch/20230313151549.15791=
-1-kiran.k@intel.com/
>
>
>  include/acpi/acpi_bus.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index e44be31115a6..fc131b4aee4e 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -52,7 +52,7 @@ bool acpi_dock_match(acpi_handle handle);
>  bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64=
 funcs);
>  union acpi_object *acpi_evaluate_dsm(acpi_handle handle, const guid_t *g=
uid,
>                         u64 rev, u64 func, union acpi_object *argv4);
> -
> +#ifdef CONFIG_ACPI
>  static inline union acpi_object *
>  acpi_evaluate_dsm_typed(acpi_handle handle, const guid_t *guid, u64 rev,
>                         u64 func, union acpi_object *argv4,
> @@ -68,6 +68,7 @@ acpi_evaluate_dsm_typed(acpi_handle handle, const guid_=
t *guid, u64 rev,
>
>         return obj;
>  }
> +#endif
>
>  #define        ACPI_INIT_DSM_ARGV4(cnt, eles)                  \
>         {                                               \
> --
> 2.17.1
>


--=20
Luiz Augusto von Dentz
