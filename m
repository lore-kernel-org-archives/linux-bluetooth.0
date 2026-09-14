Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB72A46A5FD
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395814; cv=pass; b=s8NV9caFntJNcUHIFgAsXbnsoQ9lSvGb+FrRPeE8j+qs4auFyK3v7uTNs7DWPyoHZFOdcEfhMgnFoo1gQ5YXgYxJT/YYKelwmqLWYkoBmMdaZjGY2O3wy1mp9mVNnlnLB/7TPzdjfPhejtL8tUsJ5wAm9O4xQpU/WIoayaZmoaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395814; c=relaxed/simple;
	bh=m8tk5KdgyZdkzaLmWpyk0A8uMzZSGMtaK5eFUbislS8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqXkVl4daYQMdX9vF20M0JftmcuAiMBuRU0cZo+rMNPCH7+guC26Q2RDmITeptTwaQ083pgQmKiBMoR8jcsGsteV78tNqQ2TKamVtV6P4MCTq8b/v4T/N02lZgOir4GMk1ZbJQuJorKEdZhfrzgtc2DNnE3f/pu7sf/Sv3+Subw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIJrNXla; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIJrNXla"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-7f4f0d05c12so1490070a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 07:23:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395812; cv=none;
        d=google.com; s=arc-20260327;
        b=iapnXHHsNGBHKEQLBoRM2wAJZVA9IOghNSW0kWdt1V2ZyUTcFIhJ3HlC7kGCFyagvJ
         DbxrPY5JaSOsu1wiwMkFhf+wtJxE1XlZQPlEKIJsrWw7V3WSOD5zlhdmqjsxQnz55BMw
         +5HHH5DkQr49/93Y6yVBhgvtm3U3g3ILC1GT4WYhdIlUdCQxQKC3QAyw+UZaabRCiR9b
         tiTWC9W4dxbx7zCNmpn78J2GeGf1EUp7TwdvqLmXW3fdAiwGyNyYX1QtDp9kDtTVPUHZ
         9CDcaJsylcW+qrs/uQl1bo/+iI/gNlFZl5R275uu3DSYqCp4GIs7uKlUaDYFv9iB7eOM
         ilTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EaUvQas+F9VKTGDwtMRQb6aKoVCt5uH38B+Wid/fBbQ=;
        fh=ANayFVkVjAYfcdPwDZ5cfn2ro1L/X95+jiXJMN7zbp4=;
        b=nSfAIeaJcf5bnbuNyrbqGav9R+bPqvD6wa/NyoifgT+onhw0G1pIKR6qdF9PW/p3K1
         fEgjlLHPEuBH0EHiYiZjUmb6E+BYQL5WDK/ntB/IKmRbnBrPl/uUjkZL3+FNINLCJ7LJ
         9URmSHYwVKKCcN2pGI3wfu+IF84jJAyUbqmAVjQsTlO+O1xpfU7eZUmyMj4f4VqThZ88
         bUSq0T+YuvakBsR0+DhA57TJq4U7pDeNjC4swCXIZSj0xyEg7bqbdrce84s9JnWYI7t5
         EsP+fAcD5fUnpEd+pQP1kzO7DjsWkg86tUJih4FltFBYUVan4LP9PJ/hYyZvVKVaqcPM
         +7gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789395812; x=1790000612; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaUvQas+F9VKTGDwtMRQb6aKoVCt5uH38B+Wid/fBbQ=;
        b=RIJrNXladGxhpQRVeAdVhpNJrqnUMHzpPH6YHY+cNnLBWdj+jqxM48+l16x44J3jiD
         xbvczD2GDG8eoT7Btyj61BFk7UNi0cKc1eRKnB0L9UhFbpUu1Ud64LCSfRxQXKLlgilV
         rMC//TwHVb3GQ92eM+UttngAe3XND5SGMCZPIcGV/eZdYALxjJbSmKwEC9msAXichAA8
         DzbP11mE12y5vBgqPCZ/JHnAXbqQYmJNRMHDIx6fOMzlcGKX0me8FCDMjnOztRBKZSiI
         pVoIkxGTMzLCsXENk9ALoP9aB2vwau8O4RnkuanHHRKNnAb3TE4I7eFPFYtCOfGrR3RY
         1mpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789395812; x=1790000612;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EaUvQas+F9VKTGDwtMRQb6aKoVCt5uH38B+Wid/fBbQ=;
        b=QkpeRgpm5ZCqnjK4dQAs5l90d6gjAVEwpe8vyprejsNstidnwIR3/qIezrs8IURseZ
         MWUwN2W6I3FzBl7AzjQkrth09/wmUO2DCdjSPoCtRV/or6wyhwnPCfVRpo0R+DgjqdcQ
         90xdStDlOoRL/90MYgSraGPX8M410RavF6suXUkHIA7nu8zNkB0aupNXB5t1mxGkq/2q
         ipI7iXu0teDzUjXDztiJoguHHNOj88k1ilsSPw7sdLTcJZV+xXX5eWtVjC9SqzgXxT6y
         wopr4+wbeRD6/HZc1o17Cztw7n8wxLrDdn4XFnKoScSfXXlSu+ZeCVngOdRw0gjrGrR3
         wi9Q==
