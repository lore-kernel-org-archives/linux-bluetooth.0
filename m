Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254ED46AA6B
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789393606; cv=pass; b=AuM0N3qeMwYO7Jenk+foUh0u71n5tu9PItNtJJw+H4Ca1lDsyywn69+G/SL1SS7ZZr4h+59muJ3t19fk1c+jpqQjOdbDHB7mSatAI1NL5ukEUUpnzR9sG85UeMuKC9hpMkVjQyDDf2qTmAX7Tewy+1AaE6Wml1sMO1WB7H1SkWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789393606; c=relaxed/simple;
	bh=XRYrYa93MaXLsu5fRW4xcEUPcVNgpn7TMsJKPKTiAMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBKrQV2uiVW+g+/3rto9Bp8KwCVpd4rFHd40uWmsK8/93460LUvNxbt0IEv0x2l39GwcdK/qtSAbVGpCnsLaWngzBmjjZNDVuNmoaRueoF8r+wT9dOBkQU5SVQJmD4aLbX6d94IYLoh7/9WgKy7byYM6PLslOfp4VwcbtNyxyvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQgan3FG; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQgan3FG"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67124ad72e4so3146752d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 06:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789393603; cv=none;
        d=google.com; s=arc-20260327;
        b=q8Njhd2cOxFsqpw30V0OXbaj6sqDpdsUyDuHDvpU5+hcftwK9yWJ8qb/HIMLbagdcQ
         H42E8xCep1Zg1921uxe0F8c61PPK8aNkprSyrIrQ9K7gMyG6bygr51KGe4NFB7Fkhrt9
         I7LzYmvdg3EDKjM1DrXYkOO9epWkGVw1j8OT24TcMZaY/kOBIcqDGfRyFRl+cdLaAnl9
         PezsGJAeGtCJMPbgi2ifnnHyDYRAAPskW/Kq4qaOtLGwBftTkCYQ9w2FnWBtaycRJ8+9
         9xV3hyKIlO2XyRWzN+BL5I4YMDD7B3CFHzFaudG922MGcTpZrw1fHdvLhv3qQyMlHAdE
         dU3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5fv8Bd+WM93epa+fDZa03fGFvddhLnt01168yXa1gpQ=;
        fh=klmCmF8Xyvzx52IX4dw+DfSXmXqRrInOc7G9/FmOseA=;
        b=hQyxsAO0gTDz0W5HUN3RiwiJsKkWSv7CYHE4XtZS07KF9ahaPygcFMPE9FDjaLxRtN
         Ljnp9yU7DFitd9P0Ph6YHseqguniCM5zhZkX7d6af/cOYRPBRtozSo0xm3UQL2JEd0nZ
         PoSmf/FN9TpysVqKFF3+He/oWxEfH+Hr3am87Hvo0VnRUsv2YVP8KpdjyWy8c3KNK7iU
         267Nia8yE1+yY11JE6LForvpV5Bkh0QAl4ZgzXG3ZAiM0E1ee5dyRkPN6D1wtSgX68IP
         TySb6aYtpjwr2m23gBj95tCWcP/JFocmKKw/t7Bpxvkfc9EhaazA8mTuHa3WUsbXyq4i
         4veQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789393603; x=1789998403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5fv8Bd+WM93epa+fDZa03fGFvddhLnt01168yXa1gpQ=;
        b=VQgan3FGJcLMRpLz7ozgcQGUqGKvKBXIdPryqubEcuVLBLONsfzmzcQFxS0zRW5Eth
         xxvVmiczk7E6avZlNvO1ebiz3GjG+c9xv8u/N77e71j/ApLwr8lHVh5rvrdO2IKHc9Yt
         V1QMcd1o4LTOb1VF5KT4YYW2XeCWVL+vlatFEMv+uFD2VYyz2q9+KutMtSIACyspfa4R
         kVCy7jHZ5QKqzphD1CjwmPmXqzAwSdFSxlAsLgQIK1x63Gd9BrpUzXThSf1Mgj2QKpiH
         o+VV2WWwsV/PH5EvhkUXUUkFeNLufLtlt8IoD9dEXGy0crT+jgiUAImTSE0NvIdcXh1s
         5+tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789393603; x=1789998403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5fv8Bd+WM93epa+fDZa03fGFvddhLnt01168yXa1gpQ=;
        b=bFaD/LAvLtEPNs5516MaVJzJzKUHze6bLAX9LoGTscuDOYiNTg56zvww6sJblZ8vD6
         hQ0VP8wGSmocbrHsuF9Nmoqy6hNkT9KtKVNmB7DCzvwwwaj43B/FqCxKnqty/s2iGHgi
         ExJv+7oDa+3++o8eY6s/Q5LKyyWf4R8XEnVnemXzJBudBc2oeD4rXG7alfx4+HgqlDTw
         THfVYxvFw4CbeWDyl6F8A2c0aQW3VMXXstuO4WAzPxa7NsENIzjl93dNL9TfLmUTtJIa
         Khl/fBgT+YVLtvhOMAolFQwdu1DBG8eA5CP6vaMIE1wlM4NOjM8muQdlvXkDuvrVeWc+
         cjzA==
