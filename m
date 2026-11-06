Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989992;
	b=Gxn9erGlDGSiLupUd3GdD8aorqdJ93LVjjSa4MCnF/aAqLpKgaN9uI8sskJ+/UMMXULN
	 w6Uuwjd2Fci2XbVw8mIzoOcTIWGyMfb9q19WwGkyHnA88lHEeyawsYcfxFswjxWJBT+l1
	 wGXGwQtm4iZjo0kDH0QElQm5TZooYreK/AiReDP4jYzTKNAfDBxMO6s0wTSTM2wr3l1PZ
	 f/n9v0C8wkE8CuzBoZrbNEoMQW0PGVcRq+WWUxOgu8EIMYMilrsLnZjFgwacUXSYJljtp
	 g1AufCPaGXwZlCLB2T9P5avCbEpMwQLF6XCpXrHfSVRJKMUnYDr99WFNgX57zNcS78Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=AyKK/4dyHWFsRNTQUI2y/ODrEJ3QSqkOzmNE6bLSL4c=;
	b=JbnXUmOJg31pj9II73+ncK1ZQInUYWePX6VM3g9yUBLHfmOVeRm4fESHs+FzB/dSo63E
	 N1Zpy2niA8gxUoK5p7hn816zziWPeuar5ug75pYb/hIFHKUhxXccPGZ9ATuQ2TsbCakRw
	 k4r6xRNk1GVrzIz4T+iSQKtEfDbRI2f5xMZD4zjnDBBm9eu6+NVRmETbBft4PS+fb5uFN
	 R+9Q0Xt+zTdAElxQ0xK/yGkBAQV/N5ZKKkeIecY8UOOw6jK+uYtFzgld7krhI7fWHFnDM
	 rm2RP8N1QUUaT5Z0sK5KJN3H/lXP9MSWq29LFGYjMwZfDJN11ifyVe6JEhQaNT7dHRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ebj8eiVa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026C1606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 026C1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ebj8eiVa
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b312be5de8so9206197b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793989991; cv=none;
        d=google.com; s=arc-20260327;
        b=E6/DIuJ2zzlDVRovJhbbmFoV0ymFjWm8YfKGPNUbzJ+x2pAoyt0ZmLx9ne2uL2i7vg
         qI6UZfIb8rUe8Bu5Ap4tbVxt9c3v8XP8mS1/REVyRWpnegAbZ7cf/BTKco072K44DCx6
         wssDvV43zEpaCM+1dsCG3spQPl4QxI97jVasI9j10qw/0OCHK17vs1ojm5wOl23HDq39
         tH6YMXOTEGVeYLLMNUFioiH+THEMkJiyAAkX/BqHJDHomx0ApFxdlgKSELyNPL8877VC
         Z7fqaxcy82K+TM6XaTifTaO29GKDUzoX+6CDAvHnuacDefIt5496+6+7t9Qq+K4mUAKU
         W/FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AyKK/4dyHWFsRNTQUI2y/ODrEJ3QSqkOzmNE6bLSL4c=;
        fh=3nimXdHGQOcjfBt8iP5+b0Ollu0eBkOgKmJ6MQm4IgM=;
        b=p8CB8Q0bMdYYcpsWcMfjzE3yT5eNh04EYgWHNwbQchaIUWr8EMVUTHKdfcOwRbGk0d
         49hQGNtbQhvW4H0gHgGYDzZki0wostnSdLhfeoNdQUJvaCf9Z2g0TnCO2anwrRUXbr70
         OsuXwzJ0nmjSuy2KsyURAjhFN4MpaW/6pdCj/3fnq0lTpT/l5+SkFyPUsqpV4taDLwDi
         3ccmmbVWI+MOsu69WlSohnoHRgbLSb3caWbtW60KZ24bgpI/DdJCEDiUBpkQOuWEVtAY
         AIbpeMu92DfzGo3uvDB5YGg/VZOSXKvi75qmLz5CVulEOkR4ik7f7BGfIqQv4lOGrKPp
         DRkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989991; x=1794594791; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AyKK/4dyHWFsRNTQUI2y/ODrEJ3QSqkOzmNE6bLSL4c=;
        b=Ebj8eiVasn35i6meAVZO1REuEacuZ2FMJtvclt2I19nB4dVsrftLngCk8flHNCE8PT
         FawSY15eRp0uBjBYoJTS/iNg2cD6xvuMbJmRqU3jVa33GAezu0Plxb63mcOA2jjY//yo
         9APWg7ai6rwvOydJGoqgq7Vcmx9bxCNOqT2c4AiGoETwShsLzRky3AsXKEX7GiCrYKu1
         +q0etHc4gTg1A04bdbr0wX4+2fstT6WUEL5IScRaw+HLSmDYAF5Fxrsmc0ARKRRF20ZD
         uTHUC3IvOT74YGJ84+UuFirqGDl93qlgsvQTqpeZkRJ6zga99FmBjQ/bfyRAX/4f0vLk
         fquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989991; x=1794594791;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AyKK/4dyHWFsRNTQUI2y/ODrEJ3QSqkOzmNE6bLSL4c=;
        b=RBJlf/WXBi3vNQSpf7cHTSHNQ1tY+DxdvW9Q01FVO9K2Fyk5d9jZUD2xloA0A5z7u9
         8hTW3VKRoI8AqV3xcNSAAZ/wvqthbKrj3/0vF7UJBg5M7Bf/j4S4eIFClQMtR/nyK7Qy
         g0bzjSt9aFJXVU7kleI51cKY9HtY7WuKw5B+viEaeZTG1e6A2JLccYwwM5VdFtPOuWDq
         HrNzlnI4gZNPxrPGfpA9pobS8l2Ntu0KnkRSnB6u5sauRmygvu+YHQ8G8M0oLanwip4D
         8NYe8c0A01vfGxRdtmiL66gl/CfB4mr+JNgTfsnh1cFqkel6ZoEPhvducDxDNHzFm8cI
         2cqA==
