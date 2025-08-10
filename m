Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8991D54FE
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754814030; cv=none; b=AXoHvipDBN8x0Hv4roIlpw/CIGaL9YvU/l1XwrSuRB5J6Dfy1ao1lWzv81sEagmUXHXwfRMvCJZBwz9gNSFzdBIUIBvA1bc/yNhfZLqFDctHaoQ1WKca/vf3LFm7wsn3Ip+DEsqjwxwUij4JewJwJHLGgO24B+IMgJoZHfKNuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754814030; c=relaxed/simple;
	bh=C+/xkV9qaC8ZIFJcCaoh8f9fWDN1Ph9Vz8qFXDdqFLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zm2yIlWZs7Tme2C5EuAPhcEl2W+TeysiU2OFWRYf1rcLL/2GJ/33R3VbpM7hW1pNbOxt183S2AL7bFUKRyF8nhFfj18TYA8c/Ok6BYTbK1oL/bMWz8fTnvJnZ7gD/7kaxHZQmbYcTOW+LkrxQvQ+6ZhQ5JOklNDWKtAkorv6Oeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlmtAInT; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlmtAInT"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70767eef931so44916826d6.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 01:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754814027; x=1755418827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+/xkV9qaC8ZIFJcCaoh8f9fWDN1Ph9Vz8qFXDdqFLQ=;
        b=IlmtAInTOvmF8Vg8avV0UlhW76Gxpr7tj6AGv2uPkrq9PPfwt8dMOAeSiDlcJEVGMI
         tHcRfz3wl7Tzxzq4BFmkw3nh/YSEHYf+6llDoMDTFk9T7O8cGy8hBxoqK9g7tSe72PH2
         O14tQB4MJxW3fgnjyp0QDoamscK32E7v9R73ftH1RpKdWo48l/JvTXLgdZm1BzPsfq5G
         oniiBtdcw23ad3W7GiTJVhNpFj4e6XCOdizfaYFZYjNWuyJziOCqAid9Ld1QyfY0gwhO
         Q9m6J2QZDeOeXf9nA1/4vmWCMP0VeMmpEcnNy5ihVeYCllw7VbBMA2Ne2HQhliY0P/tC
         f3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754814027; x=1755418827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+/xkV9qaC8ZIFJcCaoh8f9fWDN1Ph9Vz8qFXDdqFLQ=;
        b=LmriNIooNFA+U5SKKV+wF0TO25sMxgr6Tdn1I8XE6DnPSk7j7ITANP/EruzC03yvzj
         9MoxalDdktoXzkaHTELdKAIGEgdslOKvl60YJ2CA1xW1RCA31IfrgHK5A6EwbXwK1Qtp
         s3jvzU+g995iU1IftucYWVpoudI5LDr6S9hN9HGrfY938zAwNhWBR1/NziKooq+in2ZI
         dWG9SjP7fkflLaM6qY9NY0W+h5TdBcsCfSkablf6L5Ddmvnxrdwk5biah0eCKKauPMWi
         QBWdIlHhrjPNMuxfKEvbSrKiDfjh3q1yKbKEm80+UF3nBUBSxsyx/cFl9bXsbbd/Ywdm
         CZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU63JZaXYYfFZ5p3G1XA+UF6eNYE3Qs7FAKH0jnbzGMrnCasUjsDP0cxC8IeWb8MgXUWY02OV92xtD5MaP/Zk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3EzCvqLoetDaub3whYF8NqiLe4mPKD76DHnv4Wmd7215jHtu6
	WbLu1jNWNDmxxOZbaiZnRJ/I7VBXJ7FE8OeszjuQ9GP4QSeOpgxPl52BsPbZ1lfUaSdt2a5DQsh
	fk7kjuBXNZd0zIFSF2YWFQgmi3qGVqjrdWaGJOSXN
