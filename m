Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=109.224.244.122
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000356;
	b=UDzq+4vcS34VPDet9QAWQdQDeD9cHQiS+9/GmsLjQWJUANowweriRB9YbNimPle5U73q
	 DP3B1HC30j5PVzXrCNstpZA0kQ6N/sE/ntGRkP5sds8CUrq7dWvmm68kZGC4UqsoqAiTW
	 guHmPZKuVaacqBDgSwY0AoGuDJa4TpffLp/IrOWC2mlr5TCTBtMl92afAkF+mQhLjAmQR
	 xV5cn4fixnBtv3BGMbXwGf2dLW/bpViQdgFy9Q3vYkcIEQmerKzeMKzpMVyTBrBX6QL0Q
	 Ttld1CXObq1264augCob6iBPQFs3OtOXIPy3s9IMir7axq7fCRNnJJE8wHvMkfnf/WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000356;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=FOP8Q8YaWW5xTkf2KOXIfwzqQcVYeoFqtRAYA/d75gQ=;
	b=kgmNHeFUD5TNPenNEwxzGy1XpgbUSdsz9CkpIicVKWhdj+Qwz63IOirJqqdo0EBayrhD
	 GurfgqYnI39xtj2QrCit7hw9xwIBu1sOxdXFrFlhVJZbwlor/F9OygFw6W6b3L7mHUhFz
	 EIZhErPyIr5EZaR+vPXbNRDlUIFM5334dqBTA1NUKU6Ztn+pWB1dxgDzCGDH6VG51TgPR
	 x9hLivwHhNnDTWvp9PHWGxrn3GRiA5CTAVuTFzO6FjTGab8F2f2iu7bccFK3PcKS/weND
	 rTVKLOxr4MWADjBQpnsRrq4EbHqbyGE5JsdLN5lqMSPHDw6qW6DlsJ1oYkwcm1Gco6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=vD7DXsIw;
	arc=none smtp.remote-ip=109.224.244.122
Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F108606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 21:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F108606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=vD7DXsIw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794000353; x=1794259553;
	bh=FOP8Q8YaWW5xTkf2KOXIfwzqQcVYeoFqtRAYA/d75gQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=vD7DXsIw3WjN7R8xw289HHVy2oufbyOxxNGwoi2h9pGuJXDcVErx5cSKbYQFBBgPx
	 J2IsmEEJr2gq0ntRQ0Eu0TnlzrbjUBoVso1sa/9gDjp1w0h1MG1TOt1Zz8ms8vJGRD
	 cWbGqXhWoe9VYVo7V3DFDBa6l2ourvYxc9f4ubUQ4+jOD1C61u9czSPN2sijp49WSY
	 ICm2QU+NbT81uOEufIrlcY00IJ4WpttoBF1kmsaYKodIohSkKu+5/C3+idWIVZqi4f
	 L+rQsu79sm5/moMOtYweeQrsMNWGCY0IcAuhjSx8e3xKJIp8uTGtocX9cjEHAMHzui
	 Xt12ngpTdgSkQ==
Date: Fri, 06 Nov 2026 21:25:50 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared/timeout: Keep callback data alive during removal
Message-ID: <cIXLm-YZRgKQJnplSaccRCf0S4VYim0l2QETlhQ7v1-4AHQ3F0H2m5BbLFeZphSARDpHgRAof_ISmOvgqG9xaqcR0S34VyiTFWONBi0KVFw=@proton.me>
In-Reply-To: <CABBYNZJM9Lm0pAftc9Xv+A+1rjvwg5+p_BBK2R9+utD=Y+zprg@mail.gmail.com>
References: <20261106042339.811655-1-cochcoder@proton.me> <CABBYNZLgfhHj5HqcqCxTYKhAw9-5jBYVwnS=ciOfbgdsmsAL5A@mail.gmail.com> <CABBYNZJM9Lm0pAftc9Xv+A+1rjvwg5+p_BBK2R9+utD=Y+zprg@mail.gmail.com>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 656fe13f08da9d1ec40b234f1be384ecbd4de179
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=20

Thanks Luiz. I=E2=80=99ll defer to your patch.=20

Kyle Pepper


On Friday, November 6th, 2026 at 1:33 PM, Luiz Augusto von Dentz <luiz.dent=
z@gmail.com> wrote:

