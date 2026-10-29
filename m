Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793278384;
	b=NnVx8YkGZeNZAszVgJRXUzZvLmc+TexOcRdTtDnykd2ENpImE1oMdNTnQ7BUHlEAhVOU
	 9UudinJQYJSsadJ2aToZoOApbJo8emZ5eidqgpkZiBJ5PiPG7BK/6yxhrUVJ92O2yjCld
	 sK265xYjIdm8taPYGu5MIGpzwCtIfuuZP/TSNWDcgQJ58RYWWZCSc8qK1ZXH1cqmaqMWx
	 oew8jUvs1NqktDAJf2q/xC9P74tRY46GnS1KCVf4UYKlb8UWsLVj3D7wqvhHUf5Aer1fQ
	 P3zfNuKyvBQWEoQZejc8hO2Dxw1aYpMTzB4MJm4dfWflvNrZB958/sJfJ5vmqzWDmIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278384;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=sT0ArFBMJeyGkeMmr3StEsEq3sIwZCVpenaZi3WO0Gk=;
	b=AR22LEhvlJpr3DYZUelb8kpRUjLsoC9o8oFpDn9C04tASp9RPMxBKw7DiyVhIffiG4zD
	 UjSiZxqGKmOsavqbAPznKSeciHh2dViRNRKfDJLH/wOHGAijBpYhjE/ljooXIdebTSx6w
	 BheVMsRc5BDrE6NR5UcE8SURHZoWplTFNF/gFe+1/ZFbkBKHN5HAx96uOew3m5hzCTUTC
	 kVUDxTd85u1RbXxQp8FUNt8O9uNg5OQbbqGRbEAvAFHMcFzw6S5H/3JD0bQgk3/gZl47i
	 /rVea2zeKXjTnDEyrAYmY+nXyrRL1dmibrVlmEK+Gu3NesXBQ7GhOVj9SYF3qj0LRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=su7kwgrvcjd55nvbtudooyjwom.protonmail2 header.b=QEBxD9i7;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7385606A31A;
	Thu, 29 Oct 2026 12:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7385606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=su7kwgrvcjd55nvbtudooyjwom.protonmail2 header.b=QEBxD9i7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=su7kwgrvcjd55nvbtudooyjwom.protonmail2; t=1793278381;
	x=1793537581; bh=sT0ArFBMJeyGkeMmr3StEsEq3sIwZCVpenaZi3WO0Gk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QEBxD9i7ipkTa/oGhMGUO1xy9rWcmfjR+tCaaNzBocPjeXihSnBH8cwq4L/0fsU46
	 5YH8zNCIGbQR9+d1bekeY+k6RiQ5F6+hdr5Orgs2JqJ4fEm4rdbJOYBRtJ9NxEoghy
	 K6fvLsj5uORqMb3V+ER6tvO386nhcLQOodCPB/VbWYbNOZc2pb/0BstEesGvK+ZTAD
	 BdyQYNGGh0Ys91XFbeWtKasl0FkaUnxT5z767Jwa1h1jCUT0U7GeTOtTSP+TC8MfYn
	 9OF5yO5jmmHBWJGzT2caCaFvYMffIQ1mhBNKhbMTq4+nbel0pzpgTQcMycL/mNa1s6
	 aiNiSzGRSRj6w==
Date: Thu, 29 Oct 2026 12:52:58 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci: Represent advertising report payloads as bytes
Message-ID: <Ah3BUlHJg017ETZ8GZQG69Rs35nMmhg5WG73kEiV7X5u9R_WTd9V1Et1UJmum1Ub_rlkRpEUlC8V39VHQdwA-Yq-Z5s_t63QJWQJ1uHMeL8=@proton.me>
In-Reply-To: <Y6cAlirXtAS9pWAG1oay3YLbNw88cB8O4sDjEgoDnZrn3kKIWdDUo2MLkwWjYcmF4DWJ5s4WLSaXw5zc0sdDh5RT2dWo34mxaImxGQdetXM=@proton.me>
References: <20261014052244.416087-1-cochcoder@proton.me> <Y6cAlirXtAS9pWAG1oay3YLbNw88cB8O4sDjEgoDnZrn3kKIWdDUo2MLkwWjYcmF4DWJ5s4WLSaXw5zc0sdDh5RT2dWo34mxaImxGQdetXM=@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 4f7a1d16f22b61cc1fc70c2ce1716881d1056c27
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm withdrawing this patch since v3 of the UB500 patch at https://lore.kern=
el.org/linux-bluetooth/20261029023235.1280321-2-cochcoder@proton.me/ is no =
longer producing any warnings.=20



On Wednesday, October 28th, 2026 at 10:05 AM, cochcoder <cochcoder@proton.m=
e> wrote:

> Just checking in on this patch. Is there anything else I can do to help i=
t move forward?
>=20
>=20
>=20
> On Wednesday, October 14th, 2026 at 1:22 AM, Kyle Pepper <cochcoder@proto=
n.me> wrote:
>=20
> > Advertising records have variable-length data and cannot form a C
> > array of flexible structures. Describe the report payloads as bytes
> > to avoid Sparse warnings without changing their wire layout.
> >
> > Assisted-by: OpenCode:gpt-6.1-sol sparse
> > Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> > ---
> > Separate cleanup of warnings inherited from upstream, not a v2 of the
> > UB500 shared-buffer RFC. The same two "array of flexible structures"
> > warnings reproduce on that RFC's parent and exact submitted commit.
> > The public bot report only contains the matching include-file note;
> > its complete Sparse output was not available.
> >
> > Testing:
> > - GCC W=3D1 C=3D2: hci_event.o and btusb_main.o, no diagnostics after c=
leanup.
> > - Exact submitted UB500 commit plus this cleanup: same clean checks.
> > - Strict GCC/Clang layout checks and LLVM/32-bit hci_event.o builds pas=
s.
> > - GCC hci_event .text section is byte-identical before/after cleanup.
> > - A guest carrying the cleanup passes pairing and both HoG variants
> >   on baseline BlueZ and each of four independent ASHA topics: 15/15.
> >
> > This does not change the UB500 quirk or certify an unseen complete
> > remote Sparse report. No full architecture/configuration build matrix
> > or physical hearing-aid regression test is claimed.
> >
> >  include/net/bluetooth/hci.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 1641d879d..e873ffc15 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -2972,7 +2972,7 @@ struct hci_ev_le_advertising_info {
> >
> >  struct hci_ev_le_advertising_report {
> >  =09__u8    num;
> > -=09struct hci_ev_le_advertising_info info[];
> > +=09__u8    data[];
> >  } __packed;
> >
> >  #define HCI_EV_LE_CONN_UPDATE_COMPLETE=090x03
> > @@ -3058,7 +3058,7 @@ struct hci_ev_le_ext_adv_info {
> >
> >  struct hci_ev_le_ext_adv_report {
> >  =09__u8     num;
> > -=09struct hci_ev_le_ext_adv_info info[];
> > +=09__u8     data[];
> >  } __packed;
> >
> >  #define HCI_EV_LE_PA_SYNC_ESTABLISHED=090x0e
> >
> > base-commit: 609a23989d637e2f90522a37c62e65c8c9b8b0ff
> >