X-Gm-Message-State: APuU4Z+w175Hu3UINrpKDW6/LptRbktTmnDwJkQF2TDko6A4f9YtJOYW
	D2FksjvTR/H8OIhYV5UR4Iuz4GTK44sdzK4uII3XX9Fjx7SZJUztceBKfJ3WflfQ/XVxoh0Bj/s
	27REJBrwqbBuf34gPX8/Z+4iTv5haU8YcK/SH
X-Gm-Gg: AYBFou2mOBj97Dn1zVIMJ6xHk162Tj3YfJm5MuuRq5owUTH1z/1rVIuLuZP+lPY8e9v
	W3rUqRQMk5uqCVEAAyjS8l7ziM5hRKp4v6XMQvpeOg2sxJOAC1FO+qTe7nFplriHS6mt0RkNicm
	V9aWM1I1odTj/Kp474JUseAOjlLAeAXtVPuJn8i0x23gjF02bnsa4/dk6U8n2lmzdEzNQKOq1gJ
	NSYEHEBIpH5H40WERyY1iCislGI52qu/Hh5zBa7DWULyffFj1Ahq7rlKiPXj9iOWU11A8JylOgE
	Hgkzd7//QDgtHKouRgBQBPAGvp8e46kQjwsN4KztRkwthGG8EApyL6pUVZNqsIYOl3FAM8K1GqL
	rGWcmjk48RkLbsuXftsP1aJXprSTRPjxBc/52bUmhr23qFSCSRTm6rq0Xzf1zlddk0cvipojPpT
	uYwBHCXLKTsATk1PQ3Q4hABXHNcEdBshP0w3zw0O4iwSuwQNwAoZ50egKR8iU=
X-Received: by 2002:a05:690c:6d84:b0:8b3:4729:a9f6 with SMTP id
 00721157ae682-8b34729f672mr10001077b3.78.1793989990794; Fri, 06 Nov 2026
 10:33:10 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106042339.811655-1-cochcoder@proton.me> <CABBYNZLgfhHj5HqcqCxTYKhAw9-5jBYVwnS=ciOfbgdsmsAL5A@mail.gmail.com>
