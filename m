Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D3A35CBA4
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528894; cv=pass; b=APtGXESsp5/h8E58k9Xl8/P2fdNvtX0zU9+5hY2dAyjfntDRFK5ihagaUKBkUSiUglnWjDGVsYbsMYWZHIDBg/qK85g4cfdFNzhyXjo4zUZ3pnJx+qQDMCNJz73oAB/zdsAHnAHYNTcEMNwmfiBzJTSArPLm82/dK2Q7WUnKRoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528894; c=relaxed/simple;
	bh=nVt2gpgOgR3RCi0POinUFabXj+xMkIeCmSXkJ3L0QYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYJ+zsug3Jjdf5KJwqyFLdDHmjyyhfo68PjNDj3FM7zXDUhzNHdlhMaVgdIekF2D2aDf+sqtgxbVx6C2D+NE5Y0sVNSNF2JrSplVZsMTTxD/LHhUut3TIK3tNvKOa1BCuK8pmU/dmHeHhDLWBB3np7jeDrpKSXtj9E5xI0L9JEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diMHNReV; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diMHNReV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-790ac42fd00so59508267b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Jan 2026 07:48:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769528891; cv=none;
        d=google.com; s=arc-20240605;
        b=j7ujsIGPVUvJOCs8HaNnWfI1aQhPRLK4YGORVN7w+c+jTvN85STxRM5SahzG5xgPtE
         ja/qRkudCGCMPp1OIBwNfQr1UUGKPwJygHTKCZp6jPpwD9f4NC3JaI8FTyEoN29oyem+
         3ndI0tHPt7eofa/bb8A+khcB8qGzXtCQ9Zuob9AgBoew2gAgvlibXJmtOvFkijj3auzQ
         A8PNM7g2l+lARSRIKS8foLCaqO1PfjIHt4//hDcKRWfn5sqj5LgX3bWlqOjC0df8DHVg
         2OEYd0q7wtFqjxXUVZ0gbNdNiGXHQ12CPZ0E24LbefSZaiX6cpw8pQ0+H1IKM4YjJu7P
         aWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VDiCGgmRF+wYc1VBBOMRuOPdjAE6txRYcyUQ+FEe7Lk=;
        fh=aeZsIr/xQR2w5OLm1PwgODz06spZdYTSGA+YgfAwmgI=;
        b=D9kkTId/xmmk8kYXB9PdmZ3higk9xmlBiC8I6kO0U7JcZWj7EY60DtUWZBg7tVvu1m
         +qyFnJwHz+2QBbtF9FCjbxZkntmO8tTmpe02jsioQyHWCNQpLE5rSxplIZcPsD+Bs6b7
         ELYZj7Arptdd5sfmPo0rnm4zAWfci8AkJf5r+MHcNj/x46z+oNWzKaoZvzn7JaoHeo+6
         lCbyIcCg/upQUDOF5I5w3RIy8prEU7IFtddFNQLChNn9UPy8JBG1IFixbduPDT/HEbtQ
         gefVgvA8CFseg3n+WWdC8d0M14UMHqhcWtybvmZclSiaDqiEbJ04/V9nzQm/ZgoViwaV
         QAew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769528891; x=1770133691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDiCGgmRF+wYc1VBBOMRuOPdjAE6txRYcyUQ+FEe7Lk=;
        b=diMHNReVa/VWBkFOQ3MWuH5CoC1rA5FjsWpRdLsAXIzJXgU27Tp1KoWA/gK3bFYYDK
         u7l2mIva13/PHTtN3ClqYuDLMX/ZuwkDP+UMlq7Mnnp/+J6sXsPpjsSyotf06fgL4D5c
         KasjVY/IsoiAGZluz9KDDXbmP8r6VYCOscJ2W4/walSQRzYzZk4Ep+P981VW6yJ97vK3
         7akdnoq+7tN7X2mWAns8A18zrmt6NWiEN7u/LD3LsrFanyxNc8QnTLf6oADh0Qu6eE/i
         gNha9vtx9y7wejCVnsp6Yl1xEcJVcqRd+6hxwyyc2FbGD8PJc3jvGofVphvEl3nx0CR5
         4/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769528891; x=1770133691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VDiCGgmRF+wYc1VBBOMRuOPdjAE6txRYcyUQ+FEe7Lk=;
        b=u8oTnWb3fT2/8RDSEXzjzECdt4aP7YmrevAwj8EtYVRJjc7XRI6B89EmDlxLdk8wl1
         ezS+GEB2o+2k/kkz4c7H+zGWbLltJUqAkH2pJF69jKbQlXs+CZxSSK0tLOibuqbw5YvX
         xolLsqEtLhriblTdCKDlMmil+kmp0DKHNF93OXi9cz4muWDm/pAqT6BjVjw55DqL/apI
         u4XFMQRQqNc2ocICjAgNwuk2OXVJykdSA/H4VfPtw5jmXkFTUL3zeQtTobIGQ5mwb2Y5
         8amzk53x26Bapvz7yJ2XtgsCagbhwzzOxC1mLVcyu5GBU9PKkv9suV2u5AKIdyPCTQG2
         XLww==
