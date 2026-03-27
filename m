Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11273FA5E1
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634047; cv=pass; b=Xhz6+RitEd+G9knBAB05pRdstQR8Eb4jwogXsAkBnCdxq0hv7gx4VDXSo71xaGtM9104EuR3T/yU3gzT6JysMm3tUBRRQQJoUlzxMgkmC/4xYLjqORdLxarZmu+c3B1mk5fprYNUhfb2i6mMCaYRumkgXUBWCUxWi61WxiHzZhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634047; c=relaxed/simple;
	bh=LmFOfz1O/NDV2XSAtVLTWjg01qByY+ybHZMlf9JXSJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P/IlDzLWMS6duUbrIEBkmGn1/VXTqn2Muae84PtDa1T2I6Phe+T51qHspJDV2AsYDaksWf42msisOweQS0xGY3pzMVjg4MWm5pWpxftd/B9gkSOwBc3p6XDY04aidOHAXVfgZl1k/epg1QqpSYMU1fSam73pb5Q9uXG3RdFGhZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sz2m6yt5; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sz2m6yt5"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-64ca6595c8aso2153633d50.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 10:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774634045; cv=none;
        d=google.com; s=arc-20240605;
        b=TMJ/H0/mfQhqfk2mT0t30jgmFLgfDNdRbC2KH8183isi99rL94hi8k1etik7/8lPoM
         BDsJgs2Hm0kThJqCodWtpvaxRyZNmWV6mcjv98txHglNpZDnFj+9KzFwQ/lTR9HjlNB7
         VPgncUVwTy72bAnLUS/IdVmhkxtg+untJQ1u/4gA83n4GPhH8YwyOGeoqBCNyiCNh95z
         R9mBrZXAEdXeypHzoKovk11/rXv8WzXmkuhhuq4jnFLLbMoqa5ZT8a/s8edMnbbsUvHP
         MpkOn0rH86C2njzVUFccPqG3UdLjpCe6oMGAmnwGgM7lYVZWYP2jg0dmNGDys7cYHqYP
         XtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        fh=IylTejMVHVrrNP1CjAkHpLrlWo+mYa2TZiW2g6w6YyI=;
        b=g8wl+kFeus+jKEr3dY2a7BLbmZ3qahXplI8ljZY/neCuXA2m3p2HX/oeucXTY+dbY9
         p68tNZVD19oiigO0GD2jIiA6V2Q8ylPBWx45+7lpXl2QP5CnoFZBnUXmlam6kaCJ7ZdK
         g64fdKfEHpGAL8qXO+LN8fMV1x7pqHohvhe7zYIP+nWlAmDd8H6HA/zuJhiIkr0udaSL
         qMCX8i5S2wAvboNUV9dXL1JfRqSot/nn9RcD6+0T07deBlE5Ie5JxerEi/HXPMBBk7XW
         4xiTYAx+ctMHlHhY6S4R9MEIXLZYoE7gAjLxDoFW86deKj37bTBqIRuxHfX1mgG1e8VD
         bydg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774634045; x=1775238845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        b=sz2m6yt5CeNweQ1Vrop/sSc3euTWq7UUgI9DoqfPDpa4YsmPhecfKp/OEYkhmj8PBw
         zVYuOjN4lHxqhYD5Ws12HgqtTvHmbhQ6fCxZlFFwAZN1Ddvgp8zydrBRwo/2SWNCRlf5
         VBY9pGGF5zxyDlepL8UmoYU8DoFqztUOIDDoZql35cnrTmISwEoa6z4pmq1D7oes2Rdc
         dTx6k9131jR9YUkCqIXM3RLn/dx2/4AJmaL6nwCQiBwKDK03c8u51/f+U+V0Ed4I38Pi
         o5I73z2/54hiyZKfgX0kiHC8KQoJkJ9NAM9nLVdJZuzPqso7SzR2cVATQToMsZzowvmy
         7Row==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634045; x=1775238845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o5jvKAEq5Gk2SlSedePjyJ1o9p5DlRTHGGledO1XifM=;
        b=E10R2v3tr7GCpqCyr2W/ciL+0P1xf6mGHb5OF1UKxniAvUVkEalOIkTewIlu04LpLK
         HgbfZPCDmbhfUEvGloeTetoqubP5S6yboeQcGL5CG7bYIoBsd00lvugOYivO7wjkQHqj
         PbGESWan7uImA0OS9pcV1fWPbqjMZAFeagciBipzqGnfne1NLatXlTOrm/A3xmB+FrsM
         /FGKAzVdbgvFoFGZIz0O8evDZs17eigPGfShM/V+jxmsbtwYGZLYl4OjTPXZEY7HEjCi
         Dk83R6SPT4b1jOzXuEykhyMDCVVb9W+StziIAln5wi1VegUFc4cKoyURnIsAKPfGhcLQ
         META==
