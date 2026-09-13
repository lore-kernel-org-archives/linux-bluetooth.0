Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDC825B091
	for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2026 05:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789275909; cv=none; b=FATEtY5Qtm2HLhRdNvhrysEbAGODg7q+fkY72Q6z42IX/G+Q73t3LkIjf8U4doa+RAx9kLRjNTq6tEOf8BDkrlY57vnsav3FbpKnQeSAGnMuIQx/eF+MQ6YsyYIDJgexkXUjwu8nQud+umOvSzm0JfmAqsaJWB1iro7g3hSYh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789275909; c=relaxed/simple;
	bh=6dY9lpN7HzoWp2IdC2RdQ4sIjiwNvx7r5Syp4tCIfQ8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject; b=QJ8CcxHpSuvSGdhnq6EFWiO9F07Y1rtnpPJmt/kK2u/IqcZB8Hipdh9Ns3lfuQu0U+YKpbD6VUmuOKKxkQGL0vyyipcWliW3dTvzOGd2DYW6azaamTfInQ8lEIbAJRt/WqUNKz/qM+0xBmQcGxn6tv5TxDNF0Ooyen4BLKa/V1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpqwUtbG; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpqwUtbG"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910ca5aa8so140920785a.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 22:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789275907; x=1789880707; darn=vger.kernel.org;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sofaMStLF7rOZT9FWr0Hk4B4/GzYt2buZy/athH2EwA=;
        b=mpqwUtbGdxtRbE0RnbgplBgnZ2g2PIELalNX3W31ehViAT1hkAmeO8eZ9L2mMDtjn6
         SfgDdtpxgaaiZbhOngkfjyI1n4DR0+xziWxKd4TsHT1FNg4VfaQFY+AK9JpwAO7jqsTI
         wpymOD/gb1eCdMyDUcUUZh+3V/UvYhBLDqy0RSe9LHxroRYuqA2RbYIaJSEiH4EPbi2Z
         0iGOF3+ojfQRkej1S44pCeoBWJ+tcQWU4kzeMc+ihZWv8SbQ1lxYCTxyZfwrcTKt+k2w
         IJl648nDw7BajT+D2iPKnhc07r/7xqyoQzYbZRjhxezOqlQQME7zBYFmOiPIS/OD88MZ
         1W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789275907; x=1789880707;
        h=reply-to:subject:to:from:mime-version:content-type:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sofaMStLF7rOZT9FWr0Hk4B4/GzYt2buZy/athH2EwA=;
        b=UxzNH0xoDKrO3JIrea7Tf0OcboHCcPvnw76M2UYrnrkWeaxEQrgyT26COJLUcJS8el
         Hl10sIehotVgU+3zlYVaTeIluf1sIv6E3h2hA+i5KGG6iHrbRkGw/KP0GvqmGopO7Y1L
         jLxDWM9vGXHDkVIEl+cIyxd94Hi+O720OD/69oYamwOiD7cpj4DweQnpzAUoW2f6sjiH
         oBu21ltmV9b4KTVVyVwgEueozHq5dBEh3em9TV9v2O5m4DbBZQtWRBSUCe68KzXArYjI
         7aFQQjV29AAuZk2DwFDoI27FNrgasS1pz8uAI4OrkNOWjz1qWCSGp363M99w3eF97Edi
         ZsUA==
X-Gm-Message-State: AFuF++kid5Fnbx7InXZQ8T781kmYVDM+6SS/BGhsmtJJixZf4VGQ5Qzf
	zZhzniaxRz4t8CqI/FRwjug1ElPuxQYFSe/S2ap+6PJsDiXPiY/KyFSaVndW3Q==
X-Gm-Gg: AYBFou2bfh4o3fS/VEBS1bYyk0TU+zpunjyJoFCJAUBlt/5AATretQ/ZvTV6yiUmttl
	KHHeba+Hk9dahYaZAKa1BpkXZpzDgOZOsrjxJc6En/f9e2fmbWyFPlmxUh3ikoxR+9u2/yEdfmh
	LWSnrWtuPekAWnh4EgskWSpPtobqi2a3zcSphhMuqH7dGsL2JDaA+SvhNwGBZowxMsN4dxZQGYa
	cCyAxqO3LFKftUWa9BU/HNccrVSxqNfBUgs6Opx/HLbeelnKq74cpPk+9zNu4RFbzWvww6P41hW
	jCrCmoLX5cGvX6iWaF3XS7sm4xiTpjsyrpGi8tNfkpw4eVECnscgx0+tGVN6kR60fNfgY6FK8Hw
	25FX+Ke5Lr9Nbx3gNv3MyKA6Y36KduhASjk+KB9te5dDmaZlC+DjxZQHjgbY5WF9+AAsR0qEZKy
	D0XXI2PVH1ROTPX1lbcnVw2fC4+Peyt2hwvSBD/o/Yht0mlO9RSJHZ8tIaoiITOz3FqIQvDci/Z
	ESVPgW4W7Lh1JFm
X-Received: by 2002:a05:620a:288d:b0:939:bd4e:b2fd with SMTP id af79cd13be357-939ea28e3e1mr1657204685a.43.1789275907414;
        Sat, 12 Sep 2026 22:05:07 -0700 (PDT)
Received: from [172.17.0.2] ([20.109.36.224])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939fd7b14c9sm421751785a.1.2026.09.12.22.05.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 22:05:06 -0700 (PDT)
Message-ID: <6aa62f02.c7117bfd.d2da2.818d@mx.google.com>
Date: Sat, 12 Sep 2026 22:05:06 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6257346548835749304=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ] Pull Request #2451 was closed: client: Handle system bus setup failure
Reply-To: linux-bluetooth@vger.kernel.org

--===============6257346548835749304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

The following pull request was open for more than 2 weeks in the BlueZ
Github repository and it was closed automatically without taking any action.

   Pull Request: #2451
   Title:        client: Handle system bus setup failure
   Submitter:    nixfred
   Created:      2026-08-29 02:22:29+00:00
   URL:          https://github.com/bluez/bluez/pull/2451

Note that the BlueZ repo in Github is only for CI and testing purposes and
it doesn't accept any pull request. The patches should be sent to the Linux
Bluetooth mailing list (linux-bluetooth@vger.kernel.org) for review.

If the change should still be considered, it must be resent as a patch to
the Linux Bluetooth mailing list (linux-bluetooth@vger.kernel.org). Closing
the pull request doesn't submit anything on the submitter's behalf and no
further action is taken on it.

---
Regards,
Linux Bluetooth

--===============6257346548835749304==--
