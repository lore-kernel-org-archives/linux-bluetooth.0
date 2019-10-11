Return-Path: <SRS0=4il6=YE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71887ECE58C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355C6206A1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Oct 2019 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Db5VQuoR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfJKM72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Oct 2019 08:59:28 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40356 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfJKM72 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Oct 2019 08:59:28 -0400
Received: by mail-ot1-f50.google.com with SMTP id y39so7859116ota.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2019 05:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+uBbQBTRcve9CY4gg5jOnEOE7ACPZXueSOGm6atFp8=;
        b=Db5VQuoRuAx9H28+ZlTqY09zvCQlrnk9LilJp55O0oyswOJ29wb9dxOaRkVSoCm7LU
         qPiFGjDcf42hcSHsZ4lCJ9dRZbFlsnIo4BMRv87W2vVMHw+GrPNoakXqjnZiCm49dBkq
         6ZzOXJh+cHSWfamNGQEmV/0OmoNTkeW3t8sPRlYWKkPlY3LyRSlT5xA+/P3v//Wxz5xc
         +GjAXlK6ZuUOVhIL4c4r3enx0wDfYbEu0er/k0fAQMn3xdNEe57qs2utQ9+OFuSSiWVv
         nUUGX9NdJ8i92iwN2miVCjAiDv00CWYAD4gpEiRAqHjv0oo30lbX388PUNEGWR3XeSn2
         67uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+uBbQBTRcve9CY4gg5jOnEOE7ACPZXueSOGm6atFp8=;
        b=W2OXhmhVTuNV9ZnRtmUlM1xRXAWrCoLq0ykpyINfotaBX3yagI5RdGfb8VFN/MWLRn
         4SXRioAv629gIeTTUgBJZ3IZgCdy7+98LjvhuZVyF1QsQbcQOnSQIC55TOnAQAKykaPP
         9Rnx+pnG2or3asXABkkoZzA9Uf8DYLiJCcCyCdsIKI0V6IYn5pmB+oejJX04B9PFV0ZB
         mBQv9P10/zLa2FWnci6Kw6M/1zhGA3eydON116DA9oodaNQ2AQRKsKgtLJ/JXx0Wxiuk
         RWitAeH/oHTNiOn6Jvks6Qzxl5rH7YKWPguc7zDWw9SpqaM1gfM9TUVdUV8P7/XygAJP
         xP4g==
X-Gm-Message-State: APjAAAWHhJp4GJa5eF4KZoA9BReSkDYlbF6FFFdPA2vhKlkg0Q2pc4R4
        0DMQHLthBXozc7oY/f1aw2L9PVz8t/CpNW6ycHeesS3uf7w=
X-Google-Smtp-Source: APXvYqxCzlCkhK3bfko83yDQWDotOCqKaagJY8uB/CmC+8EEbg9v9gz41ABdsdMNv65nqQRVr2kBgQAFkHoaPCQU33M=
X-Received: by 2002:a05:6830:1203:: with SMTP id r3mr9060512otp.11.1570798766981;
 Fri, 11 Oct 2019 05:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ0=ZJ2rjxM0WmA72J5VCcUZ01q7dH+jxJi7btGzayZWHe7S1Q@mail.gmail.com>
 <CABBYNZ+DYrzhx3Riqt2SFV4ZoL5VHfOnVPH0ScHMRz=+XoBg6Q@mail.gmail.com>
 <CAJ0=ZJ1pD4dHZe98eZnZ6R-ZBazGip_mrPVV_XjFgThXM0Ebmg@mail.gmail.com>
 <CABBYNZLZFpq_aKpmWFG3mG9oEP7Ly4=5WbJHK3mqGsQgH8Da2g@mail.gmail.com>
 <CABBYNZ+GhHtnDi-FCu0N2xoEc_0eTtPMsW+N+GMM6S7buy1-Xw@mail.gmail.com> <CAJ0=ZJ17vp_N-P2df6xzVON5yTr0U1v5jk7LTYfrgCpcu6kfBg@mail.gmail.com>
