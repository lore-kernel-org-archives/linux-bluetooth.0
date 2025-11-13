Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D274342C92
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055644; cv=none; b=ZI4LGRggEQMlxshqG1ebEqkVV6QO7f/0tLbjUeKr/H4hjdkpKVoEKPfikiIiOFP4UpgONdmmL8AcIX20GcG4qreEavRQd66z9Rj5r3F+7qbSNnQ3C2AcjNGJ9nq9rJE5m5Dyg7PABSXIBHHvi376HIW1QReLqwwypWQWKGzEz04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055644; c=relaxed/simple;
	bh=iQ9LvHFP274jiS2uNBDNRBSa4dW3JPUxEH2NI9m3RnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK9CaSWIHXy7aLq/W2AbCDGYdFZs0CgVLQMIe/ze25sYTXz9lguVT/Ch0z9l21tvURIVQ220cOrPlZlpEbGYunl6XIBrQ59Zp20TFEXZpOqWBbDpI7T/pM1udRossGvIb50kIvWx5xztexN1AHP1W2jMr2bnUUzky9nksffyUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB+LvSP9; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB+LvSP9"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-37b99da107cso10475861fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763055639; x=1763660439; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLf0UmkAisqKxup9iPcfwDG2hAbqZCy1ksQZffpggck=;
        b=kB+LvSP91SKJdX5aIe88FK6RGSupdpZkv6a2cVYscJ8TnO2MXm8RJXB/+PPk8kQQCC
         WeYQafnNSg+zrRpgvhkSXVQ4a+hDZa7QgojhZ07vTUQB2B3nqJsdmNhr619OpIBIaqJ7
         58lbuK8+klZWw4JCua6yQkPFNEludFXCiB0IZh8Fju8qgnZ3Cj5+7Ky7H9Mvg3KvgFdO
         ZtG8fN7wCh79MBrMxYS5eAPoeyMtWEa9lgqnRbRrmhgT+pMeGN1lgM7Opn+atmgXvzDk
         Q23jporN8h7MrYI/4vsC9hUq5KRCBI8I2yLNQFEu/QozA7swYqP8thEnVRLJM+tk7Z8p
         jWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763055639; x=1763660439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLf0UmkAisqKxup9iPcfwDG2hAbqZCy1ksQZffpggck=;
        b=RW+rNzb6gJuhUqNF2WR0qxPtfofUb1DhuBpNmxvnxnsFdUqhS3UXDFQIwjZ1mEzZW5
         ww1Y6kOq8KtDGBp7XlzV9CCuq4ltUChhg21jFn19prt8otp0s4j1sp6N487cU1Wp8C2H
         5IFSDCHIkuXl9d5NHJ4npmCR3xdRXuh3MlRLWlAJVf+vUUxL7gsQQ+Uh7OoodvksFNu0
         AxVXG7wemxzvxR2cvC9uQxcST/YvjqBCKnfUydHHjLQloV9dP9j95RYFgzSHBNiLzpZf
         Pg2Cz4wn8lyi1l279DAeqlOZDffJoe6agTojj8ZBWJvWy3u69ve6epD0Fe79fXlkgV5Y
         sJjQ==
X-Gm-Message-State: AOJu0YxGBeHp9tX2DyjtCl26vcviXbfoB6KY1GRcL03ojXF7YOqJvHVD
	eVbKSziZBKjle9x5bt56nLKG+dNy974ildjTvPFYVUrKCsNXhj2Vax/Nk9LzSjc77m6BSK7IgBj
	9rfLeYDU5s4GkmZ8t7odXdWMF0HDCF22yBw==
X-Gm-Gg: ASbGnctZT7m458tI8nWlMfWITGXFBPxBrYLoAw6JluLAVwarpghQ8C3X1G2uAs46Ibv
	jLIWoQQTxuZdGUykAHyhbwRqWSrus05geTa0qcz/Ddh50NFz1bNntEC01Rl46nrhOXR9pQnK1Ft
	qQGrW7/RMlXPhZQjo2lROB/7lJUu2i16sNzmAvOImi7UoAX6wLkYJxmUxam3wYZwCEJ1IXArEIu
	RO5CihU5ilwuIbdqnc9MagzxTOyMXSKeueoXY7r7fmzvzeSA3vs6g9JZljxsxW8yapULA==
X-Google-Smtp-Source: AGHT+IH7/jGYVGfWxJ6lCd11WFNKCWwmfCWja26PpfXkbCxve5Y1JRj0uswXGw855nKXiPCOtPqO4CB4jG2y0m704rw=
X-Received: by 2002:a05:651c:4185:b0:37a:832f:509 with SMTP id
 38308e7fff4ca-37b8c2f5b14mr20066331fa.1.1763055638951; Thu, 13 Nov 2025
 09:40:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763052876.git.pav@iki.fi>
 <55f2fbe7c18f8c6b04bf8b4af161ceee3ac825c4.1763052876.git.pav@iki.fi>
