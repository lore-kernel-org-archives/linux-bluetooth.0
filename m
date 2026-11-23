Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455486;
	b=gX6lFNBVQryb5pznf7AcgF9CJ7iR9BArZPKx9UVrTR917QZxVdliSkIXQHOc06W33YdV
	 AtNJEkjbR+xBn/tsPfMLHEe6aSV5igL7QcgD5mjRzuN9uY2PKLCAaQEHPf9C5rxEAre+B
	 bPg44GmKla9wAd+yVE1Bk0svvUyhknpJt421WfEwUC1Cuze/klVvGUl8tR/mNT60OplFV
	 2K6gUpUXUUOt9sjjNhBI40KaFoHyTbhmeCH+vRYZCciliQzdN9vKgc4YzEDXesBupbVZf
	 oQcOzXtx/mvwqMEHhR9+T9v12Hi8aXkHzvyKhenSXiisD1RPnZz7Ifq5B6amrMCZR0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=/ceFBhhqJrnbQFbqPwtXcLvHTZT4SmqFYJ7GwpTs+mg=;
	b=fZHDVdX+CptaQoag8CVepBjxKBP0SP/Bpt7YFfGzmMlsuq/5tjtZImGoQ+w9KXcTp1Pu
	 NYVTYH9PRT5On4x4dHeEou9PfolZzVGhDP4hsEngRej1NaykZAsOtOP0UWWClV0Q6nYp3
	 KopQrsApkcLfzII6KjQ58501CliNZVQGSi+QVQhZS3LyZlyGiQHE/GeWr1MA2QPZDPkmn
	 o3dXixicLAfO9JjTUhiIyhJ1IOpSSW3oAoDfdIRCM0TXKZfOlJQa/krrkvuvOcYUDFfrA
	 SHWhRvAH2hzPFtCo9r9VwZleua3XqboWHi6DvkwOwHQqTuJM20tCBM8nQXB5jKIU9Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDXvtabm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F6606A336
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 17:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE7F6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vDXvtabm
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6767d92cde6so3851130d50.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 09:38:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795455485; cv=none;
        d=google.com; s=arc-20260327;
        b=pF/rfNXc0dlP3y0pmD1f1BINiHAVqAFbb1kRUOQyitevnysTTXbx+3aR5rJWVJ1PYs
         fN2EH+cnotX+e2JCxE+32TXUmMd1pR9oFXKW/cB8HGEg+jWS6Tsh7TRHoaGWU+xNANlG
         YCau6r8hHLvoQzJSgZBqvu0e4B7IbjGMpB2aR1gkZ4+QFoEYmwlnVPDIu0N9Y2l1pKMC
         nmWbLyt2tXnd2+WjyzKVr1RxiswebrhZjn1kqS4+cHssE5WvphpiK2aWBGmP+alTXYaj
         1xmO+TILaIQyhwJKVLL12SoyaiZ4EX25magH/KUCO2A3dVoEMoAIOd4LoBs60no3VgT3
         jNCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/ceFBhhqJrnbQFbqPwtXcLvHTZT4SmqFYJ7GwpTs+mg=;
        fh=0pu0EwQRM28wOtyR9QuPwuw91xJod4PdWa7ti+skODk=;
        b=aM/W62DztRzE/nfmkk3h990NCN/LC5FuVGpa3xRrVLWRFXgs6pxJ6t3PJBrAKpubY+
         du/ozS/iNo1ndvpakLJa04jqTyk621r4tFt54SDcOovPfFhjk5FKNJFlOoVzqqx7ngZu
         Qns0uorog22gZ0LmvhU7YVmW14nIvfs+PWRyAtOaMhtOWRWHG6A3plbks38UU984oGIf
         20ZndHm43OZSaK/uI8jbRNK42wxBdlI/hGWkE6InI6ItaoUJ2qLVjCq6HxcsFobRI8f8
         a01I/rmMmJppWTEwf2i8HwRTyZz8cFI5cYfAayGwU8mkmTBTYxOu+mleoUCLy+OO5PBF
         dJUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795455485; x=1796060285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ceFBhhqJrnbQFbqPwtXcLvHTZT4SmqFYJ7GwpTs+mg=;
        b=vDXvtabmkpK6OY+znCCc1FxYgWBwAdjcPdIFtfYoBARKiWkio2aeGeoY5laySu75Q8
         SsHeAbrIjUxqcn8KWsOJ5IUOm5IebyjQBlswNHFjEDMMLTEeM+aW9nVCUvIWb4jRFohQ
         jz6vIjti8Z1d45IKR4Y7A8RISU9qlIjvPtw4Mwj5CtSBBt+aFqyECQo2ESc0yPop4jWw
         tdlNiWsHmRvPqI7cYxgUy4MdTQynW5Gju8xjbzJSDxxxm7+Qf7obwvv4K8GE/0uBECjl
         ipPZtPt/Cl5ouFOy4mX9WeQdlHaT3sogfdXUvH6OL25uF0VlbXEu7A1Fe/9N0gctps18
         ZmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455485; x=1796060285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ceFBhhqJrnbQFbqPwtXcLvHTZT4SmqFYJ7GwpTs+mg=;
        b=vIbJWIqoB/3/IjtlL5GY27Sq69D9dCznuwPA/yxlOEB+egQFLWdqhB3qAPP3HNgXtL
         2TXbIhL4SrEY3ZuqkIy4GnY0BqCC6dWyazArVtux8Iey1K0Gm9OncAK5gNxzCZKcmMbs
         GCHP33AnN6GYgt4bf739TdvbTrqBG949Rei1RepQ7BM3koqZJUeMo8W8EhI+kMJMaUfO
         WVpyGQgFUNUjpMKkCpqNZOJeLRJc2yYQfkcrvvLSu6DeJLEh2zukZePVQ+7MZEKKUND6
         ZogfIcKnFSOY2ZWndtSf3vyIdgTL0CwlMTGTe7vV9Ja9n96/rgcCWDt5QqEJlVC4x5t5
         Hq5w==