> Hi,
>=20
> On Fri, Nov 6, 2026 at 1:30=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Kyle,
> >
> > On Thu, Nov 5, 2026 at 11:24=E2=80=AFPM Kyle Pepper <cochcoder@proton.m=
e> wrote:
> > >
> > > A timeout callback can remove its own timer. The mainloop then destro=
ys
> > > the wrapper before timeout_callback reads its identifier again.
> > >
> > > Hold a reference while dispatching and clear the identifier when the
> > > timer is destroyed. This also prevents a removed callback from modify=
ing
> > > a replacement timer that reused its descriptor. Keep user destruction
> > > synchronous for timerfd timers.
> > >
> > > Add unit coverage for idle and timerfd timers with one-shot, repeatin=
g,
> > > self-removing and replacement callbacks.
> > >
> > > Fixes: 1f11ee8f5194 ("shared: Add timeout handling with mainloop supp=
ort")
> > > Assisted-by: Codex:GPT-6
> > > ---
> > >  src/shared/timeout-mainloop.c |  26 +++++++--
> > >  unit/test-mainloop.c          | 100 ++++++++++++++++++++++++++++++++=
++
> > >  2 files changed, 121 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainl=
oop.c
> > > index e6f9c5e826..edcc801114 100644
> > > --- a/src/shared/timeout-mainloop.c
> > > +++ b/src/shared/timeout-mainloop.c
> > > @@ -16,31 +16,46 @@
> > >
> > >  struct timeout_data {
> > >         int id;
> > > +       unsigned int ref_count;
> > >         timeout_func_t func;
> > >         timeout_destroy_func_t destroy;
> > >         unsigned int timeout;
> > >         void *user_data;
> > >  };
> > >
> > > +static void timeout_unref(struct timeout_data *data)
> > > +{
> > > +       if (!--data->ref_count)
> > > +               free(data);
> > > +}
> > > +
> > >  static void timeout_callback(int id, void *user_data)
> > >  {
> > >         struct timeout_data *data =3D user_data;
> > > +       bool repeat;
> > >
> > > -       if (data->func(data->user_data) &&
> > > -                       !mainloop_modify_timeout(data->id, data->time=
out))
> > > -               return;
> > > +       /* The callback may remove the timeout. */
> > > +       data->ref_count++;
> > > +       repeat =3D data->func(data->user_data);
> > > +
> > > +       if (data->id) {
> > > +               if (!repeat || mainloop_modify_timeout(data->id, data=
->timeout))
> > > +                       mainloop_remove_timeout(data->id);
> > > +       }
> > >
> > > -       mainloop_remove_timeout(data->id);
> > > +       timeout_unref(data);
> > >  }
> > >
> > >  static void timeout_destroy(void *user_data)
> > >  {
> > >         struct timeout_data *data =3D user_data;
> > >
> > > +       data->id =3D 0;
> > > +
> > >         if (data->destroy)
> > >                 data->destroy(data->user_data);
> > >
> > > -       free(data);
> > > +       timeout_unref(data);
> > >  }
> > >
> > >  unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
> > > @@ -49,6 +64,7 @@ unsigned int timeout_add(unsigned int timeout, time=
out_func_t func,
> > >         struct timeout_data *data;
> > >
> > >         data =3D new0(struct timeout_data, 1);
> > > +       data->ref_count =3D 1;
> > >         data->func =3D func;
> > >         data->user_data =3D user_data;
> > >         data->timeout =3D timeout;
> >
> > LGTM
> >
> > > diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
> > > index 70ee03ee42..4cff654147 100644
> > > --- a/unit/test-mainloop.c
> > > +++ b/unit/test-mainloop.c
> > > @@ -12,6 +12,7 @@
> > >  #include <stdlib.h>
> > >
> > >  #include "src/shared/mainloop.h"
> > > +#include "src/shared/timeout.h"
> > >
> > >
> > >  #define test_failed_msg(msg) \
> > > @@ -153,6 +154,104 @@ static void test_timeout(struct test_data *data=
)
> > >         check(data->destroys =3D=3D 1);
> > >  }
> > >
> > > +struct wrapper_data {
> > > +       unsigned int id;
> > > +       unsigned int calls;
> > > +       unsigned int destroys;
> > > +       unsigned int replacement_calls;
> > > +       unsigned int replacement_destroys;
> > > +       unsigned int interval;
> > > +       bool repeat;
> > > +       bool remove;
> > > +       bool replace;
> > > +};
> > > +
> > > +static void wrapper_destroy(void *user_data)
> > > +{
> > > +       struct wrapper_data *data =3D user_data;
> > > +
> > > +       data->destroys++;
> > > +}
> > > +
> > > +static void replacement_destroy(void *user_data)
> > > +{
> > > +       struct wrapper_data *data =3D user_data;
> > > +
> > > +       data->replacement_destroys++;
> > > +}
> > > +
> > > +static bool replacement_callback(void *user_data)
> > > +{
> > > +       struct wrapper_data *data =3D user_data;
> > > +
> > > +       data->replacement_calls++;
> > > +       mainloop_exit_success();
> > > +       return false;
> > > +}
> > > +
> > > +static bool wrapper_callback(void *user_data)
> > > +{
> > > +       struct wrapper_data *data =3D user_data;
> > > +       unsigned int replacement;
> > > +
> > > +       data->calls++;
> > > +
> > > +       if (data->remove) {
> > > +               timeout_remove(data->id);
> > > +
> > > +               if (data->interval)
> > > +                       check(data->destroys =3D=3D 1);
> > > +
> > > +               if (data->replace) {
> > > +                       replacement =3D timeout_add(1, replacement_ca=
llback,
> > > +                                                 data, replacement_d=
estroy);
> > > +                       check(replacement > 0);
> > > +
> > > +                       if (data->interval)
> > > +                               check(replacement =3D=3D data->id);
> > > +               } else {
> > > +                       mainloop_exit_success();
> > > +               }
> > > +
> > > +               return data->repeat;
> > > +       }
> > > +
> > > +       if (data->repeat && data->calls < 3)
> > > +               return true;
> > > +
> > > +       mainloop_exit_success();
> > > +       return false;
> > > +}
> > > +
> > > +static void test_timeout_wrapper(void)
> > > +{
> > > +       unsigned int interval, mode;
> > > +
> > > +       for (interval =3D 0; interval < 2; interval++) {
> > > +               for (mode =3D 0; mode < 6; mode++) {
> > > +                       struct wrapper_data data =3D {
> > > +                               .interval =3D interval,
> > > +                               .repeat =3D mode & 1,
> > > +                               .remove =3D mode >=3D 2,
> > > +                               .replace =3D mode >=3D 4,
> > > +                       };
> > > +
> > > +                       mainloop_init();
> > > +                       data.id =3D timeout_add(interval, wrapper_cal=
lback,
> > > +                                             &data, wrapper_destroy)=
;
> > > +                       check(data.id > 0);
> > > +                       check(mainloop_run() =3D=3D EXIT_SUCCESS);
> > > +                       check(data.calls =3D=3D
> > > +                                       (!data.remove && data.repeat =
? 3 : 1));
> > > +                       check(data.destroys =3D=3D 1);
> > > +                       check(data.replacement_calls =3D=3D data.repl=
ace);
> > > +                       check(data.replacement_destroys =3D=3D data.r=
eplace);
> > > +                       fprintf(stderr, "Timeout wrapper %u/%u passed=
\n",
> > > +                               interval, mode);
> > > +               }
> > > +       }
> > > +}
> > > +
> > >  #define define_test(name, function)                            \
> > >         do {                                                    \
> > >                 static struct test_data data =3D {};              \
> > > @@ -167,5 +266,6 @@ int main(int argc, char *argv[])
> > >         define_test("Test Modify File Descriptor", test_modify_fd);
> > >         define_test("Test Re-Add Other Callback", test_readd_other_ca=
llback);
> > >         define_test("Test Timeout", test_timeout);
> > > +       test_timeout_wrapper();
> >
> > This doesn't look good. First, let's have as a separate test. Second,
> > this should be another test e.g. Use `define_test` to test removing
> > the timeout within its callback.
>=20
> Actually I do have an outstanding patch fixing this, for some reason I
> forgot to apply it:
>=20
> https://patchwork.kernel.org/project/bluetooth/patch/20261030134426.42097=
9-1-luiz.dentz@gmail.com/
>=20
> > >         return 0;
> > >  }
> > >
> > > base-commit: 34b6f8e0e998728ce9e8e64e280d9d390c511804
> > > --
> > > 2.56.0
> > >
> > >
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>=20
>=20
>=20
> --
> Luiz Augusto von Dentz
> 
