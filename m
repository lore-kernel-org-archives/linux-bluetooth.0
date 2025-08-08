Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A551920322
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Aug 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662130; cv=none; b=iCQ+ccez0+1VOfaTio22O5t2BsAiKnkDKlg4vk7xZtU9ZhfSY9wOXzBy4EdwvzE2cVitAvY/XBF7vIa/NL1Su6MoWc8yRzr0Kf1fLgD++vnmuxqlTVeg0TV167kA27pTP2hzhQK+VP1LoxYhAhpGFYWHxWxf9ntTTCJoaP0AdsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662130; c=relaxed/simple;
	bh=m8qJ5IARod0NhgitJFQvUBn46dNJ1mzHTgiqiu3vmO8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k09iX0SkgHjCwANIGH9Cc1ibxmj4j6MquP+l/Kd2FphLEZ+zI5/7Th80FbO9ck1B1ZgyRPeVqeIwhoX/LAOaybGYNaNO07cgYQA1paEg2j18ApA5tGk3wtWtz4ikZCyGNVInDvjPTZjh17ICdUHJI2FdMhzbCoq+RhQhhCmf4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68F5044977;
	Fri,  8 Aug 2025 14:08:41 +0000 (UTC)
Message-ID: <af1e61baadba6d6d526f7b7310658342ad622012.camel@hadess.net>
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in
 `compute_seq_size`.
From: Bastien Nocera <hadess@hadess.net>
To: Oliver Chang <ochang@google.com>
Cc: linux-bluetooth@vger.kernel.org, oss-fuzz-bugs@google.com
Date: Fri, 08 Aug 2025 16:08:40 +0200
In-Reply-To: <CAFqAZOJzuHn=hUO+xyZwQBh8u0mzABkDf3==imzxkQmj0czGhA@mail.gmail.com>
References: <20250808013402.548986-1-ochang@google.com>
	 <20250808013402.548986-2-ochang@google.com>
	 <8f18dbeaf80530fb3d460060864a2a15f73b7039.camel@hadess.net>
	 <CAFqAZOL4iKjuxa=ubwFCGHyfgtuGBCW7F1US=1sYSoeWiMZpTg@mail.gmail.com>
	 <CAFqAZOJzuHn=hUO+xyZwQBh8u0mzABkDf3==imzxkQmj0czGhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdegtdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredttderjeenucfhrhhomhepuegrshhtihgvnhcupfhotggvrhgruceohhgruggvshhssehhrgguvghsshdrnhgvtheqnecuggftrfgrthhtvghrnhepieffgfehtedtgefgjeeggfffgeeuvdegveekveejfeekkedujeehteffueefffeunecukfhppedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffedphhgvlhhopeglkffrvheimedvrgdtudemvgefgeemvggtjeefmegtfhdvtdemjeduuggrmeefsggumedvtdgrleemudeffegnpdhmrghilhhfrhhomhephhgruggvshhssehhrgguvghsshdrnhgvthdpnhgspghrtghpthhtohepfedprhgtphhtthhopehotghhrghnghesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshhsqdhfuhiiiidqsghughhss
 ehgohhoghhlvgdrtghomh

On Fri, 2025-08-08 at 21:45 +1000, Oliver Chang wrote:
> (Apologies for the noise, I'm new to this. One more attempt to resend
> this as text-only for those who have seen this email multiple times).
>=20
> Thank you for the feedback. The problem here is that there is a heap
> buffer overflow found by fuzzing with the following testcase:
>=20
> `<sequence><foo/><text/></sequence>`
>=20
> This causes the `compute_seq_size(ctx_data->stack_head->data);` to be
> called on `ctx_data->stack_head->data` that isn't a sequence type.
> This patch adds some type checks to guard against that.
>=20
> I don't believe a regression test using valgrind would catch this --
> we used AddressSanitizer to detect this.

I meant that there should be:
- a test for SDP XML
- valgrind run of that shows this specific memory being leaked (don't
need ASAN for that...)
- patch that fixes the leak with the section of the valgrind log=20

We don't need the memory leak itself to be regression tested, don't
think it's something that's easy to put in place right now.

> While fixing this, we also discovered a memory leak in the error
> handling path touched by the patch (` if
> (g_markup_parse_context_parse(ctx, data, size, NULL) =3D=3D FALSE) `),
> which we included a fix for.
> Would it be better if we separated out the heap buffer overflow fix
> and the memory leak fix into 2 separate commits?

Separate commits would be useful.