X-Gm-Message-State: APuU4Z/xY4J9QjclMGvR+4lsfBtaT2f22Gegeayo7PQq1nTHj3KIXEHA
	qAlWNwzYwCu4PtkgwEcV8W5PyAGPKUTSpSTKh8wUSHk+rYF37g2prNTvD5o9jMKwV2sXdFctihu
	BXi/oKcXlHxHgH+DR1067y5gz54Ogv+KCo7+n
X-Gm-Gg: AZFdTZdgU9TBZAf02hNRScfhu8HbRPfuvmBQQIUQPnYXq4cMgWooeSR1vY74iIJDooC
	b46hTFZFGJSuUmzv4Zt+O9xdQi3AOaZUwu0vvBhNEbGgJCb+00yWVVZu2uR+ZcqKu0KuAvKTgWb
	zd2PpQfw4k7S+EtkyTVkJChYmErZ/7eSoGuLIMuBvqFcqDkXe4gQ99b34adfh/IfWkCt4zyPGR1
	erR5ewVBk54AcmX5gcnykN7wepLVTaQVrZg9IFd5WwbltGkcnYiNshPOq8dL+YPDqFI1TzzqJUd
	CCbOXoMb5qWgLfK4chIvIgw4vlJGOklA4V9DgDZRMv0KMkcLXzCNs5DGKJFlzEH97AaE5fKHZdG
	elETLeCud/7aj0XFGBdYwMXCishlEtHtXf7mhYueNzag6EdDS/mWhkdKUxmTt+bHcXtcQ+1GG0G
	TFtaD+JtnAJhwndmSaDF66VqF1XLv1riL1RnfvDtyTCTQ9DNmfPl1g421VE+w=
X-Received: by 2002:a05:690e:134b:b0:67d:a6b9:dff with SMTP id
 956f58d0204a3-67df43faa4bmr5670947d50.43.1795455484983; Mon, 23 Nov 2026
 09:38:04 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121205835.381239-2-ecstaticmorse@gmail.com> <6b0226ba.f2313814.3bef54.59b0@mx.google.com>
In-Reply-To: <6b0226ba.f2313814.3bef54.59b0@mx.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Nov 2026 12:37:51 -0500
X-Gm-Features: Aa3M54o2hLKaLJfkVHN7kD2X-L95N-Lb1-_7_o5d0533eSnCy3FRz781crzZ3og
Message-ID: <CABBYNZKkyNC8dUuRuzKSHqfwsVMOXmqfym36M+iZywzin9CvUg@mail.gmail.com>
Subject: Re: input: Do not re-page HID devices that disconnected on purpose
To: linux-bluetooth@vger.kernel.org
Cc: ecstaticmorse@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 21, 2026 at 6:18=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/series/1218301/
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.73 seconds
> GitLint                       PASS      0.50 seconds
> BuildEll                      PASS      17.21 seconds
> BluezMake                     PASS      257.03 seconds
> MakeCheck                     PASS      0.95 seconds
> MakeDistcheck                 PASS      129.88 seconds
> CheckValgrind                 PASS      134.93 seconds
> CheckSmatch                   PASS      233.08 seconds
> bluezmakeextell               PASS      85.62 seconds
> TestFunctional                PASS      1069.87 seconds
> IncrementalBuild              PASS      259.98 seconds
> ScanBuild                     PASS      908.77 seconds
>
>
>
> https://github.com/bluez/bluez/pull/2864

Copilot flagged the following problems:

https://github.com/bluez/bluez/pull/2864#pullrequestreview-6024217611

> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
