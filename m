Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F939657E
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776330300; cv=none; b=SeCoiLoM4y8aQCBdv8lxwTb2iVyNBR0Ekcih65VLQcJ+TcZ3H9mjC8r1SN9FTfkNIzEIoZJ6suo7wTpWWULfe60jCEE3nGy+xXgAlwPH0upRy3+/CJkiT7H4+vYjOGTADAJNPMgyuJ97KegalrHPWrApv5v9LiF5R4tRiCaMCNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776330300; c=relaxed/simple;
	bh=kSUsktBfjTgsb2N9gCeFeRDbhHbebFACgd8HpipZFMs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vfo+66PE1IyRYQNE3F3AnmF5ALnUsGE7DHkBOdRYQ5Al9T1crtoxxkc8Og0v4JvwJIV1xTQy+n4JRGev+RwkIi7IxVk2I7z05duMFZqwUOY2WkRR5ZFrbqD+AgHwGJ+msMpQ2G0dIcOaZ2wgOZo9j4S5LLqAY8Jx8eBa7v78ZYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 02FAD3EBAE
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 09:04:48 +0000 (UTC)
Message-ID: <448e67eae35581ff8a1384622ba2c0567026ecc7.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/4] shared/queue: Add way to iterate over queue
 contents
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 16 Apr 2026 11:04:48 +0200
In-Reply-To: <20260403084128.348931-1-hadess@hadess.net>
References: <20260403084128.348931-1-hadess@hadess.net>
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
X-GND-Score: 0
X-GND-Cause: dmFkZTFmmg2COw6jMPDdLrYjq/Rh8/RWDY1w1zESsc0i+THC5+L/iNtOrSZsWCirzmcIEuk4CFMBMVVGkVNq2VOp9r9yJdgRX/RdbgeVADlmYPlIMJk2AF0gj31L7lq180M/jUYSpPtUcf7FKQ6PyvgbrydTh7jxmQpMbak7KG5zZ+yN8ewOx6cgQZcoDA71QVcyGaa4eLcQNua/iasCOWn7JocjePjrWXv5Z8sqTbrFylUv8J2q+29+xcX7ctZXN2htufJmBD0ZJuhAfo7w1rlicHII3ErU77GdMsvBmQ5BwXK0oV3BjfsVFd8SBjaS6jzveOC+GdaNCVd9goPBr70D1pyeDXWlF6wfX4j/vx5qPnPyWeJDhCPAPXa+K3oOgBTt2eKc8EgcrTU5eIp0WtJHjDgLxQ4b1GlrflhxnQtO66FdaBDjpC9iVTHEnixRoaYl83FgW9r4r9R/q93N2a8A3L4i3JQQLosp27RSSa/53Jlbb2UEIe3fLF7szNp8P9rILI8xCsYnwB09+E6sI4Od6W3OJH6DTxopPzOyrHK3jOXDywCwlrDmNgHXSOqk548gUGzLYrQFnNk29ZWgBj+hg2DschILgKV9gtO+w0bEpCwYMzUX2YjTacTh43wWs4cZrOzRJH5N/EQo8bdVlQNXhDHAwZoHI8KwKJRkuzVeDtLM/A
X-GND-State: clean

Hey,

Could I please get a review on this patchset?

Cheers

On Fri, 2026-04-03 at 10:40 +0200, Bastien Nocera wrote:
> There were no accessors that would give us an iteratable structure,
> leaving us with just *_foreach() constructs that are cumbersome.
>=20
> Add a way to get the first entry in the queue.
> ---
> =C2=A0src/shared/queue.c |=C2=A0 8 ++++++++
> =C2=A0src/shared/queue.h |=C2=A0 1 +
> =C2=A0unit/test-queue.c=C2=A0 | 20 ++++++++++++++++++++
> =C2=A03 files changed, 29 insertions(+)
>=20
> diff --git a/src/shared/queue.c b/src/shared/queue.c
> index 0b53b5b7976e..20fe2a913f58 100644
> --- a/src/shared/queue.c
> +++ b/src/shared/queue.c
> @@ -179,6 +179,14 @@ void *queue_peek_head(struct queue *queue)
> =C2=A0	return queue->head->data;
> =C2=A0}
> =C2=A0
> +struct queue_entry *queue_peek_head_entry(struct queue *queue)
> +{
> +	if (!queue || !queue->head)
> +		return NULL;
> +
> +	return queue->head;
> +}
> +
> =C2=A0void *queue_peek_tail(struct queue *queue)
> =C2=A0{
> =C2=A0	if (!queue || !queue->tail)
> diff --git a/src/shared/queue.h b/src/shared/queue.h
> index 122f4eaa6c2f..5ea7ce4fd768 100644
> --- a/src/shared/queue.h
> +++ b/src/shared/queue.h
> @@ -27,6 +27,7 @@ bool queue_push_head(struct queue *queue, void
> *data);
> =C2=A0bool queue_push_after(struct queue *queue, void *entry, void *data)=
;
> =C2=A0void *queue_pop_head(struct queue *queue);
> =C2=A0void *queue_peek_head(struct queue *queue);
> +struct queue_entry *queue_peek_head_entry(struct queue *queue);
> =C2=A0void *queue_peek_tail(struct queue *queue);
> =C2=A0
> =C2=A0typedef void (*queue_foreach_func_t)(void *data, void *user_data);
> diff --git a/unit/test-queue.c b/unit/test-queue.c
> index 46018ef9cf1f..e47199497d41 100644
> --- a/unit/test-queue.c
> +++ b/unit/test-queue.c
> @@ -246,6 +246,25 @@ static void test_remove_all(const void *data)
> =C2=A0	tester_test_passed();
> =C2=A0}
> =C2=A0
> +static void test_peek_head_entry(const void *data)
> +{
> +	struct queue *queue;
> +	struct queue_entry *entry;
> +
> +	queue =3D queue_new();
> +	g_assert(queue !=3D NULL);
> +
> +	g_assert(queue_push_tail(queue, INT_TO_PTR(10)));
> +
> +	entry =3D queue_peek_head_entry(queue);
> +	g_assert(entry->data =3D=3D queue_peek_head(queue));
> +	g_assert_cmpint(PTR_TO_INT(entry->data), =3D=3D,
> PTR_TO_INT(queue_peek_head(queue)));
> +	g_assert_cmpint(PTR_TO_INT(entry->data), =3D=3D, 10);
> +
> +	queue_destroy(queue, NULL);
> +	tester_test_passed();
> +}
> +
> =C2=A0int main(int argc, char *argv[])
> =C2=A0{
> =C2=A0	tester_init(&argc, &argv);
> @@ -263,6 +282,7 @@ int main(int argc, char *argv[])
> =C2=A0						test_destroy_remove,
> NULL);
> =C2=A0	tester_add("/queue/push_after",=C2=A0 NULL, NULL,
> test_push_after, NULL);
> =C2=A0	tester_add("/queue/remove_all",=C2=A0 NULL, NULL,
> test_remove_all, NULL);
> +	tester_add("/queue/peek_head_entry", NULL, NULL,
> test_peek_head_entry, NULL);
> =C2=A0
> =C2=A0	return tester_run();
> =C2=A0}
