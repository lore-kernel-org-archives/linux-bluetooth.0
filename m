Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594A725A2AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154420; cv=none; b=MI0zCTan3149oE/JvDCa2aUDl++YjoP4hFqsMhQZ7MHH7C9PEQlmw0rW9AmgZHddMJCD4tePLHxwA20LBhGoPCxpNJN7Fi7LJKFAN2k6AJklZP9EiOG3vkzPSWbvlMcOWVULGTxJcCi/6ZwbPt/7LhDTa6EJEGJmjc2W0h/0h8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154420; c=relaxed/simple;
	bh=0/1igUaDhWpSXRgh1BHc7cwtLC+Yg6q7YoNmXcuA2l4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3jDS3e49ze36Z1bj2gZzYaawmH9LAdDS+7ZS8PE5R8AnaX7Av3T44NFBbYVEpTTzi3PkULcijFjZTZkQysBP+Wmt4bk79GAmO0b/xU4wA4Up2olByyeyusDG8kBUegHS9WSS87T8dCGmzijnU7NTB5jT7cPBmvdTgmR7U/L3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YarwcXrH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YarwcXrH"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-32f1df5703aso7388041fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752154414; x=1752759214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx+ubdGqjDfX12vJp3ga3JtXs7CDCQyyaCpmwUGudlM=;
        b=YarwcXrHnYixVn75PCvqr9/1YuMAfUSF1ESitGAVxQQxBlepBXW2ecsiAHOBI9j253
         NdoeX2Q3DoFteIZxzJ9zCJnwfBrIQHV7EPsOGNEenkAYmImkfSa2OVebVeUr/ZC/x2vF
         /QICAi7NlJsibI+4FrT0m4Z87GQNNJj9RTxeKNFnQ8s8yp6SVvwShTx+LKM4kUx5fiKO
         jzCi/K/jXynBiSdsQPwpz4OauDZbWpZrtNJpUeyJZjKUvvD1PX1XHXJE4KzrLnBbxuPB
         i5S3yb43xHx6S18C+mHjmm0gBQM3AOdePIFWITVFP7NvKvBQ26v+ER1Dk9o75OWPTYWN
         SfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154414; x=1752759214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tx+ubdGqjDfX12vJp3ga3JtXs7CDCQyyaCpmwUGudlM=;
        b=BPYhab1UItbIlb3n+bAoR+ee2aj0iaveGIm0NJ5ZIInv0cuocSI/wco5LnaAIC0/Ey
         ulD2x0RT03HJO5lDJvir7zN5yQVN2L9wyk3vhBBe4SqgLccJ24ST9LgbJKEFrHqSbCa4
         FxvTQ2oFW/9k9ou6qivOL4EfwCY6B6VMtvobdvs2Hz3+wn5egMlSFl6uHajFu5tl2kOZ
         iHNX3GPpRAWYiLXjBHbxFW6w+4Y3D6n5uAeJ8iSZ6Q6UrUz4YGo67Vnitn5De+S9rl/p
         x4r9zQRpohA6h0U8nvyDxDwoy9mz2yJP783XEfP/6YvA4LuK9HJRaV0/3aeuxZN+cNac
         EIBg==
X-Gm-Message-State: AOJu0Yzf9BhBqcw/e13jBEnereSXuDKTNVHMBoivIgsdKHSYPqiSvpcL
	JcC/zWeM+R8nahSb0GPoix069DmzqJ+g3ppLGZv455VFxduE/wphUfQpG6nbMRlStlreT3fNoPk
	19z6+z+UUbeTf29fGcUg4N5EH26gW5qiOSY+u
X-Gm-Gg: ASbGncsNszGwFhXdd9jV12faIKSFMKInyucyw/G/rY9AgL5ODlI2jdfnI+UEKopixMa
	Ff5l3NLLoRdmUCq7bEvZsb7QQUVWiXKd3VE50tSZob9n12p6lfGgaBL+cGmrZ8sQlDIF5B3Ejci
	3Oph9LKtusEEcHTqh9kFmkOYK3BdwgkmnGU39iLwFe0n9ZD/hbVhhg
