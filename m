Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B0B3A4F31
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980182; cv=pass; b=n07989RCWAotDqLZerL5UgC1h0AhX1NbtWqhZDq3Xt3mtIeZoWJ4M6zpjP5R18Wflc3doS/mrLNCWPpWwkkQKbm/UM8kft/LZTRnNoIpjdOMzIkHqBOgo2jXFjuhaJDHILMV/3leWL7S7oGBwg1twpABTt/AlJxrlaPwStYTneg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980182; c=relaxed/simple;
	bh=v169Ph9KQetNzxSfr4qNJk0CkRwGUbgmiuww9pZv3Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGWs8HCBzehQPH0w6MU7sTScA3WixOOS3Li7w71lS2SAZoXKGF9o4uy1aRB6tzYAlMoneYfcW81oaoGXl7z7e+s5udngPGtzMLsOOTZtsqnP68pf8DFGhiUCXc+ojMIsfE3enrh66E4PagQvWOnf1o68iHyl3QPqfMkweAuzUjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5WnYWAC; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5WnYWAC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8565d77c277so86490527b3.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 11:56:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788980180; cv=none;
        d=google.com; s=arc-20260327;
        b=cn61gDUmIUK7bnxamq8LNMyac+VCqDEhMJo/fFKzkXbRTbjQGnA3tQWYSXHidivQrH
         LtEH67ICp9cw19gCC1oimCWkkM3ZhdX6WzE8Nlobrt+16pMt/dts/2leNedTRP/3yytr
         4jS7uLuqta1N/JoSNZBqGmxGkgPcDQHVmH/I5OulmCm7HJ/3csvnCw+UsE5Ru1OJ/Z5V
         4ad383XLMf4uCLkhcuIT/qYNtR3wTw9cpgD2ekDPuNyfmY0KY9P2cb7zvHO2LXl+kYvd
         FufFr/MZ28OYMGN6e8cXr+vjQmjnXOwVThssohXM3BT9zgujq8lk9ovWaqI9SIMqO+PC
         o4eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3pCf1fD48gFxTtE+nVWYZVzn0X/IuUaa0rlzbaSjKQ=;
        fh=Gq4dvWE2ynBNkE4ExOOG3YKA3TstX0zmcJgbOpofQ88=;
        b=NfepTCVZNlwumRiU68odoi4FX7vf1nWMU/CLfRPropIORM0VIcfJNNQW3U3C5Nhzam
         JehSJ1s2U9krj1XQvvaExK2FIoZfHKRQZ7/YtX3dVRJRk0g0zR9bwF5i9KP7PrVvJZ1R
         dElXCT9KvoImfO22In2iMaKQK0zMvLKHQ6+55wTEYwN+JJcJIzziC9eh7Ta5BVaoQCmy
         1BTInHqfpDTUCIxkE9oRAKg2IWTVtXKxRbz0/Dnf/Z5CsjuO1P9yHBVl48zuKfaRy+Dz
         N1R7j3L43ubAanTZQoQIqk72i5zutT7lP/dvQOOM3Vc5HIZTk++t8U7yN7xQ+yDcrCsw
         OKow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788980180; x=1789584980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=s3pCf1fD48gFxTtE+nVWYZVzn0X/IuUaa0rlzbaSjKQ=;
        b=i5WnYWACmxK1DvYdR2nwlWd+5ni29CbXK0sE8v4WK7kzlcTmomCqOoEx+M0sOgLLyw
         QILysP+G2dHXSWStDPzdZDY6cI0U7DtWzDJ0+vIITLGmywRrSlwic5+MWkQFWCnM86KC
         /Eom9mRY8tcrtq3luJCSJL95Loho8PVsza53w0Djroq1gHHaywu/fn3PsrutfO0Py+5p
         B9WHUrxHDV+zsqypo0nJLHYdy19CdonvnvG6MGiqimQgEYRn86iLDpuxXG1H/vkxb/V2
         EknKWXZl6SXZuhU/QT5YsJdJFkU8DvtbIDTELJ2I6LDOmLWSAxwuotWZKhO6luAbfD5f
         66+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788980180; x=1789584980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s3pCf1fD48gFxTtE+nVWYZVzn0X/IuUaa0rlzbaSjKQ=;
        b=GDeclJlttH1XbkM+5xemb3SnVgvn64dQgiTFVelg7wMlS3wNlUpwVemjprKK1GnROn
         IAo30tTIRHxURmtwnFBHhEpt5TiU9SkhMUcfUbCUUy+iHgq/VyCKhTJB/HvNbG23pbxi
         TKEnpPRogfdjUc6t/oYeNvFj2UglfcNtGKLhvK6pxyY123o6JgPNb4j1MDUAPMrhm8PR
         sUWpKq3xntVx9Ycd8yjzSPK4LQMHzaqvLrEDtp064wXe9uYFxLZPsMEivDp7fvPNVMGa
         Ew+VLD2z4Porp/fAsmqb2OGWVU5vTD8Sro3uIZK2LGVX1TFYNwZpD8t0OJxewkMyCUT0
         HA7A==