In-Reply-To: <55f2fbe7c18f8c6b04bf8b4af161ceee3ac825c4.1763052876.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 13 Nov 2025 12:40:25 -0500
X-Gm-Features: AWmQ_bkiGzp6DS_SyPvdUzC3Tzgu2JNitxt2p52lmMu4Olg0N9M1LBWHh_c0VDo
Message-ID: <CABBYNZ+CuoWiwqxSbDYGzjkWRrXQwtGBJXSkpLNnibevC7_ydg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 3/4] test-bap: add tests for bt_bap_select()
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Nov 13, 2025 at 12:20=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Add basic tests for bt_bap_select(), for configurations in BAP.TS. 4.10.
>
> UCL Select LC3 AC 1 (0a)
> UCL Select LC3 AC 1 (0b)
> UCL Select LC3 AC 1 (0c)
> UCL Select LC3 AC 1 (0d)
> UCL Select LC3 AC 1 (1)
> UCL Select LC3 AC 1 (1a)
> UCL Select LC3 AC 1 (1b)
> UCL Select LC3 AC 1 (1c)
> UCL Select LC3 AC 4 (2)
> UCL Select LC3 AC 4 (2a)
> UCL Select LC3 AC 4 (2b)
> UCL Select LC3 AC 4 (2c)
> UCL Select LC3 AC 2 (0a)
> UCL Select LC3 AC 2 (0b)
> UCL Select LC3 AC 2 (0c)
> UCL Select LC3 AC 2 (0d)
> UCL Select LC3 AC 2 (1)
> UCL Select LC3 AC 2 (1a)
> UCL Select LC3 AC 2 (1b)
> UCL Select LC3 AC 2 (1c)
> UCL Select LC3 AC 10 (2)
> UCL Select LC3 AC 10 (2a)
> UCL Select LC3 AC 10 (2b)
> UCL Select LC3 AC 10 (2c)
> UCL Select LC3 AC 3
> UCL Select LC3 AC 5
> UCL Select LC3 AC 7i
> UCL Select VS AC 7i
> UCL Select LC3 AC 6i
> UCL Select LC3 AC 6ii L
> UCL Select LC3 AC 6ii R
> UCL Select LC3 AC 9i
> UCL Select LC3 AC 9ii L
> UCL Select LC3 AC 9ii R
> UCL Select LC3 AC 8i
> UCL Select LC3 AC 8ii L
> UCL Select LC3 AC 8ii R
> UCL Select LC3 AC 11i
> UCL Select LC3 AC 11ii L
> UCL Select LC3 AC 11ii R
> UCL Select LC3 Many 2
> UCL Select LC3 Many 8

These are not the names used by the test specification though, so I
wonder what is the thought process here? We probably want something
like:

Test Case ID | ASE Type| Audio Channels/ Locations per ASE | CIS Establishm=
ent
BAP/UCL/STR/BV-535-C [UCL, AC 2,Generic] | Source ASE | 1 | Enable
...

So it reflects exactly what the test specs expect for each test case
ID, if you still think there are combinations not covered by these
then we can perhaps custom test case ID to cover those, but I'd only
consider that once we are done with the tests above.


