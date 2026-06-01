Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983834D92C
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Jun 2026 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342973; cv=pass; b=KLZuEGhRt6CQws3ZKPsBCsXHw4IoVJ3p5F6X7wg5/iv39bDPPcdA9tcXyyzh755GFBZAIKj4yTTtLuNvJWeyZ5frDdTDJkz153DPKN2pRUKb6RUGoqPwfdOEDuh6um3lcfhnXB2t7u6I36Txdhg4sl7S0H0Oq1+CL79WXo1uSyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342973; c=relaxed/simple;
	bh=A7EPqTPB1aVQYse9zl8w+TEZoo4x2/JY/tcnjXQTXbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LQqEEnNcAmHRdx6pTIA0qTkETLUNL3qzcflZLR6CQUnYA4ogeYcT+qPSXmX8FAaKMhcsMOGImh2XS3pqlrvcHgf5xt9tkSLBwOR7kIdHOYzyDFG5T2ZmQvXhZuhg5Q9i5mXU/xeDIlm+Ji4p2SFJd0OsIv+sCZ5klLA62HVyAMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2p3RYXW; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2p3RYXW"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6603246b66dso4776997d50.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Jun 2026 12:42:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780342971; cv=none;
        d=google.com; s=arc-20240605;
        b=N5ZGr5fBl1ptsZaRbxcKaKvRmvZVd7jZ2gyIGxozrXhcr8QG3YzogyYKmH7CuX42t1
         eXzayqETbEEnueV1bEmXKieMkM3IhTrJl+lzI+/u+ARqN2VRSj7wr8isIMnbeBNSx9Hn
         x8Ow+PPI6t/hihMiuMtvZD31OYyhT8Zk1Kr9BdToW8/F2gEH/bgH9Vqa0Vpgxb9YJ4sY
         osb/P49vvHD1hBPbYxQC1bpECCPRcq9W6DWOioXpaoJzL3v7BsgTcAKz6oSauDGThEis
         Q3YI+SXgOxHpayhC7oDur27cTsQnjD1i38yF2D3PbQORnYAVBzvQTjrsEAWK3lOiGsI5
         kIKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wYgTguUDkpRGGT6qwF0YcNNDiZVx9sYEywmaZNILKXI=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=CV59GXsi6mZCmjcTd6Fy7B9c48SvRNTgjMQHIfOeZ4KbuEeERRcqOgOqFjKszPcivk
         DW4VBLaSsleDBy9eftNM+4JJBhn/9qAsUjHFvfam0ChCKQlOy5wcenSusXvzlqljNhO3
         TrkYNIQKknMe8DFNgh4HSEAxLucfpq+3M2qC9PDCBUXCRiwFNTL0O/6Ffl95Di7iu2iS
         NPsMGjd6aYuGbQPNNBvcxtEx+iokyyepg28iWKujZMPaTh27Wdf8zVhUiyIEG8T/Vcz2
         Fi8qSsYF4UWgJHufJymtWwyOdZhnxqkqEm6RRik6vnzwoUouHHavIimcKOpdQV+KyTRP
         QZkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780342971; x=1780947771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYgTguUDkpRGGT6qwF0YcNNDiZVx9sYEywmaZNILKXI=;
        b=P2p3RYXWIW70mvoR9euzL2Mhs6d4WVDDzd4r6jsBrrlu3++YGxRoZyRQA7wzphm+y4
         rSsPldZzO70gYBCGNwlfYrmpRruvg8y9VqsaJ39aAdaLQ/mQ4CNdJ8p+BlTmRscqm1rs
         OVNbZrPqmFuV3Hx35EmlKzQtzfvhzxU45alO5B6XqKbUapBD23CDVOkF7DLAR3FWsm92
         dPHDSlMhJxBj1shRVNJvBxaSZf6SPu390Hm/+T4UDol2u6mQKrvGMfKRWmdJ7+epgUYX
         s3BRFJuFJrZR5Xa+ObGUtcu4GMuzUDMOocSBcBykn8AmKyTvK6uO3ut8aTDFJ0r6uFcU
         QqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342971; x=1780947771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYgTguUDkpRGGT6qwF0YcNNDiZVx9sYEywmaZNILKXI=;
        b=NYs8bWMzBYufPSdFficx9kmtv5MyvDCuSkYxv0linblH4dsqVST+Dx01H7G+iDukxO
         K3FBelS2ix5vbmMb9Y+c1gTqywP90j01/zjr8XgWL7icDbI4Jv9k+K58uRn0O8yYlwCW
         faKs8ZkKwPB/2zrrmgwdsYCKYBr8gPq58YxozfEY3oqK+R2yj6ClBasRUyh3vyVuFDt2
         MY4sMMAv2h9+yBOeqvOt3IImsC5R0Kmxsy5m6eVowBsoHRS0vFaBBSMVhMKAWRh0ggFm
         portw6PC6LoNMzL0fIZyuWdxKGnvXGPzyM8jo6QpgrZjXK/wn1qp/I9mOHg113FtedZQ
         9oaQ==
