Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C53330B32
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 18:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992221; cv=pass; b=EGgHm5Qe9V6N01NcOEIuq+t3fkayXMhbc7EIYt3EgMVIBEi3Tcv/qwvxwQJC8qcovZbkIbZjItR+4VItTlXcRIM5a/xW0/A/zSArYgxAyxJAfh1ba66+w8VcpGIR7F7k41wqBtHpOyp3SK9B7zkRjp+lsiLHBr3paILDSjn1K+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992221; c=relaxed/simple;
	bh=kFUN9djagA2d2V73MWLMnsNCDl9EhEQ6AKpalaiUFdQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQp+XZDKMwEQa39kaqNcZOqM1Szg8HZOB0WLEsV6aNvdA0nWjv3VAOecMFiWG0Z2ZYdvfsA410XqgWGWwDB2eMLxYPr837jJqZIN8HLLcq1Q8Ha6jD0K/o5MIAob549nMyCkOusLlGwn5nNH1sFHWPWXeMDtSHRjGcmq9od49gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl2R/dPa; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl2R/dPa"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c711b7f2aso5532271d50.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 11:43:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786992219; cv=none;
        d=google.com; s=arc-20260327;
        b=lXwDr7TsFbFYEDy3L0DmnuXiP7H2QnRJaQhOJv6YbyYZttPfZaoG9UrL2sohvsa6uF
         TYhLpTzXWk8c9L5UWk/ZEaYNrxER+JZHbqV/TfJ3tFbkLXkb4uHQURNgc1OmelsBkf2m
         8z9DXneqHYbCJ+/WRglexCx9eKLyczCASDH67ChrmE0acYd+bV2yMg+mjqf2xcLPG2Zu
         anVPK8uAmIKVoS55cQLBaf/RrJnuqcirM4bhmqgsjHelbnZTW2w6TiiiI5BFEOFQtvA4
         N5914tZKm944MV7AWxHcM0a5umRTBSSDZBlEQNbTu5s1P0Gc7NylmeYPdDisd8NbQerf
         Qmgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3TmBisPOhOA5pousfNjAC0K6au9wS+YV1klStzHvJk8=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=Z2/EV2zkkqDREiru3uNbaL+3PI79k1AR+WUN67d+BtwMdavxzhI8lAjRI8sMJ1V0ND
         iQNC1q+CZelRMp8udkep2iieBhPZtrnLdl2H29d8CGkU4RH5cyJgYCY9YUhBZvqtoILB
         F4kgwOlOPPXMkju9iLoFdOPySaGqBjxHRWYiP6jjRbRRPRPJr3tiC2ocdVzI5nDzzztS
         gOe6k/BYiM3O08hOm+HPjC9XIaJ35LtwXA9m3FpgPzq8BUCJZele80938bfPD26JAbbf
         aUF6Jl3Fsgng5TL6r0ag9D28fEwGS3Io5gUXXiP8wvPoLUDol2xOnvm5Ok8lbV1Lkzee
         aBLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786992219; x=1787597019; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3TmBisPOhOA5pousfNjAC0K6au9wS+YV1klStzHvJk8=;
        b=Dl2R/dPa7c0Q6jtuDmIKdV6sMoXjE4XS3aTvXY9Ym4y0LVp+i8cay0N5ysUiRuLLwA
         eKyjzV1jB9ftj4xU4jRcqo3yRsIISF6eZrF3eDSfczeKZTv2aHs4l4z68hN69nInwOtE
         no4db6TcZAtM9JuTPDFQt6aX5Qzd/FEKp4F/qa6K2+saE+/V4Gj9U7lHsCHl0HKCAeAD
         vvuMe4Hf7s5DtcCN8f9IQCbm3c7ZBFGhz8PPJdqnBCawbPEdj/y2zhjLLfHqIVOrtJFu
         IalLF+02arUnjlxFxndQlokRcPTbbqn3cPGIwY+hQSYstEGC4kQbAgeEtaQPkDlTwfB9
         ukQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786992219; x=1787597019;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3TmBisPOhOA5pousfNjAC0K6au9wS+YV1klStzHvJk8=;
        b=BGOoRe64D+JJG7qp3OWDiQyeiCEwb1JJcvSPUrER/FSCYu6+++TDa7SwBowGZwyoa3
         t8euXuY3b6OS47nd78QLVnreDfUfCQqVtV+3mi7liCkZcwk0RPJ8zBF9Aml8KYzfg0SP
         3l0J0gDfjECD65oVH30jbj+bqsnbWw4VoaZO85FEip/Zlc0l3XMeGku+G7YqN04p/Z/d
         uz1ncwzCGy7qzVOLHeyYIAKQC6mHyhdzaSw6v3sjAIgquy3d4efQtcIP3PdNVcErsnIk
         9SiXzy4NzE3jJRfqkQ5RuHld10uwv6X+dYvAG+ANUM67KYC4dQXz79ZfiojOLAsmW4tM
         powQ==
X-Gm-Message-State: AOJu0Yzu2BGKOolko8qFMlvnVofB2WFXcQ6MDc7mdKfKLI7JeR41z0tg
	60Re0FypIVbHOOH1T1WigHfb21RKuwXcecOkJp4gEXhiE1Cexkt25WCVL0AHjP/YR2CIOuC/wFG
	8cZpcEHtb2rBH8UjLpwnrbfa1BY5xN5wnpvzrTFKScg==
