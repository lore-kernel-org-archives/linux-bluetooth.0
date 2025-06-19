Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F9B19D8BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750355134; cv=none; b=nLRpsWLjdmERK9tiiNS/6sdXiI75WaX0USPlOl2dJPxafGXJ0BUnngoIYsne6SAlVkRz0mb3O+yOG3jAoljhcfuwFQbThKcy/VwAsRWp/4fS9ZKdOZo5Ve48WZONFNPt3eghUEXp4HC2OXA1+TqXiLejtZi9R07DSjyBcgkq7hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750355134; c=relaxed/simple;
	bh=02YqKk9N2UKaAjLLtTG2OEXgBzg8fkErDKtmY0pSZlk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA0aAKqr8iF7B/UB2wBY7Tqom2LSRUnd2/FXyZP82SLhC4dHmNpJpgWhcmV3NPbRcme4vHa6ntyy+QxX0eC9HOiWFOyQ6ccitQbCgkhj9XKAtU+qoTh4IJTghwL1TXav5RNiVrJ+P9VkxGzkZXjsh6hjsMZTsTaFZpnzLHbuZJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZuK301j; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZuK301j"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b50f357ecso8903981fa.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 10:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750355130; x=1750959930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uVW0+rBq/oMWZwGh/XUTT1THD0qzUnC9s+drFmG4JOk=;
        b=HZuK301jBa01didhlB0C3esTSdSQSH9buaymRrY35TV1Cj4xK0S0UDGa9HDLAGqgsU
         nJ2dSQgk2yvIIChyfD2Mn/3aV3+9+wOGgajvSEou9Ssd6CxeJkdcmHxido21W41NHWEt
         7lNt+vRxpUQshG3eTuKqyb3kZwOxy+WYCWpdH42+JGe3zWrIeyQHzI6qs6REpTwoX8lG
         uiQUI2vxnS5KpyRFydawQXuLe4hrsvSePPz95PIvHy70aqB689bJzqpN7ruswA4ARhpD
         vZ+d1R5n/4p5HNTspQQdXk3gnRZQRfcwTNebCHg26LOOWx/ktH1gsggC8qeFzFUV5fe0
         LcuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750355130; x=1750959930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVW0+rBq/oMWZwGh/XUTT1THD0qzUnC9s+drFmG4JOk=;
        b=eXqFvoTRZoVz4q5MLQlXWkYEC6FQMFJtWFTCWU5biQMwkiHgc5Lu5foq/QPwXuxGbW
         Qhb1Ovw3+XgYIJj4dTUapRsnzs2VYxTDR21+6f7V5QBHZb6KPpb+lLZapFzn5Lev7SeS
         CFAL7CwX5f+GhW+EOvdu6QHE25QBqiHXW/FRzwMcvC7N6Wjib/PLEVuvb9T44iidVgKK
         tCyND+K4VkFbR8gePo1TZ0ceRTshBXOJw9k1wFYXZaChXxRAnXgo4E86vl9SspDCZije
         TFCq044qdkWBWOtKjW6pDHWYCmtIqH/xyf/6DMoNsIwMFDqpNuYDHVJG7t9MJwaRPDqG
         qR8w==
X-Gm-Message-State: AOJu0Yz4FNqyDB8MvzONKs2/W5F84AaMpIiRZvtcG6pBneyhnoT8dKt+
	08dPChBsNeL1BSlL2sceRj+LSC6BLue+T7AqYKKt1k2WCJLbx9UhR8hPaeXG98gSxab3RB2Lh9g
	Yucn5tz9y6armHWVYE7xM7TSPdxKKTzI6nUOIXck=
X-Gm-Gg: ASbGnctqPDrgqDrnSrAtgpekVaAwFahGuu46c2ZeWVZjypRna3MZ6w2g4XMhpUXCP2o
	rcv2aW4qdiRLB68Y0yXsTe3fiXwb6Ijog3A1fVf2z2Sxm3PdqlqMxrjCMPdm/tAXtZsX9Qi7pJV
	P681KGKbqxKbzqynFY7BQUuK1z/lAchSD/gF0C9jhjPxZY8EyOxgG2
X-Google-Smtp-Source: AGHT+IGHQihZaT5ZeJ8Rh/TY3rlpGeXxB7hNGWRKQ3NJll8SET5nulOIpgfGHJrbMI2Nl78s9eB6CGogM4tW4s1Ho1Q=
X-Received: by 2002:a2e:a585:0:b0:32b:6bae:e3fe with SMTP id
 38308e7fff4ca-32b6baee492mr38105691fa.9.1750355130246; Thu, 19 Jun 2025
 10:45:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619153120.126315-1-k.samburskiy@omp.ru> <20250619153120.126315-2-k.samburskiy@omp.ru>
In-Reply-To: <20250619153120.126315-2-k.samburskiy@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 19 Jun 2025 13:45:18 -0400
X-Gm-Features: AX0GCFsQl8XDbl38hbalO3sFEgiIjla0p5LnA1RdcSFxTZ2Gl6Ib-aLv0apDL9A
Message-ID: <CABBYNZ+RoEG3-kNvW8EayiprP5ZgX+n9__GD6ELRuu4vAaXfFA@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] shared/tester: add ability to shutdown tester IO
To: Kirill Samburskiy <k.samburskiy@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kirill,

On Thu, Jun 19, 2025 at 11:34=E2=80=AFAM Kirill Samburskiy <k.samburskiy@om=
p.ru> wrote:
>
> Some tests may require the ability to shutdown IO for proper teardown.
> Add function tester_shutdown_io to accomplish that.
> ---
>  src/shared/tester.c | 6 ++++++
>  src/shared/tester.h | 1 +
>  2 files changed, 7 insertions(+)
>
> diff --git a/src/shared/tester.c b/src/shared/tester.c
> index 371ccaced..230e9ef75 100644
> --- a/src/shared/tester.c
> +++ b/src/shared/tester.c
> @@ -1047,6 +1047,12 @@ struct io *tester_setup_io(const struct iovec *iov=
, int iovcnt)
>         return ios[0];
>  }
>
> +void tester_shutdown_io(void)
> +{
> +       io_shutdown(ios[0]);
> +       io_shutdown(ios[1]);
> +}

We might as well just done it in tester_result, something like this:

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 230e9ef7579e..62a14d0732c8 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -654,6 +654,8 @@ static void test_result(enum test_result result)
                test->timeout_id =3D 0;
        }

+       tester_shutdown_io();
+
        if (test->result =3D=3D TEST_RESULT_FAILED)
                result =3D TEST_RESULT_FAILED;

That said, it appears it uncovered some other issues after Ive done that.

>  void tester_io_send(void)
>  {
>         struct test_case *test =3D tester_get_test();
> diff --git a/src/shared/tester.h b/src/shared/tester.h
> index 1f8138434..dfc1ca3a8 100644
> --- a/src/shared/tester.h
> +++ b/src/shared/tester.h
> @@ -81,5 +81,6 @@ void tester_wait(unsigned int seconds, tester_wait_func=
_t func,
>                                                         void *user_data);
>
>  struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
> +void tester_shutdown_io(void);
>  void tester_io_send(void);
>  void tester_io_set_complete_func(tester_data_func_t func);
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
