Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D2C331209
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 16:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567671; cv=pass; b=CDKKlqB/a2Z8wx/d2mPwNUJGZkyEdCj+HaiNGtUYqcknr+rifD8G1gpBDGyoUqhmzxXTlE3d/K7HhUOpO1Q4iU+RpB7t6DKuqNDszycqcZ1N3RD0jyLWG7+Ft0AuI1Jz+wcdDfKBk17jDMEGoIQax1/Tou7A/NaQEjr0tYOYikM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567671; c=relaxed/simple;
	bh=s3Q1zrVX/VDLpIIL3aJ8TT2PIigww+xEiCWav7Oc06s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pZM+sAF7YPW+gwsKpkg7AWP7vW30x3hGkN7NXXX7BSY2zpCoNOVkD9KVUr6rZh2N2QJvxtwgAHeok/NBfcEiquskuKLZxC1WZgTIdHK8GKW9wnW5oHqwx1AoTh9w1yqDuecxb99jGT4OCsdTYYI0/1StvO4KYOWjOJfLaL+qE7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz7WoQgz; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz7WoQgz"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-67148a70f8aso117a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 09:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777567669; cv=none;
        d=google.com; s=arc-20240605;
        b=QFa9ychoXtGS+W7Y2HaVAlG1aB38RGev0U4oekNKBMR1l1Y1+6kYs5lh47vY9SCxuU
         6ys1rag7ow9m0G3cwH3rinoV3MXVTGN/l8Mjdr7YSg/BS4gtKbtT1XGltA9gcxz/O12F
         jGG49Q7/Ov34er/56WuxnEf6Uco3uz3yFkWV6FBwQ/DPm+72SRF8MAOCMXUkIddjYQCW
         g/F/DgAgdT9f0qRjB48oSqj59WOfMg0xSnIT6XGHQKmOZ7pLnptmlhe+KsiFLkHAJiQ1
         kU0STsHkBePIOU1FIc/0v9XxegZTux7qpbexukU/TvpShlmnRHCXqe0LVtXgORyefXTH
         71KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        fh=1ampE+hIyWOJbAn1KY/FHa8bZtpDD3aN0t4l+yyhSYM=;
        b=hHnPethrrDWNvywMJTXpRcp1PEvSQMRVKw6sqFNkUSdpKgNnhthadnpgtnztFVg9t6
         1VQfhj7DTUwPWPbDUpSMyHQiroLWxhTrWN1D80kvh0dn4i+Pns+YTdfYayAyskbqTvo0
         duchQd/f1Y5V7I5Ve+ReYU9rdRJOKI60W1gVUhhajybeovDrkGhQu3M8dct4MXwdcpfB
         FIalkgxGralxbCsLUl4yzLhvr1Y8+6WYB5+TI+lMNQ8uSovRr3Go0Mqj8sN8fJeoDKHs
         dICnY4f5S2R09m7YOrq5n34aPhGtp2bHNhkUW26ULDao7pZreQ9nmcC7szas9eJUW17B
         0N/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777567669; x=1778172469; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        b=Bz7WoQgzDd+nfWMklgOLBjaChHrou7f8kejh2HF1GUTZZOqQnhfro6oRPb34+QcALk
         Hi5kMoA/74+sDdm1OpY21gUhlE32cL7wN2fW4nP4H7S/SsIQAGFR17USFgib2oqy/+UI
         1owckaM2LHZZ5n6Qf23z7yEIX0YtiXCAmw2VYt+1tG8z+7t7gib23vJ5jkPk1DnncdWy
         cGn471zA2h0IW15horCWO3Gutq8yaURrim3D2AedDBMMGbJmWJnRABg8OpbxtSR7O5NH
         XW1MKl7omJSoQqnFhzDZY3pSzCX4saKqXoqmh9152CXR3BipjVgI0iA8KKSEepTUdz7w
         kp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567669; x=1778172469;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35BOGIcH1p4dwQ5HuRv3TZ7eqiagtXX5VFCur+zr67U=;
        b=YeGP0fKyQdqJZYhLWAVCROK5m8KPQMtz9oLSw7q5NGtMQgC5FRkVCFxwJPLsax6G4+
         eXvaQNkIUa79zwWlerim23YPYtCzYdd2uNg6EgEAriPUEkb6gWUglSdD6re29g93Q3ny
         qYvonUfGQAZLot8HyaZIhX1V4gB/wGmOR/+8vuI+ggSYMVTvYNhQZ6kpjb4M4+bsGd4w
         gCizpx5LmtV+bavYeUB8S2SJNXwowyv6oEqlW5bf431pb9+wrFZ5OflzqWH5P25ytdMP
         UQW96IcFUEJCuBmIhWVHfoKkifKWj+iZAY48Mh5MVN3sVLkNHrQgXMaXs7xyWkocExEa
         haRg==
