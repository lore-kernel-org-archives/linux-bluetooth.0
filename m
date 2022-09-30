Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5875C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 11:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiI3LQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 07:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbiI3LPl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 07:15:41 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC7753007
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:57:54 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-11e9a7135easo5041036fac.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 03:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=nOz93YVF96CNDIku89n6rQsiDaZfiDrOvlnq6TD/v8I=;
        b=Y0TNGrxgfefvBA2M5UPl4VRGObwrb3FF/EtdmKGPGBvSoLgFp4/pX6phBDN8TJZvT4
         hSgrDF4SaqdgxicSRTd0uv7h6c0MtbSUW8MOpS0MqPl1w5TdtJzmrRm+wotuNWLCcOhZ
         4n9qnWHELQ3fgrdOLd0sYITSnJdDIS9Fdh+5sTBaT43bYhTKqRG0Y26mBZ6Pi9KFdGlT
         tZaOm9L2lEwhCCiuL0w0D00iuFppCQkgnpbwI+OFyo79SniiMTe5aXp+ToZrR8Z10Nxo
         gaUuYbbpLKJ7u91LcsI01D93AftcuzYjoL/EIrBavWwDcwjE56OP/4usP5u610xsB+6s
         yXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=nOz93YVF96CNDIku89n6rQsiDaZfiDrOvlnq6TD/v8I=;
        b=CBPG5CJNJ8P42giX/8zOJ40ZKP+aZ8XG8ha7VIZ8r+jEFVo0fwG0PVHLl6yBo8ipxw
         fl8a0QlHzjJ3VUVe9llWVkMqnHYK/KKJPIXJlQrBW75hTdMquBZ+eIxEtCD4WfutVyCg
         rlS53tS8Tq1qAr19wnBCIg73PZqSnhnJ3BndavEdujU2fO6rq1G/0pKLkDLPwrCHoG17
         E8gYbh1xdpFdJ+JTITyEmrTs7YxPBwsSqD0GSteDPzAMlUpZXVzyqevi3igztK6j5J+u
         6VH+qdvXMn3Ji8MUX30RO8zOPpHJVTmFtWCqWZ6zVlaTscoyljbGHoQk+qKVcpQJZGV8
         HJdQ==
X-Gm-Message-State: ACrzQf0S9xq+BbieNIbBKIHF7Q9lSmR2E05SPDwWTRnOJYBd0BtZkEou
        9REX940H5ODuSMFCazrZWcdoiqqz2RI6sxhE5QSYtFSkcuJ10A==
X-Google-Smtp-Source: AMsMyM7EbfEnP/uBSLx9ZSGGEeoMYo4ebsMC9PBYnAPUbu0rNLPpCuABq+MhL3l4UeOCbfgzUorVtwMN1L7RYNKQM44=
X-Received: by 2002:a17:90a:eac5:b0:20a:6183:aa11 with SMTP id
 ev5-20020a17090aeac500b0020a6183aa11mr563637pjb.183.1664533445901; Fri, 30
 Sep 2022 03:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220930184954.108937-1-sathish.narasimman@intel.com> <b9478f7c-c11f-5f67-860a-32a4dc86beff@molgen.mpg.de>
In-Reply-To: <b9478f7c-c11f-5f67-860a-32a4dc86beff@molgen.mpg.de>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 30 Sep 2022 15:53:53 +0530
Message-ID: <CAOVXEJKao-vHAjQyPaE+dMhMDtDH9xTO=M-fgySAS772Y3-kMg@mail.gmail.com>
Subject: Re: Message from the future (wrong date) (was: [PATCH 1/3]
 audio/transport: seprate a2dp and bap transport to update volume)
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

 patches

On Fri, Sep 30, 2022 at 3:50 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Sathish,
>
>
> Thank you for your patches.
>
>
> Am 30.09.22 um 20:49 schrieb Sathish Narasimman:
>
> [=E2=80=A6]
>
> It looks like the clock on your system is incorrectly configured.
>
>      Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
>        by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2022 02:58:50 -0700
>      [=E2=80=A6]
>      Date:   Sat,  1 Oct 2022 00:19:52 +0530
>
> Could you please fix that?
>
> Also there is a typo in the summary/title: seprate =E2=86=92 separate

Sure will update
>
>
> Kind regards,
>
> Paul
