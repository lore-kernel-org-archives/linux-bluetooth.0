Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989822;
	b=RXPlD9mM/lCDtlTyeXFfmmt38r0+OKyyVRSZMiBYnp/C0itRjHCfI/Yzfwz2PDA1Isub
	 G9UAuMaPI8+yNn1udlJuXmfpEJ4MCVVEPxQlwn9diz7AUcfPUURDHFcunaua+Yhbkj9SM
	 2J1jJDU3me/BndYFjXleu9Q0aoNg/Duz1LuOl2QG1T6hynAm34gw7MGX7FzyquudRZHRH
	 RSYiJN20n5ljAmw9xmUVQX6cBZppiSbENRo3XDQdO8Pof0Om22NrMJbHqzUoQVC9fUEq9
	 4P+YyTi22tVXao+tGaR/YjC8Q3JLjvUEVKz/Ztw36/Ojs4Jclna8b/dujjzwXrC6Wpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989822;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RV79s8Si+RPH0wiOjUMaJx/gq7XHXNNH/ng1kvuaL+Q=;
	b=0lkLQfJJKpdzPDE6WMGCLT4CvDlCSPkJ9VNCuvMiMOyZTPRmjrNOigNJn62RkP2ZMMbO
	 YnyLWtd86G7R3xD3HkX3Td1UgWb+/zHbbhB0gkQO1H7fK23qs/INAPbd5qPOAQlEmOMHL
	 PlEA5iHlyEN2zxzJmqk7VpxjtRBoS/cSEBlRDKY+2RmjmXEdSRzYllUp9eQbzZ+r69wp+
	 7ieOmgkZhyrzIktv+DN2bRKyuG84B+fFaigmWN9AgF1TWXC3g0oR/3/vh3gc0wkNJLo/F
	 3C8zEl5OEKmMJlJ3S1fDvpqgI2LalcjBXvdhaV5CvZP9JQ5aEOFNonbnz8d0L8593GQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v0/q2G8b";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A41E606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A41E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v0/q2G8b
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b2d14968c9so9217037b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:30:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793989821; cv=none;
        d=google.com; s=arc-20260327;
        b=oQMgYyQ/ztkxU3XsYzwLLmg8y+fpveqcTsl/oAGm0hYQy6HNH/0ZJMGrc/zfNFy0k/
         82i5TvNhwfl4vd9eb/njMsCGNiVjVjgPkzRAeoveHKPkYt3ZEj7zoMQ5W8mByQWmig6t
         0RvT38viaWxj7bybrsEDADgNIpn01KsVjra2qeEH7ae57XmV5yBVopJwtJUWhczBMZ1F
         uX/ByXZQ5yCOfAJqhMprptTZ5FuQM0/jxJOdieUrOdNS2JvIRQwjyDwX+KgIs/3luJFg
         q6I3YPxjGz5lOjwM2jhwbHTuc7qDQqxpMTeFtwilqwn4XNz9JOEh0KCKUjMxfP4Dlb4m
         zxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RV79s8Si+RPH0wiOjUMaJx/gq7XHXNNH/ng1kvuaL+Q=;
        fh=3nimXdHGQOcjfBt8iP5+b0Ollu0eBkOgKmJ6MQm4IgM=;
        b=e5aZaUVM0pFfIRnI0vvJpeG+ulUqg/mhBNGN9+Qy2SOQDwhJHlwgF6ODn885qyLEFo
         8zRBFSGbU7iYvh9gAHY7WlGfdy87Rbbe7QZaRdyn+YJyLMzEvitgg05gVuy8jlWRO1ow
         tQJitVr8O2nZC57BamveqjcV/WvZ6cZ/V0uMbQSPrkEp6N9Zv7mFYHd6wn3GI01L0acp
         pdCjzw9hSjv1f+tMFQp4OqjyhGCP7ChVpa4zAz/zEWr3a7h55lhKptG9a2q1iUxfScLk
         ccQOW7FJM3mpLilRTtq0Za4mgnmdBwBAaH9wE+dVDFGbkSDZ1Mc6WK8CO6CQlzQ85Ry8
         +Cgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989821; x=1794594621; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RV79s8Si+RPH0wiOjUMaJx/gq7XHXNNH/ng1kvuaL+Q=;
        b=v0/q2G8bkPNx4S3EaGrzpHAfmTwmK6UvMf7AGZtxP9wkdqibNUiYgdE1LroaDECqpU
         xiOmPlCui4tDawCp3vHaW2Mln9YJ+BkzswpM3pKG5XLQkwRbqRyl6F3C1TOHi+64JytA
         d7Cv1iHo1hu345Ep2EBxDWedtvLSPRaBlnLqCvTDjYyGfm/JGiswYYGAmUFv6PQydwU6
         KqwvXbYgxDaJw8P2OptxXAp/utOfkxLDbyNWsv2uvJ4AV1vIieT2/310t+Eq40s2rR8c
         Ol0u1VwrR+YCvn3mXQdEv4UxZ9Qnf514VEYPnYaJ/HhpqjdL79Mm9TLjr2QPziqCgGX7
         wBig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989821; x=1794594621;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RV79s8Si+RPH0wiOjUMaJx/gq7XHXNNH/ng1kvuaL+Q=;
        b=t34HfiD/SMhDB6tRBuB2eh4AxYX0zmRy3/2pedqm86gFkb1j5CEG9nT9FRsApFmyKX
         gacMLhrLKzUfm/OUX0NNH61Y390bsYETzo1qVKoH8oBtVJe1Kgk6VdX+J9JKGQFS4Ntl
         Fazi9N8aSy4xN2fGi7Y4vNKTTn8Lrw7GAewAvAxKfziawnrxEkXZfC0+6wuJbosfyYPg
         URJy4C7fNsFWhejk8F9tbfWvbEZmc/ARP+FdHBTio3plAsbq3b5Wd2YQHnE75o2LDYfB
         TI1KAZkASW2R601AEcPbwMdJCZgTcYaJVz+kVGUXbWlzhsg8v3MISy8OdMIj3a6zUnj6
         T0bg==
