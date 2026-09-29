Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A883A1683
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666763; cv=pass; b=s43l7nLyS0UJanOoBtwrTlWI8ZoAji0igcG2x3JAmvFiHpdkPoH9m/4n3hPctMViRqHqRgn1aAmKMA4QbrwLmwj+zNItai7FHI6+s/vivTcagvD6S9B7G0nhVNAwVaRTVhnOh4S7I8lfM3IdcRvE6zxAvIpuF9RYTOssOuICJCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666763; c=relaxed/simple;
	bh=QP7qZgESzSMLgR7Y2qh+WpPtujTLFVV94zFRn/3wLJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKh+esStBZziooXY8mOX2lNxTa4hICGTVWtoeWuaaO/2ngUgxinzFbNsvqiSXoGwB3ueBXz3PrynYjmGLYNKtdQXulg2o/pbkwQYCKux1QclbvilbG4FaA14i5FNr8JhIJbJG+3j2tzdOL8XnZtusSt3nyARYW7mqGtb+3Q1vBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brmjbkJJ; arc=pass smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brmjbkJJ"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-81be5042c56so1634030a34.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 00:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790666761; cv=none;
        d=google.com; s=arc-20260327;
        b=AL285ThoEWZlJWVzu2QLCAA+Nwt0wBqee4V+KeyIdRM1Swp5vnJcVQmI6d8hKqo0LN
         r/LPBLlJYgn1ranU4VD4Q2isBRBHCwHDkBGyhtdA6VaeNE3/Gaupp+YuvllrPt+t/OSz
         YpS7t76tpmbdaJuH4tLAQAbGrKwQh0dWGN+y+BgL169luiejWi+/4e6kmHVswhCPvXvs
         emP2Zr8FSljkHFvQNu/Oa+zLB7RF5epQqmODJNPc65kHpAG7ZWRBen0ynmmwQRuVbk/v
         /1UDUnwhv5Fen7/9Wf1cm/Mi+4kx2Q2ANGptXmrSODcdeWTJnq4hgaUnhEXo9LDxnaSt
         ioJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MBklxLmUWGp5YMrkYX4HVlElUeVxv+Xuq5ehv5XgjC0=;
        fh=RziVRvAeUZy61XJ1jsuwdXcbu5EVwG1flsHtXDPLdsc=;
        b=Xbf+aqYjHUu9TwBmLbOYZAvKghrib0SsY+LdWi80N6C+/V22xLARWetnqlVgZD3T3Y
         LB5exlK5gu37Okq7Qs1BnnCHUSxgSLgiVyfhLizXo4q36hIRy73UAtPxZy+H1ex/lbVw
         8mApeorthY6lPxgJpqxVtV0RI30ioUFJ+KTYD0A1pW9MMW3reKtkadsXkpYmxdQLDygj
         VSpJA/RiS6TGKu6JeTB0AxYCAmEHceneDZlUmowe/RNTs4ks+K/TvTnm6oRdsKRatiRL
         6qRMZIFKWH5yy93vtVj6islk5jXuhnPCAe2Hbh9XBOGHVTk566B5GkI7ggRy4ZY+Uxn8
         4oew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790666761; x=1791271561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MBklxLmUWGp5YMrkYX4HVlElUeVxv+Xuq5ehv5XgjC0=;
        b=brmjbkJJ+NE/GonX6oNk69B4auQ4xZFqSdw1kuEABzG6Ni2QHGqsmFqelhnBv5iTcf
         6KJ/DRkW+m3Ke822uP7HdZKmEEdCe0qcn5E8O3/AMIhRM4qQV9MYkD4zooQUKGNOw1Ax
         d7t/mLMYmReXO3X4H9VePGR0Wi1cP+c4KlFyvwhlY3/msfPOT9jB1bX/+NDIjBWRdRPl
         RDpZxc//WnyHRlek7aPraK2W5w4ix6shSp2DKKruYTPi84v6SNfys5nvKsQrVC8AYWc8
         Roso+kK5uZLlJ1Af4rkSVKtEwuHEKgj8v7hFRFjDP5uFgEPB81Nz2FChuv8uegUvx/kx
         sOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790666761; x=1791271561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MBklxLmUWGp5YMrkYX4HVlElUeVxv+Xuq5ehv5XgjC0=;
        b=2Tu+hLTvYHfmcU3UA6EfD7URGoHw8X29r+L5jD5Q8pl/1fJn+yoBE756qdu8S5U9IL
         CIcZWdePqNgwysauy3o9dIJiakIcIXT39WHSKw7J3q/h7pLeIz5ZksxUzgQB7HdPcDEq
         B2PJW5/ra0upBAqQUFlP600UGA94ecttCQORRNO8G8e6fxA9e6+Dc8cczu0HCAv4LJJt
         r6+sJw1h+gvxyztMjSGs8Leum92U9oPWCKTdyjRBgk3MWqywwrJNkR0/TukRHr1G/DKk
         RNZ6s6Naf+vdpDgm2xjgAjSVEfa+mShOBfi504fWlul5T/bmXT2pEs7qPnlM1nyFVuyz
         CFgw==
