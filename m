Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F36D49EC54
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789142949; cv=pass; b=rQXou86xpIC8l1dQCT2UQcwgDuQLvtDMDPJ2b6ZWTnK9GFL0M2PLqy51wwDqki0g1s2CRQTG1AIHPzJQilBIw99Ye76bOagsewlRv4qfeUDlLnodTe97Qt35SWjueRtfFoaWxRMw0Bb+oRI9z6i3rYSSNHcVb4SmhKkEbIPxdvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789142949; c=relaxed/simple;
	bh=NoN1MVab1tJYLotpBfWAO5k2PGtFrXkg1OQCxGFBIGY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hdiZ+dgZbq35aRmvgWMSzWPmNq9t1BSY9Ls6xraU+8xp91PGqIrlRK8Eov+MRs0aYmVMNnHvwsMQWGP55KFY9suhQV9nBWbdwSkIys8a1h/Y8uoAS5eYdCJaCAGuTLauLC9HPysYWJgbdEGr35zvoEasJEvSGmZU6FBcA4SgiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FVE4/hAt; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FVE4/hAt"
Received: from [192.168.1.195] (unknown [IPv6:2a02:6ea0:1508:9::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4hhKGs55bjz49Pyc;
	Fri, 11 Sep 2026 19:08:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1789142934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoN1MVab1tJYLotpBfWAO5k2PGtFrXkg1OQCxGFBIGY=;
	b=FVE4/hAtAOvYc9jvioYzaUWZmZnnsoKY3fpUcJwZqEdct+PQUOKw338aizRQ8RG2fGcp+u
	KDUSMpUKqbm1x7HW4J96os3deGFbUOcqxl1Y02J8KNfxD0dZD1TR2x4TBKqkd/wlxYrE9+
	0kOvYiN4lknRI68LDaDl1XvT6HacSQKbxmJbnC/rqfpwP+ckDYN3BNYbMTtNlVoic+Ich5
	sDWmlUc+8f18ijWR/GVRzQHcXmUzdpVfN5YecR9MvnZB5V1lZlxt01Y6dB4712+zB/JB8Q
	stZqz8o/lV/a/WikIQqYCh7psnwzp6/MSZSk8HMi/rl2QXgZDDDK/DMcN1Zi8w==
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1789142934;
	b=GPV5LLNTZNARvYQ0yTN0Azl2FoG2D9uqwBtXA9RcrdOYM1qDuUjC3cryosk7S9q36ARCue
	xo4CaCRxVlg0KapTtLAF1i8+KeVyuA4LO6v618o3hnFQ/s1+z/jOPu0L0XECJl6xRQTnpx
	+WEHvMvJQeUVZLHwFDI0zBhDubDzPzmE+EwhH+BQO6GlpQGWqEmA3iFzt8HCE6PvhLOWpt
	MKntUGSxEA6mevLw6/n5t7zFW1WJE6uDfspOE9HG3Lz+5DyNExw11sXhgGCSHMhf/BfQqn
	9Y2pYQKjZVOZVuHLP0Sol/IzN5J/i2bP4dt02atDJCdYz/Zr1CtVZblKWgyeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1789142934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoN1MVab1tJYLotpBfWAO5k2PGtFrXkg1OQCxGFBIGY=;
	b=vahao/MvTBgQG/CEE+1XOcMBZjCakq6qtanCbI9n+66kKHUBd268VFc5MTw/b7lZZZwgA7
	TPrODdQsQP3TddmQP9otdKplKICMJECKsqsmJqQWp/Y8fa2beF74RZBPTuXCoHGzPtG+4y
	v/A68ytED/l/EuGLf5Z/iXLdONRopF69lNGKzHJwPEH4RVtwKuvttu3BjCu1ZnByQMDUj2
	DVQSbdP4cHCBo9SlQ8QFcKrfOkbhKKhl/V03B1UkYvCqkxf2hlE6p4sdK6lVDgap+wm2VJ
	17v7nLrTYJysUXceqN/TQzZf+gyrr8nlIghdcq9R+rOvjkl1UqL8dcIN3Cd1cw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <32f2cdeea1561dce8a974196bebbdd1b688e4542.camel@iki.fi>
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bastien Nocera
	 <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 11 Sep 2026 19:08:52 +0300
In-Reply-To: <CABBYNZKW=W8_Q+KXmGmn9gt7hN74H_EO0mSd2vOzqM64yoGWmg@mail.gmail.com>
References: <cover.1788712996.git.pav@iki.fi>
	 <178889520963.3704993.9911217550470009790.git-patchwork-notify@kernel.org>
	 <CABBYNZJmYqh6ZJ2wAjauP5mkK5gxgyRY8-EnKZ6v3tPNe5=6Ww@mail.gmail.com>
	 <CABBYNZKW=W8_Q+KXmGmn9gt7hN74H_EO0mSd2vOzqM64yoGWmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-09-10 kello 13:47 -0400, Luiz Augusto von Dentz kirjoitti:
[clip]
> While chatting with @Bastien Nocera he suggested moving
> https://github.com/pv/bluez-ci-image/ under bluez organization to make
> it easier to manage. Perhaps the same should happen for
> https://github.com/pv/pytest-bluezenv.
>=20
> There is some documentation on how to do it, if you agree, on:
> https://docs.github.com/en/repositories/creating-and-managing-repositorie=
s/transferring-a-repository

The plan was that bluez-ci-image would be moved under bluez org. Image
name needs to be updated in the workflow scripts for the image and
action-ci, see
https://github.com/bluez/action-ci/pull/7#issue-4699895038

> There is some documentation on how to do it, if you agree, on:
>
https://docs.github.com/en/repositories/creating-and-managing-repositories/=
transferring-a-repository

This appears to require I'm member of the bluez org, as it complains I
don't have permissions to create public repositories there.

***

pytest-bluezenv would need BlueZ organization account on pypi.org so
releases can be done,

https://packaging.python.org/en/latest/guides/publishing-package-distributi=
on-releases-using-github-actions-ci-cd-workflows/#trusted-publishing

--=20
Pauli Virtanen
