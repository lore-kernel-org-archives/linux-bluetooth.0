Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357501CFB9
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 06:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721888081; cv=none; b=aohEEDO9BZgWia2hnRiHrOUsUHnvapy2pi9flWO1ZEkW3/6VrYW21yKRtR1jttKNEiXiZTGPckjiZW2IFYpeGMtSlGtirSsto47OVv9+kuNLNANHOo+m0esaZG578p4FlbP/ayE9HHqM8hjtyp/NkyxtAxefHxgBlHIqY4cowXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721888081; c=relaxed/simple;
	bh=CvxAesfzIrfbfHs2Uk6unz+GAuvTKflksRROPC3boHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNtZJC/kkMXYFCNS2Z32F4o0rdlcWorWfR9QpiMRNTOfTzGpQ3wtDk2RQVdM9b4cZG/HXZJYW5tXw8n1RF2ktFfvXKa9pidjoA0uRNWX4bl8mqHK1DBIWi4RLjnnIapGti7rxMwxYZne8l8gfm9q0kPKbJ3Po/R0Ik3oPt6Lbh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=FDXNCSST; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="FDXNCSST"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2ed592f6so6072431fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 23:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1721888076; x=1722492876; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tlWI1D0KHQ839y/TrYgnZSfwUx6qXw3bKbIt0ygp4QM=;
        b=FDXNCSSTpA6WgmDJkC2nGAWlOZzGoeULhJLRNNagSVu2YheUgp7q0LHaEW2LV4XvmG
         r0BrDM7nJdFwwysicfBIv1g7UNIQP5yy4BF9UjMUKwCyxWJvQfb5F0Lx8NLgIjBq9NDC
         k50fAyn3qXNfBjNp3p8J5pN/WNDYJWhCpq4mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721888076; x=1722492876;
        h=in-reply-to:autocrypt:from:references:cc:to:content-language
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlWI1D0KHQ839y/TrYgnZSfwUx6qXw3bKbIt0ygp4QM=;
        b=Fip7wMRCLfYmU5iWfgkNG2bE74mEG7Mzm/jzvKSUWgU3tafRLZiUcvQOP8H4bzlDAZ
         AeaAl59m1N+rp5uFGdAV+xARZlUNrMCtTgwRTwSmQf4zIwPdkI3ZU4IQQ1SmbRLDPwHd
         M4szNfXWtpC+5cIWCfkiDSM9MG485x2Rv8z9kOCbpnbrxrnRwzXQJWmJkAZgXLX8Mn5h
         JcIhnsDNNLONzv8rgE3bxpGxbusF90UbS9cJ9w+Cjqj9ihZGnlCZu8GO7DET6vTLzfnM
         Z2k8lkLvIz4IunOUicqKx1b37TVj7DCu59lvYCQeY3Ro2LLKPnQ8s3P+lnVRfz6YG+LU
         NBXw==
X-Forwarded-Encrypted: i=1; AJvYcCVLMvscjjJy3WRVgc4dIpIy0Ir5KD1iIKD6q+5blrRtH3L5RFPSnZgOJmnSTpx4hn8UzKShNkX1KyrNB9O5o2qwzvS7uIlXNxIrkgvA/wnx
X-Gm-Message-State: AOJu0YxCf64zSl7QYrNeIkjAw17y3c1OVfF/WwVd2uY+Ptz+7rC6WQxb
	U1LJ1Naojk6yxWw2MWkNnhWc9gpEhiP10VT3ANFr9VzZ7uYJBX0i+QU9N5Xi2Jc=
X-Google-Smtp-Source: AGHT+IFikUtxZhVEJ4p34KRhGwC2HMhPpEjzVHARuEjnGuUfy0k8tpnAKY2CzrlnLYD/CeFPGWME3A==
X-Received: by 2002:a2e:868e:0:b0:2ef:2ed2:25b1 with SMTP id 38308e7fff4ca-2f03db909b0mr5539411fa.20.1721888075885;
        Wed, 24 Jul 2024 23:14:35 -0700 (PDT)