> ---
>
> Notes:
>     v2:
>     - fix checking stream counts
>     - fix VS test
>     - fail tests with tester_test_failed() instead of g_assert()
>
>  unit/test-bap.c | 753 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 748 insertions(+), 5 deletions(-)
>
> diff --git a/unit/test-bap.c b/unit/test-bap.c
> index b1d1a42f1..6af6c3871 100644
> --- a/unit/test-bap.c
> +++ b/unit/test-bap.c
> @@ -44,6 +44,12 @@ struct test_config {
>         uint8_t state;
>         bt_bap_state_func_t state_func;
>         uint8_t streams;
> +       uint32_t snk_locations[4];
> +       uint32_t src_locations[4];
> +       struct bt_bap_pac_qos *pac_qos;
> +       struct iovec *pac_caps;
> +       const struct iovec *setup_data;
> +       size_t setup_data_len;
>  };
>
>  struct test_data {
> @@ -105,6 +111,10 @@ static struct bt_bap_pac_qos lc3_qos =3D {
>                 data.caps =3D &lc3_caps;                          \
>                 data.qos =3D &lc3_qos;                            \
>                 data.cfg =3D _cfg;                                \
> +               if (data.cfg && data.cfg->pac_caps)             \
> +                       data.caps =3D data.cfg->pac_caps;         \
> +               if (data.cfg && data.cfg->pac_qos)              \
> +                       data.qos =3D data.cfg->pac_qos;           \
>                 data.iovcnt =3D ARRAY_SIZE(iov_data(args));       \
>                 data.iov =3D util_iov_dup(iov, ARRAY_SIZE(iov_data(args))=
); \
>                 data.streams =3D queue_new(); \
> @@ -325,6 +335,185 @@ static const struct iovec setup_data[] =3D {
>         IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
>  };
>
> +static const struct iovec setup_data_no_location[] =3D {
> +       /* ATT: Exchange MTU Response (0x03) len 2
> +        *   Server RX MTU: 64
> +        */
> +       IOV_DATA(0x02, 0x40, 0x00),
> +       /* ATT: Exchange MTU Request (0x02) len 2
> +        *    Client RX MTU: 64
> +        */
> +       IOV_DATA(0x03, 0x40, 0x00),
> +       /* ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute type: Server Supported Features (0x2b3a)
> +        */
> +       IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x3a, 0x2b),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Type Request (0x08)
> +        *   Handle: 0x0001
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
> +       /*
> +        * ATT: Read By Group Type Request (0x10) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute group type: Primary Service (0x2800)
> +        */
> +       IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
> +       /*
> +        * ATT: Read By Group Type Response (0x11) len 37
> +        *   Attribute data length: 6
> +        *   Attribute group list: 2 entries
> +        *   Handle range: 0x0001-0x0013
> +        *   UUID: Published Audio Capabilities (0x1850)
> +        *   Handle range: 0x0014-0x0023
> +        *   UUID: Audio Stream Control (0x184e)
> +        */
> +       IOV_DATA(0x11, 0x06,
> +               0x01, 0x00, 0x13, 0x00, 0x50, 0x18,
> +               0x14, 0x00, 0x23, 0x00, 0x4e, 0x18),
> +       /* ATT: Read By Group Type Request (0x10) len 6
> +        *   Handle range: 0x0024-0xffff
> +        *   Attribute group type: Primary Service (0x2800)
> +        */
> +       IOV_DATA(0x10, 0x24, 0x00, 0xff, 0xff, 0x00, 0x28),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Group Type Request (0x10)
> +        *   Handle: 0x0024
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x10, 0x24, 0x00, 0x0a),
> +       /* ATT: Read By Group Type Request (0x10) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute group type: Secondary Service (0x2801)
> +        */
> +       IOV_DATA(0x10, 0x01, 0x00, 0xff, 0xff, 0x01, 0x28),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Group Type Request (0x10)
> +        *   Handle: 0x0001
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x10, 0x01, 0x00, 0x0a),
> +       /* ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0001-0x0023
> +        *   Attribute group type: Include (0x2802)
> +        */
> +       IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x02, 0x28),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Group Type Request (0x10)
> +        *   Handle: 0x0001
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
> +       /* ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0001-0x0023
> +        *   Attribute type: Characteristic (0x2803)
> +        */
> +       IOV_DATA(0x08, 0x01, 0x00, 0x23, 0x00, 0x03, 0x28),
> +       /* ATT: Read By Type Response (0x09) len 57
> +        * Attribute data length: 7
> +        * Attribute data list: 8 entries
> +        *   Handle: 0x0002
> +        *   Value: 120300c92b
> +        *   Properties: 0x12
> +        *     Read (0x02)
> +        *     Notify (0x10)
> +        *   Value Handle: 0x0003
> +        *   Value UUID: Sink PAC (0x2bc9)
> +        *   Handle: 0x0008
> +        *   Value: 120900cb2b
> +        *   Properties: 0x12
> +        *     Read (0x02)
> +        *     Notify (0x10)
> +        *   Value Handle: 0x0009
> +        *   Value UUID: Source PAC (0x2bcb)
> +        *  Handle: 0x000e
> +        *  Value: 120f00cd2b
> +        *  Properties: 0x12
> +        *    Read (0x02)
> +        *    Notify (0x10)
> +        *  Value Handle: 0x000f
> +        *  Value UUID: Available Audio Contexts (0x2bcd)
> +        *  Handle: 0x0011
> +        *  Value: 121200ce2b
> +        *  Properties: 0x12
> +        *    Read (0x02)
> +        *    Notify (0x10)
> +        *  Value Handle: 0x0012
> +        *  Value UUID: Supported Audio Contexts (0x2bce)
> +        *  Handle: 0x0015
> +        *  Value: 121600c42b
> +        *  Properties: 0x12
> +        *    Read (0x02)
> +        *    Notify (0x10)
> +        *  Value Handle: 0x0016
> +        *  Value UUID: Sink ASE (0x2bc4)
> +        *   Handle: 0x001b
> +        *   Value: 121c00c52b
> +        *   Properties: 0x12
> +        *     Read (0x02)
> +        *     Notify (0x10)
> +        *   Value Handle: 0x001c
> +        *   Value UUID: Source ASE (0x2bc5)
> +        *   Handle: 0x0021
> +        *   Value: 182200c62b
> +        *   Properties: 0x18
> +        *     Write (0x08)
> +        *     Notify (0x10)
> +        *   Value Handle: 0x0022
> +        *   Value UUID: ASE Control Point (0x2bc6)
> +        */
> +       IOV_DATA(0x09, 0x07,
> +               /* keep same IDs as above, leaving holes */
> +               0x02, 0x00, 0x12, 0x03, 0x00, 0xc9, 0x2b,
> +               0x08, 0x00, 0x12, 0x09, 0x00, 0xcb, 0x2b,
> +               0x0e, 0x00, 0x12, 0x0f, 0x00, 0xcd, 0x2b,
> +               0x11, 0x00, 0x12, 0x12, 0x00, 0xce, 0x2b,
> +               0x15, 0x00, 0x12, 0x16, 0x00, 0xc4, 0x2b,
> +               0x1b, 0x00, 0x12, 0x1c, 0x00, 0xc5, 0x2b,
> +               0x21, 0x00, 0x18, 0x22, 0x00, 0xc6, 0x2b),
> +       /* ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0022-0x0023
> +        *   Attribute type: Characteristic (0x2803)
> +        */
> +       IOV_DATA(0x08, 0x22, 0x00, 0x23, 0x00, 0x03, 0x28),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Type Request (0x08)
> +        *   Handle: 0x0022
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x08, 0x22, 0x00, 0x0a),
> +       /* ATT: Find Information Request (0x04) */
> +       IOV_DATA(0x04, 0x04, 0x00, 0x07, 0x00),
> +       /* ATT: Error Response */
> +       IOV_DATA(0x01, 0x04, 0x04, 0x00, 0x0a),
> +       /* ATT: Find Information Request (0x04) */
> +       IOV_DATA(0x04, 0x0a, 0x00, 0x0d, 0x00),
> +       /* ATT: Error Response */
> +       IOV_DATA(0x01, 0x04, 0x0a, 0x00, 0x0a),
> +       /* ATT: Find Information Request (0x04) */
> +       IOV_DATA(0x04, 0x17, 0x00, 0x1a, 0x00),
> +       /* ATT: Error Response */
> +       IOV_DATA(0x01, 0x04, 0x17, 0x00, 0x0a),
> +       /* ATT: Find Information Request (0x04) */
> +       IOV_DATA(0x04, 0x1d, 0x00, 0x20, 0x00),
> +       /* ATT: Error Response */
> +       IOV_DATA(0x01, 0x04, 0x1d, 0x00, 0x0a),
> +       /* ACL Data TX: Handle 42 flags 0x00 dlen 11
> +        *   ATT: Read By Type Request (0x08) len 6
> +        *   Handle range: 0x0001-0xffff
> +        *   Attribute type: Database Hash (0x2b2a)
> +        */
> +       IOV_DATA(0x08, 0x01, 0x00, 0xff, 0xff, 0x2a, 0x2b),
> +       /* ATT: Error Response (0x01) len 4
> +        *   Read By Type Request (0x08)
> +        *   Handle: 0x0001
> +        *   Error: Attribute Not Found (0x0a)
> +        */
> +       IOV_DATA(0x01, 0x08, 0x01, 0x00, 0x0a),
> +};
> +
>  static void print_debug(const char *str, void *user_data)
>  {
>         const char *prefix =3D user_data;
> @@ -340,7 +529,11 @@ static void test_setup(const void *user_data)
>         struct gatt_db *db;
>         struct io *io;
>
> -       io =3D tester_setup_io(setup_data, ARRAY_SIZE(setup_data));
> +       if (!data->cfg || !data->cfg->setup_data)
> +               io =3D tester_setup_io(setup_data, ARRAY_SIZE(setup_data)=
);
> +       else
> +               io =3D tester_setup_io(data->cfg->setup_data,
> +                                               data->cfg->setup_data_len=
);
>         g_assert(io);
>
>         att =3D bt_att_new(io_get_fd(io), false);
> @@ -454,11 +647,13 @@ static void test_setup_pacs(struct test_data *data)
>                                                         "test-bap-snk",
>                                                         BT_BAP_SINK, 0x0f=
f,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       data->qos, data->=
caps,
> +                                                       NULL);
>                 else
>                         data->snk =3D bt_bap_add_pac(data->db, "test-bap-=
snk",
>                                                         BT_BAP_SINK, LC3_=
ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       data->qos, data->=
caps,
> +                                                       NULL);
>                 g_assert(data->snk);
>         }
>
> @@ -468,11 +663,13 @@ static void test_setup_pacs(struct test_data *data)
>                                                         "test-bap-src",
>                                                         BT_BAP_SOURCE, 0x=
0ff,
>                                                         0x0001, 0x0001,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       data->qos, data->=
caps,
> +                                                       NULL);
>                 else
>                         data->src =3D bt_bap_add_pac(data->db, "test-bap-=
src",
>                                                         BT_BAP_SOURCE, LC=
3_ID,
> -                                                       NULL, data->caps,=
 NULL);
