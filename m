Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052F1ADFE5;
	Fri,  4 Oct 2024 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075044; cv=none; b=KGufXd0MaOP+6lhGujNVroqqYZA1m3ReGNYkihih+sWzif7yHqJ1JNkJ9Zn+GUFi4miOhpBGRF6BGvTmx+tzIliT50GZLBwEZJEWJbyxT13mq31IEhyhRbrGF05AapiL9c/KWKvw/ZQnpi0OMD0J0YsXMLwJ1aNH1k8Ag7OzvJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075044; c=relaxed/simple;
	bh=VcyTOyD+G5sF0Ri5jMwK19wbzp71f0jCAgSp3vQ4PRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPkOdPCyL0gtI7NLuOH/eV1Ta4CAl64thcSCqzYt2hmXo12csK7IbH6B0Uw8hsXgsmTyPYIlE5anfqeMcO76ZLwuQURtRuTYdo3Xu9B0BH1JQ73CdpNBdHIS/DMY7cb0gXmANuLZMutVdtII8hHvatVZCZQhLwd9tXht5F7WhM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNF4yl1G; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNF4yl1G"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2faccada15bso26504791fa.3;
        Fri, 04 Oct 2024 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728075041; x=1728679841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PLrhtOZc0ncpbV4SqRPfXJqQLk4SBEeN/sSgGTDaZr4=;
        b=cNF4yl1GR/1+eiaKYN8Q54U9xomUAQvx7BjBISjO0Xf/QIa6ol2uacFJx++bppnSvn
         gA1mn0xyvg+noWxKb+2I4tQ2PGD7NtWZwXjMiBJg9GKI5nX82PPP8w9rxTz1WYMSf7Eb
         L4iTphAhJoqulZriE4y4i3Uo6VtH1X0QmYS0MKGMkF2EyRCTItt8vDioLv3LGjpGV+e6
         sRV8UACN2Uh/8WsuFkm7Mz9804dzMXm28MMZOTJYhF7LAX8ZF6ihLGseQj9B4pjiBj8S
         RZpyLU1wapjyo/l0blnFVrRq/oQSQ66UzMnRpINnVOWHI/yMpx31QwtEr5EgPZdoILh3
         yw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075041; x=1728679841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PLrhtOZc0ncpbV4SqRPfXJqQLk4SBEeN/sSgGTDaZr4=;
        b=pFgaozvx95QaceyJg2q2IrC+S2kpKxA0vICeSgr0MqQnwyAGTEe4E/eQ9fEfL1xXje
         W3dd2RtHHGJ41XtraCKH7NZ3vKfJh14Hy8MQHt37FxDm2RFdLISXKv1yZea002ppWQTM
         XCdMxUV+bbZTfZgGhqukM4JDx1jyq2L145oql2G62kZpWDVlpN6iNHxXt8coRBfM0ltU
         BqrRD0Vr/JMnXnHWYEm6qlIMAOizISALKY2xSqHNIuukwojkJkwjL1/zzIn/uXQ9wG75
         qS/7BzB7NZEMuf/Hg8WWdVDx7F1/q1vf1JAjNBlHaHzoITPrKqr0GdV0FGu75G5HyOKu
         lkIg==
X-Forwarded-Encrypted: i=1; AJvYcCVSPOTaDT5Nohs8FhAZQIt04vqSWFKqi6n7jmlz2ddpwKxN3ZROoJsnwGe2kpwLDlKFOD2YtCO12u6kkfwV@vger.kernel.org, AJvYcCWWu8q0TnnfU6vmiTklfb5f2oMts6PoBgP/YV+SDpx5xUTFMRQDEZyWb2pTjPy9A2XrzHEitPLIC+hcYSBHs5o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0PZ6FebfAW3dki2P8ZuCjGIL5PhWGO1G4g8zw55Crh2qT0Q5
	dQL5MGKdVltwHGzdgwodQxc20d9fUMzEl1FepO7aQwk39/Dis63vJz31+JZdbUlgjt5kzfBiUzk
	hWaJLn/Ye87R7EbSAnA8EGTCCCZ5DpA==