Received: from [10.1.15.122] (vpn.streamunlimited.com. [91.114.0.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a1d7445a75sm44531885a.110.2024.07.24.23.14.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jul 2024 23:14:34 -0700 (PDT)
Message-ID: <e797e7d3-8d6f-46a9-8ad2-af9435c24beb@streamunlimited.com>
Date: Thu, 25 Jul 2024 08:14:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Generic BlueZ Host Qualification
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Oliver.Staude@avnet.eu, Alex Lu <alex_lu@realsil.com.cn>,
 Ron Wong <ron.wong@nxp.com>, Chris Laplante
 <Chris.Laplante@lairdconnect.com>, Arkadiusz Bokowy <a.bokowy@samsung.com>,
 =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>,
 "Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
References: <CABBYNZL9Tu2mdZeYdwgYuzATbvUMDxJb1T9jznnkxzscS0eLxA@mail.gmail.com>
 <CABBYNZLFj_94qXh0FSSpgy+oepXByN==nj=Fbcm=h3c4YM975Q@mail.gmail.com>
From: Hannes Riedl <hannes.riedl@streamunlimited.com>
Autocrypt: addr=hannes.riedl@streamunlimited.com; keydata=
 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
 egNXE4hlaCPZcdOkAwYgvs/p1w==
In-Reply-To: <CABBYNZLFj_94qXh0FSSpgy+oepXByN==nj=Fbcm=h3c4YM975Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ymb6Rwe6MEPspFRp9VtPDBx4"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ymb6Rwe6MEPspFRp9VtPDBx4
Content-Type: multipart/mixed; boundary="------------Y08piq6JMQq7TeEk3YcRX7l2";
 protected-headers="v1"
From: Hannes Riedl <hannes.riedl@streamunlimited.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Oliver.Staude@avnet.eu, Alex Lu <alex_lu@realsil.com.cn>,
 Ron Wong <ron.wong@nxp.com>, Chris Laplante
 <Chris.Laplante@lairdconnect.com>, Arkadiusz Bokowy <a.bokowy@samsung.com>,
 =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>,
 "Naga Bhavani Akella (QUIC)" <quic_nakella@quicinc.com>
Message-ID: <e797e7d3-8d6f-46a9-8ad2-af9435c24beb@streamunlimited.com>
Subject: Re: Generic BlueZ Host Qualification
References: <CABBYNZL9Tu2mdZeYdwgYuzATbvUMDxJb1T9jznnkxzscS0eLxA@mail.gmail.com>
 <CABBYNZLFj_94qXh0FSSpgy+oepXByN==nj=Fbcm=h3c4YM975Q@mail.gmail.com>
In-Reply-To: <CABBYNZLFj_94qXh0FSSpgy+oepXByN==nj=Fbcm=h3c4YM975Q@mail.gmail.com>

--------------Y08piq6JMQq7TeEk3YcRX7l2
Content-Type: multipart/alternative;
 boundary="------------UqCjtTBhDLUiR5bXpeGd0wza"

--------------UqCjtTBhDLUiR5bXpeGd0wza
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgTHVpeiwNCg0KdGhhbmtzIGZvciBmb2xsb3dpbmctdXAuDQoNCkkgbG9va2VkIHVwIHRo
ZSBsaXN0aW5ncywgYXMgZXhwZWN0ZWQgbW9zdCBvZiB0aGVtIHNoYXJlIHRoZSBjb3JlIElD
UywgDQpidXQgdGhlcmUgaXMgYSBsb3Qgb2YgdmFyaWF0aW9uIGluIHByb2ZpbGVzIGFuZCBz
ZXJ2aWNlcy4NCg0KV2UgYXJlIHdvcmtpbmcgb24gTEUgQXVkaW8gdXNlIGNhc2VzIGFuZCBh
cmUgbW92aW5nIHRvd2FyZHMgdGhlIG5lZWQgZm9yIA0KcXVhbGlmaWNhdGlvbiBzb29uLiBJ
J20gc3RpbGwgdmVyeSBtdWNoIGludGVyZXN0ZWQgaW4gYSBjb21tb24gbGlzdGluZywgDQpi
dXQgbm90IHN1cmUgd2hvIGVsc2UgaXMgd29ya2luZyBpbiB0aGF0IGFyZWEuIExvb2tpbmcg
YXQgdGhlIFRDUkwsIHRoZSANCm51bWJlciBvZiB0ZXN0IGNhc2VzIGlzIGh1Z2UuIEZyb20g
b3VyIGV4cGVyaWVuY2Ugd2l0aCBxdWFsaWZ5aW5nIA0KY2xhc3NpYyBCVCBBdWRpbywgd2Ug
YXNzdW1lIHRoYXQgTEUgQXVkaW8gd2lsbCBhbHNvIHJlcXVpcmUgc2lnbmlmaWNhbnQgDQpl
ZmZvcnRzIHRvIHdyaXRlIGNvZGUvcGF0Y2hlcyB3aGljaCBzdXBwb3J0IGV4ZWN1dGlvbiBv
ZiB0aGUgdGVzdCBjYXNlcyANCmR1cmluZyBxdWFsaWZpY2F0aW9uLg0KDQpJIHdvdWxkIGFw
cHJlY2lhdGUgdG8gZm9ybSBhIHN0ZWVyaW5nIGdyb3VwLCBvciBtYXliZSB0YWtlIHRoaXMg
DQpjb252ZXJzYXRpb24gYXMgYSB0cmlnZ2VyIHRvIHN0aWxsIGRpc2N1c3Mgb3VyIGlkZWFz
IG9uIGdpdGh1Yi4gUHJvYmFibHkgDQphIGZpcnN0IHN0ZXAgdG8gbW92ZSBmb3J3YXJkIHdv
dWxkIGJlIHRvIGNvbGxlY3QgYSBjb21tb24gbGF5ZXIgDQpzZWxlY3Rpb24gKGkuZS4gbGlz
dCBvZiBjb3JlIHNwZWMgbGF5ZXJzLCB0cmFkaXRpb25hbCBwcm9maWxlcyBhbmQgTEUgDQpw
cm9maWxlcyBhbmQgc2VydmljZXMgaW5jbC4gTEUgQXVkaW8pIGZvciBzdWNoIGEgZ2VuZXJp
YyBkZXNpZ24gKHdpdGggDQp0aGUgbmV3IHF1YWxpZmljYXRpb24gdG9vbCwgdGhlIHN1Yi1z
eXN0ZW1zIGRlZmluaXRpb25zIHNlZW0gdG8gYmUgDQpvdXRkYXRlZCBzaW5jZSBKdWx5IDFz
dCk/IEJhc2VkIG9uIHRoZSBkZXNpcmVkIGxheWVycywgd2UgY2FuIHRoZW4gbG9vayANCnVw
IHdoaWNoIGNvbXBhbmllcyBoYXZlIGV4cGVyaWVuY2UgaW4gSUNTIHNwZWNpZmljYXRpb24g
YW5kIHRlc3QgZXhlY3V0aW9uLg0KDQpMb29raW5nIGZvcndhcmQgdG8gcmVjZWl2aW5nIHlv
dXIgb3Bpbmlvbi4NCg0KQmVzdCByZWdhcmRzDQoNCkhhbm5lcw0KDQoNCk9uIDI0LjA3LjI0
IDIwOjMwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSwNCj4NCj4gT24g
VHVlLCBBcHIgMTYsIDIwMjQgYXQgMToxOOKAr1BNIEx1aXogQXVndXN0byB2b24gRGVudHoN
Cj4gPGx1aXouZGVudHpAZ21haWwuY29tPiAgd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBJIGNy
ZWF0ZWQgYSBkaXNjdXNzaW9uIGluIGdpdGh1YiBpbiBhdHRlbXB0IHRvIGdhdGhlciBpbmZv
cm1hdGlvbg0KPj4gYWJvdXQgY29tcGFuaWVzIHF1YWxpZnlpbmcgQmx1ZVogYW5kIGlmIHRo
ZXkgd291bGQgYmUgaW50ZXJlc3RlZCBpbg0KPj4gaGF2aW5nIGEgZ2VuZXJpYyBIb3N0IFN0
YWNrIFF1YWxpZmljYXRpb246DQo+Pg0KPj4gaHR0cHM6Ly9naXRodWIuY29tL29yZ3MvYmx1
ZXovZGlzY3Vzc2lvbnMvODE3DQo+Pg0KPj4gU29tZSBvZiB0aGUgYmVuZWZpdHMgd291bGQg
YmUgdGhhdCBub3Qgb25seSBjb21wYW5pZXMgY2FuIHJldXNlIHRoZQ0KPj4gc2FtZSBsaXN0
aW5nIG9uIHRoZWlyIHByb2R1Y3RzIGJ1dCB3ZSBhY3R1YWxseSBjb3VsZCBhdHRlbXB0IHRv
IGRvDQo+PiBtb3JlIGF1dG9tYXRpb24gYW5kIHVzZSB0aGUgcXVhbGlmaWNhdGlvbiBwcm9j
ZXNzIHRvIHN0YWJpbGl6ZSB0aGUNCj4+IHN0YWNrLg0KPj4NCj4+IE5vdGU6IElmIHlvdSBh
cHBlYXIgaW4gdGhlIENDIGlzIHRoYXQgYmVjYXVzZSB5b3UgaGF2ZSBjb250cmlidXRlZCB0
bw0KPj4gQmx1ZVogYW5kIHlvdXIgY29tcGFueSBoYXMgYSBxdWFsaWZpY2F0aW9uIGxpc3Rl
ZCBpbiB0aGUgZGlzY3Vzc2lvbg0KPj4gYWJvdmUuDQo+Pg0KPj4gTm90ZSAyOiBJIHdvdWxk
IHN1Z2dlc3Qgbm90IHN0YXJ0IHdpdGggZGlzY3Vzc2lvbnMgYWJvdXQgaG93IHRvIGZ1bmQN
Cj4+IHRoZSBxdWFsaWZpY2F0aW9uLCBvciB3aG8gc2hhbGwgYmUgdGhlIGNvbXBhbnkgaW4g
dGhlIGxpc3RpbmcsIHNpbmNlDQo+PiBmb3IgdGhhdCB3ZSBtaWdodCB3YW50IHRvIGludm9s
dmUgdGhlIGxpa2VzIG9mIExpbnV4IEZvdW5kYXRpb24uDQo+IFNpbmNlIG5vYm9keSBpcyBy
ZXNwb25kaW5nIHBlcmhhcHMgd2Ugc2hvdWxkIGF0dGVtcHQgdG8gZmlyc3QNCj4gZXN0YWJs
aXNoIHNvbWUgc3RlZXJpbmcgZ3JvdXAgdG8gZGlzY3VzcyBob3cgdG8gbW92ZSBmb3J3YXJk
Lg0KPg0KLS0gDQoNCipfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fKg0KDQoqSGFubmVzIFJpZWRsKg0KRGly
ZWN0b3IsIFN0cmVhbVNESw0KDQoqU3RyZWFtVW5saW1pdGVkIEVuZ2luZWVyaW5nIEdtYkgq
DQpIaWdoIFRlY2ggQ2FtcHVzLCBHdXRoZWlsLVNjaG9kZXItR2Fzc2UgMTAsIDExMDAgVmll
bm5hLCBBdXN0cmlhDQpQaG9uZTogKzQzLTEtNjY3MjAwMi0zNjY0OyBGYXg6ICs0My0xLTY2
NzIwMDItNDQwMQ0KU2t5cGU6IGhhbm5lcy5yaWVkbA0Kd3d3LnN0cmVhbXVubGltaXRlZC5j
b20gPGh0dHA6Ly93d3cuc3RyZWFtdW5saW1pdGVkLmNvbS8+DQoNCg==
--------------UqCjtTBhDLUiR5bXpeGd0wza
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi Luiz,</p>
    <p>thanks for following-up.</p>
    <p>I looked up the listings, as expected most of them share the core
      ICS, but there is a lot of variation in profiles and services.</p>
    <p>We are working on LE Audio use cases and are moving towards the
      need for qualification soon. I'm still very much interested in a
      common listing, but not sure who else is working in that area.
      Looking at the TCRL, the number of test cases is huge. From our
      experience with qualifying classic BT Audio, we assume that LE
      Audio will also require significant efforts to write code/patches
      which support execution of the test cases during qualification.</p>=

    <p>I would appreciate to form a steering group, or maybe take this
      conversation as a trigger to still discuss our ideas on github.
      Probably a first step to move forward would be to collect a common
      layer selection (i.e. list of core spec layers, traditional
      profiles and LE profiles and services incl. LE Audio) for such a
      generic design (with the new qualification tool, the sub-systems
      definitions seem to be outdated since July 1st)? Based on the
      desired layers, we can then look up which companies have
      experience in ICS specification and test execution.</p>
    <p>Looking forward to receiving your opinion.</p>
    <p>Best regards</p>
    <p>Hannes</p>
    <p>=C2=A0<br>
    </p>
    <div class=3D"moz-cite-prefix">On 24.07.24 20:30, Luiz Augusto von
      Dentz wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CABBYNZLFj_94qXh0FSSpgy+oepXByN=3D=3Dnj=3DFbcm=3Dh3c4YM975Q@m=
ail.gmail.com">
      <pre class=3D"moz-quote-pre" wrap=3D"">Hi,

On Tue, Apr 16, 2024 at 1:18=E2=80=AFPM Luiz Augusto von Dentz
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:luiz.dentz@gmail.com">&=
lt;luiz.dentz@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">
Hi,

I created a discussion in github in attempt to gather information
about companies qualifying BlueZ and if they would be interested in
having a generic Host Stack Qualification:

<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/orgs/bluez/=
discussions/817">https://github.com/orgs/bluez/discussions/817</a>

Some of the benefits would be that not only companies can reuse the
same listing on their products but we actually could attempt to do
more automation and use the qualification process to stabilize the
stack.

Note: If you appear in the CC is that because you have contributed to
BlueZ and your company has a qualification listed in the discussion
above.

Note 2: I would suggest not start with discussions about how to fund
the qualification, or who shall be the company in the listing, since
for that we might want to involve the likes of Linux Foundation.
</pre>
      </blockquote>
      <pre class=3D"moz-quote-pre" wrap=3D"">
Since nobody is responding perhaps we should attempt to first
establish some steering group to discuss how to move forward.

</pre>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      <meta http-equiv=3D"CONTENT-TYPE" content=3D"text/html; charset=3DU=
TF-8">
      <title></title>
      <p><font face=3D"Arial, sans-serif"><font size=3D"2"><b>___________=
___________________________________________________________</b></font></f=
ont></p>
      <p><font face=3D"Arial, sans-serif"><font size=3D"2"><b>Hannes Ried=
l</b></font></font><br>
        <font face=3D"Arial, sans-serif"><font size=3D"1">Director,
            StreamSDK<br>
          </font></font></p>
      <font face=3D"Arial, sans-serif"><font size=3D"1">
          <b><font face=3D"Arial, sans-serif"><font size=3D"2">StreamUnli=
mited
                Engineering GmbH</font></font></b><br>
          <font face=3D"Arial, sans-serif"><font size=3D"1">High Tech
              Campus, Gutheil-Schoder-Gasse 10, 1100 Vienna, Austria<br>
              Phone: +43-1-6672002-3664; Fax: +43-1-6672002-4401<br>
              Skype: hannes.riedl<br>
              <a href=3D"http://www.streamunlimited.com/">www.streamunlim=
ited.com</a></font></font>
          <p></p>
        </font></font></div>
  </body>
</html>

--------------UqCjtTBhDLUiR5bXpeGd0wza--

--------------Y08piq6JMQq7TeEk3YcRX7l2--

--------------ymb6Rwe6MEPspFRp9VtPDBx4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEmn6rG0FP5T4B6Baq2d96wRDLBnEFAmah7UgFAwAAAAAACgkQ2d96wRDLBnFc
SQ//TlZspE42GJyzy5po0baS7K18QPKE/u4J4z0SXvheWU7Ct6W5z0d0h3IvzQdlaPm1o5Bzw9D+
gZiR4N7Udjp4ltJSbtL2wLJzmRlS3AcpTYNmecLAFymnSqUT6L3qrGNPiAm2V4y9VIgUPHV/5wtX
oeNB69jf7230QbGfGjllkev49kzyEm8DOh7dyZuaLQZ2Ma868qObRBmPpJw58czyBCCK7wLQXVwW
i8Tiilh9dk8/w3fxznex48GPC/sF9najfYbD3DH2kzW0aV6Iq2co2O4avVC4vYGtBbxAK9d3GPGi
HOqYNCk2/8KHM/bQnuX7LGYT/w88p5cwm6DMUk6lsT9igzvpv7VCZxC3Uk4OfysvJ/ZtB4GozNem
DVMs0mFsMYSy9V27LFabSgsf5ILfEj9e+D4rrNnBzlE3827owOvoCQADXyNtsEbYCQ7UiCqRaEAY
mQaxQHP+CP5KX2dQyPkXu6GC+/lJigmeK0zL8VWt3IcH6sNplFu6cc5kq8dAjnGeYPAR3IdrMIeM
Ud9q4j6aRuNtTbx4k5IZUpjqG1GuHeAGKlesYxf8yn+EN7DXRCgXpWpvTDfvlhV/m2iPCfj0Raif
Ygn7EbrbO5dzqD2cWKxRqM3zGqGxgbItk30yLnq7Ex/3jOQvn2UiJJ+8eaGDrRRYnxVtJYHrpKos
rSc=
=G2oR
-----END PGP SIGNATURE-----

--------------ymb6Rwe6MEPspFRp9VtPDBx4--