> +                                                       data->qos, data->=
caps,
> +                                                       NULL);
>                 g_assert(data->src);
>         }
>  }
> @@ -8686,6 +8883,551 @@ static void test_bsrc_str(void)
>         test_bsrc_str_2b();
>  }
>
> +/*
> + * Configuration selection: check example cases for BAP AC.
> + */
> +
> +#define LC3_PAC_CAPS_NO_COUNT \
> +       0x06, 0x00, 0x00, 0x00, 0x00, 0x0d, 0x03, 0x01, \
> +       0xff, 0x00, 0x02, 0x02, 0x03, 0x05, 0x04, \
> +       0x1a, 0x00, 0xf0, 0x00, 0x00
> +
> +#define UNKNOWN_PAC_CAPS \
> +       0xff, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00
> +
> +/* BAP.TS 4.10.1 configurations */
> +#define DISC_SELECT_SNK(loc, caps) \
> +       DISC_SRC_ASE(loc, 0, IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
> +
> +#define DISC_SELECT_SNK_NO_LOC(caps) \
> +       DISC_SRC_ASE_NO_LOCATION(IOV_CONTENT(caps), UNKNOWN_PAC_CAPS)
> +
> +#define DISC_SELECT_SRC(loc, caps) \
> +       DISC_SRC_ASE(0, loc, UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
> +
> +#define DISC_SELECT_SRC_NO_LOC(caps) \
> +       DISC_SRC_ASE_NO_LOCATION(UNKNOWN_PAC_CAPS, IOV_CONTENT(caps))
> +
> +#define DISC_SELECT_LC3_AC1_0a DISC_SELECT_SNK(0, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC1_0b DISC_SELECT_SNK(0, LC3_PAC_CAPS_NO_COUNT)
> +#define DISC_SELECT_LC3_AC1_0c DISC_SELECT_SNK_NO_LOC(LC3_PAC_CAPS(0x01)=
)
> +#define DISC_SELECT_LC3_AC1_0d DISC_SELECT_SNK_NO_LOC(LC3_PAC_CAPS_NO_CO=
UNT)
> +
> +#define DISC_SELECT_LC3_AC1_1  DISC_SELECT_SNK(0x2, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC1_1a DISC_SELECT_SNK(0x2, LC3_PAC_CAPS(0x03))
> +#define DISC_SELECT_LC3_AC1_1b DISC_SELECT_SNK(0x22, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC1_1c DISC_SELECT_SNK(0x22, LC3_PAC_CAPS(0x03))
> +
> +#define DISC_SELECT_LC3_AC4_2  DISC_SELECT_SNK(0x44, LC3_PAC_CAPS(0x02))
> +#define DISC_SELECT_LC3_AC4_2a DISC_SELECT_SNK(0x44, LC3_PAC_CAPS(0x03))
> +#define DISC_SELECT_LC3_AC4_2b DISC_SELECT_SNK(0x444, LC3_PAC_CAPS(0x02)=
)
> +#define DISC_SELECT_LC3_AC4_2c DISC_SELECT_SNK(0x444, LC3_PAC_CAPS(0x03)=
)
> +
> +#define DISC_SELECT_LC3_AC2_0a DISC_SELECT_SRC(0, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC2_0b DISC_SELECT_SRC(0, LC3_PAC_CAPS_NO_COUNT)
> +#define DISC_SELECT_LC3_AC2_0c DISC_SELECT_SRC_NO_LOC(LC3_PAC_CAPS(0x01)=
)
> +#define DISC_SELECT_LC3_AC2_0d DISC_SELECT_SRC_NO_LOC(LC3_PAC_CAPS_NO_CO=
UNT)
> +
> +#define DISC_SELECT_LC3_AC2_1  DISC_SELECT_SRC(0x2, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC2_1a DISC_SELECT_SRC(0x2, LC3_PAC_CAPS(0x03))
> +#define DISC_SELECT_LC3_AC2_1b DISC_SELECT_SRC(0x22, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_LC3_AC2_1c DISC_SELECT_SRC(0x22, LC3_PAC_CAPS(0x03))
> +
> +#define DISC_SELECT_LC3_AC10_2 DISC_SELECT_SRC(0x44, LC3_PAC_CAPS(0x02))
> +#define DISC_SELECT_LC3_AC10_2a        DISC_SELECT_SRC(0x44, LC3_PAC_CAP=
S(0x03))
> +#define DISC_SELECT_LC3_AC10_2b        DISC_SELECT_SRC(0x444, LC3_PAC_CA=
PS(0x02))
> +#define DISC_SELECT_LC3_AC10_2c        DISC_SELECT_SRC(0x444, LC3_PAC_CA=
PS(0x03))
> +
> +/* BAP.TS 4.10.2 configurations */
> +#define DISC_SELECT_VS_AC1_1   DISC_SELECT_SNK(0x2, VS_PAC_CAPS_NO_COUNT=
)
> +#define DISC_SELECT_VS_AC1_2   DISC_SELECT_SNK(0x44, VS_PAC_CAPS(0x01))
> +#define DISC_SELECT_VS_AC2_1   DISC_SELECT_SRC(0x2, VS_PAC_CAPS_NO_COUNT=
)
> +#define DISC_SELECT_VS_AC2_2   DISC_SELECT_SRC(0x44, VS_PAC_CAPS(0x01))
> +
> +/* BAP.TS 4.10.3 configurations
> + * Assumed Channels/Locations applies only to Sink ASE, as it's supposed
> + * to test AC 3, 5, 7(i)
> + */
> +#define DISC_SELECT_LC3_AC3    DISC_SRC_ASE(0x1, 0x1, LC3_PAC_CAPS(0x01)=
, \
> +                                                       LC3_PAC_CAPS(0x01=
))
> +#define DISC_SELECT_LC3_AC5    DISC_SRC_ASE(0x22, 0x2, LC3_PAC_CAPS(0x02=
), \
> +                                                       LC3_PAC_CAPS(0x01=
))
> +#define DISC_SELECT_LC3_AC7i   DISC_SRC_ASE(0x4, 0x4, LC3_PAC_CAPS(0x01)=
, \
> +                                                       LC3_PAC_CAPS(0x01=
))
> +
> +/* BAP.TS 4.10.4 configurations */
> +#define DISC_SELECT_VS_AC3     DISC_SRC_ASE(0x1, 0x1, VS_PAC_CAPS(0x01),=
 \
