Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1453C2788
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776347205; cv=pass; b=f3igxYkx0l5ecxrx//GLCFksY16bSD+3pczlvM1sXBFJfUUzwB28PXgNCsxvLsIoEgG80rVAN6hbMgBpaKrlJIimRw3xy+/v9Cc61LBzMgltrTJs9l/qUzF4nSFLLil28W6Lu1UnZDbYbxG7u1kjqO2vltC9qpLSJp5ZsqW49Oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776347205; c=relaxed/simple;
	bh=F4E+SV682YFhOYx1CqshCnXQQUs7t/Fr0NWVR1LIJas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqPHF748U/njbb/0GKCBWjBBgdX573VsTogVZL6VNe7Z7+hzQuIggn4dnTZoRkBS5u8Nhabtlv1PaC1LfhT6G/BgbjQiTNH2obLFtCEyDGGHKnwSJChfPRght8g+ovjN6QX4r99k0FHHhQOjv5My8mgpiNR1SGUqFlIzhrTyBv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N55JV9I7; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N55JV9I7"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-651b2f46720so4907592d50.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 06:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776347203; cv=none;
        d=google.com; s=arc-20240605;
        b=atfWjNWDzYioCejZA5W69OeMtqgk61koFbCUegPGg/+5Fn19Ktt4xVa8IO9QI7LYbE
         zu6bipzmS7TFlhjhoY/iuj5REmwmNy63YJIR5+7WKGCWVk5DufXy8YInneFTIIcnU/Wa
         HffmoaF3drA6oHJ2o0eZk2dL3PeamD8fUkWclgd0YIDdHOlXF0K5kmOZ5wphhvnTCvti
         9mrP8DmsEtOMd1FKBhGHfH0kp3EVA10wuo+E2nb2JquydF2c1EWvkcVA3KXKXIbSePoT
         w/KlQcaorUoe5ewjGmWsim69uXGZ3BaS/n32XctV4jRiumUbNvdW+RM1o8XS16KrR0m+
         rDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U8bqAYRpq7ajkkQvOwKi4og5G89/1c8Wz7m+aRyG00Y=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=Qeb7+MRmzMf4aG+UWba02Rlt2zfUMd+sTQrYMKelpNqZKYBoiJXNnBEYWxzm8Y7+qG
         m5oyVdk+49OqY2lnPOoJfzObxuFzlrKs01LgvsHP8wJA/CP5emi6GQSTKYCk2OVKd2a/
         MJnS8hAnSyCBYwTnfkj2bdhBY1raeCF69xKOdeS4drhDv8YtMzUr5tsso1O7KsPW9thh
         H418VJwGOfmsHMaWfaFsr6aWophDXviL8Azt004HAcJ27dJxLfRfGs7auNp+yDQk/LUy
         x7/ALOxhx58r23epXKQvY/GbEoy8wzEILqqM5GWdbyGjCJNP8g42dnZtkC8tsmFGivPY
         lWow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776347203; x=1776952003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8bqAYRpq7ajkkQvOwKi4og5G89/1c8Wz7m+aRyG00Y=;
        b=N55JV9I71lDaqpY51pnVHBC9tyHCYLvjCWQevKV9BfZCNBAqeO6sd6zOMRvpUzXgsG
         GQZIxRwZRYh9xl/wPKrKD8VlsYoT2vBZDiWxpO8fVNMI5lFAM1zWPvM+1sE8bQhS9Eri
         /IWIKb/7xZGXnuJdpk+D4JVeoMlj+cahtNGGa0ET7U8+l3d33OZcFsNQnHc/85x2dYvK
         IslLSJq9jfagFSEL/YBpyQHuEnoNV6DihNLKk48HZBtmPiHZrNV56bEr2+vNBC9YT/0h
         /PPqshFUJBK4OGrGmCi0sz1M9aTdDFGldxerIQLVQbJ52oChmU5bu5K6Vx1VqNTG+W+/
         EvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776347203; x=1776952003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U8bqAYRpq7ajkkQvOwKi4og5G89/1c8Wz7m+aRyG00Y=;
        b=QTfnW7tbDrX3wRJqKNLEnH7Uq7fmNymcN2Xh7dgeLwzlMyiIAgjwyQ2sMw+5q/aWUN
         d4Ui5R2hpI7nAe05oYlhBQu2MrRRRbBuuNaSgIsGSK0u+IWc26A6Gg3RfwzKQ6KKhG4X
         d63SIWqUBpkD29W/jp6g4G+36e4MfQ8bNfu+kzjBLDaHT7NXy2vXqa8cPtqHrHk4yL0f
         Vg9m+CxYCE0M9+rX+rJDcUb/81JAM9IK+1aU/fz/O1wHSckeTSxN/GhxZz6pmM43Kxo9
         YQcxrKrthMGfMz0qk6PZE8TTiCM0nolDFUbZ1OpIh5iKL4NM6lMqNGspQ5M2XcLuRjgZ
         q6nw==
X-Gm-Message-State: AOJu0YxVh043l4OC/ZL8gwLZKRrEMGP3mWG8lBe8dQ16CRJK5aj2mtCC
	TzV7J+Z9egXuu4TbqEs1okiXWLA38SbQ9HpgS6fizdmdBBpfV7dG+0/gjqY/omzZxx9qENnY9mW
	LQOiiTB11iX3xIQdp9xZJC8dzKKqKCX9q52nH