X-Forwarded-Encrypted: i=1; AKwUvByx1VR22wqOhVJFpraJ22dQ6xwvq4sKMqr6S2tO/T8zYyX92I08whMrNXk3E02U6LcGvVX2tTPOSBfwAPe49Dk=@vger.kernel.org
X-Gm-Message-State: AFuF++lWgkM66/8rClCa9ClPFmygdbw35QdHd/FH3WoJXJfMmu9/P07b
	/FONWHe1ZGWOaEKhPAXEmbvKX89AWZnJJ63q6jMnAvetg90CeGHZnLqzl9KNdm43Jy6+4U+Rg3L
	izv3CeEcOAPq2fX6pJoD6WkhMWF7EIFY=
X-Gm-Gg: AYBFou1HnklXeEYB1J6X6cmtEl2kH3xIs3zJLOiQmxsAX/zVhzweFBvMEYwbiltaLtq
	y9gQQR2VfzIbyEg5O/PVUjGoOq6TjSGf2DZv0BorEYNdkG+CgF5pr7EDyj0Ad4aFpg4z/xBkiJN
	2Ae8xgWumP14+xqOim7WLm0TfbsmNqIo7j8DA0XC/uk5rN5HVitE21YpQAlR4Zz/xg7aOY4AV4v
	wwqSp2a9WNiNvIPH8D4qfhWlQ7p4j1uRhHQe2K9IZiV/alvnyIZSOD6LXEK7oyTNcRRPm23FVht
	CgYWwVmP4M7zjs9FJ/pMdTH7smXMa10wGy4UTncQteoLvuun4v8I7rfDV/s4OwRa9DM3cO1aV0q
	QMxgq+8DDTWq0yvkhADbpoxMfR73sxdQAcX+Y4usFiQ==
X-Received: by 2002:a05:6830:438d:b0:805:b3e5:18d9 with SMTP id
 46e09a7af769-80899457cb5mr3276624a34.10.1789395811612; Mon, 14 Sep 2026
 07:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912100315.151674-1-mikhail.v.gavrilov@gmail.com> <CABBYNZKDMriYfGN_8hNmpDdhxdJXL8hzOzP+7LhsV_kwXcYTBw@mail.gmail.com>
In-Reply-To: <CABBYNZKDMriYfGN_8hNmpDdhxdJXL8hzOzP+7LhsV_kwXcYTBw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 14 Sep 2026 19:23:20 +0500
X-Gm-Features: AcwNN1WphdiasEHCC986WGbnoeurVXFdsisLPD0AeIJ1IwaUJ851qa4o4JNWsZU
Message-ID: <CABXGCsPe5wykd8Aj-hm+SJ7SGQyb8yoGNnx3XDpPmBathj+EGg@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: RFCOMM: connect the session socket without rfcomm_mutex
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: marcel@holtmann.org, nicoyip.dev@gmail.com, pav@iki.fi, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+74071deb72339c215b2e@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Luiz,

> We might need to check if the sock hasn't been closed in the process:
>
> https://sashiko.dev/#/patchset/20260912100315.151674-1-mikhail.v.gavrilov%40gmail.com

You are right, and the review is right about where it goes wrong.

While the socket is being connected the DLC is not on any session yet, so
a concurrent close is a no-op: rfcomm_dlc_close() leaves without touching
it at all.

s = d->session;
if (!s)
    goto no_session;

d->state therefore stays BT_OPEN, the state check in __rfcomm_dlc_open()
passes when rfcomm_mutex is taken again, and the DLC gets linked to the
new session even though its socket is gone.

The window is not new - rfcomm_sock_connect() drops the sock lock before
calling rfcomm_dlc_open() - but it used to be as short as one mutex
acquisition, and this patch stretches it across a page attempt, so it is
seconds wide now.

The consequence the review points at looks real to me as well.  For an
orphaned DLC rfcomm_sk_data_ready() returns without freeing the skb:

struct sock *sk = d->owner;
if (!sk)
    return;

and rfcomm_recv_data() does not free it either - it calls d->data_ready()
and returns 0, while kfree_skb() sits on the drop: label it never
reaches.  So every data frame the remote sends on such a DLC leaks one
skb.  That leak is reachable whenever a DLC outlives its socket and is
not caused by this patch, but this patch makes it easy to reach, and it
may be worth fixing on its own.

For v4 I plan to make the close visible instead of inferring it from the
state:

 - rfcomm_dlc_close() sets a flag on the DLC in the no-session case, so
   that a close during the window leaves a trace;
 - rfcomm_dlc_open() clears that flag while it still holds rfcomm_mutex
   the first time, and checks it after re-acquiring the lock: if it is
   set, the socket is released and the DLC is not linked;
 - the state check cannot be used for this, since BT_CLOSED is a legal
   starting state for a DLC that is being reused.

Does that match what you had in mind, or would you rather see the owner
pinned for the duration of the connect?  For the socket path the caller
holds the fd across the syscall, but rfcomm_dev_add() in rfcomm/tty.c is
the other caller and I have not convinced myself that the same holds
there.

-- 
Thanks,
Mikhail Gavrilov.