> +                                                       VS_PAC_CAPS(0x01)=
)
> +#define DISC_SELECT_VS_AC5     DISC_SRC_ASE(0x22, 0x2, VS_PAC_CAPS(0x02)=
, \
> +                                                       VS_PAC_CAPS(0x01)=
)
> +#define DISC_SELECT_VS_AC7i    DISC_SRC_ASE(0x4, 0x4, VS_PAC_CAPS(0x01),=
 \
> +                                                       VS_PAC_CAPS(0x01)=
)
> +
> +/* BAP.TS 4.10.5 configurations */
> +#define DISC_SELECT_LC3_AC7ii_L        DISC_SELECT_SNK(0x01, LC3_PAC_CAP=
S(0x01))
> +#define DISC_SELECT_LC3_AC7ii_R        DISC_SELECT_SRC(0x10, LC3_PAC_CAP=
S(0x01))
> +
> +/* BAP.TS 4.10.6 configurations */
> +#define DISC_SELECT_LC3_AC6i   DISC_SELECT_SNK(0x11, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_VS_AC6i    DISC_SELECT_SNK(0x11, VS_PAC_CAPS(0x01))
> +
> +/* BAP.TS 4.10.7 configurations */
> +#define DISC_SELECT_LC3_AC6ii_L        DISC_SELECT_SNK(0x01, LC3_PAC_CAP=
S(0x01))
> +#define DISC_SELECT_LC3_AC6ii_R        DISC_SELECT_SNK(0x10, LC3_PAC_CAP=
S(0x01))
> +#define DISC_SELECT_VS_AC6ii_L DISC_SELECT_SNK(0x01, VS_PAC_CAPS(0x01))
> +#define DISC_SELECT_VS_AC6ii_R DISC_SELECT_SNK(0x10, VS_PAC_CAPS(0x01))
> +
> +/* BAP.TS 4.10.8 configurations */
> +#define DISC_SELECT_LC3_AC9i   DISC_SELECT_SRC(0x11, LC3_PAC_CAPS(0x01))
> +#define DISC_SELECT_VS_AC9i    DISC_SELECT_SRC(0x11, VS_PAC_CAPS(0x01))
> +
> +/* BAP.TS 4.10.9 configurations */
> +#define DISC_SELECT_LC3_AC9ii_L DISC_SELECT_SRC(0x01, LC3_PAC_CAPS(0x01)=
)
> +#define DISC_SELECT_LC3_AC9ii_R        DISC_SELECT_SRC(0x10, LC3_PAC_CAP=
S(0x01))
> +
> +/* BAP.TS 4.10.10 configurations */
> +#define DISC_SELECT_LC3_AC8i   DISC_SRC_ASE(0x11, 0x02, \
> +                                       LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(=
0x01))
> +
> +/* BAP.TS 4.10.11 configurations */
> +#define DISC_SELECT_LC3_AC8ii_L        DISC_SELECT_SNK(0x1, LC3_PAC_CAPS=
(0x01))
> +#define DISC_SELECT_LC3_AC8ii_R        DISC_SRC_ASE(0x10, 0x2, \
> +                                       LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(=
0x01))
> +
> +/* BAP.TS 4.10.12 configurations */
> +#define DISC_SELECT_LC3_AC11i  DISC_SRC_ASE(0x11, 0x22, \
> +                                       LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(=
0x01))
> +
> +/* BAP.TS 4.10.13 configurations */
> +#define DISC_SELECT_LC3_AC11ii_L DISC_SRC_ASE(0x01, 0x02, \
> +                                       LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(=
0x01))
> +#define DISC_SELECT_LC3_AC11ii_R DISC_SRC_ASE(0x10, 0x20, \
> +                                       LC3_PAC_CAPS(0x01), LC3_PAC_CAPS(=
0x01))
> +#define DISC_SELECT_VS_AC11i_L DISC_SRC_ASE(0x01, 0x02, \
> +                                       VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x=
01))
> +#define DISC_SELECT_VS_AC11i_R DISC_SRC_ASE(0x10, 0x20, \
> +                                       VS_PAC_CAPS(0x01), VS_PAC_CAPS(0x=
01))
> +
> +/* Expected bt_bap_select() results */
> +
> +static struct test_config cfg_select_ac1_0ab =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac1_0cd =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0, -1 },
> +       .src_locations =3D { -1 },
> +       .setup_data =3D setup_data_no_location,
> +       .setup_data_len =3D ARRAY_SIZE(setup_data_no_location),
> +};
> +
> +static struct test_config cfg_select_ac1_1 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .streams =3D 1,  /* force 1 channel; caps support also AC 4 & 6(i=
) */
> +       .snk_locations =3D { 0x2, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac4_2 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x44, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac2_0ab =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0, -1 },
> +};
> +
> +static struct test_config cfg_select_ac2_0cd =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0, -1 },
> +       .setup_data =3D setup_data_no_location,
> +       .setup_data_len =3D ARRAY_SIZE(setup_data_no_location),
> +};
> +
> +static struct test_config cfg_select_ac2_1 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .streams =3D 1,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0x2, -1 },
> +};
> +
> +static struct test_config cfg_select_ac10_2 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0x44, -1 },
> +};
> +
> +static struct test_config cfg_select_ac3 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, -1 },
> +       .src_locations =3D { 0x1, -1 },
> +};
> +
> +static struct test_config cfg_select_ac5 =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x22, -1 },
> +       .src_locations =3D { 0x2, -1 },
> +};
> +
> +static struct test_config cfg_select_ac7i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x4, -1 },
> +       .src_locations =3D { 0x4, -1 },
> +};
> +
> +static struct test_config cfg_select_vs_ac7i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x4, -1 },
> +       .src_locations =3D { 0x4, -1 },
> +       .vs =3D true,
> +};
> +
> +static struct test_config cfg_select_ac6i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, 0x10, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac6ii_L =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac6ii_R =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x10, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac9i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0x1, 0x10, -1 },
> +};
> +
> +static struct test_config cfg_select_ac9ii_L =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0x1, -1 },
> +};
> +
> +static struct test_config cfg_select_ac9ii_R =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { -1 },
> +       .src_locations =3D { 0x10, -1 },
> +};
> +
> +static struct test_config cfg_select_ac8i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, 0x10, -1 },
> +       .src_locations =3D { 0x2, -1 },
> +};
> +
> +static struct test_config cfg_select_ac8ii_L =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, -1 },
> +       .src_locations =3D { -1 },
> +};
> +
> +static struct test_config cfg_select_ac8ii_R =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x10, -1 },
> +       .src_locations =3D { 0x2, -1 },
> +};
> +
> +static struct test_config cfg_select_ac11i =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, 0x10, -1 },
> +       .src_locations =3D { 0x2, 0x20, -1 },
> +};
> +
> +static struct test_config cfg_select_ac11ii_L =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x1, -1 },
> +       .src_locations =3D { 0x2, -1 },
> +};
> +
> +static struct test_config cfg_select_ac11ii_R =3D {
> +       .snk =3D true,
> +       .src =3D true,
> +       .snk_locations =3D { 0x10, -1 },
> +       .src_locations =3D { 0x20, -1 },
> +};
> +
> +/* Additional bt_bap_select() tests */
> +
> +#define DISC_SELECT_MANY \
> +       DISC_SRC_ASE(0x000000ff, 0, LC3_PAC_CAPS(0xf), UNKNOWN_PAC_CAPS)
> +
> +static struct iovec caps_select_snk_many =3D
> +       LC3_CAPABILITIES(LC3_FREQ_ANY, LC3_DURATION_ANY, 0x0a, 26, 240);
> +
> +static struct test_config cfg_select_many_2 =3D {
> +       .snk =3D true,
> +       .snk_locations =3D { 0x00000003, -1 },
> +       .src_locations =3D { -1 },
> +       .pac_caps =3D &caps_select_snk_many,
> +};
> +
> +static struct test_config cfg_select_many_8 =3D {
> +       .snk =3D true,
> +       .streams =3D 8,
> +       .snk_locations =3D { 0x0000000f, 0x000000f0, -1 },
> +       .src_locations =3D { -1 },
> +       .pac_caps =3D &caps_select_snk_many,
> +};
> +
> +struct test_select_data {
> +       struct test_data *data;
> +       unsigned int num_src;
> +       unsigned int num_snk;
> +       uint32_t src_locations[4];
> +       uint32_t snk_locations[4];
> +};
> +
> +static bool test_select_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *=
rpac,
> +                                                               void *use=
r_data)
> +{
> +       struct test_select_data *sdata =3D user_data;
> +       struct test_config *cfg =3D sdata->data->cfg;
> +       int err, count =3D 0;
> +
> +       err =3D bt_bap_select(sdata->data->bap, lpac, rpac, cfg->streams,=
 &count,
> +                                                       (void *)0x1, sdat=
a);
> +       if (err)
> +               tester_test_failed();
> +
> +       return false;
> +}
> +
> +static void bap_select_ready(struct bt_bap *bap, void *user_data)
> +{
> +       struct test_select_data sdata =3D {
> +               .data =3D (void *)user_data,
> +       };
> +       struct test_config *cfg =3D sdata.data->cfg;
> +       unsigned int i;
> +
> +       bt_bap_foreach_pac(bap, BT_BAP_SINK, test_select_pac, &sdata);
> +       bt_bap_foreach_pac(bap, BT_BAP_SOURCE, test_select_pac, &sdata);
> +
> +       for (i =3D 0; i < sdata.num_snk; ++i)
> +               if (sdata.snk_locations[i] !=3D cfg->snk_locations[i])
> +                       goto fail;
> +       if (i < ARRAY_SIZE(cfg->snk_locations) &&
> +                       cfg->snk_locations[i] !=3D (uint32_t)-1)
> +               goto fail;
> +
> +       for (i =3D 0; i < sdata.num_src; ++i)
> +               if (sdata.src_locations[i] !=3D cfg->src_locations[i])
> +                       goto fail;
> +       if (i < ARRAY_SIZE(cfg->src_locations) &&
> +                       cfg->src_locations[i] !=3D (uint32_t)-1)
> +               goto fail;
> +
> +       tester_test_passed();
> +       return;
> +
> +fail:
> +       tester_test_failed();
> +}
> +
> +static int pac_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
> +                       uint32_t location, struct bt_bap_pac_qos *qos,
> +                       bt_bap_pac_select_t cb, void *cb_data, void *user=
_data)
> +{
> +       struct test_select_data *sdata =3D cb_data;
> +
> +       if (bt_bap_pac_get_type(rpac) =3D=3D BT_BAP_SINK) {
> +               if (sdata->num_snk >=3D ARRAY_SIZE(sdata->snk_locations))
> +                       goto fail;
> +               tester_debug("select SNK 0x%08x", location);
> +               sdata->snk_locations[sdata->num_snk++] =3D location;
> +       } else {
> +               if (sdata->num_src >=3D ARRAY_SIZE(sdata->src_locations))
> +                       goto fail;
> +               tester_debug("select SRC 0x%08x", location);
> +               sdata->src_locations[sdata->num_src++] =3D location;
> +       }
> +
> +       return 0;
> +
> +fail:
> +       tester_test_failed();
> +       return 0;
> +}
> +
> +static struct bt_bap_pac_ops test_select_pac_ops =3D {
> +       .select =3D pac_select,
> +};
> +
> +static void test_select(const void *user_data)
> +{
> +       struct test_data *data =3D (void *)user_data;
> +       struct io *io;
> +
> +       io =3D tester_setup_io(data->iov, data->iovcnt);
> +       g_assert(io);
> +
> +       tester_io_set_complete_func(NULL);
> +
> +       data->db =3D gatt_db_new();
> +       g_assert(data->db);
> +
> +       test_setup_pacs(data);
> +
> +       if (data->snk)
> +               bt_bap_pac_set_ops(data->snk, &test_select_pac_ops, NULL)=
;
> +       if (data->src)
> +               bt_bap_pac_set_ops(data->src, &test_select_pac_ops, NULL)=
;
> +
> +       data->bap =3D bt_bap_new(data->db, bt_gatt_client_get_db(data->cl=
ient));
> +       g_assert(data->bap);
> +
> +       bt_bap_set_debug(data->bap, print_debug, "bt_bap:", NULL);
> +
> +       bt_bap_ready_register(data->bap, bap_select_ready, data, NULL);
> +
> +       bt_bap_attach(data->bap, data->client);
> +}
> +
> +static void test_ucl_select(void)
> +{
> +       define_test("UCL Select LC3 AC 1 (0a)", test_setup, test_select,
> +                               &cfg_select_ac1_0ab, DISC_SELECT_LC3_AC1_=
0a);
> +       define_test("UCL Select LC3 AC 1 (0b)", test_setup, test_select,
> +                               &cfg_select_ac1_0ab, DISC_SELECT_LC3_AC1_=
0b);
> +       define_test("UCL Select LC3 AC 1 (0c)", test_setup, test_select,
> +                               &cfg_select_ac1_0cd, DISC_SELECT_LC3_AC1_=
0c);
> +       define_test("UCL Select LC3 AC 1 (0d)", test_setup, test_select,
> +                               &cfg_select_ac1_0cd, DISC_SELECT_LC3_AC1_=
0d);
> +
> +       define_test("UCL Select LC3 AC 1 (1)", test_setup, test_select,
> +                               &cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1)=
;
> +       define_test("UCL Select LC3 AC 1 (1a)", test_setup, test_select,
> +                               &cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1a=
);
> +       define_test("UCL Select LC3 AC 1 (1b)", test_setup, test_select,
> +                               &cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1b=
);
> +       define_test("UCL Select LC3 AC 1 (1c)", test_setup, test_select,
> +                               &cfg_select_ac1_1, DISC_SELECT_LC3_AC1_1c=
);
> +
> +       define_test("UCL Select LC3 AC 4 (2)", test_setup, test_select,
> +                               &cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2)=
;
> +       define_test("UCL Select LC3 AC 4 (2a)", test_setup, test_select,
> +                               &cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2a=
);
> +       define_test("UCL Select LC3 AC 4 (2b)", test_setup, test_select,
> +                               &cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2b=
);
> +       define_test("UCL Select LC3 AC 4 (2c)", test_setup, test_select,
> +                               &cfg_select_ac4_2, DISC_SELECT_LC3_AC4_2c=
);
> +
> +       define_test("UCL Select LC3 AC 2 (0a)", test_setup, test_select,
> +                               &cfg_select_ac2_0ab, DISC_SELECT_LC3_AC2_=
0a);
> +       define_test("UCL Select LC3 AC 2 (0b)", test_setup, test_select,
> +                               &cfg_select_ac2_0ab, DISC_SELECT_LC3_AC2_=
0b);
> +       define_test("UCL Select LC3 AC 2 (0c)", test_setup, test_select,
> +                               &cfg_select_ac2_0cd, DISC_SELECT_LC3_AC2_=
0c);
> +       define_test("UCL Select LC3 AC 2 (0d)", test_setup, test_select,
> +                               &cfg_select_ac2_0cd, DISC_SELECT_LC3_AC2_=
0d);
> +
> +       define_test("UCL Select LC3 AC 2 (1)", test_setup, test_select,
> +                               &cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1)=
;
> +       define_test("UCL Select LC3 AC 2 (1a)", test_setup, test_select,
> +                               &cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1a=
);
> +       define_test("UCL Select LC3 AC 2 (1b)", test_setup, test_select,
> +                               &cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1b=
);
> +       define_test("UCL Select LC3 AC 2 (1c)", test_setup, test_select,
> +                               &cfg_select_ac2_1, DISC_SELECT_LC3_AC2_1c=
);
> +
> +       define_test("UCL Select LC3 AC 10 (2)", test_setup, test_select,
> +                               &cfg_select_ac10_2, DISC_SELECT_LC3_AC10_=
2);
> +       define_test("UCL Select LC3 AC 10 (2a)", test_setup, test_select,
> +                               &cfg_select_ac10_2, DISC_SELECT_LC3_AC10_=
2a);
> +       define_test("UCL Select LC3 AC 10 (2b)", test_setup, test_select,
> +                               &cfg_select_ac10_2, DISC_SELECT_LC3_AC10_=
2b);
> +       define_test("UCL Select LC3 AC 10 (2c)", test_setup, test_select,
> +                               &cfg_select_ac10_2, DISC_SELECT_LC3_AC10_=
2c);
> +
> +       define_test("UCL Select LC3 AC 3", test_setup, test_select,
> +                               &cfg_select_ac3, DISC_SELECT_LC3_AC3);
> +       define_test("UCL Select LC3 AC 5", test_setup, test_select,
> +                               &cfg_select_ac5, DISC_SELECT_LC3_AC5);
> +       define_test("UCL Select LC3 AC 7i", test_setup, test_select,
> +                               &cfg_select_ac7i, DISC_SELECT_LC3_AC7i);
> +
> +       define_test("UCL Select VS AC 7i", test_setup, test_select,
> +                               &cfg_select_vs_ac7i, DISC_SELECT_VS_AC7i)=
;
> +
> +       define_test("UCL Select LC3 AC 6i", test_setup, test_select,
> +                               &cfg_select_ac6i, DISC_SELECT_LC3_AC6i);
> +
> +       define_test("UCL Select LC3 AC 6ii L", test_setup, test_select,
> +                               &cfg_select_ac6ii_L, DISC_SELECT_LC3_AC6i=
i_L);
> +       define_test("UCL Select LC3 AC 6ii R", test_setup, test_select,
> +                               &cfg_select_ac6ii_R, DISC_SELECT_LC3_AC6i=
i_R);
> +
> +       define_test("UCL Select LC3 AC 9i", test_setup, test_select,
> +                               &cfg_select_ac9i, DISC_SELECT_LC3_AC9i);
> +
> +       define_test("UCL Select LC3 AC 9ii L", test_setup, test_select,
> +                               &cfg_select_ac9ii_L, DISC_SELECT_LC3_AC9i=
i_L);
> +       define_test("UCL Select LC3 AC 9ii R", test_setup, test_select,
> +                               &cfg_select_ac9ii_R, DISC_SELECT_LC3_AC9i=
i_R);
> +
> +       define_test("UCL Select LC3 AC 8i", test_setup, test_select,
> +                               &cfg_select_ac8i, DISC_SELECT_LC3_AC8i);
> +
> +       define_test("UCL Select LC3 AC 8ii L", test_setup, test_select,
> +                               &cfg_select_ac8ii_L, DISC_SELECT_LC3_AC8i=
i_L);
> +       define_test("UCL Select LC3 AC 8ii R", test_setup, test_select,
> +                               &cfg_select_ac8ii_R, DISC_SELECT_LC3_AC8i=
i_R);
> +
> +       define_test("UCL Select LC3 AC 11i", test_setup, test_select,
> +                               &cfg_select_ac11i, DISC_SELECT_LC3_AC11i)=
;
> +
> +       define_test("UCL Select LC3 AC 11ii L", test_setup, test_select,
> +                               &cfg_select_ac11ii_L, DISC_SELECT_LC3_AC1=
1ii_L);
> +
> +       define_test("UCL Select LC3 AC 11ii R", test_setup, test_select,
> +                               &cfg_select_ac11ii_R, DISC_SELECT_LC3_AC1=
1ii_R);
> +
> +       define_test("UCL Select LC3 Many 2", test_setup, test_select,
> +                               &cfg_select_many_2, DISC_SELECT_MANY);
> +
> +       define_test("UCL Select LC3 Many 8", test_setup, test_select,
> +                               &cfg_select_many_8, DISC_SELECT_MANY);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>         tester_init(&argc, &argv);
> @@ -8696,6 +9438,7 @@ int main(int argc, char *argv[])
>         test_bsnk_scc();
>         test_bsnk_str();
>         test_bsrc_str();
> +       test_ucl_select();
>
>         return tester_run();
>  }
> --
> 2.51.1
>
>


--
Luiz Augusto von Dentz