X-Google-Smtp-Source: AGHT+IHk5N+nqArtKZde1Rjz34epM7A8EYXLa03AKa5XEsuMtqEfTVFjZkVJPM2qEbcVG5weElksvHKi2e0DK3G3pO4=
X-Received: by 2002:a2e:602:0:b0:2fa:dcb6:fa7a with SMTP id
 38308e7fff4ca-2faf3c14387mr16888911fa.11.1728075040382; Fri, 04 Oct 2024
 13:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zv67JUPfzgQp7Kgf@fedora> <66fec4aa.050a0220.9ec68.004b.GAE@google.com>
 <Zv7KOuMKKHrLTvfw@fedora> <CABBYNZ+BwrGdL0HYh3cmQ39RFwEqjzreJSyYhFkkhSWxeoorNg@mail.gmail.com>
 <Zv7RRwVy7fcDLPHJ@fedora>
In-Reply-To: <Zv7RRwVy7fcDLPHJ@fedora>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 4 Oct 2024 16:50:27 -0400
Message-ID: <CABBYNZKxOsgd6FpfdOKGUD9tbSadCnBzzsnf1K8sVZQ5Tn0cQQ@mail.gmail.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000ed7c520623acd281"

--000000000000ed7c520623acd281
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 3, 2024 at 1:16=E2=80=AFPM Qianqiang Liu <qianqiang.liu@163.com=
> wrote:
>
> Hi Luiz,
>
> > Are you sure this hasn't been already fixed by Bluetooth: MGMT: Fix
> > possible crash on mgmt_index_removed?
>
> Oh, it looks like it's already fixed by your patch, thanks!
>
> --
> Best,
> Qianqiang Liu
>

#syz test

--=20
Luiz Augusto von Dentz

--000000000000ed7c520623acd281
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="v1-0001-Bluetooth-MGMT-Fix-possible-crash-on-mgmt_index_r.patch"
Content-Disposition: attachment; 
	filename="v1-0001-Bluetooth-MGMT-Fix-possible-crash-on-mgmt_index_r.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1v78ksh0>
X-Attachment-Id: f_m1v78ksh0