X-Gm-Message-State: APuU4Z8ugDqXk6NAVZb3RCC+5gysIZUTLw+pmIjpM2iBcIky2/oaiHM7
	7m/jOS8jT15whk2YPyiGW9yFl6WA1DeM1L/uZ+qBdo8RVYtd5NtoJJcfQ7yoHp5dxZ4Ay/ragz6
	H53YTyG+N+vBQS+iWroN0Agphrx5EEEt3ig==
X-Gm-Gg: AYBFou3YiWQSw78NxRRT4RttDeoZkmad7V9Z4IMRUeUxhpdhs8TrKf5zktn3IQnCERV
	ncpwgVuBCOI7wegKWnplcO9/oP/D+7TsRAJ5a7y8O5XcLgsG03zjR89q0ovbdQm2R4mon9wBxR1
	L+JeC6WsM04bek7GoxCJKEm6aLuUZdbmRkm2es4L1S+y55y2yu6auEiN2DED3ktNAM5uA4Ef0L1
	PbAHTFIFE9VqxMRc7n2NHh/iz6JXUuIAOl7UIr4nYyUa1OAw0ccw5WdxHqD+NxoTXGF7g/Xbz9r
	HEcq/+dmP6y2S/K+H/zpIUAjMB8dX1yQv7MjOToWy+NwBSFwqBPUzlFZBn0qot7M8Pb6CxiEuoX
	Px3VDtFsMFf+gXD37agyhydvZic1Y5SAa9zjXjfddQrCqyVvGhhHVMFOo+8+sCkK49lwpgzmxtH
	yrbbjPPVsPrbM6YbthCSDCs6ZB7cp4Kl6VGw9kaTyb8+kMRsuKHCamFAiywytkrhs49XXX/KLWV
	qi6xmZV
