Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F1F20E3
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 13:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726148337; cv=none; b=aEOhB0WlvzvFcdOUhmhDPCM4W9QIfMeazKPd9Bovd1uSAo1QBh4LGQ79qsSnMX3SYWKxwg/uUNN5H5Gy8i4oR3eHshkwrfM7HrcB8AmJDGIuJCYFSniAGgXeKpO6MeGajedVgIofXqcj7UIvPG1JSOh1YeTy39TY6IP05BqJ08k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726148337; c=relaxed/simple;
	bh=LP4hEtrpjUNlBDmiVamJqgvTq9ofj3WiQoYl2xrkpFk=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=U29+3AYi1mor+EK9IJeAyJ5wbzEFSh4NUmd9Wen19pVR7cmj206Inl90VOFWQk/VO488LpbUOKhZj7Ojrs4hk9Upp+xv/n5QGtNj3wqJ5WIwFHhrkiHZcL3ysbKSh1RCby7VXPp+fLyqMVr12LwmYLfQZJoX4YaUogvPT9viKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4C8BB240003
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 13:38:54 +0000 (UTC)
Message-ID: <74b373054d0f2a15e6d585b6d357434a4b880f61.camel@hadess.net>
Subject: Surfacing "Pairing not supported" device response?
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 12 Sep 2024 15:38:53 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

Hey,

I got a report some time ago about a Kawai music keyboard's Bluetooth
MIDI interface not being usable from GNOME's Bluetooth settings:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/154

The code in the Bluetooth settings always tries to pair devices, unless
it's blocklisted in our database.

Ideally, we wouldn't need to have those devices in a database because
the device would answer that it doesn't support pairing (as in the
"pairing failed" line here:
https://gitlab.gnome.org/-/project/1617/uploads/83953481a1008b8cdbe894849ee=
5b3a7/gnome-bluetooth.png
)

and then we could retry setting up the device without pairing it.

But the device response doesn't seem to bubble up to user-space.

Any advices on reporting this error message all the way up to user-
space for bluez, and then gnome-bluetooth, to use?

This is the tracking bug in the meanwhile:
https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/158

Cheers
