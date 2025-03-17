Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BEA1A7AF7
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235070; cv=none; b=umqT4CBvqcnj1PxsgnuMfF26IG+Sb1CyAoRUX6/ge/krZS+a9J8Jb0ZvvlH1kwO9ZLl5Qx4ukFQZ6XHGMZkCJu5iXLcD3iSNgius6NvHukEh6NVVQVfazHFyuBL2hDL+QhKs5+LoZHVBloRu3KBeBKvHASWJSLnJvFO6ocViEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235070; c=relaxed/simple;
	bh=nlvHPmP/sCF87iS9AUKIJrehiQw1sbQrTAuTTgaQ4Cg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdZrtS1FoJ8obdhryVeF0583DgOaxUG+Z4Miv7BFPefGXjEZnyGPry9vuFbmxMuNLSREY4NDbPj0O6rcbEHGibz/8uNg6TuJCG3B2+pSSRr9i0FImZHuqWXWmdLwOwumceIcXNifZ+PUpIiWAdIQlQmbXLsEx5N6SQBTE53PkC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtrRHxmY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtrRHxmY"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-30bef9b04adso51485391fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 11:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742235067; x=1742839867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izv2soa/Lkb0fze4uYaQ0tFkWAj7tpI64gdtFALNwWY=;
        b=NtrRHxmY89xhxV9Q29ZSIXN6kL9K5GqXC4JnUhqFi8Vx82+B8WptEdx6IvmqqmU6qH
         HxzL+Ko36PIV7iYAluRVDDdAyw5OwYmkllvVsW/OnZvc5WJQXzBA23IMYdBSfxtVnbdc
         PWecZaVYZemfRC6GZdi7PbfWQJE8ff2MxMS8RFkYjJqhv+Lu+df2rd49m51yQNayXBNG
         ELeORr5dNAok+idZAD4Q5/ljEuZzHeYD4773hJBLK6HWhK9Z6tiIKlaLa74eymg4l6FO
         7t7K36VtN9qQ8/UGJrBq9Mci/QfL0P7+x+fVOIXfSBGNp3lqutZU/Ii6KQtJJBh01SnR
         zk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235067; x=1742839867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izv2soa/Lkb0fze4uYaQ0tFkWAj7tpI64gdtFALNwWY=;
        b=RFFgXD21tU1Gh0A3NuSaSQyQhIHODCO6WsIAyFtzVi/+SHlIrHebMj/HERUkFBlYmN
         AfGiBG6ww6cbthoCdk+cnSEK5QtBnbaB9n5KRT8Wp/tSutu84WyRsO0APfPGuJXlOyQU
         xSaFCFlMV2abQZ+Q57iPIaOwnLvUmQc7OPt4AZPvrMjC/rALVyTXfXGJJgvams4fLFaH
         7gpRgKzcQsxAgK6AWBny9bDt58gl6ZMPa9Ppf/xI2ezQnLUfYiTH6Cxk4O1wpJ6Op8Ul
         8z3I+Zv0rXnCVVvOd3b9ZR28p8mrJg0M7TtSQNhuOF2WzssJBTqIKCJyQdaoxw1CT955
         2L7Q==
X-Gm-Message-State: AOJu0Yz1O1OGrWTMz0s/hwAb3XGCEV+bqBYeCnpqC1bpWPX6/u51pZdS
	v6ALvViRFumuxH6eMdwNA1L336Zj1jRmafLjlH5MIsm0G8rgL5rnttdcJQxQkn0lWOhR+upN+KK
	OBfnTL1VgJETGytFrV5gxgEvdxZE=
X-Gm-Gg: ASbGncsJ6icgPn/somxXaPDEAbMnK0C5NN+adl1AYwb8u+iUubaNpU61dHbs2+0fGve
	K8NB1Ip6l8OwYESDoKpVQJB9X0oJCGWqebhgG21WWiv0uRJtQfyqbvLsuR5Hjn/yKTKjE+WMTxV
	VFIb7W4rIciX0mS5CEWMLE5VvJ
X-Google-Smtp-Source: AGHT+IHbRmkWEB2awJPvWMWFsjcaNQZf1+rm3UU0qhmfxURBR+m/JbZ1d8LKLi+pNmg8VKYU9lX0gdaF6p6AhitbojI=
X-Received: by 2002:a05:651c:b0b:b0:30b:b28d:f0a6 with SMTP id
 38308e7fff4ca-30c97534d5fmr9156201fa.8.1742235066663; Mon, 17 Mar 2025
 11:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740844616.git.pav@iki.fi> <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
In-Reply-To: <a0a8eb4d51a35f3181617303aa8f6ad8227b2bca.1740844616.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 17 Mar 2025 14:10:54 -0400
X-Gm-Features: AQ5f1JoGYln5BK4mePJEWdNElLfRDqt_jZYvxGDeJ7JEladVYhDyI1G9rtMsIVA
Message-ID: <CABBYNZKVj5b7CRAU0qi1CfxGd2FabtCaQsxTUoc1yq0AabztXw@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ 1/9] org.bluez.MediaEndpoint: removing BAP
 streams with ClearConfiguration
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 1, 2025 at 10:58=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Allow user to remove specific streams by calling
> ClearConfiguration(transport_path) on the endpoint.  If the path is the
> endpoint path instead, clear all streams associated with the endpoint.
> ---
>  doc/org.bluez.MediaEndpoint.rst | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoin=
t.rst
> index f2b830ab0..b81106f0b 100644
> --- a/doc/org.bluez.MediaEndpoint.rst
> +++ b/doc/org.bluez.MediaEndpoint.rst
> @@ -109,6 +109,12 @@ void ClearConfiguration(object transport)
>
>         Clear transport configuration.
>
> +       **Server role:** [ISO only]
> +
> +       Close the stream associated with the given transport. If the
> +       path given is the path of this endpoint, all its streams are
> +       closed.

This seems sort of trivial, that said we can't really guarantee the
MediaTransports will be closed even if we send an ASCS_Release
operation the server may still cache the codec configuration.

>  void Release()
>  ``````````````
>
> --
> 2.48.1
>
>


--=20
Luiz Augusto von Dentz