X-Received: by 2002:a05:690c:397:b0:8b2:e86a:8f11 with SMTP id
 00721157ae682-8b341ad10d5mr16198467b3.47.1793989820852; Fri, 06 Nov 2026
 10:30:20 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106042339.811655-1-cochcoder@proton.me>
In-Reply-To: <20261106042339.811655-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Nov 2026 13:30:09 -0500
X-Gm-Features: AclHuK9N2DkIuUZjlm6y7184Cnw6Q3mwGwXJHtDUohqATAfP4h1KUOqHvqnPTZI
Message-ID: <CABBYNZLgfhHj5HqcqCxTYKhAw9-5jBYVwnS=ciOfbgdsmsAL5A@mail.gmail.com>
Subject: Re: [PATCH] shared/timeout: Keep callback data alive during removal
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Thu, Nov 5, 2026 at 11:24=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> A timeout callback can remove its own timer. The mainloop then destroys
> the wrapper before timeout_callback reads its identifier again.
>
> Hold a reference while dispatching and clear the identifier when the
> timer is destroyed. This also prevents a removed callback from modifying
> a replacement timer that reused its descriptor. Keep user destruction
> synchronous for timerfd timers.
>
> Add unit coverage for idle and timerfd timers with one-shot, repeating,
> self-removing and replacement callbacks.
>
> Fixes: 1f11ee8f5194 ("shared: Add timeout handling with mainloop support"=
)
> Assisted-by: Codex:GPT-6
> ---
>  src/shared/timeout-mainloop.c |  26 +++++++--
>  unit/test-mainloop.c          | 100 ++++++++++++++++++++++++++++++++++
>  2 files changed, 121 insertions(+), 5 deletions(-)
>
> diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.=
c
> index e6f9c5e826..edcc801114 100644
> --- a/src/shared/timeout-mainloop.c
> +++ b/src/shared/timeout-mainloop.c
> @@ -16,31 +16,46 @@
>
>  struct timeout_data {
>         int id;
> +       unsigned int ref_count;
>         timeout_func_t func;
>         timeout_destroy_func_t destroy;
>         unsigned int timeout;
>         void *user_data;
>  };
>
> +static void timeout_unref(struct timeout_data *data)
> +{
> +       if (!--data->ref_count)
> +               free(data);
> +}
> +
>  static void timeout_callback(int id, void *user_data)
>  {
>         struct timeout_data *data =3D user_data;
> +       bool repeat;
>
> -       if (data->func(data->user_data) &&
> -                       !mainloop_modify_timeout(data->id, data->timeout)=
)
> -               return;
> +       /* The callback may remove the timeout. */
> +       data->ref_count++;
> +       repeat =3D data->func(data->user_data);
> +
> +       if (data->id) {
> +               if (!repeat || mainloop_modify_timeout(data->id, data->ti=
meout))
> +                       mainloop_remove_timeout(data->id);
> +       }
>
> -       mainloop_remove_timeout(data->id);
> +       timeout_unref(data);
>  }
>
>  static void timeout_destroy(void *user_data)
>  {
>         struct timeout_data *data =3D user_data;
>
> +       data->id =3D 0;
> +
>         if (data->destroy)
>                 data->destroy(data->user_data);
>
> -       free(data);
> +       timeout_unref(data);
>  }
>
>  unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
> @@ -49,6 +64,7 @@ unsigned int timeout_add(unsigned int timeout, timeout_=
func_t func,
>         struct timeout_data *data;
>
>         data =3D new0(struct timeout_data, 1);
> +       data->ref_count =3D 1;
>         data->func =3D func;
>         data->user_data =3D user_data;
>         data->timeout =3D timeout;

LGTM

> diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
> index 70ee03ee42..4cff654147 100644
> --- a/unit/test-mainloop.c
> +++ b/unit/test-mainloop.c
> @@ -12,6 +12,7 @@
>  #include <stdlib.h>
>
>  #include "src/shared/mainloop.h"
> +#include "src/shared/timeout.h"
>
>
>  #define test_failed_msg(msg) \
> @@ -153,6 +154,104 @@ static void test_timeout(struct test_data *data)
>         check(data->destroys =3D=3D 1);
>  }
>
> +struct wrapper_data {
> +       unsigned int id;
> +       unsigned int calls;
> +       unsigned int destroys;
> +       unsigned int replacement_calls;
> +       unsigned int replacement_destroys;
> +       unsigned int interval;
> +       bool repeat;
> +       bool remove;
> +       bool replace;
> +};
> +
> +static void wrapper_destroy(void *user_data)
> +{
> +       struct wrapper_data *data =3D user_data;
> +
> +       data->destroys++;
> +}
> +
> +static void replacement_destroy(void *user_data)
> +{
> +       struct wrapper_data *data =3D user_data;
> +
> +       data->replacement_destroys++;
> +}
> +
> +static bool replacement_callback(void *user_data)
> +{
> +       struct wrapper_data *data =3D user_data;
> +
> +       data->replacement_calls++;
> +       mainloop_exit_success();
> +       return false;
> +}
> +
> +static bool wrapper_callback(void *user_data)
> +{
> +       struct wrapper_data *data =3D user_data;
> +       unsigned int replacement;
> +
> +       data->calls++;
> +
> +       if (data->remove) {
> +               timeout_remove(data->id);
> +
> +               if (data->interval)
> +                       check(data->destroys =3D=3D 1);
> +
> +               if (data->replace) {
> +                       replacement =3D timeout_add(1, replacement_callba=
ck,
> +                                                 data, replacement_destr=
oy);
> +                       check(replacement > 0);
> +
> +                       if (data->interval)
> +                               check(replacement =3D=3D data->id);
> +               } else {
> +                       mainloop_exit_success();
> +               }
> +
> +               return data->repeat;
> +       }
> +
> +       if (data->repeat && data->calls < 3)
> +               return true;
> +
> +       mainloop_exit_success();
> +       return false;
> +}
> +
> +static void test_timeout_wrapper(void)
> +{
> +       unsigned int interval, mode;
> +
> +       for (interval =3D 0; interval < 2; interval++) {
> +               for (mode =3D 0; mode < 6; mode++) {
> +                       struct wrapper_data data =3D {
> +                               .interval =3D interval,
> +                               .repeat =3D mode & 1,
> +                               .remove =3D mode >=3D 2,
> +                               .replace =3D mode >=3D 4,
> +                       };
> +
> +                       mainloop_init();
> +                       data.id =3D timeout_add(interval, wrapper_callbac=
k,
> +                                             &data, wrapper_destroy);
> +                       check(data.id > 0);
> +                       check(mainloop_run() =3D=3D EXIT_SUCCESS);
> +                       check(data.calls =3D=3D
> +                                       (!data.remove && data.repeat ? 3 =
: 1));
> +                       check(data.destroys =3D=3D 1);
> +                       check(data.replacement_calls =3D=3D data.replace)=
;
> +                       check(data.replacement_destroys =3D=3D data.repla=
ce);
> +                       fprintf(stderr, "Timeout wrapper %u/%u passed\n",
> +                               interval, mode);
> +               }
> +       }
> +}
> +
>  #define define_test(name, function)                            \
>         do {                                                    \
>                 static struct test_data data =3D {};              \
> @@ -167,5 +266,6 @@ int main(int argc, char *argv[])
>         define_test("Test Modify File Descriptor", test_modify_fd);
>         define_test("Test Re-Add Other Callback", test_readd_other_callba=
ck);
>         define_test("Test Timeout", test_timeout);
> +       test_timeout_wrapper();

This doesn't look good. First, let's have as a separate test. Second,
this should be another test e.g. Use `define_test` to test removing
the timeout within its callback.

>         return 0;
>  }
>
> base-commit: 34b6f8e0e998728ce9e8e64e280d9d390c511804
> --
> 2.56.0
>
>
>


--=20
Luiz Augusto von Dentz
