Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07594653A
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 14:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563407; cv=none; b=UhC7WGpVvaJAqyxsN/S9oRlKnKAiDokovxa0NPvUbUNbXjI5AqQDKVp9J0pvnwFL3n7MBbY4JVUNQYMvLP+Fd5P9aKqYyJR1ds1RPvoXFbf7EQWhwbawbyIYRittTtidrGhZBp+KfHXu3hSADq1Dj7LFALGuktmlocuHHMQilpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563407; c=relaxed/simple;
	bh=JFM6OYnFi+aorqg1Mjijh9NqStvR66D6Y8Vikz5JuIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANLSuyXFfJyYxElUlUrdflnTdZF+URMdrpgg7G/1TT8BJ3DJhXDDir6+JJafeD5nyE13J/neSesUX2+DoDTrWpcVhAeVqY1SQys2Axts4dAXk2ADw/Yazt81g1O0Y4zueOknzZx5ciOjA6GMOBMdX5dp40P6V+JjsMrFzwNeHlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMrMp7/L; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMrMp7/L"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d269b2ff48so52207821fa.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 06:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709563404; x=1710168204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OllV8Z+0TQRjZwoDmqBDl7QGS+0pxReMr5QXsEnYuBs=;
        b=IMrMp7/LA1sxUEzZjjenwjVTWsMhr3X9KINlrxEMaxNwhnqIhf7fKh4SLWuBIdIk6n
         gI6/37dH08JEhBGZrddi6tK2sMy7+1rsgPnw6j4TIua+pe+217qc5iLnUBLgaJ+VJw5B
         HK1LOwAq1H5IvyjmxNSDqXRZb5sDt3gvbjvlvT5ksNJAO9s1IwWvnQliWWDlv+Af0jd4
         Pk94NaFy54cRq5j3WsTnefdfkIFlVkwW36G5dHmpJVkCYZJEvHjno5wh/utC33jsos4n
         QOleG/sbmEw3KWN8Wb/hhfNQdnrfTYuQS9lSEyT2wxf2lNxM6gWbOw/qTl0i3vdjEbUq
         CFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563404; x=1710168204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OllV8Z+0TQRjZwoDmqBDl7QGS+0pxReMr5QXsEnYuBs=;
        b=gUYZHPJb0/pEctb8dVTuTlCnlloD3cUzWAfi9F5tBabsJP9N+OH3cl877Q+vyMFhBh
         twJMvAN1tJotexk+1/UjDA3cAFHm2Z+I75qQqpjMx8/a0aWZ2N5bt+MAMQz9zJEtMudx
         kZcJt/kGLPLjkBnZiJ8HV9Pl19dTwIJNXh9ZR7ItgXGT2OOKuja7cR2UXZums1Lj0D0m
         NpnF/LawIe6bx22Ybwebg1w2fXCgKbcOve5nDgpS7NNOjO6UvybuY6kETkGcZg1233xT
         vG6wQmkRZgI6ulaW4y7LWA2Q1RfVd7otpWUQ+GRg6MdAlIyIloJRmfUm5qiaOA1JiWbT
         AIXA==
X-Gm-Message-State: AOJu0YwNOB56BFuRQzviSdwF5vE04h88iupgPNMccMW01/XiVeMTfTlA
	6UosVJd7RpbcDSPvMwD7/09OxjdHx1bkkATcCWqyeIowqeRmnSVKh+D1SB1zos1HzUyqxaXNILL
	FcIbNmM17L6QmXSe+mOejTIeBmpD+buk0
X-Google-Smtp-Source: AGHT+IFEZFpXBnI02Mx3pbay227uPlHWKjJWx6kgV9/9j/v1Xl9hN9Qmq5rYyEHZBOGsDjWBOTZUBcHfWDRp7PaCQSs=
X-Received: by 2002:a05:651c:209:b0:2d2:d0ba:2590 with SMTP id
 y9-20020a05651c020900b002d2d0ba2590mr6163850ljn.7.1709563403653; Mon, 04 Mar
 2024 06:43:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709409039.git.pav@iki.fi>
In-Reply-To: <cover.1709409039.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Mar 2024 09:43:11 -0500
Message-ID: <CABBYNZKssv0WrSn_qDTgWXEmCvkKWZ8J+JwyrW4cdt2kdtHKug@mail.gmail.com>
Subject: Re: [PATCH BlueZ 0/3] tests: add TX timestamping tests
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 2, 2024 at 3:10=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add tests for ISO and L2CAP TX timestamping
>
> Pauli Virtanen (3):
>   lib: add BT_SCM_ERROR sock_extended_err CMSG
>   iso-tester: Add tests for TX timestamping
>   l2cap-tester: Add test for TX timestamping

Same thing as for missing SCO_LINK handing in the kernel, we probably
want to do the same for sco-tester.

>  lib/bluetooth.h      |   1 +
>  tools/iso-tester.c   | 169 ++++++++++++++++++++++++++++++++++++++++---
>  tools/l2cap-tester.c | 106 +++++++++++++++++++++++++--
>  tools/tester-utils.h | 163 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 424 insertions(+), 15 deletions(-)
>  create mode 100644 tools/tester-utils.h
>
> --
> 2.44.0
>
>


--=20
Luiz Augusto von Dentz