X-Gm-Message-State: AFuF++l5KugNaya5BdlCjn7u+PlYqPxWDMZVJdDeIqYb2miJz1Na0asc
	5m/AMcUAYI+D53UOu+GP1Nqxys4BWvpbkgFLh8OTAqBHZhOtyxoj9iEiXZWqhLZ00tAoBExIB+A
	/wMDqIzTZ97miSX8amH26+3QYgmM7Kaukou5KamQ=
X-Gm-Gg: AYBFou3iEPocJISIhdVYiK58toDglIzqG/aYe9w0Tvlb7T+8cgjf1BDZbu+pz2Op2IU
	fsu7A74e6ci/qty5Ec8006WsFmD9fsAdh7u+o3yAAu68a05CS18dvMYZL20505MaMlFdMkT7kBt
	UqIXUBkUicbHKA9VWV9KVjLxTNZ2rIP0r6K0XGG2wYxtU+N6zJ60F4Gnhbnd/X8bkZOgPlqPZgj
	76wFo2Y0873vwGd5uX7Ly8NrpnO7RhhcOXacdDRvmSozTyYMbNXX5XLYe81GBMEnjzUqya68kac
	r/+QIw8Jzj7iZl79/R2DubOrfC+YC82eHnhLu72QSUr/vcd48pRjnyaufzXSjlliGissyT3CR1l
	URkBuelruw68ZeybPiJXa7Tsj2/eoKUNmi2Z+FkUl640UXfMyMOoq
X-Received: by 2002:a05:690e:4894:20b0:66f:c1be:a641 with SMTP id
 956f58d0204a3-6714e07691fmr393356d50.51.1789393602822; Mon, 14 Sep 2026
 06:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789220439.git.zhilinz@nebusec.ai> <a45e40e8a5360391b24f8d1a3a0cc7d03e8607de.1789220439.git.zhilinz@nebusec.ai>
In-Reply-To: <a45e40e8a5360391b24f8d1a3a0cc7d03e8607de.1789220439.git.zhilinz@nebusec.ai>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 14 Sep 2026 09:46:31 -0400
X-Gm-Features: AcwNN1X2dwsiFlUYp8o_0G_AsTMurBJm2-CIV0O6TwsRvrMRCN30egqfiJmirls
Message-ID: <CABBYNZKc=y0V-Lw20x_dKBaFJDKAFuWbgChGEa-fEPw+c5Z=aQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] Bluetooth: prevent wrapped eSCO connection attempts
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com, 
	kiran.k@intel.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zhiling,

On Sat, Sep 12, 2026 at 9:45=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai> wr=
ote:
>
> The eSCO retry counter is an 8-bit value.  Repeated synchronous
> connection failures can wrap it to zero, after which the eSCO parameter
> lookup uses an index before the start of its static table.
>
> Reject a wrapped attempt before the lookup and before building another
> enhanced synchronous-connection command.

No idea how it is even possible to go past the ARRAY_SIZE to loop
around, or is this more of a defensive coding, anyway we sould run
into invalid access if it attempts to access past the ARRAY_SIZE of
esco_param_cvsd, sco_param_cvsd or esco_param_msbc.

> Fixes: b2af264ad3af ("Bluetooth: Add support for HCI_Enhanced_Setup_Synch=
ronous_Connection command")
> Cc: stable@vger.kernel.org
> Reported-by: VEGA <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> ---
>  net/bluetooth/hci_conn.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 8de98af2fb581..582b85f063874 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -217,6 +217,8 @@ static bool find_next_esco_param(struct hci_conn *con=
n,
>  {
>         if (!conn->parent)
>                 return false;
> +       if (!conn->attempt)
> +               return false;
>
>         for (; conn->attempt <=3D size; conn->attempt++) {
>                 if (lmp_esco_2m_capable(conn->parent) ||
> @@ -294,6 +296,8 @@ static int hci_enhanced_setup_sync(struct hci_dev *hd=
ev, void *data)
>         conn->out =3D true;
>
>         conn->attempt++;
> +       if (!conn->attempt)
> +               return -EINVAL;
>
>         memset(&cp, 0x00, sizeof(cp));
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
