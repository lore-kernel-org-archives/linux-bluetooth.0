Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF51B3803F5
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 14:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776696269; cv=pass; b=qgL3rqgVkPaOdKx+mIP+RNf2boMInyPh5I/0zDYW04pCAXiwA0WmAgOxxwYqZM/HfQVnWXpx5a6ZmDf741Qj4d6xgQqo+B5jDh7D87g+M5N715VdG0rBMgT8R2fAFcbbDtU29Ab23eOAnTwtp+QC6oUniThxS0Wcot0HRStfmdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776696269; c=relaxed/simple;
	bh=8lrkGBHatQ6vQ4p2oPTZlrhDntfr8RDQrxGbPkQqLmU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UDat655BNjKGisyVQaT50vGFGbn5i8e/80tzCxXOHDx3dZRGEO98TDszexkoTU3IVFLmnKIBecmcOlX8xSFqbr/vEayBBmXuOKrCZ7+kvJX0cbz57iQVGIlCh+NwfT7mZRQVYe81bTvYf88em7nCB9xwpG3kV3PNFSHXPXse1RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b=ClUzxW1V; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=george.kiagiadakis@collabora.com header.b="ClUzxW1V"
ARC-Seal: i=1; a=rsa-sha256; t=1776696266; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y2wZMf7N435AkmnzZ2MDrJaVWnZN9wq5Ylx3SqDEY81mPIlDPnUnh5VZ/nsqYW84PAYZv6RBsJoDRaJWelXPXgZ+hwIZJDW9KdTuGDEq+TbE86QnvG69DG9ye0iKHlzUuup0KydTFi/bz1RO04s+GmA0kvSc/gvtIjppAq6lRyw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776696266; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=8lrkGBHatQ6vQ4p2oPTZlrhDntfr8RDQrxGbPkQqLmU=; 
	b=Tiq+07JBZnm9tA1L44XW4TbzNbMERRa7OvO4PTuqFNr+8+LZaxp27XTQj08gdCnhInYo1hTsTw2gwhLgY+uUOGJwx0X+Kpt+W4+0c5EKFuu3NvL3u/YnT9p9AYskmdpnswvLGZfEV7KBlI7+5q3BzfY83T5OZZafi7qhx60ptR4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=george.kiagiadakis@collabora.com;
	dmarc=pass header.from=<george.kiagiadakis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776696266;
	s=zohomail; d=collabora.com; i=george.kiagiadakis@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
	bh=8lrkGBHatQ6vQ4p2oPTZlrhDntfr8RDQrxGbPkQqLmU=;
	b=ClUzxW1VjC+G7jTUgyRTJCePEmT2TZT4EvL2pS7IS0r1Dv+uodeicLUfCP+Hi256
	9XsFcnUZiLGAgAwvOzKb79A5SWLwVB7CWK06p0H0jcbwtLDlz1ufgkv4m58+ulDJBH+
	VEm7XdIsQaUgY7fLg8/FDWlR/wPUamzdUF6/d9iI=
Received: by mx.zohomail.com with SMTPS id 1776696263886389.760528000371;
	Mon, 20 Apr 2026 07:44:23 -0700 (PDT)
Message-ID: <3279c8579e9c1750c672bc070b91a48c13a3f4e7.camel@collabora.com>
Subject: Re: BlueZ Face-to-Face Meetup - Nice, France, May 30-31, 2026
From: George Kiagiadakis <george.kiagiadakis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 20 Apr 2026 17:44:18 +0300
In-Reply-To: <39DA4E65-9DE8-4857-8776-41F7BAF00C56@collabora.com>
References: <39DA4E65-9DE8-4857-8776-41F7BAF00C56@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 10:50 +0200, George Kiagiadakis wrote:
> Hello everyone,
>=20
> We are pleased to announce a BlueZ face-to-face meetup in Nice, France on=
 May 30-31, 2026. The meetup is organized and sponsored by Collabora and wi=
ll take place right after the Embedded Recipes [1] conference, co-located a=
lso with other events.
>=20
> This is an excellent opportunity for developers and stakeholders to meet =
in person, discuss current development priorities, and collaborate on techn=
ical challenges. You are very welcome to join us!
>=20
> Announcement: https://github.com/orgs/bluez/discussions/1881
> Dates: Saturday, May 30th & Sunday, May 31st, 2026
> Location: Radisson Blu Hotel Nice
>=20
> Registration is free of charge, but we kindly ask you to confirm your att=
endance by commenting on the GitHub discussion thread: https://github.com/o=
rgs/bluez/discussions/1881#discussioncomment-15756005
>=20
> The meetup is strategically scheduled adjacent to several related events:
>=20
> - Embedded Recipes conference (May 27-28) [1]
> - PipeWire hackfest (May 29-30) [2]
> - Linux Media Summit, Buldroot hackathon, libcamera, Yocto Project and ot=
hers... [3]
> - Bluetooth SIG Member Summit & UPF in Milan (June 2-7) - conveniently ac=
cessible via train from Nice
>=20
> Note that the meetup will share the venue with the PipeWire hackfest on S=
aturday. This co-location offers additional opportunity to nail down LE Aud=
io integration topics that are shared between the two projects.
>=20
> We look forward to productive discussions and the opportunity to strength=
en collaboration within the BlueZ community.
>=20
> Best regards,
> George
>=20
> [1]. https://embedded-recipes.org/2026/
> [2]. https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/PipeWire-Ha=
ckfest-in-Nice---May-2026
> [3]. https://embedded-recipes.org/2026/colo/
>=20
> --
> George Kiagiadakis
> Principal Software Engineer
>=20
> Collabora Limited | Unit 1.06, St John's Innovation Centre, Cowley Road, =
Cambridge, CB4 0WS, UK
> Registered in England and Wales | Company No. 05513718
>=20
>=20

Hello everyone,

This is a reminder for the upcoming f2f meetup in Nice, on May 30-31. The t=
ime
is approaching, so if you are planning to attend and haven=E2=80=99t yet bo=
oked, now is
a good time! Also please remember to register, so that we know how many peo=
ple
to expect.

PS: there will be option to attend discussions remotely, if you are unable =
to
join us in person and you want to participate. But of course, face to face =
is a
different (and highly recommended) experience!

Best regards,
George
