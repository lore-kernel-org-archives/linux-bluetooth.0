Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DE560B82
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930249; cv=none; b=h9slUMCmXQiiAbSzwsfVq3brbmXN8wpdhBlvq2nym33I8zqqjBcAwfRoJ7UwpQDgviGinD++JUZ/jYl9EGlVgl3gOW7FC4ieJ8ifd4Zb4Cmhr7suMlkNrHDm+DMWEa/ddbibTF+BB3YsOf1s5yuFPYhbg0DilPfnH6Z+BgmYDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930249; c=relaxed/simple;
	bh=H5LHEQ8OulwG8S97MfmhK6NJlOCoyI37a8UfuFOH/ps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=QIbxLIZk/dfgUqijM6JjY1qifWlT2f0xTusIEE7MHGLIdAo38xbrxcWRb0iADYjDDYIGePDWNdz42MZeu5194JHNw7bZ1sUfxhaTpbXK/yT6wBL1tv5ye674Cm1FSXqJPUFnPo7UXfH44prLOzgfywv1WwJ8eNsbkDXQUgAr78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFDJR5hZ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFDJR5hZ"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so2973288276.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Feb 2024 09:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707930247; x=1708535047; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3gPTkIr9lPr0PtRR+Vhmq8d05c7WNhszhY0r41ZXxI=;
        b=CFDJR5hZkAbATjN3fthKoKyGUnmpdc25Bv2FEUVMYw4rHRFoG90iWLEFOSkm3E0EkN
         mshKokWo5LJR+GwWvvT5Tm4a92D0hP1wb5MSXgug++Q/6u96iQu/ZvswTjjO/KsY3fsv
         KwjvmV6BoQIdFBQFfNAnPjYqEHinvbPBXeQckNF06UKo+UQqEv4gO69sXeFBPnpsLplp
         q2FMctsPkUlCob7HwRnf1OCn4Hcb7LDCs6fWunXXSOA8UGzO+8Jj1XGwtyzNG34gKvhO
         +x2ToRZDH9TgLNOM5qjyLL1VZ7p47AyUirs5i3Twvuq9ThtisMZuqifcc6zKHwmXCypn
         p3ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707930247; x=1708535047;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z3gPTkIr9lPr0PtRR+Vhmq8d05c7WNhszhY0r41ZXxI=;
        b=vBHqUF2iqhlOfBy6elTbK5k2sHkUDBQe0gIGOmSkTIGQmZSPA4dal1lhl3J+Myjscu
         Uon6p+Z6K+amCFefSaJ3Hj+/6Fpzh2bjfU+LeoARAa88XBimd83YIpz1p+z4641AZGC/
         pVRxhZi3NQgqwgrI/94zLzhNASIpNn6SsBWosrZWPfnXGHTgaDnYk7zCALE0j6ap5He6
         SjviZM3Ku0Tk2V6fUjMzaooftMEjsycc2Q/lm4z9Zpn7tVKOFpf4Cb4fBvrQk3xM0ChA
         fASckZxZfS6dP6AekldwaPqKIcTnZ5e4P1hUnhQGIc5PfDiT85P1fQILm92Rx7l0vO1a
         7pzw==
X-Gm-Message-State: AOJu0Yxt8ZPVEHML0Zoy3n5Jv2AkQQbI9CQSG4uQQ7+PZZIJxg1pqaAH
	rbIo/IsNdGFhWK2up/+7RlUCHuj9fz6W4xOUwkuV2M7/9YF1BXKIjgEq99614SNUU+1pr1ilvxy
	KjWx9djoCVj01yaacX0151Oo9tGUgq8Y6KZ4=
X-Google-Smtp-Source: AGHT+IE7p1LsBWALY1Jiw2lVY0vbL91Trm9FAA4tP2XqJ8oUlmx76Wq2qs2kBguVAR/4cGeXpnOT6ZgInHxgrwc3xrg=
X-Received: by 2002:a25:2e42:0:b0:dcd:3575:db79 with SMTP id
 b2-20020a252e42000000b00dcd3575db79mr2813698ybn.6.1707930247081; Wed, 14 Feb
 2024 09:04:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emil Velikov <emil.l.velikov@gmail.com>
Date: Wed, 14 Feb 2024 17:03:55 +0000
Message-ID: <CACvgo50dSAw_L3uC7WST_+9ixMWLBdfVJc8cQNQNZ48dWdUijw@mail.gmail.com>
Subject: Re: Re: [PATCH BlueZ v2 00/10] Distribution inspired fixes
To: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hello Luiz,

Due to a bug in the CI bot, I've scraped this off the ML. Hope it's
not too badly formatted :-)

> Here is the summary with links:
>  - [BlueZ,v2,01/10] Return at least the title attribute from player_list_metadata()
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f2671bf8f951
>  - [BlueZ,v2,02/10] adapter: Remove experimental flag for PowerState
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d3aeae79de4b
>  - [BlueZ,v2,03/10] test: consistently use /usr/bin/env python3 shebang
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d31f04aa928a
>  - [BlueZ,v2,04/10] profiles: remove unused suspend-dummy.c
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1313351f7144
>  - [BlueZ,v2,05/10] obex: remove unused syncevolution plugin
>    (no matching commit)
>  - [BlueZ,v2,06/10] obex: remove unused mas/messages-tracker impl
>    (no matching commit)
>  - [BlueZ,v2,07/10] obex: remove phonebook tracker backend
>    (no matching commit)
>  - [BlueZ,v2,08/10] build: ship all config files with --enable-datafiles
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be0e796299b0
>  - [BlueZ,v2,09/10] obex: Use GLib helper function to manipulate paths
>    (no matching commit)
>  - [BlueZ,v2,10/10] Allow using obexd without systemd in the user session
>    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b16b19885c53

Massive thanks for applying the above.

Out of curiosity: is there anything wrong with the few remaining ones?
I had a look through the ML archives on lore.kernel.org as well as my
inbox and could not find any replies.

Cheers,
Emil