X-Gm-Gg: AR+sD12Ofp6hu3vq2hhOuFZyaYV6yfi1wEIv/OuWua0btaP7OOfnZXFs2a8hgkATkUo
	zKCQ1yRFgbiHj4jNonoTozAYMtk/qyRvqd8/JyXqDgLRJ2TXAjdIrhkngXy5/p9eNM24iJgTD4d
	kUaNZaz4n0DSrPcFf6DNni+c//zj6UYf/QyYX35aj4WQ9smY4megKVfCfFTHxEi1mswk/CK+ni0
	OFN1Y/Z8U4cwny9iKpTxTlv+FEsIEv6s17wobg5Abigpt4jeapBicgKyngRVgznD8QZ7UHmKy4G
	IwBe5KzNVvBK6zmSG30AVMauCLz32Gefhi+CMi7vS3kp+TQNknOTHPq5Kh4r3O4VvY+n4evReuO
	BrRL0PbzhrbxlD0S7xMTn6HcCrm0AWUo=
X-Received: by 2002:a05:690e:dc2:b0:66c:731c:8604 with SMTP id
 956f58d0204a3-66cb9e8f173mr987220d50.35.1786992218959; Mon, 17 Aug 2026
 11:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814174731.1441738-1-luiz.dentz@gmail.com>
 <20260814174731.1441738-2-luiz.dentz@gmail.com> <8664f27d1427fac3a37f3be0f97f40c6af4d097c.camel@hadess.net>
In-Reply-To: <8664f27d1427fac3a37f3be0f97f40c6af4d097c.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Aug 2026 14:43:26 -0400
X-Gm-Features: AcwNN1X_un9hW1g_Js1JwMG586EvALm5zliOCxSaP4UJNhgnkMVkdyFhJbEj2HU
Message-ID: <CABBYNZ+ynwx51S5pG2ioxFH0328jqhJ0AmzdDX32UCZR8F=zbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/3] unit/test-sdp-xml: Give each test its own test_data
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Mon, Aug 17, 2026 at 4:41=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Fri, 2026-08-14 at 13:47 -0400, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > DEFINE_TEST assigned the filename and expected result to a single
> > test_data and passed its address to tester_add(), so every test
> > shared
> > one struct and ran with whatever the last registered test left in it.
> >
> > All the file based tests therefore parsed the same file, and a test
> > pointing at a file that does not exist still passed.
> >
> > That in particular meant compute-seq-size-type-confusion.xml, the
> > regression test for GHSA-7mmr-gwqx-vc34, was never actually parsed,
> > and
> > passed only because it inherited the expected result of the test
> > registered after it.
>
> That's not quite correct. The fix introduced memory leaks, which you're
> fixing in "sdp-xml: Fix leaking the parse stack on malformed input",
> but it fixed the original crash.
>
> This test would only fail when run under ASan.
>
> I just want to be clear that this fix doesn't have an impact on GHSA-
> 7mmr-gwqx-vc34 being resolved earlier.

Yeah, the model got confused, it seems it doesn't understand the macro
expands the fname, I though it was off or something because it didn't
seem to change anything with respect to the output.

> >
> > Use an array with one entry per test instead.
> >
> > Assisted-by: Claude:claude-opus-5
> > ---
> >  unit/test-sdp-xml.c | 34 ++++++++++++++++++++++------------
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/unit/test-sdp-xml.c b/unit/test-sdp-xml.c
> > index b338788aa295..72e01f5f5806 100644
> > --- a/unit/test-sdp-xml.c
> > +++ b/unit/test-sdp-xml.c
> > @@ -114,25 +114,35 @@ static void
> > sequence_on_squared_teardown(gconstpointer data)
> >       tester_teardown_complete();
> >  }
> >
> > -#define DEFINE_TEST(fname, res)
> > {                                     \
> > -     data.expected_result =3D
> > res;                                  \
> > -     data.filename =3D
> > fname;                                                \
> > -     tester_add("/" fname, &data,
> > NULL,                         \
> > -                     parse_xml_for_filename,
> > NULL);                        \
> > -     }
> > +#define DEFINE_TEST(fname, res) { .filename =3D fname,
> > .expected_result =3D res }
> > +
> > +/*
> > + * Each test needs its own test_data, sharing a single one would
> > make every
> > + * test run with the values assigned by the last one registered.
> > + */
> > +static struct test_data file_tests[] =3D {
> > +     DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE),
> > +     DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE),
> > +     /* From
> > https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34
> >  */
> > +     DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE),
> > +     /* From
> > https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc
> >  */
> > +     DEFINE_TEST("duplicate-attribute.xml", TRUE),
> > +};
> >
> >  int main(int argc, char *argv[])
> >  {
> >       struct test_data data;
> > +     unsigned int i;
> >
> >       tester_init(&argc, &argv);
> >
> > -     DEFINE_TEST("Bluetooth_HID-sdp_record.xml", TRUE);
> > -     DEFINE_TEST("qt-SerialPortSDPRecord.xml", TRUE);
> > -     /* From
> > https://github.com/bluez/bluez/security/advisories/GHSA-7mmr-gwqx-vc34
> >  */
> > -     DEFINE_TEST("compute-seq-size-type-confusion.xml", FALSE);
> > -     /* From
> > https://github.com/bluez/bluez/security/advisories/GHSA-75v6-6q44-57hc
> >  */
> > -     DEFINE_TEST("duplicate-attribute.xml", TRUE);
> > +     for (i =3D 0; i < G_N_ELEMENTS(file_tests); i++) {
> > +             char *name =3D g_strdup_printf("/%s",
> > file_tests[i].filename);
> > +
> > +             tester_add(name, &file_tests[i], NULL,
> > +                             parse_xml_for_filename, NULL);
> > +             g_free(name);
> > +     }
> >
> >       tester_add("/sequence_on_squared", &data,
> >                  sequence_on_squared_setup,



--=20
Luiz Augusto von Dentz
