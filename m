Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0EA366823
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333036; cv=none; b=TyUDo7HZdYvX9jyc40wo8+XgBVEY8AZpmLX7Z7TrxbD9uqFpItRwYsggh8hvpCW0Nx664hA6upkfyy5Wfew8O8G7lL9ProrJvxmF+lrB+qxF7JhQQIZ38G2JyWteKNKjdv7Q2b7Q7xBa8FNagAjXfw7sn6QXW1O9hxFszLlpsEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333036; c=relaxed/simple;
	bh=7JuHdFFsOI+HVuNOw1i3NMDFmmDzVGpxoRjPjwiiGVM=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=JAjkusDxl/l7CErt630PFj+ixIsQMDH/UP1X3Z97c0Myf+mefYf8V0YB7whyecwA6e+Rl6Uh/6XUtIRfV4fBAhA57p2s3dP4/UayLZs02egDXQHMZNJbjBiy6tm7WKJC1/rSP1sYNxAkh5rMpfJSFmCNYFj/G1pl98VRpbk5CBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cop9q8RE; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cop9q8RE"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2de831d2b20so3303299eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 02:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776333034; x=1776937834; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2Z5YoQiiifrYeAfNvaFlr1Rr/6O3SUTVnIBwctU9Khk=;
        b=cop9q8REi+W4gXz1B9pL9CoSk90LUaJzIL7Pv+TYGMwuGON2/I9JTw6jaZJzkQB8Xh
         3fkU626yatInxmQ5ha8qmk7mZW3xFd9WT0sLs2Dsnu9El5HHhTeW//wSxBwZTQjbHbX+
         U3rIdqjgLcpIbE2O9DpxUQc8/UtRlVOdk3cp+GCpQtxPSKbxPsRObVTxmxpduYJHTI1H
         bTV2FhL1v8S9xWB6Il+hi1g8dJJblOVKadBXkSOy/yFjC60I+DZ7DJ9Tgoo9yw+jhqvx
         aNg0uuNEbAv9pwtCYLZF2tu+ysd70DynocKYkTyveY5NIZWnnYY/dTrRRL+m9+0gTjhm
         2MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776333034; x=1776937834;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Z5YoQiiifrYeAfNvaFlr1Rr/6O3SUTVnIBwctU9Khk=;
        b=BuaNS5gRdHi4FP+sgCC5DrQJURaVgN933UytMkDz4vaefDnVD9bwHUfGFk6qeeJ4j3
         DKWQmcWUdO4E+YHIN9wkcIyhskc8ctZlpDZFFAd5AcOg/ZsRdgWMtAfezj36YoaGZb2f
         DIMNjuE3nVtOLF1lSErwcPvV7Km1zQk1avjxnd/WjE40nmlbuxs/2GXtnVoMWlJ6fzq+
         S/7kqJwHhSjirEuZk1M8J0Kii9aChyASx+psguJfSULElZqslv/irdwp7qOpAh12g6+8
         ZbCanWL7Unn61X0H5Dbbl3vI+zY659W+aezaI7xQR+GXwXy53ddSlzF7rQjNfiQHN7XZ
         V06A==
X-Gm-Message-State: AOJu0YwcqCC0qkoyYHjRZ+sSvFXA8+4/heiUOjgPITcTcIn5krakyyCJ
	lcddj3RsLUv4kdX0mBYZn6lGjvxuU2mq8NlKl9qznlJc62zgRnWg3euL8mCqqw==
X-Gm-Gg: AeBDies43bm/B/0di7bwrlg5elhVxWF8utSevFmUmrar1apznDFYyfaaEngw+sXrDvp
	cs6o0gyp4MLpXeTjvBHg6EwWlvKgIcp/yS8ppWvYGbDlNhqway4Zta5A4sCRUiGC1rIfzYXdq7Q
	V4aVhF6qtT1rgdFQiW6jI1imPJSKT041pNawhH3VgKogo0FbOhcIhgLeUZM9y8rA/O0b/MQ2kri
	yEZuesJgVOfsuYhnThErsT23L8HBvAjjqAr/6rsc/RxBMz34QTKkOazqt1KhKih/OYCLLQnA6d2
	Yph2aJl/3V5unvrpAnTlDX5yv18MGrGVKjYuwDqLfT188MN/9ZH+IrmUwE7AA6mhdY/JLs/BAHo
	diw7mzU9Hhnc4tZF1pU3OhzSoLf7LDdoK9pDzl5YHavLMq9KSqWCyjrTpHhQWm/75rw4XkhBWK/
	dAaMe/dTiVpqte1oEZedTeBqhdwTRNCil4AJOoso8ijt0=
X-Received: by 2002:a05:693c:2c8c:b0:2df:68dd:21d7 with SMTP id 5a478bee46e88-2df68dd2618mr1935421eec.27.1776333034026;
        Thu, 16 Apr 2026 02:50:34 -0700 (PDT)
Received: from [172.17.0.2] ([172.184.173.244])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8f65f9bcsm8083513eec.22.2026.04.16.02.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:50:33 -0700 (PDT)
Message-ID: <69e0b0e9.050a0220.3d9965.1e2c@mx.google.com>
Date: Thu, 16 Apr 2026 02:50:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0903915041613170358=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] doc: Add missing btmon-cs doc to btmon.rst
In-Reply-To: <20260416084750.3735103-1-hadess@hadess.net>
References: <20260416084750.3735103-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0903915041613170358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081931

---Test result---

Test Summary:
CheckPatch                    PASS      0.24 seconds
GitLint                       PASS      0.19 seconds
BuildEll                      PASS      19.92 seconds
BluezMake                     PASS      648.95 seconds
MakeCheck                     PASS      18.27 seconds
MakeDistcheck                 FAIL      56.74 seconds
CheckValgrind                 PASS      291.92 seconds
CheckSmatch                   PASS      344.48 seconds
bluezmakeextell               PASS      180.81 seconds
IncrementalBuild              PASS      643.03 seconds
ScanBuild                     PASS      1012.54 seconds

Details
##############################
Test: MakeDistcheck - FAIL
Desc: Run Bluez Make Distcheck
Output:

../../doc/btmon.rst:770: (SEVERE/4) Problems with "include" directive path:
InputError: [Errno 2] No such file or directory: '../../doc/btmon-cs.rst'.
Exiting due to level-4 (SEVERE) system message.
make[2]: *** [Makefile:12191: doc/btmon.1] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:4156: all] Error 2
make: *** [Makefile:10690: distcheck] Error 1


https://github.com/bluez/bluez/pull/2044

---
Regards,
Linux Bluetooth


--===============0903915041613170358==--
