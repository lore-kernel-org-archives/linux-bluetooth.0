Received: from mail-106121.protonmail.ch (mail-106121.protonmail.ch [79.135.106.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2E37AA86
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 17:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976172; cv=none; b=WfEqw0Af1DjthAXAEW0ChjDQYIFUuC8NS0hKWaMo6tzp8iTvcltEy97VojxUwclGLW5U/O3Foi/cxTlu0srPzrcODHWN7ohx/Tf8dMfdatjZ03Y9ss2tYQlXVw0wGbaFqQBSSajltRIhwigghSuE0lvJEGGtHh8Ktzi8nMosz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976172; c=relaxed/simple;
	bh=mwOUy/NMXGEZKrthCr1tWMYmYOVvRt7x/OO1rMpAKBY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ed4j1rNT5rTfX+MTl0PecKSUFGarIk6JLcZLGMXjmeCdiR6bivRJzJ65Ll+FbmUJiZXB/4LrCH88cCb70DbQXPYQk+8ALBDHY2RE9GPr2PjcwEkGcMwk5qzUgVik7/K7sVoLWeK4MlUcYhONE6m5BF0iZUYS+O4JggEoKp302oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Wsdgh/E7; arc=none smtp.client-ip=79.135.106.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Wsdgh/E7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788976169; x=1789235369;
	bh=DYSLfUzxzl91CMjEBiNmSBOqF1O75zu+M37AftAOG90=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wsdgh/E7Fb8lJOUaSOrp8FJeCUewMWyGFNOUcFBOsbzQA+CKjJKntlQwjMboCq/5r
	 rIXY91mLQiu9LIK0K3Kokf6ys5Ga2mShhHmqzqbbevktfzV5kzwcW8Jh/FERkDAteu
	 aLjH8IDcbJI0Apl1YIpTRUuii3ZGbRbPTTENkXyAgWXPt0C2E41l7fSqCbelhzEeOQ
	 NutIcdyA2dsdkIDesRxfAYSYi6tOvrRNn5dU0f47ekb3c5zvjjYvXz+50Gp74w7lCJ
	 BQgfIzs91DL3ElEvP/hKHt/XOaxjUnp/nN+a06pNFicuft/1G3Loh7HQ/YeCQw7+3I
	 E149Uw8QCo8+Q==
Date: Wed, 09 Sep 2026 17:49:24 +0000
To: Ferenc Lengyel <dev@lengyelf.eu>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>, Kiran K <kiran.k@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260909174918.80317-1-lsa.uz@pm.me>
In-Reply-To: <df180a89-b214-41b4-b8ce-c6ed6b12372f@lengyelf.eu>
References: <20260908174316.11795-1-lsa.uz@pm.me> <df180a89-b214-41b4-b8ce-c6ed6b12372f@lengyelf.eu>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 0b368a98a5f1c9cd290daea0e9b859cfb6169ad0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ferenc,

I owe you a plain acknowledgement: I told you my guess was that v4 alone wo=
uld
fix your hibernation, and it did not. You checked instead of taking my word=
 for
it, then instrumented the re-read and found the actual second fault - .thaw
running an FLR that leaves the controller in ROM when .poweroff asks it for=
 D3
nine seconds later. That is the mechanism, and it is not one I would have g=
ot
to from this machine, where the failure is on s2idle and looks nothing like=
 it.

The series went out yesterday with both patches:

  https://lore.kernel.org/linux-bluetooth/20260909123416.71919-1-lsa.uz@pm.=
me/

Your Tested-by is on 2/2 and deliberately not on 1/2, which is how you aske=
d
for it: a tag on patch N means the tree with 1..N applied, so 2/2 is the on=
e
that carries "the pair, tested". Your Assisted-by went with it, in your ord=
er.
Your own caveat about ten cycles against a one-in-three rate - Fisher p ~ 0=
.06 -
is quoted in the cover letter in your words rather than summarised away.

Nothing needed from you. If the maintainers ask for more cycles I will say =
so
here rather than assume you are available.

Sergey