X-Gm-Gg: ASbGncvmTQY5RThY8c1S7HY2w0Ifzfq4ViSxrE6J7Pnfmu7ujoUnHGtJzY9QJmSa6iw
	E8n+roykPJ58bVb5w+CNcL23xIogmqifO10V4wKmitCxZmeh0J+rLFCcBlFn178QY45aotKdlMa
	r9iCv0NBSj/2IRrz9D+9rlPFMwmsAIUmX78um/AAx2MCirBK4rEjIe1/uHkOMZwy9NgOwGsOmHT
	ETjFpd62OEr/bhC7k5nvsmprHBzgTuYLNGPkeox4KeWz5UsaM2XSZkBLCetx4s=
X-Google-Smtp-Source: AGHT+IGahtY6UEZ3A4XL2qWY3Za4yBv/MuTCiTIoqAEb6CEkfto2ou2Pq7WlIYjeaUf+2XevQWugxl8At0Qxh7cNp20=
X-Received: by 2002:a05:6214:1c4a:b0:707:494:ec4 with SMTP id
 6a1803df08f44-7099a437f3bmr124632256d6.27.1754814026788; Sun, 10 Aug 2025
 01:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810064656.1810093-2-ochang@google.com> <20250810064656.1810093-4-ochang@google.com>
 <42be480f-d301-4963-b5f6-73811586e857@molgen.mpg.de>
In-Reply-To: <42be480f-d301-4963-b5f6-73811586e857@molgen.mpg.de>
From: Oliver Chang <ochang@google.com>
Date: Sun, 10 Aug 2025 18:20:14 +1000
X-Gm-Features: Ac12FXyKyF90VCAXSoLNMKo_QAMikoDyOqlmAz57OQGgcYBPPBsZ2yWA6SrKzY0
Message-ID: <CAFqAZO+WK1m2ww1B5qi-iUC8rV-mnsuBk=VeHbBy5euGWBH77Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in `compute_seq_size`.
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Paul,

> Thank you for the patch. For the summary, I=E2=80=99d use imperative mood=
 and do
> not add a dot/period at the end:
>
> Fix heap-buffer-overflow in `compute_seq_size`

Thank you for the suggestion, I will make sure to do this for future
commit summaries. What do I need to do here in this instance to make
this change? Do I need to resend the patch with a new subject?

> The last comment says:
>
> > This issue was migrated from crbug.com/oss-fuzz/51480?no_tracker_redire=
ct=3D1
>
> But that URL gives *Page Not Found*.

Apologies for that. We had a migration from a legacy issue tracking
system, and that legacy system has since been turned down.
>
> > https://oss-fuzz.com/testcase-detail/5896441415729152
>
> I am unable to access this without logging in.

The emails that can access this are the ones listed here:
https://github.com/google/oss-fuzz/blob/ef1c29822d62470fb6b0af7b73412d245d0=
5f80c/projects/bluez/project.yaml#L3.
Are there any other emails we should add?

These emails also receive automatic email notifications whenever
OSS-Fuzz finds a new bug. Note though, to view the oss-fuzz.com
report, you'll need either a GitHub or Google account associated with
the email.

https://oss-fuzz.com/testcase-detail/5896441415729152 contains the
ASan stacktrace, which I've also included in my earlier email.

>
> With your patch and the test case, what error is logged now?

There is still a memory leak detected by ASan that's unrelated to this
patch/issue, but the buffer overflow report is gone.

I don't see any other log messages, including the ones I added in the
patch. This is likely because `sdp_xml_parse_record` calls
`g_markup_parse_context_parse` with a NULL `error`, so any parsing
errors encountered are not propagated.

```
if (g_markup_parse_context_parse(ctx, data, size, NULL) =3D=3D FALSE) {
```

It seems useful to enable propagating of parsing errors to
`sdp_xml_parse_record` in the future. But if preferred, I can remove
the logging I added since they're not going anywhere right now.

Kind regards,
Oliver
