Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC818E752
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051972; cv=none; b=oOLdJdNZNU2ximhddr43Y5as3+MU+2+n9FLf0W39gn/0F9rGdh3FRg2iJCpU5R5PqQqdyGAJEInQQ/GD8XETVNhMWpXevQO7XorKj+pr9hofwfJuFCNfi3LQcdHEeVtNckaAB0NH1YbxiuUHjL/0PDLDjffmEh1siSChxZa/OSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051972; c=relaxed/simple;
	bh=fVYvYCrgRJF3PlF6lGBsfVvFPNzlOsXIOFH0UCv2dY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQIe3SSv9HaqLit/IujTPqM0Db2bbFm9WsWknrDH4j2qRG+CJGuJxbCj349uA4nNLSqtcT059sYeUDZ8rxsM7tNxV3lc/M3ipCfWmIdps3K0J4MZlrclbWy2oaPyt6hu0I49grDBUjgl8TVTVKqqDVVRnWKFZ1j5twUZGK4L1Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQXp8/7Y; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQXp8/7Y"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-64789495923so40716877b3.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2024 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721051969; x=1721656769; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xbpAf9Iz0WaXtkTP5+IPP8WJkp/UYJ9URQ8tAUfdv80=;
        b=jQXp8/7YNfTq8etCiHOxiTXhgJZzPPy/Up6zH3xWis/VZuMLjKuZkZxgJZkvYJQVVj
         OGfVfOvnnQQoYINwn5lpfDBd0th37G5NubdOB/JtW7ies57mJSTLYsfK7EAxHgP4/alJ
         +JyLHSxyPOIJ5CiVFxQd7m1C+4rtfmMBTpP9LB5H9cewcWSu/LtqU7VZyuWeI+UN52UC
         p1PzBp2TMFIDd4SXy1whua2ZruvQw+0ziT+vl8ZjQIJTAIIv+wmBZnsY6gcoxYgybJbb
         ljO3sPLEyS9di7kvh9ElidpwsLKZTVVq+FDkM7Om+mczCgRkg3nvisLSqGkeN1onsyiA
         CTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721051969; x=1721656769;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbpAf9Iz0WaXtkTP5+IPP8WJkp/UYJ9URQ8tAUfdv80=;
        b=OCvbiNki0QUt7KpnpTBJ/5Z/b0IsAMnIdQEnc61BjWn21Q3UQq6xwwDdVfNmlt4ikr
         Hg0jHDQ458wgA7U+rAhvUew5uPG9ETh0Pykx6b/ZZqPIfK9jYaTUUsAyfKCXzEu+zYsz
         uCSYN1jAJQvIwh88Y1ROH7apvnp7Bc3aV0aVnlbd7rIr8ch81hFWcXv33J11pUBzQgk8
         7rcuIEE1obJjLnb350qkCwzta0Ba08IjgyOCiplmiFjGH+pQIzfo+sdbY8/n+agVbf54
         pLd/ALNkTMoVJZaMFiVDVY/1ea1sMgUPMptTswC9oUxJYhWxr/wKJBoDfYPxW/ndKmD8
         F+Rg==
X-Forwarded-Encrypted: i=1; AJvYcCU/sdnQB1QiaGK7EETuokJ+mbs6aintzNTUG3zwZb0GzjUC8xKit4LXTF49hMwrhutLyFvaqWe7UzmT8212dFmnu/78/oRDLUHdVVFAREqW
X-Gm-Message-State: AOJu0YwzGUf0ZebtRmCsL9IDPgag5DbuGhcE1Bv2CFKmvEjkN/7f7cAJ
	neSNyhIQ7Do5+Ae2sQACZjpY+4dbdg4MGlaxkoRrsDCEEdFRHJhWNdUNht8SwclT2pfPHF1WMhT
	El1XuaCK0VeBtGGs2ThJfVlptB7Y5yV2XR9BEY+2Zo15OnCrn
X-Google-Smtp-Source: AGHT+IFq4yRpnxT2dPyje15G4PJAq08GA3tX1Gr8HKva6X+GNBjNoKXyg6sR0RdTV/BYANGhO6+gfurAhfoU0kRceb8=
X-Received: by 2002:a81:8ac3:0:b0:646:5f95:9c7d with SMTP id
 00721157ae682-658f01fda1bmr186420427b3.36.1721051969436; Mon, 15 Jul 2024
 06:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
In-Reply-To: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 15 Jul 2024 15:59:18 +0200
Message-ID: <CACMJSet9xj=Ct0=OuGRX_xHsES6MgFe-OkYnGoCD+TetUcR7_A@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Jakub Kicinski <kuba@kernel.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 15:55, Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > >  - qca: use the power sequencer for QCA6390
> >
> > Something suspicious here, I thought Bartosz sent a PR but the commits
> > appear with Luiz as committer (and lack Luiz's SoB):
> >
> > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets") committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
> >         committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Is this expected? Any conflicts due to this we need to tell Linus about?
>
> Luiz pulled the immutable branch I provided (on which my PR to Linus
> is based) but I no longer see the Merge commit in the bluetooth-next
> tree[1]. Most likely a bad rebase.
>
> Luiz: please make sure to let Linus (or whomever your upstream is)
> know about this. I'm afraid there's not much we can do now, the
> commits will appear twice in mainline. :(
>
> Bart
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/log/

Alternatively you can wait for Linus to pull my PR and then just drop
my commits from your tree before sending out your PR for upstream.

Bart