X-Google-Smtp-Source: AGHT+IHRPPucdHUWbeH7PKG23pdDJI3XeFrVE9Buo8X12W8km8kuMOhTNEFjzf8yOm8bpZqY3E6nbp2MAP8ozRpYdP0=
X-Received: by 2002:a2e:be07:0:b0:32c:c397:f9b4 with SMTP id
 38308e7fff4ca-32f48561f1emr23206491fa.26.1752154413993; Thu, 10 Jul 2025
 06:33:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709191333.3374053-1-luiz.dentz@gmail.com>
 <CABBYNZJLLWu2EEEsZ+tE0+0H4o1ba3gG2ab9dLaPbAxz2BzGmA@mail.gmail.com> <CABtds-0U4mD9kr708UdB+SAHRvBAPYrEaOSCjKkqTDXjJpWOUw@mail.gmail.com>
In-Reply-To: <CABtds-0U4mD9kr708UdB+SAHRvBAPYrEaOSCjKkqTDXjJpWOUw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 10 Jul 2025 09:33:20 -0400
X-Gm-Features: Ac12FXwg18cz1824tTLyPXqCL0x4V-FfcftQid6etHxtTxaFtkqtvou9AwCbA8I
Message-ID: <CABBYNZ+Xo8Ou=dLfHhPVfiqMCehh23aFY=G+KRMb6d9uoKxjjQ@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Check if controller is ISO capable
 on btintel_classify_pkt_type
To: Sean Rhodes <sean@starlabs.systems>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sean,

On Thu, Jul 10, 2025 at 9:18=E2=80=AFAM Sean Rhodes <sean@starlabs.systems>=
 wrote:
>
> Hi Luiz
>
> Yes, works perfectly with that patch.
>
> Thanks
>
> Sean
>
> On Wed, 9 Jul 2025 at 21:06, Luiz Augusto von Dentz <luiz.dentz@gmail.com=
> wrote:
>>
>> Hi Sean,
>>
>> On Wed, Jul 9, 2025 at 3:13=E2=80=AFPM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>> >
>> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> >
>> > Due to what seem to be a bug with variant version returned by some
>> > firmwares the code may set hdev->classify_pkt_type with
>> > btintel_classify_pkt_type when in fact the controller doesn't even
>> > support ISO channels feature but may use the handle range expected fro=
m
>> > a controllers that does causing the packets to be reclassified as ISO
>> > causing several bugs.
>> >
>> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D219553
>> > Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2100565
>> > Link: https://github.com/StarLabsLtd/firmware/issues/180
>> > Fixes: f25b7fd36cc3 ("Bluetooth: Add vendor-specific packet classifica=
tion for ISO data")
>> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>> > ---
>> >  drivers/bluetooth/btintel.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
>> > index 55cc1652bfe4..06575a0b9aee 100644
>> > --- a/drivers/bluetooth/btintel.c
>> > +++ b/drivers/bluetooth/btintel.c
>> > @@ -2670,7 +2670,7 @@ static u8 btintel_classify_pkt_type(struct hci_d=
ev *hdev, struct sk_buff *skb)
>> >          * Distinguish ISO data packets form ACL data packets
>> >          * based on their connection handle value range.
>> >          */
>> > -       if (hci_skb_pkt_type(skb) =3D=3D HCI_ACLDATA_PKT) {
>> > +       if (iso_capable(hdev) && hci_skb_pkt_type(skb) =3D=3D HCI_ACLD=
ATA_PKT) {
>> >                 __u16 handle =3D __le16_to_cpu(hci_acl_hdr(skb)->handl=
e);
>> >
>> >                 if (hci_handle(handle) >=3D BTINTEL_ISODATA_HANDLE_BAS=
E)
>> > --
>> > 2.50.0
>>
>> Can you try with the changes above?
>>
>> --
>> Luiz Augusto von Dentz

Please add Tested-by so we can move to get it merged, I do intend to
send a pull request later this week.

--=20
Luiz Augusto von Dentz