In-Reply-To: <CAJ0=ZJ17vp_N-P2df6xzVON5yTr0U1v5jk7LTYfrgCpcu6kfBg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 11 Oct 2019 15:59:13 +0300
Message-ID: <CABBYNZ+3hobO1HkoKru0Z_NXgyPz-6BDqpWr6vEDktAOku8qVA@mail.gmail.com>
Subject: Re: Bluez stopped connecting A2DP sink
To:     yayfortrees <yayfortrees@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000085335c0594a2161c"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--00000000000085335c0594a2161c
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Oct 10, 2019 at 11:13 PM yayfortrees <yayfortrees@gmail.com> wrote:
>
> Hello,
>
> I've attached debug logs for 5.50 nopatch and 5.50 with the patch.
>
> To me it looked like it may be a timing issue - trying to connect the
> a2dp sink too early. As an experiment I put a sleep(1) at the top of
> the hs_cb function from your patch and the a2dp sink was connected.
> With the sleep I still get the "Device or resource busy" error early
> on, but it does reconnect the a2dp sink later in the connection and
> things work. It's not consistent though, maybe 1 of 5 attempts would
> fail to connect the a2dp profile.

Try with the following patch.

> I included that debug log as well.
>
> Hope this helps, thanks!
>
> On Thu, Oct 10, 2019 at 2:10 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi,
> >
> > On Wed, Oct 9, 2019 at 10:51 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Oct 9, 2019 at 1:56 AM yayfortrees <yayfortrees@gmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > I've attached btmon traces for 5.50 and 5.51. Thanks for taking a look!
> > > >
> > > > Let me know if you need anything else.
> > >
> > > Must likely the following error has something to do with it:
> > >
> > > = bluetoothd: a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2:
> > > Device or resource busy
> > >
> > > I will check why this could be happening.
> >
> > I tried this one and couldn't reproduce with the headsets I have,
> > could you please run bluetooth -dn and attach the logs here?
> >
> > > > On Tue, Oct 8, 2019 at 4:24 AM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Mon, Oct 7, 2019 at 10:34 PM yayfortrees <yayfortrees@gmail.com> wrote:
> > > > > >
> > > > > > Hello,
> > > > > >
> > > > > > I recently upgraded bluez to 5.51 from 5.50 and my headphones stopped
> > > > > > using the A2DP sink during autoconnect. The headphones instead go to
> > > > > > HSP/HFP mode and the A2DP sink is disabled in pavucontrol/pactl. The
> > > > > > A2DP sink will only work when the device is initially paired.
> > > > > >
> > > > > > This had worked flawlessly for years. I was able to track down the
> > > > > > regression to this patch:
> > > > > > https://www.spinics.net/lists/linux-bluetooth/msg76180.html ([PATCH
> > > > > > BlueZ] policy: Add logic to connect a Sink). If I apply the patch to
> > > > > > 5.50, my headphones no longer connect to the A2DP sink, if I remove it
> > > > > > the problem goes away.
> > > > > >
> > > > > > Not sure what else I should include to help track this down. The
> > > > > > headphones I'm using are Beats Wireless (Solo Bluetooth).
> > > > > >
> > > > > > The only relevant log entry I see with the patch applied is:
> > > > > > a2dp-sink profile connect failed for 34:DF:2A:0D:F8:C2: Device or resource busy
> > > > >
> > > > > Can you collect the HCI traces of the problem using btmon? I didn't
> > > > > expect that to cause any problems, it should in theory solve them but
> > > > > lets see.
> > > > >
> > > > > > Let me know if any other information is needed.
> > > > > > Thanks.
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Luiz Augusto von Dentz
> > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz

--00000000000085335c0594a2161c
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-audio-Fix-cancelling-disconnect-timeout.patch"
Content-Disposition: attachment; 
	filename="0001-audio-Fix-cancelling-disconnect-timeout.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k1m50mrl0>
X-Attachment-Id: f_k1m50mrl0