X-Forwarded-Encrypted: i=1; AJvYcCW4dhUNuShnZrFZI0nR9+nxqOwGc3JUhxV6dg1v6TTcy1XrTfbupOI7r7XoxyAfu5F8DhGUSZ+kf75UDQ5jLvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxLU/YM2c+gWp6wwYkKXfCuyahCpcJExsZvIjaKS66Es5DXQUr
	LYlTo7u7fJbw2bd8bbc3ulw+tPEJvE872eANl1vCb1lOVyhwyEEXfAS0mlzLfzMfxclIyB6VgIB
	IFDGkz+IT+3pkxkk7LXAYjeyRYlJowd4=
X-Gm-Gg: ATEYQzzsLrdYVEAzLJnmnu9zEC5qjWsaBDdPwyOa/mMlFQPSyhC6FzihwcJmwCfR8cc
	Pt+p/PCZVtTtCB993F4b5Wtb3f6MAenRIZfDV7brfoBvlGE3bI2knTLnCWPGPhdD70e553e0ll0
	LwwPl0zBHgw02Zd8e7oz0rZWb9y0+8g41Qwet0roBpkE9RVMhb6eekKogcWN+Liiz4u6j1jnuZk
	Ip5Im7HP+hDkOJD7+fLP7P+jhLS6I3TZ1ZReZtgvRB6Ana6V2U8D0V+/S9hS9ihjZZOKltFPHqw
	3fU62RCCqxLRIwtkyH/F+cnGSz7ux/PGLiM4gMr/6Z0P/VXboyGAmr3gEU+mPVJ5EukXCA==
X-Received: by 2002:a05:690e:16a1:b0:64e:8cde:814d with SMTP id
 956f58d0204a3-64ff71edc43mr3636436d50.17.1774634044730; Fri, 27 Mar 2026
 10:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260327082941.1396521-1-shuai.zhang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Mar 2026 13:53:53 -0400
X-Gm-Features: AQROBzABUNBAq4NDI41MlQecMK1c72cnfWT1jZSJzoRfaj-V1aWkzICh_EWxFMw
Message-ID: <CABBYNZKY_-QgsenfU4hpyQ1+87rXDS13wFueN2nX6Wojy4BgHQ@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: hci_qca: Convert timeout from jiffies to ms
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Shuai Zhang <quic_shuaz@quicinc.com>, 
	stable@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuai,

On Fri, Mar 27, 2026 at 4:30=E2=80=AFAM Shuai Zhang
<shuai.zhang@oss.qualcomm.com> wrote:
>
> From: Shuai Zhang <quic_shuaz@quicinc.com>
>
> Since the timer uses jiffies as its unit rather than ms, the timeout valu=
e
> must be converted from ms to jiffies when configuring the timer. Otherwis=
e,
> the intended 8s timeout is incorrectly set to approximately 33s.
>
> Cc: stable@vger.kernel.org
> Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump =
during SSR")
> Signed-off-by: Shuai Zhang <quic_shuaz@quicinc.com>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> Changes v4:
> - add review-by signoff
> - Link to v3
>   https://lore.kernel.org/all/20251107033924.3707495-1-quic_shuaz@quicinc=
.com/
>
> Changes v3:
> - add Fixes tag
> - Link to v2
>   https://lore.kernel.org/all/20251106140103.1406081-1-quic_shuaz@quicinc=
.com/
>
> Changes v2:
> - Split timeout conversion into a separate patch.
> - Clarified commit messages and added test case description.
> - Link to v1
>   https://lore.kernel.org/all/20251104112601.2670019-1-quic_shuaz@quicinc=
.com/
> ---
>
>  drivers/bluetooth/hci_qca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 228a754a9..d66af13ab 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1607,7 +1607,7 @@ static void qca_wait_for_dump_collection(struct hci=
_dev *hdev)
>         struct qca_data *qca =3D hu->priv;
>
>         wait_on_bit_timeout(&qca->flags, QCA_MEMDUMP_COLLECTION,
> -                           TASK_UNINTERRUPTIBLE, MEMDUMP_TIMEOUT_MS);
> +                           TASK_UNINTERRUPTIBLE, msecs_to_jiffies(MEMDUM=
P_TIMEOUT_MS));
>
>         clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
>  }
> --
> 2.34.1
>

https://sashiko.dev/#/patchset/20260327082941.1396521-1-shuai.zhang%40oss.q=
ualcomm.com

Comments seem valid to me.

--=20
Luiz Augusto von Dentz