X-Forwarded-Encrypted: i=1; AJvYcCVNy1gl4MMXBVCSMIZq/Cd9QsCLIsRYgYP1cWyQdXmf+7HPjnpuWjNrtjnIa5Q5gYMs+3zxyYOHxFDOmqk8DVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGcPSKoi2YcL//h6zhG/IFfMHW0ND2gkjzfpmGoXkN/DzWVBv
	OEqnVvWpRkU1u6dDnsYADyJG3FhLJ/faAZmyP8GvA53wFRBPV0AeEJ61V0pY9p6qxFQgaADCpYE
	+b2Wp8V6UNDOb1DxT1f+sK1RAutEot7s=
X-Gm-Gg: AZuq6aJtkL+jaEwRvZ7snXTfyV5pQlvNj70jXzrK2YM5Sht/Qo+5eSgNe5d/Fdr97Xx
	bWFt3mn4PS2pl+bwOEnnuvKVGCiEjT3j2W1A/x8cXy/iE9MYph1LXYkH2Tmv+DXmQIcmC9jH96i
	R5mGXWGRRDclLl8Kyi0lEryRqZU0gl88AvQ3xKjRyenJVnl/1vY9v7J6VYgnJKO8h0aZb+QzOY+
	H10Z1mI4AvV3Zci97kWl6W/3cMHdoSVEIz/5rxYEfXC7rMzfM+SoRItpwufSC5PthzEpUsX4E2x
	tg8wrhzIbjn2KCCD1chKWgIBxUa+81slhAZMsO7TjFHQR08D+ME3SDMtYtz9siscmQ==
X-Received: by 2002:a05:690c:8a46:b0:794:7131:3dc2 with SMTP id
 00721157ae682-7947ac02fbcmr26583017b3.36.1769528890973; Tue, 27 Jan 2026
 07:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126162444.4194293-1-mengshi.wu@oss.qualcomm.com>
 <20260126162444.4194293-3-mengshi.wu@oss.qualcomm.com> <kej5u2hjxjtfdzmgtebns3amz7gmb5d2nciy45jsyglkprgh6s@kt6fodrc3oll>
 <7b9fec28-2272-4ff7-9575-76e72cecada5@oss.qualcomm.com> <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
In-Reply-To: <l2ib5kalse4nop6e6ak5xronejxusnprl4qgz2wxvdw7wpzw6e@aa6fn35id4we>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 27 Jan 2026 10:47:59 -0500
X-Gm-Features: AZwV_QguijB4i8whAVQxuCkNKrCCN6j01DXElsjD4VsotRtlUe-77VXI2_Mz2lI
Message-ID: <CABBYNZL-J3-kcrN-B_1yXci+nw8zjgiiD_YFH0i4xeRNvY_Jrw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: hci_qca: Enable HFP hardware offload
 for WCN6855
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mengshi Wu <mengshi.wu@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shuai.zhang@oss.qualcomm.com, cheng.jiang@oss.qualcomm.com, 
	chezhou@qti.qualcomm.com, wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 27, 2026 at 10:06=E2=80=AFAM Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Tue, Jan 27, 2026 at 10:32:58AM +0800, Mengshi Wu wrote:
> >
> >
> > On 1/27/2026 1:51 AM, Dmitry Baryshkov wrote:
> > > On Tue, Jan 27, 2026 at 12:24:44AM +0800, Mengshi Wu wrote:
> > >> Add QCA_CAP_HFP_HW_OFFLOAD capability flag to WCN6855 device
> > >> data structures to enable Hands-Free Profile (HFP) hardware
> > >> offload support on these Qualcomm Bluetooth chipsets.
> > >>
> > >> Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
> > >> ---
> > >>  drivers/bluetooth/hci_qca.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >
> > > Any other chips which would benefit from this flag? If you are settin=
g
> > > it for WCN6855, I'd assume that it also applies to WCN7850. Should it=
 be
> > > set for WCN6750?
> > >
> >
> > Thanks for the reminder. This should also apply to WCN7850. WCN6750 is =
not
> > considered at this time.
>
> What does it mean? It either supports HFP ofload, or not. Does it?

Or does that mean offload is considered the default over HCI, and in
that case does it actually work with the likes of Linux
distros/Pipewire or it is Android only? The fact that it is mentioning
HFP rather than SCO is already concerning to me, the kernel driver
shouldn't be involved with profile layers other than core.


>
> --
> With best wishes
> Dmitry



--=20
Luiz Augusto von Dentz