X-Gm-Gg: AeBDievRPggkgbymlqT9UfpWw+j+9XxuCNvkVOwY0YHpQEkMVejGo863pwcl9BoFYzd
	3w1BAf2Q5t14RyYWGHgR5lJrBGjWNESqqQkyWTE5u0jRsCcjTxf2k9vjOx8QUBGP9D3Ua3W8T3i
	Atz1miRaCFhLkW9A3at+bsBCgiib+pbUNtTyZsg5C+OzeBd6Fgt/AwoLQhwmXiNLrKdPGZtZvVM
	mjt0r4ENH4o+Enmg5FwQ31//MPW0e4+rb6l+Eo44W1QOzIM0/JonFq9WDHEmbGljW10e6OaEeZL
	OIJujYJsF7uXd09q6H4wr7hBN+wMRzU2gtlbmoNne59onBAlUbACZasGLGL0hMKr1z5t2W65tYM
	3TThb
X-Received: by 2002:a53:b544:0:b0:64e:e380:c841 with SMTP id
 956f58d0204a3-65198bb4d1amr18240368d50.50.1776347202916; Thu, 16 Apr 2026
 06:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403084128.348931-1-hadess@hadess.net> <448e67eae35581ff8a1384622ba2c0567026ecc7.camel@hadess.net>
In-Reply-To: <448e67eae35581ff8a1384622ba2c0567026ecc7.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 16 Apr 2026 09:46:31 -0400
X-Gm-Features: AQROBzAQsA-dBLKGyyfeYGwrLPDRck0dM44rfdtyFsqk17ExuHebTcjpny9UEtY
Message-ID: <CABBYNZ+uJUN1njPukM-A4ubMb-yiuCGR+ZO7RqzBe9p5rFQVcQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/4] shared/queue: Add way to iterate over queue contents
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Thu, Apr 16, 2026 at 5:05=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> Hey,
>
> Could I please get a review on this patchset?

There is already a function to iterate manually:

queue_get_entries

> Cheers
>
> On Fri, 2026-04-03 at 10:40 +0200, Bastien Nocera wrote:
> > There were no accessors that would give us an iteratable structure,
> > leaving us with just *_foreach() constructs that are cumbersome.
> >
> > Add a way to get the first entry in the queue.
> > ---
> >  src/shared/queue.c |  8 ++++++++
> >  src/shared/queue.h |  1 +
> >  unit/test-queue.c  | 20 ++++++++++++++++++++
> >  3 files changed, 29 insertions(+)
> >
> > diff --git a/src/shared/queue.c b/src/shared/queue.c
> > index 0b53b5b7976e..20fe2a913f58 100644
> > --- a/src/shared/queue.c
> > +++ b/src/shared/queue.c
> > @@ -179,6 +179,14 @@ void *queue_peek_head(struct queue *queue)
> >       return queue->head->data;
> >  }
> >
> > +struct queue_entry *queue_peek_head_entry(struct queue *queue)
> > +{
> > +     if (!queue || !queue->head)
> > +             return NULL;
> > +
> > +     return queue->head;
> > +}
> > +
> >  void *queue_peek_tail(struct queue *queue)
> >  {
> >       if (!queue || !queue->tail)
> > diff --git a/src/shared/queue.h b/src/shared/queue.h
> > index 122f4eaa6c2f..5ea7ce4fd768 100644
> > --- a/src/shared/queue.h
> > +++ b/src/shared/queue.h
> > @@ -27,6 +27,7 @@ bool queue_push_head(struct queue *queue, void
> > *data);
> >  bool queue_push_after(struct queue *queue, void *entry, void *data);
> >  void *queue_pop_head(struct queue *queue);
> >  void *queue_peek_head(struct queue *queue);
> > +struct queue_entry *queue_peek_head_entry(struct queue *queue);
> >  void *queue_peek_tail(struct queue *queue);
> >
> >  typedef void (*queue_foreach_func_t)(void *data, void *user_data);
> > diff --git a/unit/test-queue.c b/unit/test-queue.c
> > index 46018ef9cf1f..e47199497d41 100644
> > --- a/unit/test-queue.c
> > +++ b/unit/test-queue.c
> > @@ -246,6 +246,25 @@ static void test_remove_all(const void *data)
> >       tester_test_passed();
> >  }
> >
> > +static void test_peek_head_entry(const void *data)
> > +{
> > +     struct queue *queue;
> > +     struct queue_entry *entry;
> > +
> > +     queue =3D queue_new();
> > +     g_assert(queue !=3D NULL);
> > +
> > +     g_assert(queue_push_tail(queue, INT_TO_PTR(10)));
> > +
> > +     entry =3D queue_peek_head_entry(queue);
> > +     g_assert(entry->data =3D=3D queue_peek_head(queue));
> > +     g_assert_cmpint(PTR_TO_INT(entry->data), =3D=3D,
> > PTR_TO_INT(queue_peek_head(queue)));
> > +     g_assert_cmpint(PTR_TO_INT(entry->data), =3D=3D, 10);
> > +
> > +     queue_destroy(queue, NULL);
> > +     tester_test_passed();
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >       tester_init(&argc, &argv);
> > @@ -263,6 +282,7 @@ int main(int argc, char *argv[])
> >                                               test_destroy_remove,
> > NULL);
> >       tester_add("/queue/push_after",  NULL, NULL,
> > test_push_after, NULL);
> >       tester_add("/queue/remove_all",  NULL, NULL,
> > test_remove_all, NULL);
> > +     tester_add("/queue/peek_head_entry", NULL, NULL,
> > test_peek_head_entry, NULL);
> >
> >       return tester_run();
> >  }
>


--=20
Luiz Augusto von Dentz