RnJvbSA0YmJkNDc3Y2Y2YWMwNWFmZjczZWU3NGYxOGExYTQxOGIxYzFhZjlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50
ekBpbnRlbC5jb20+CkRhdGU6IEZyaSwgMTEgT2N0IDIwMTkgMTU6NDA6MDQgKzAzMDAKU3ViamVj
dDogW1BBVENIIEJsdWVaXSBhdWRpbzogRml4IGNhbmNlbGxpbmcgZGlzY29ubmVjdCB0aW1lb3V0
CgpJZiBBVkRUUCBzZXNzaW9uIGhhcyBiZWVuIGNvbm5lY3RlZCBidXQgbm8gc3RyZWFtIGhhcyBi
ZWVuIHNldHVwIGNhbGxzCnRvIHNlcnZpY2UtPmNvbm5lY3Qgd291bGQgcmV0dXJuIC1FQlVTWSB0
byBhdm9pZCBzdHJlYW0gc2V0dXAgY29sbGlzaW9uCmJ1dCBpdCBhbHNvIHRha2VzIGEgcmVmZXJl
bmNlIHRvIHRoZSBzZXNzaW9uIHdoaWNoIGNhbmNlbGxpbmcgdGhlCmRpc2Nvbm5lY3QgdGltZW91
dCBhbmQgZGlzYWJsaW5nIHRoZSBzdHJlYW1fc2V0dXAgbG9naWMgdGhhdCB3b3VsZAphdHRlbXB0
IHRvIGVzdGFiaWxpc2ggYSBzdHJlYW0uCi0tLQogcHJvZmlsZXMvYXVkaW8vc2luay5jICAgfCAy
NSArKysrKysrKysrKystLS0tLS0tLS0tLS0tCiBwcm9maWxlcy9hdWRpby9zb3VyY2UuYyB8IDI1
ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9u
cygrKSwgMjYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvcHJvZmlsZXMvYXVkaW8vc2luay5j
IGIvcHJvZmlsZXMvYXVkaW8vc2luay5jCmluZGV4IDdjYWMyMTAzNC4uOTY2NDQwNTM0IDEwMDY0
NAotLS0gYS9wcm9maWxlcy9hdWRpby9zaW5rLmMKKysrIGIvcHJvZmlsZXMvYXVkaW8vc2luay5j
CkBAIC0yNTYsMTEgKzI1NiwxOCBAQCBnYm9vbGVhbiBzaW5rX3NldHVwX3N0cmVhbShzdHJ1Y3Qg
YnRkX3NlcnZpY2UgKnNlcnZpY2UsIHN0cnVjdCBhdmR0cCAqc2Vzc2lvbikKIAlpZiAoc2luay0+
Y29ubmVjdF9pZCA+IDAgfHwgc2luay0+ZGlzY29ubmVjdF9pZCA+IDApCiAJCXJldHVybiBGQUxT
RTsKIAotCWlmIChzZXNzaW9uICYmICFzaW5rLT5zZXNzaW9uKQotCQlzaW5rLT5zZXNzaW9uID0g
YXZkdHBfcmVmKHNlc3Npb24pOwotCi0JaWYgKCFzaW5rLT5zZXNzaW9uKQotCQlyZXR1cm4gRkFM
U0U7CisJaWYgKCFzaW5rLT5zZXNzaW9uKSB7CisJCWlmIChzZXNzaW9uKQorCQkJc2luay0+c2Vz
c2lvbiA9IGF2ZHRwX3JlZihzZXNzaW9uKTsKKwkJZWxzZQorCQkJc2luay0+c2Vzc2lvbiA9IGEy
ZHBfYXZkdHBfZ2V0KAorCQkJCQlidGRfc2VydmljZV9nZXRfZGV2aWNlKHNlcnZpY2UpKTsKKwor
CQlpZiAoIXNpbmstPnNlc3Npb24pIHsKKwkJCURCRygiVW5hYmxlIHRvIGdldCBhIHNlc3Npb24i
KTsKKwkJCXJldHVybiBGQUxTRTsKKwkJfQorCX0KIAogCXNpbmstPmNvbm5lY3RfaWQgPSBhMmRw
X2Rpc2NvdmVyKHNpbmstPnNlc3Npb24sIGRpc2NvdmVyeV9jb21wbGV0ZSwKIAkJCQkJCQkJc2lu
ayk7CkBAIC0yNzQsMTQgKzI4MSw2IEBAIGludCBzaW5rX2Nvbm5lY3Qoc3RydWN0IGJ0ZF9zZXJ2
aWNlICpzZXJ2aWNlKQogewogCXN0cnVjdCBzaW5rICpzaW5rID0gYnRkX3NlcnZpY2VfZ2V0X3Vz
ZXJfZGF0YShzZXJ2aWNlKTsKIAotCWlmICghc2luay0+c2Vzc2lvbikKLQkJc2luay0+c2Vzc2lv
biA9IGEyZHBfYXZkdHBfZ2V0KGJ0ZF9zZXJ2aWNlX2dldF9kZXZpY2Uoc2VydmljZSkpOwotCi0J
aWYgKCFzaW5rLT5zZXNzaW9uKSB7Ci0JCURCRygiVW5hYmxlIHRvIGdldCBhIHNlc3Npb24iKTsK
LQkJcmV0dXJuIC1FSU87Ci0JfQotCiAJaWYgKHNpbmstPmNvbm5lY3RfaWQgPiAwIHx8IHNpbmst
PmRpc2Nvbm5lY3RfaWQgPiAwKQogCQlyZXR1cm4gLUVCVVNZOwogCmRpZmYgLS1naXQgYS9wcm9m
aWxlcy9hdWRpby9zb3VyY2UuYyBiL3Byb2ZpbGVzL2F1ZGlvL3NvdXJjZS5jCmluZGV4IDQwODFl
MTk3MC4uMGFjMjBmZTQwIDEwMDY0NAotLS0gYS9wcm9maWxlcy9hdWRpby9zb3VyY2UuYworKysg
Yi9wcm9maWxlcy9hdWRpby9zb3VyY2UuYwpAQCAtMjU3LDExICsyNTcsMTggQEAgZ2Jvb2xlYW4g
c291cmNlX3NldHVwX3N0cmVhbShzdHJ1Y3QgYnRkX3NlcnZpY2UgKnNlcnZpY2UsCiAJaWYgKHNv
dXJjZS0+Y29ubmVjdF9pZCA+IDAgfHwgc291cmNlLT5kaXNjb25uZWN0X2lkID4gMCkKIAkJcmV0
dXJuIEZBTFNFOwogCi0JaWYgKHNlc3Npb24gJiYgIXNvdXJjZS0+c2Vzc2lvbikKLQkJc291cmNl
LT5zZXNzaW9uID0gYXZkdHBfcmVmKHNlc3Npb24pOwotCi0JaWYgKCFzb3VyY2UtPnNlc3Npb24p
Ci0JCXJldHVybiBGQUxTRTsKKwlpZiAoIXNvdXJjZS0+c2Vzc2lvbikgeworCQlpZiAoc2Vzc2lv
bikKKwkJCXNvdXJjZS0+c2Vzc2lvbiA9IGF2ZHRwX3JlZihzZXNzaW9uKTsKKwkJZWxzZQorCQkJ
c291cmNlLT5zZXNzaW9uID0gYTJkcF9hdmR0cF9nZXQoCisJCQkJCWJ0ZF9zZXJ2aWNlX2dldF9k
ZXZpY2Uoc2VydmljZSkpOworCisJCWlmICghc291cmNlLT5zZXNzaW9uKSB7CisJCQlEQkcoIlVu
YWJsZSB0byBnZXQgYSBzZXNzaW9uIik7CisJCQlyZXR1cm4gRkFMU0U7CisJCX0KKwl9CiAKIAlz
b3VyY2UtPmNvbm5lY3RfaWQgPSBhMmRwX2Rpc2NvdmVyKHNvdXJjZS0+c2Vzc2lvbiwgZGlzY292
ZXJ5X2NvbXBsZXRlLAogCQkJCQkJCQlzb3VyY2UpOwpAQCAtMjc1LDE0ICsyODIsNiBAQCBpbnQg
c291cmNlX2Nvbm5lY3Qoc3RydWN0IGJ0ZF9zZXJ2aWNlICpzZXJ2aWNlKQogewogCXN0cnVjdCBz
b3VyY2UgKnNvdXJjZSA9IGJ0ZF9zZXJ2aWNlX2dldF91c2VyX2RhdGEoc2VydmljZSk7CiAKLQlp
ZiAoIXNvdXJjZS0+c2Vzc2lvbikKLQkJc291cmNlLT5zZXNzaW9uID0gYTJkcF9hdmR0cF9nZXQo
YnRkX3NlcnZpY2VfZ2V0X2RldmljZShzZXJ2aWNlKSk7Ci0KLQlpZiAoIXNvdXJjZS0+c2Vzc2lv
bikgewotCQlEQkcoIlVuYWJsZSB0byBnZXQgYSBzZXNzaW9uIik7Ci0JCXJldHVybiAtRUlPOwot
CX0KLQogCWlmIChzb3VyY2UtPmNvbm5lY3RfaWQgPiAwIHx8IHNvdXJjZS0+ZGlzY29ubmVjdF9p
ZCA+IDApCiAJCXJldHVybiAtRUJVU1k7CiAKLS0gCjIuMjEuMAoK
--00000000000085335c0594a2161c--
