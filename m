Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306653DDDC3
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348933; cv=none; b=l2JAMPSdizWAEcbjRdAC+/wir72Y5ZP54TsD5RgOCvTAARSyNTKimOCTXHJdhfu+BSf5B+/G07KeId1+nOqGn+7j/EwYRDmj5HscR5ureDXntLnAQVNcLri1wQ6SJvgvb3HM+BVDutPnMPPTgHdZshvDtk2VauMGPnBrmNIDq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348933; c=relaxed/simple;
	bh=ZJKr7Ei2+N6ZlL+W4zh+WafgxNXai/CksswXbl+Jkb8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dLRlaYW/18A2Eq6NbXaak0O8KlG4t4CQApoC+qG2nD8EevuaTDJgU01NIBBlWA8h20kwE/vz8AvfUqsZxHF/RIENfp+ysBDtMSWkXdefJpCvKWP7Nlm63532IJwWmXugdHVh8NC08ptn4KwtzRTXTv59P61HO4ZI7Tpx33zTdVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F78B3EC5A;
	Thu, 16 Apr 2026 14:15:30 +0000 (UTC)
Message-ID: <0821f653dc6ff4bdd25399501b57131aaaef281d.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/4] shared/queue: Add way to iterate over queue
 contents
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 16 Apr 2026 16:15:30 +0200
In-Reply-To: <CABBYNZ+uJUN1njPukM-A4ubMb-yiuCGR+ZO7RqzBe9p5rFQVcQ@mail.gmail.com>
References: <20260403084128.348931-1-hadess@hadess.net>
	 <448e67eae35581ff8a1384622ba2c0567026ecc7.camel@hadess.net>
	 <CABBYNZ+uJUN1njPukM-A4ubMb-yiuCGR+ZO7RqzBe9p5rFQVcQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEWGGKNZaFeL4zLfoSzdazmn4KWfiLp6/ma63sPQ3ORu11kyVTysqwlotaIyukrxAXHatpPaWSUA459GWxkI9Oa1d4Xwx3VHB8l+YivLqwfXTdoSU3yCNdxWupBNzmT6EExpH6P5pXO168Dr1du43tu7GJFBiYmvHYYKb4hyMhG2nNuqs+fY/ZElI+q7dlJ9GeTYmebV+zq0q0UPtpP8lvjvFhIIt5PobpwSad1Edoy2JfvBdm62/jkbBx9n4TuZCNLqOdX8/Z0mJ5qJrn3OkR3/Grwv/QsKRw2ddgvkJFxK9tCo/f4tVA6rz6EYFR1r6HIdUc9zUrtyKmVQlQ69bg2nobqeI7r9uWsuUmQkF7UQxn0FeNBS9IO6qg7nQrXXonLxHrkkB58vO98HHObCwu11G6QUmAbzMSyaOXImyg8VkJ4JGEeua6H7uZw3EzhR4ebIv4BdT6HJpWqvbtm5UZCWNXyQZxrtYaNdJzBfvFOij58zPl7YNTR08lDT6kVqaRLHNYe+Wt5IvxtGzJROGTU9UQhAdbjxifEuiPd+TO/OBgrhGnuWkNa3mxfxtgdkChxkRSRwntQa+vZuGiUcQapXi6/Y7h24Kfn9Xs4/X4WdtEDUH1KgmZ6CR3l2SJq7laM6rCbsL1Pdn4NafZgInikfxYDw8tWgrwMN2j/bHG1Pg

On Thu, 2026-04-16 at 09:46 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Thu, Apr 16, 2026 at 5:05=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > Hey,
> >=20
> > Could I please get a review on this patchset?
>=20
> There is already a function to iterate manually:
>=20
> queue_get_entries

Well, this is starting to be embarrassing. I've sent in a v3 that uses
this API instead.

Cheers

>=20
> > Cheers
> >=20
> > On Fri, 2026-04-03 at 10:40 +0200, Bastien Nocera wrote:
> > > There were no accessors that would give us an iteratable
> > > structure,
> > > leaving us with just *_foreach() constructs that are cumbersome.
> > >=20
> > > Add a way to get the first entry in the queue.
> > > ---
> > > =C2=A0src/shared/queue.c |=C2=A0 8 ++++++++
> > > =C2=A0src/shared/queue.h |=C2=A0 1 +
> > > =C2=A0unit/test-queue.c=C2=A0 | 20 ++++++++++++++++++++
> > > =C2=A03 files changed, 29 insertions(+)
> > >=20
> > > diff --git a/src/shared/queue.c b/src/shared/queue.c
> > > index 0b53b5b7976e..20fe2a913f58 100644
> > > --- a/src/shared/queue.c
> > > +++ b/src/shared/queue.c
> > > @@ -179,6 +179,14 @@ void *queue_peek_head(struct queue *queue)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return queue->head->data;
> > > =C2=A0}
> > >=20
> > > +struct queue_entry *queue_peek_head_entry(struct queue *queue)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 if (!queue || !queue->head)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return NULL;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 return queue->head;
> > > +}
> > > +
> > > =C2=A0void *queue_peek_tail(struct queue *queue)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!queue || !queue->tail)
> > > diff --git a/src/shared/queue.h b/src/shared/queue.h
> > > index 122f4eaa6c2f..5ea7ce4fd768 100644
> > > --- a/src/shared/queue.h
> > > +++ b/src/shared/queue.h
> > > @@ -27,6 +27,7 @@ bool queue_push_head(struct queue *queue, void
> > > *data);
> > > =C2=A0bool queue_push_after(struct queue *queue, void *entry, void
> > > *data);
> > > =C2=A0void *queue_pop_head(struct queue *queue);
> > > =C2=A0void *queue_peek_head(struct queue *queue);
> > > +struct queue_entry *queue_peek_head_entry(struct queue *queue);
> > > =C2=A0void *queue_peek_tail(struct queue *queue);
> > >=20
> > > =C2=A0typedef void (*queue_foreach_func_t)(void *data, void
> > > *user_data);
> > > diff --git a/unit/test-queue.c b/unit/test-queue.c
> > > index 46018ef9cf1f..e47199497d41 100644
> > > --- a/unit/test-queue.c
> > > +++ b/unit/test-queue.c
> > > @@ -246,6 +246,25 @@ static void test_remove_all(const void
> > > *data)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_test_passed();
> > > =C2=A0}
> > >=20
> > > +static void test_peek_head_entry(const void *data)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct queue *queue;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 struct queue_entry *entry;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 queue =3D queue_new();
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(queue !=3D NULL);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(queue_push_tail(queue, INT_TO_PTR(=
10)));
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 entry =3D queue_peek_head_entry(queue);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(entry->data =3D=3D queue_peek_head=
(queue));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmpint(PTR_TO_INT(entry->data), =
=3D=3D,
> > > PTR_TO_INT(queue_peek_head(queue)));
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_cmpint(PTR_TO_INT(entry->data), =
=3D=3D, 10);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 queue_destroy(queue, NULL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 tester_test_passed();
> > > +}
> > > +
> > > =C2=A0int main(int argc, char *argv[])
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_init(&argc, &argv);
> > > @@ -263,6 +282,7 @@ int main(int argc, char *argv[])
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > test_destroy_remove,
> > > NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_add("/queue/push_after",=C2=A0 =
NULL, NULL,
> > > test_push_after, NULL);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tester_add("/queue/remove_all",=C2=A0 =
NULL, NULL,
> > > test_remove_all, NULL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 tester_add("/queue/peek_head_entry", NULL, =
NULL,
> > > test_peek_head_entry, NULL);
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tester_run();
> > > =C2=A0}
> >=20
>=20