X-Forwarded-Encrypted: i=1; AKwUvBzHQSweBuDNbdPPfLZwCY2OODx8QolGL6ByREOSyfitms/g93WRvAIZ8AwML758ngd7KTY5UhnkFa4kUKMFe5E=@vger.kernel.org
X-Gm-Message-State: AFuF++msGk8Vei6A72JNrj3P1PZoOFIqZ7QLNFDzBIBSeXWh72dAFgw6
	rPxMR5G15aknnTdzO25MnwRkli2gPDmjhsZt/L25GqrBsXhK9vNrqxHfy1oCjvSBAiAWnCAxlsN
	T0ywfENcifuex5ejO4BbEOTTNiI8O3DdGfHH0B9eBceR+
X-Gm-Gg: AYBFou2ZYmwccjG0Ec5XM/Tz0QXXbFNCVx3sYoUTgalYoyvjx0ZBcsMl0ByS2xvFHoH
	Pso4MoyNRC16jyCT1gwNftIh9Ea57ltEbXyZIR7R1k4APtIQIOIoNvy6qfZCDCSJzDd4j8FwyLi
	4LdxXa+04lDEpDozn5ggM/2LDda3DPgrnslIeYACO3JLz1ilCLjJq9dySIJ/Rk+rRWP3Crme9h3
	nvstdpX5YD+6B91HUi0V8BRSAZ5QEJuTE9cFq2qT2cvvhjFrmRyLM/mwJRb23lZiTALVs2n+yhy
	Obdz02EBLPBFPzTihRBnCwbQ+EiMe+Y4tu92EC5oUpq96/2+OVrX2JqYi3atQIwLKZT0IpYZdMe
	KlGdoLY58oMuuFdhs9J/H+j86mv3eFAt4PSRzaBzTqyo=
X-Received: by 2002:a05:6830:6a95:b0:7fa:ab72:9df8 with SMTP id
 46e09a7af769-81916ef553cmr12515132a34.16.1790666760781; Tue, 29 Sep 2026
 00:26:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFabseTuRiyz2pGkc_Qj0moGDnY7KEp1qdTOqkw6gAL3hw@mail.gmail.com>
 <20260911183811.374433-1-aliamemis@disroot.org>
In-Reply-To: <20260911183811.374433-1-aliamemis@disroot.org>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 29 Sep 2026 12:25:49 +0500
X-Gm-Features: AclHuK-Of9yKGEJugUCKZw2ooiR4vfhfGUzCSb342ECJlyfoCnnZi-aVCEOTQv8
Message-ID: <CABXGCsMfJwgYQ6nToU2PkyZeKHZPD4K=ObYtsTx87NvhvM0xBg@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] possible deadlock in l2cap_chan_connect
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: Jiaming Zhang <r772577952@gmail.com>, marcel@holtmann.org, luiz.dentz@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org, kuba@kernel.org, nicoyip.dev@gmail.com, suunj1331@gmail.com, 
	syzkaller@googlegroups.com, Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 11:38=E2=80=AFPM Ali Ahmet Memi=C5=9F <aliamemis@di=
sroot.org> wrote:
>
> On Sat, Sep 12, 2026 at 12:59:09AM +0800, Jiaming Zhang wrote:
> > We are actively working on a patch, if the above solution is acceptable=
,
> > I would be happy to submit a formal patch for review.
>
> This is the same lock inversion syzbot reported as 74071deb, and Mikhail
> already has a fix for it under review:
>
>   https://lore.kernel.org/linux-bluetooth/20260904012028.77590-1-mikhail.=
v.gavrilov@gmail.com/
>
> It uses the same approach you describe, queue the confirmation and let
> krfcommd handle it under rfcomm_mutex.

Hi Jiaming, Ali,

thanks for the report and for putting the reproducer up, and thanks
Ali for connecting the two threads.

The deferral Jiaming suggests is what v2 of my patch did - that is the
version Ali linked - but that approach was dropped during review.  Pauli
pointed out that delaying the confirmation makes it hard to rule out new
races against DLC setup, and Luiz asked to break the cycle on the connect
side instead.

v3 does that.  The session socket is created and connected without
rfcomm_mutex held, and the lock is only taken again to put the new
session on the list:

  https://lore.kernel.org/linux-bluetooth/20260912100315.151674-1-mikhail.v=
.gavrilov@gmail.com/

That removes exactly the edge in your trace, rfcomm_dlc_open() holding
rfcomm_mutex while l2cap_chan_connect() takes hdev->lock.  syzbot's own
reproducer no longer triggers with it:

  https://lore.kernel.org/all/6ab100d7.71f81b7d.15fa6d.0029.GAE@google.com/

v4 will follow shortly.  It adds a check for the socket being closed while
it is being connected, which Luiz and the Sashiko review raised on v3.
I will Cc you and add your report as Reported-by and Closes.

Could you run your C reproducer against v4 once it is out?  A Tested-by
from your side would be worth a lot, since your trace hits the cycle from
the connect side, which is the edge the patch removes.

--=20
Thanks,
Mikhail