X-Forwarded-Encrypted: i=1; AKwUvBzaVPNFEqVVqv7jheb1viWnK0ctD8+BKRs2r1Sc5zz181T4v6PlEqPqi94M0oER2KYQXTPZMd25CoiYPWC9dm0=@vger.kernel.org
X-Gm-Message-State: AFuF++kU6aS0kfkgaLHB0pZTOZgRMea5ANKRWomVgovGyg1J7h5tjq/Y
	NEiiZnwteFVZxQDJi9a9pPinAYu6bDfRvtQDsagcR49GEFDSq//UmTJQ/IWj1slkZDqFekAJxYd
	Ov2/Xq45uf7rGLla+jY545y7MBfOMucs=
X-Gm-Gg: AYBFou1+6GqbODBn8w4jj4X35fI4oJtnsdxWBO8Q5I1j0gX3E8ZX2ntXzTxQ9TLK1G2
	6XmwCGoAr1evm9NL6RpLfy707qIY0pNXX9Oe1rWuCPTV4kREYnsXo+ER/PWaoagNOKASFof8V9q
	Icb7KLZng7gQuQZMiMdZgusaDHqaKhZenoKxuL3q2e4LGQKqyd3oGBn3KwP2LRL8rrK3YBR1Fzx
	ZTiGbmj2xr56BzbQAYugU3Z0gI2L0+fnOE4K6H9uIN8hUwRYiTitlnp8YOGs6gKedL2x+gsB4lL
	xiykLfzWrhcCjmAETb2VJOZrQ/jf6JAs63ZSzP2nuTn7g3FBwQGZFdhUHaG7gDIgNTMOktTULtx
	XSB60685bArfqgSlvtbUoqBZHL2FSyGknx/coaFP1uQ==
X-Received: by 2002:a05:690c:c50e:b0:872:1e2e:b4b6 with SMTP id
 00721157ae682-8721e2ebee3mr148014947b3.13.1788980180008; Wed, 09 Sep 2026
 11:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788712996.git.pav@iki.fi> <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
In-Reply-To: <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Sep 2026 14:56:08 -0400
X-Gm-Features: AcwNN1XaSmZalH3l_W3lvyCNfP5Rg7x0TzCCNWuOU84xdyKSUKfjjw0x51vnfJY
Message-ID: <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
To: patchwork-bot+bluetooth@kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Sep 8, 2026 at 5:48=E2=80=AFPM <patchwork-bot+bluetooth@kernel.org>=
 wrote:
>
> Hello:
>
> This series was applied to bluetooth/bluez.git (master)
> by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
>
> On Sun,  6 Sep 2026 19:49:42 +0300 you wrote:
> > Add framework for writing tests simulating "real" environments where
> > BlueZ and other parts of the stack run on different virtual machine
> > hosts that communicate with each other.
> >
> > *** v7 ***
> >
> > * Bump to pytest-bluezenv=3D=3D0.1.9 (better core dump / oops reporting=
)
> >
> > [...]
>
> Here is the summary with links:
>   - [BlueZ,v7,1/9] doc: add functional/integration testing documentation
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3D19a5bbd7eee2
>   - [BlueZ,v7,2/9] test: add functional/integration testing framework
>     https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3Dfa9390b5cee3
>   - [BlueZ,v7,3/9] build: add functional testing target
>     (no matching commit)
>   - [BlueZ,v7,4/9] test: functional: impose Python code formatting
>     (no matching commit)
>   - [BlueZ,v7,5/9] test: functional: add some Agent1 interface tests
>     (no matching commit)
>   - [BlueZ,v7,6/9] test: functional: add basic obex file transfer tests
>     (no matching commit)
>   - [BlueZ,v7,7/9] test: functional: add tests running the various kernel=
 testers
>     (no matching commit)
>   - [BlueZ,v7,8/9] test: functional: add test for adv_monitor crash
>     (no matching commit)
>   - [BlueZ,v7,9/9] test: functional: add test for AVRCP crash
>     (no matching commit)
>
> You are awesome, thank you!
> --
> Deet-doot-dot, I am a bot.
> https://korg.docs.kernel.org/patchwork/pwbot.html

Do you also have the changes to https://github.com/bluez/action-ci to
enable functional testing? I was going to do it but if you already
done it please submit a PR.


--=20
Luiz Augusto von Dentz
