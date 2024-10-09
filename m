Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A7192B97
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Oct 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475316; cv=pass; b=WjxIItoQexgNTcImTX27FLiYX/mSVl5TmOcxKbK/DcQJ84UK6C6WEqgMSvGHbWvKtQtwUOcVV5ZlhE4tVALbOiAo+XsBmA+of1BVATRZAJaIe9yKqQxGSXb4FznPt8iF4cgRJyU/CQ5+5zBaGXqG9sI6nkEjHXJ5LtMQD2lRYAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475316; c=relaxed/simple;
	bh=3kU1dk/xvrr/s/sOMCnFVCYLNMgCofFLjveTl53ghmY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=OZ3yKg5OieoG4s/WE/IHHu69cwUypsrIqxdQJXkyxFHXKKeLIUPLGBzKzDnfUt3GgoNORMmT8S1CVbIDQHzEkoda9sZJOiKbgFHn/rIBoJovmFhjThJmlVCtOjyOcMwcr97A2aGCL61rvF0DIUvm1OQAZzKMgCvQnWhRbDkSSb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk; spf=pass smtp.mailfrom=collabora.co.uk; dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b=O5eXKzpU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.co.uk header.i=andrew.shadura@collabora.co.uk header.b="O5eXKzpU"
ARC-Seal: i=1; a=rsa-sha256; t=1728475288; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OMa+z9UFnGdG7olPcwGA+h/EPQqW9WSfD/kwZAc5JI82FF5b7j5l/IABPOYHjyCGO9ZXS253uNIm7uTAJmBmcWux868y7S76ttOfxPFZocexaQULjsaZmke4PyjPFzsXoEdVjFSuNwqTwdLMN+osOvARyd1TImWMaPdkJULvgcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1728475288; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=l8qS2wo+8fS8vYU0I61OVWruGADSYfpcup7Yjnucmjo=; 
	b=BX4acXRVs/5uhxBb4exE4hVQxHSUYWlbj3WwueZw/L+a0CKM+vMwRzpFm5CwuMhSDd0J3dKOi3JKVdFw+i5+Edbjv1kKTkkXhGdMjlqVBGG+P0lPe1k964NmqHMxKQLYRCMmXUFeeA/mSlP1YidupJR5QCdn3ed9C8smQ41IhEU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.co.uk;
	spf=pass  smtp.mailfrom=andrew.shadura@collabora.co.uk;
	dmarc=pass header.from=<andrew.shadura@collabora.co.uk>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728475288;
	s=zoho; d=collabora.co.uk; i=andrew.shadura@collabora.co.uk;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=l8qS2wo+8fS8vYU0I61OVWruGADSYfpcup7Yjnucmjo=;
	b=O5eXKzpUMNHmOTZfEblk0V3JqFyttYjEiC1tracCE4eveAUgLP2bsERQypO/uSDU
	JE7x25SrzQNEnqexd88ENS++EWZeGs00WBfrSNWMoRdqR261Ip7AkseMY1fe7fs6Pf8
	7qh+76w3zWXirO1e9w8eU8WWTvcZknZeW+61eOGA=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1728475286582489.6746188951836; Wed, 9 Oct 2024 05:01:26 -0700 (PDT)
Date: Wed, 09 Oct 2024 14:01:26 +0200
From: Andrej Shadura <andrew.shadura@collabora.co.uk>
To: "Aleksei Vetrov" <vvvvvv@google.com>
Cc: "linux-bluetooth" <linux-bluetooth@vger.kernel.org>,
	"Nathan Chancellor" <nathan@kernel.org>,
	"Justin Stitt" <justinstitt@google.com>,
	"llvm" <llvm@lists.linux.dev>, "kernel" <kernel@collabora.com>,
	"George Burgess" <gbiv@chromium.org>
Message-ID: <1927127cbe6.dc6b0ddf457820.2500942166826392402@collabora.co.uk>
In-Reply-To: <ZwQ7OzSSWZHM4XqS@google.com>
References: <20241002141217.663070-1-andrew.shadura@collabora.co.uk>
 <ZwQ7OzSSWZHM4XqS@google.com>
Subject: Re: [PATCH] Bluetooth: Fix type of len in
 rfcomm_sock_{bind,getsockopt_old}()
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

On 07/10/2024 21:49, Aleksei Vetrov wrote:
> Hi Andrej,
>=20
> On Wed, Oct 02, 2024 at 04:12:17PM +0200, Andrej Shadura wrote:
>> Change the type of len to size_t in both rfcomm_sock_bind and
>> rfcomm_sock_getsockopt_old and replace min_t() with min().

> rfcomm_sock_bind doesn't use copy_to_user, are you sure it has the same
> issue?

> This change produces a compilation error around min expression, as
> "kernel test robot" notices below. And I think rfcomm_sock_bind
> shouldn't be touched at all, it doesn't use copy_to_user and doesn't
> produce compile errors with latest Clang.

Thanks, you=E2=80=99re right, I went a bit too far here :)
Rebuilding with a different verbosity setting revealed it here as well.

> This looks ok. But there is the same pattern in rfcomm_sock_getsockopt
> (without old prefix) and it also uses copy_to_user and produces compile
> error with latest Clang.
>=20
> Could you remove rfcomm_sock_bind patch and apply it to
> rfcomm_sock_getsockopt instead? Or I can send my version of the patch:
> we've encountered the same compile errors in rfcomm_sock_getsockopt and
> rfcomm_sock_getsockopt_old after updating Clang and would like to get it
> fixed.

Interestingly, it didn=E2=80=99t produce an error on my clang version, but =
sure,=20
I am amending the patch and will submit it shortly.

--=20
Cheers,
   Andrej