X-Forwarded-Encrypted: i=1; AFNElJ8NFPjD7tzs+Vrm1v12WchY2cZ8ydDE/fyRsBO3NHjcEvPCddsCSki2DuGn6P1eUdn0eyJKNMkpB4YTwH6n+2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygmrt12Iev42LlK/chwfIYk+nIVGjAiW64ER0zlbmHFnXdMDmZ
	Jc+a6KRtGby5dml5ExhMhQ37wFOZxGj0p7rqFnmMokYfKdhk/+xe6NOxF3aeOZg4lYPU3s9HfRA
	ieA1TpzUGlxbVe9Nl8jz3A2/Y82p4f6JQHu7wGmlh
X-Gm-Gg: AeBDiesfKSLB6Yas+jPckV1BFKNSUhLHL/rIUN5p/F0+P8FClL/RrNkTL29yH+qcPqp
	0H7Zksfv9jvpL1t+7odE/yUYSpERiKr0RPbLp7oP5iVcCyXKDn7Az5SUjaV7qkaplHd632nK/sc
	oyMvVBojt9HSlHr3o7wOj56HQEQkdJFAlzpKNXGB8Yy9o18VqsHRfz3xQvIHmRdT8qO+nySSuiH
	rzxuSEHgRcjgN3yDoUDOPjlWF991Ig2WkSI8H7iwLTeNzE/av86dgSvnxAkjk8QdaYD7dpvZeSG
	p7J9pFAfaeEdQDWV4Lc+Sl671gBPUsOXLYfktDrf7nc0tSZgy1ipk/EPBg==
X-Received: by 2002:aa7:ca4c:0:b0:670:d5f0:2595 with SMTP id
 4fb4d7f45d1cf-67b8f250163mr2117a12.11.1777567668262; Thu, 30 Apr 2026
 09:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jann Horn <jannh@google.com>
Date: Thu, 30 Apr 2026 18:47:12 +0200
X-Gm-Features: AVHnY4JtB2QrcIoj5b2LdRvNFl6PvvqV-cmLqetEfIthcxa1hOmyqbxeD9zj4A8
Message-ID: <CAG48ez2=SSQfGUXTPs9jQw_2Tw0JdzRHcLDdCgC7wTGkK0GOTA@mail.gmail.com>
Subject: [BUG?] bluetooth LE ISO sockets never get freed because of SOCK_DEAD confusion?
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: kernel list <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

I can't figure out how to release a bluetooth LE ISO socket such that
it gets freed.

ISO sockets are placed on the iso_sk_list, which holds references to
its entries. The only place in which an ISO socket can be removed from
this list is iso_sock_kill(), which calls bt_sock_unlink(&iso_sk_list,
sk).

But iso_sock_kill() bails out immediately if either sk->sk_socket is
still set, or SOCK_DEAD is set. This means that if anything other than
iso_sock_kill() sets SOCK_DEAD, the socket can never be freed.

When I call close() on an ISO socket returned by accept(), the
behavior I observe is:

sock_close
  __sock_release
    iso_sock_release
      iso_sock_close
        iso_sock_kill
          [bails out because sk->sk_socket is still non-NULL]
      sock_orphan
        sk_set_flag(sk, SOCK_DEAD)
        sk_set_socket(sk, NULL)
      iso_sock_kill
        [bails out because SOCK_DEAD is now set]

Am I missing something, or can ISO sockets (once they have been
accepted) never be freed?