X-Gm-Message-State: AOJu0YzwJXMvlHLghQTwsH2Yq6eF/jTtdg+N2GN9WlZ2mg70LTgF0Gem
	mbYMbnXTt7uxXGize0Dlu5yhVjwLEiwKLEgyAV3wbGQlO33FlE8Gt08WnpBF3S/eTb1oWC2TzB7
	tDF4B8IOgTrAraRaQKV710dDZWhNREF4=
X-Gm-Gg: Acq92OGaAwYT6N14ezXH61Rgb6togxGUtm12ju9ISHdCMH2HKmbdvfMtSRj98+S+9Nk
	8oFPhBjloaINTY/08ajf5wTZr2jkthmTzQmf63CKTrorw/H/xdiQ8U07SURIhnkL0K5+hPu7q1/
	fbWG7UrExHCx+2NPfRwUkz3oUQd5+7XAbNAesi1QOfZxX+Su6lSCoJJmhLq7e7++3mK0XLoSnfX
	I8CuKwOaMx5QDTPY6sRKkGPGB572fG0cQf0WhBld8svZTpYxrb+zzQwtPp7zI4nkJZA4/TUg6Ep
	VTnbV/IyUDHFp8CvdUlMQcqe7AwPMt2Xi7381wHnRg969piA5wX5nNlf7IuYLI+EGW4cvVK08fJ
	ovzJV
X-Received: by 2002:a05:690e:138d:b0:660:3426:3ff4 with SMTP id
 956f58d0204a3-6605ef41fe8mr11163898d50.18.1780342970856; Mon, 01 Jun 2026
 12:42:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1778930064.git.pav@iki.fi>
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Jun 2026 15:42:39 -0400
X-Gm-Features: AVHnY4JRfNEwbylF8ceWTdMScrVKhGBFibJhNVpp3cSDBa_B7IiiojDIHzzqsOw
Message-ID: <CABBYNZKjKr5yM2ORC_v67tpCOuDe86WT6e4hYbOFL92RNOtTcQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Bluetooth: enable context analysis
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, May 16, 2026 at 7:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> wrote:
>
> Set up compiler context analysis that generate compiler warnings on
> problems that Clang -Wthread-safety can detect:
>
> https://docs.kernel.org/dev-tools/context-analysis.html
>
> Clang 22, and probably Clang 23 [1] will be required.  Sparse locking
> analysis support was removed in commit
> 5b63d0ae94ccfd64dcbdb693d88eb3650eb3c64c, this is its successor.
>
> This series enables the analysis and adds minimal annotations to silence
> some false positives.
>
> Also, one patch to fix what looks like a legitimate locking issue in
> iso.c.
>
> In future, it probably is a good idea to make more use of it and add
> __must_hold, __guarded_by etc annotations.
>
> Kernel test robot appears to be checking for these, but not sure in what
> trees [2]
>
> BlueZ testbot doesn't check these currently but it's possible to add
> https://github.com/bluez/action-ci/pull/4

I would like to merge the above changes to action-ci but apparently
there are some conflicts. Can you fix that? It seems fine as a
starting point so we might as well merge it if there is nothing
blocking it. Or did you submit it as an RFC because something is still
pending?

> [1] https://lore.kernel.org/all/CANpmjNN4O=3DW70sAc5gaVkTAFdrGGOW+XBMyueh=
fz3_QMiT=3DuCw@mail.gmail.com/
> [2] https://lore.kernel.org/all/202605060005.JYWpZXr2-lkp@intel.com/
>
> Pauli Virtanen (5):
>   Bluetooth: af_bluetooth: Add minimal context analysis annotations
>   Bluetooth: hci_core: Add minimal context analysis annotations
>   Bluetooth: ISO: lock same hdev as what is released
>   Bluetooth: L2CAP: Add minimal context analysis annotations
>   Bluetooth: enable context analysis
>
>  drivers/bluetooth/Makefile   |  2 ++
>  net/bluetooth/Makefile       |  2 ++
>  net/bluetooth/af_bluetooth.c |  7 +++++--
>  net/bluetooth/hci_core.c     |  3 +++
>  net/bluetooth/iso.c          | 14 ++++++++------
>  net/bluetooth/l2cap_sock.c   |  1 +
>  6 files changed, 21 insertions(+), 8 deletions(-)
>
> --
> 2.54.0
>
>


--=20
Luiz Augusto von Dentz