In-Reply-To: <CABBYNZLgfhHj5HqcqCxTYKhAw9-5jBYVwnS=ciOfbgdsmsAL5A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Nov 2026 13:32:59 -0500
X-Gm-Features: AclHuK88NuXLJd_17LMcZWHJF-F9gozjmbCuKGvZkHRuLHsNQ6hGUTAfRlEzIYs
Message-ID: <CABBYNZJM9Lm0pAftc9Xv+A+1rjvwg5+p_BBK2R9+utD=Y+zprg@mail.gmail.com>
Subject: Re: [PATCH] shared/timeout: Keep callback data alive during removal
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 6, 2026 at 1:30=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Kyle,
>
> On Thu, Nov 5, 2026 at 11:24=E2=80=AFPM Kyle Pepper <cochcoder@proton.me>=
 wrote:
> >
> > A timeout callback can remove its own timer. The mainloop then destroys
> > the wrapper before timeout_callback reads its identifier again.
> >
> > Hold a reference while dispatching and clear the identifier when the
> > timer is destroyed. This also prevents a removed callback from modifyin=
g
> > a replacement timer that reused its descriptor. Keep user destruction
> > synchronous for timerfd timers.
> >
> > Add unit coverage for idle and timerfd timers with one-shot, repeating,
> > self-removing and replacement callbacks.
> >
> > Fixes: 1f11ee8f5194 ("shared: Add timeout handling with mainloop suppor=
t")
> > Assisted-by: Codex:GPT-6
> > ---
> >  src/shared/timeout-mainloop.c |  26 +++++++--
> >  unit/test-mainloop.c          | 100 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 121 insertions(+), 5 deletions(-)
> >
> > diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloo=
p.c
> > index e6f9c5e826..edcc801114 100644
> > --- a/src/shared/timeout-mainloop.c
> > +++ b/src/shared/timeout-mainloop.c
> > @@ -16,31 +16,46 @@
> >
> >  struct timeout_data {
> >         int id;
> > +       unsigned int ref_count;
> >         timeout_func_t func;
> >         timeout_destroy_func_t destroy;
> >         unsigned int timeout;
> >         void *user_data;
> >  };
> >
> > +static void timeout_unref(struct timeout_data *data)
> > +{
> > +       if (!--data->ref_count)
> > +               free(data);
> > +}
> > +
> >  static void timeout_callback(int id, void *user_data)
> >  {
> >         struct timeout_data *data =3D user_data;
> > +       bool repeat;
> >
> > -       if (data->func(data->user_data) &&
> > -                       !mainloop_modify_timeout(data->id, data->timeou=
t))
> > -               return;
> > +       /* The callback may remove the timeout. */
> > +       data->ref_count++;
> > +       repeat =3D data->func(data->user_data);
> > +
> > +       if (data->id) {
> > +               if (!repeat || mainloop_modify_timeout(data->id, data->=
timeout))
> > +                       mainloop_remove_timeout(data->id);
> > +       }
> >
> > -       mainloop_remove_timeout(data->id);
> > +       timeout_unref(data);
> >  }
> >
> >  static void timeout_destroy(void *user_data)
> >  {
> >         struct timeout_data *data =3D user_data;
> >
> > +       data->id =3D 0;
> > +
> >         if (data->destroy)
> >                 data->destroy(data->user_data);
> >
> > -       free(data);
> > +       timeout_unref(data);
> >  }
> >
> >  unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
> > @@ -49,6 +64,7 @@ unsigned int timeout_add(unsigned int timeout, timeou=
t_func_t func,
> >         struct timeout_data *data;
> >
> >         data =3D new0(struct timeout_data, 1);
> > +       data->ref_count =3D 1;
> >         data->func =3D func;
> >         data->user_data =3D user_data;
> >         data->timeout =3D timeout;
>
> LGTM
>
> > diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
> > index 70ee03ee42..4cff654147 100644
> > --- a/unit/test-mainloop.c
> > +++ b/unit/test-mainloop.c
> > @@ -12,6 +12,7 @@
> >  #include <stdlib.h>
> >
> >  #include "src/shared/mainloop.h"
> > +#include "src/shared/timeout.h"
> >
> >
> >  #define test_failed_msg(msg) \
> > @@ -153,6 +154,104 @@ static void test_timeout(struct test_data *data)
> >         check(data->destroys =3D=3D 1);
> >  }
> >
> > +struct wrapper_data {
> > +       unsigned int id;
> > +       unsigned int calls;
> > +       unsigned int destroys;
> > +       unsigned int replacement_calls;
> > +       unsigned int replacement_destroys;
> > +       unsigned int interval;
> > +       bool repeat;
> > +       bool remove;
> > +       bool replace;
> > +};
> > +
> > +static void wrapper_destroy(void *user_data)
> > +{
> > +       struct wrapper_data *data =3D user_data;
> > +
> > +       data->destroys++;
> > +}
> > +
> > +static void replacement_destroy(void *user_data)
> > +{
> > +       struct wrapper_data *data =3D user_data;
> > +
> > +       data->replacement_destroys++;
> > +}
> > +
> > +static bool replacement_callback(void *user_data)
> > +{
> > +       struct wrapper_data *data =3D user_data;
> > +
> > +       data->replacement_calls++;
> > +       mainloop_exit_success();
> > +       return false;
> > +}
> > +
> > +static bool wrapper_callback(void *user_data)
> > +{
> > +       struct wrapper_data *data =3D user_data;
> > +       unsigned int replacement;
> > +
> > +       data->calls++;
> > +
> > +       if (data->remove) {
> > +               timeout_remove(data->id);
> > +
> > +               if (data->interval)
> > +                       check(data->destroys =3D=3D 1);
> > +
> > +               if (data->replace) {
> > +                       replacement =3D timeout_add(1, replacement_call=
back,
> > +                                                 data, replacement_des=
troy);
> > +                       check(replacement > 0);
> > +
> > +                       if (data->interval)
> > +                               check(replacement =3D=3D data->id);
> > +               } else {
> > +                       mainloop_exit_success();
> > +               }
> > +
> > +               return data->repeat;
> > +       }
> > +
> > +       if (data->repeat && data->calls < 3)
> > +               return true;
> > +
> > +       mainloop_exit_success();
> > +       return false;
> > +}
> > +
> > +static void test_timeout_wrapper(void)
> > +{
> > +       unsigned int interval, mode;
> > +
> > +       for (interval =3D 0; interval < 2; interval++) {
> > +               for (mode =3D 0; mode < 6; mode++) {
> > +                       struct wrapper_data data =3D {
> > +                               .interval =3D interval,
> > +                               .repeat =3D mode & 1,
> > +                               .remove =3D mode >=3D 2,
> > +                               .replace =3D mode >=3D 4,
> > +                       };
> > +
> > +                       mainloop_init();
> > +                       data.id =3D timeout_add(interval, wrapper_callb=
ack,
> > +                                             &data, wrapper_destroy);
> > +                       check(data.id > 0);
> > +                       check(mainloop_run() =3D=3D EXIT_SUCCESS);
> > +                       check(data.calls =3D=3D
> > +                                       (!data.remove && data.repeat ? =
3 : 1));
> > +                       check(data.destroys =3D=3D 1);
> > +                       check(data.replacement_calls =3D=3D data.replac=
e);
> > +                       check(data.replacement_destroys =3D=3D data.rep=
lace);
> > +                       fprintf(stderr, "Timeout wrapper %u/%u passed\n=
",
> > +                               interval, mode);
> > +               }
> > +       }
> > +}
> > +
> >  #define define_test(name, function)                            \
> >         do {                                                    \
> >                 static struct test_data data =3D {};              \
> > @@ -167,5 +266,6 @@ int main(int argc, char *argv[])
> >         define_test("Test Modify File Descriptor", test_modify_fd);
> >         define_test("Test Re-Add Other Callback", test_readd_other_call=
back);
> >         define_test("Test Timeout", test_timeout);
> > +       test_timeout_wrapper();
>
> This doesn't look good. First, let's have as a separate test. Second,
> this should be another test e.g. Use `define_test` to test removing
> the timeout within its callback.

Actually I do have an outstanding patch fixing this, for some reason I
forgot to apply it:

https://patchwork.kernel.org/project/bluetooth/patch/20261030134426.420979-=
1-luiz.dentz@gmail.com/

> >         return 0;
> >  }
> >
> > base-commit: 34b6f8e0e998728ce9e8e64e280d9d390c511804
> > --
> > 2.56.0
> >
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