RnJvbSBlYjNhZDc2YTA3YjZjZGFhYTE1Njc2NmRhNWZlNmMzODRhMTI5MzBiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IFRodSwgMTIgU2VwIDIwMjQgMTI6MzQ6NDIgLTA0MDAKU3ViamVj
dDogW1BBVENIIHYxIDAxLzIzXSBCbHVldG9vdGg6IE1HTVQ6IEZpeCBwb3NzaWJsZSBjcmFzaCBv
bgogbWdtdF9pbmRleF9yZW1vdmVkCgpJZiBtZ210X2luZGV4X3JlbW92ZWQgaXMgY2FsbGVkIHdo
aWxlIHRoZXJlIGFyZSBjb21tYW5kcyBxdWV1ZWQgb24KY21kX3N5bmMgaXQgY291bGQgbGVhZCB0
byBjcmFzaGVzIGxpa2UgdGhlIGJlbGxvdyB0cmFjZToKCjB4MDAwMDA1M0Q6IF9fbGlzdF9kZWxf
ZW50cnlfdmFsaWRfb3JfcmVwb3J0KzB4OTgvMHhkYwoweDAwMDAwNTNEOiBtZ210X3BlbmRpbmdf
cmVtb3ZlKzB4MTgvMHg1OCBbYmx1ZXRvb3RoXQoweDAwMDAwNTNFOiBtZ210X3JlbW92ZV9hZHZf
bW9uaXRvcl9jb21wbGV0ZSsweDgwLzB4MTA4IFtibHVldG9vdGhdCjB4MDAwMDA1M0U6IGhjaV9j
bWRfc3luY193b3JrKzB4YmMvMHgxNjQgW2JsdWV0b290aF0KClNvIHdoaWxlIGhhbmRsaW5nIG1n
bXRfaW5kZXhfcmVtb3ZlZCB0aGlzIGF0dGVtcHRzIHRvIGRlcXVldWUKY29tbWFuZHMgcGFzc2Vk
IGFzIHVzZXJfZGF0YSB0byBjbWRfc3luYy4KCkZpeGVzOiA3Y2Y1YzI5NzhmMjMgKCJCbHVldG9v
dGg6IGhjaV9zeW5jOiBSZWZhY3RvciByZW1vdmUgQWR2IE1vbml0b3IiKQpSZXBvcnRlZC1ieTog
amlheW1hbyA8cXVpY19qaWF5bWFvQHF1aWNpbmMuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5jb20+Ci0tLQogbmV0L2JsdWV0
b290aC9tZ210LmMgfCAyMyArKysrKysrKysrKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0
b290aC9tZ210LmMgYi9uZXQvYmx1ZXRvb3RoL21nbXQuYwppbmRleCBlNGY1NjRkNmY2ZmIuLjQx
NTdkOWYyM2Y0NiAxMDA2NDQKLS0tIGEvbmV0L2JsdWV0b290aC9tZ210LmMKKysrIGIvbmV0L2Js
dWV0b290aC9tZ210LmMKQEAgLTE0NTMsMTAgKzE0NTMsMTUgQEAgc3RhdGljIHZvaWQgY21kX3N0
YXR1c19yc3Aoc3RydWN0IG1nbXRfcGVuZGluZ19jbWQgKmNtZCwgdm9pZCAqZGF0YSkKIAogc3Rh
dGljIHZvaWQgY21kX2NvbXBsZXRlX3JzcChzdHJ1Y3QgbWdtdF9wZW5kaW5nX2NtZCAqY21kLCB2
b2lkICpkYXRhKQogewotCWlmIChjbWQtPmNtZF9jb21wbGV0ZSkgewotCQl1OCAqc3RhdHVzID0g
ZGF0YTsKKwlzdHJ1Y3QgY21kX2xvb2t1cCAqbWF0Y2ggPSBkYXRhOwogCi0JCWNtZC0+Y21kX2Nv
bXBsZXRlKGNtZCwgKnN0YXR1cyk7CisJLyogZGVxdWV1ZSBjbWRfc3luYyBlbnRyaWVzIHVzaW5n
IGNtZCBhcyBkYXRhIGFzIHRoYXQgaXMgYWJvdXQgdG8gYmUKKwkgKiByZW1vdmVkL2ZyZWVkLgor
CSAqLworCWhjaV9jbWRfc3luY19kZXF1ZXVlKG1hdGNoLT5oZGV2LCBOVUxMLCBjbWQsIE5VTEwp
OworCisJaWYgKGNtZC0+Y21kX2NvbXBsZXRlKSB7CisJCWNtZC0+Y21kX2NvbXBsZXRlKGNtZCwg
bWF0Y2gtPm1nbXRfc3RhdHVzKTsKIAkJbWdtdF9wZW5kaW5nX3JlbW92ZShjbWQpOwogCiAJCXJl
dHVybjsKQEAgLTkzOTQsMTIgKzkzOTksMTIgQEAgdm9pZCBtZ210X2luZGV4X2FkZGVkKHN0cnVj
dCBoY2lfZGV2ICpoZGV2KQogdm9pZCBtZ210X2luZGV4X3JlbW92ZWQoc3RydWN0IGhjaV9kZXYg
KmhkZXYpCiB7CiAJc3RydWN0IG1nbXRfZXZfZXh0X2luZGV4IGV2OwotCXU4IHN0YXR1cyA9IE1H
TVRfU1RBVFVTX0lOVkFMSURfSU5ERVg7CisJc3RydWN0IGNtZF9sb29rdXAgbWF0Y2ggPSB7IE5V
TEwsIGhkZXYsIE1HTVRfU1RBVFVTX0lOVkFMSURfSU5ERVggfTsKIAogCWlmICh0ZXN0X2JpdChI
Q0lfUVVJUktfUkFXX0RFVklDRSwgJmhkZXYtPnF1aXJrcykpCiAJCXJldHVybjsKIAotCW1nbXRf
cGVuZGluZ19mb3JlYWNoKDAsIGhkZXYsIGNtZF9jb21wbGV0ZV9yc3AsICZzdGF0dXMpOworCW1n
bXRfcGVuZGluZ19mb3JlYWNoKDAsIGhkZXYsIGNtZF9jb21wbGV0ZV9yc3AsICZtYXRjaCk7CiAK
IAlpZiAoaGNpX2Rldl90ZXN0X2ZsYWcoaGRldiwgSENJX1VOQ09ORklHVVJFRCkpIHsKIAkJbWdt
dF9pbmRleF9ldmVudChNR01UX0VWX1VOQ09ORl9JTkRFWF9SRU1PVkVELCBoZGV2LCBOVUxMLCAw
LApAQCAtOTQ1MCw3ICs5NDU1LDcgQEAgdm9pZCBtZ210X3Bvd2VyX29uKHN0cnVjdCBoY2lfZGV2
ICpoZGV2LCBpbnQgZXJyKQogdm9pZCBfX21nbXRfcG93ZXJfb2ZmKHN0cnVjdCBoY2lfZGV2ICpo
ZGV2KQogewogCXN0cnVjdCBjbWRfbG9va3VwIG1hdGNoID0geyBOVUxMLCBoZGV2IH07Ci0JdTgg
c3RhdHVzLCB6ZXJvX2NvZFtdID0geyAwLCAwLCAwIH07CisJdTggemVyb19jb2RbXSA9IHsgMCwg
MCwgMCB9OwogCiAJbWdtdF9wZW5kaW5nX2ZvcmVhY2goTUdNVF9PUF9TRVRfUE9XRVJFRCwgaGRl
diwgc2V0dGluZ3NfcnNwLCAmbWF0Y2gpOwogCkBAIC05NDYyLDExICs5NDY3LDExIEBAIHZvaWQg
X19tZ210X3Bvd2VyX29mZihzdHJ1Y3QgaGNpX2RldiAqaGRldikKIAkgKiBzdGF0dXMgcmVzcG9u
c2VzLgogCSAqLwogCWlmIChoY2lfZGV2X3Rlc3RfZmxhZyhoZGV2LCBIQ0lfVU5SRUdJU1RFUikp
Ci0JCXN0YXR1cyA9IE1HTVRfU1RBVFVTX0lOVkFMSURfSU5ERVg7CisJCW1hdGNoLm1nbXRfc3Rh
dHVzID0gTUdNVF9TVEFUVVNfSU5WQUxJRF9JTkRFWDsKIAllbHNlCi0JCXN0YXR1cyA9IE1HTVRf
U1RBVFVTX05PVF9QT1dFUkVEOworCQltYXRjaC5tZ210X3N0YXR1cyA9IE1HTVRfU1RBVFVTX05P
VF9QT1dFUkVEOwogCi0JbWdtdF9wZW5kaW5nX2ZvcmVhY2goMCwgaGRldiwgY21kX2NvbXBsZXRl
X3JzcCwgJnN0YXR1cyk7CisJbWdtdF9wZW5kaW5nX2ZvcmVhY2goMCwgaGRldiwgY21kX2NvbXBs
ZXRlX3JzcCwgJm1hdGNoKTsKIAogCWlmIChtZW1jbXAoaGRldi0+ZGV2X2NsYXNzLCB6ZXJvX2Nv
ZCwgc2l6ZW9mKHplcm9fY29kKSkgIT0gMCkgewogCQltZ210X2xpbWl0ZWRfZXZlbnQoTUdNVF9F
Vl9DTEFTU19PRl9ERVZfQ0hBTkdFRCwgaGRldiwKLS0gCjIuNDYuMQoK
--000000000000ed7c520623acd281--
