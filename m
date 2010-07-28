Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <94b1ecb27a99150d2cc0cae8fe6607af.squirrel@www.codeaurora.org>
References: <1279814780-29673-1-git-send-email-ingas@codeaurora.org>
	<1279814780-29673-3-git-send-email-ingas@codeaurora.org>
	<AANLkTi=nW-E8S3ccyutn_LYafmhSXiGY62PVZJ6L2QnX@mail.gmail.com>
	<94b1ecb27a99150d2cc0cae8fe6607af.squirrel@www.codeaurora.org>
Date: Wed, 28 Jul 2010 08:59:03 +0300
Message-ID: <AANLkTimXNgHxzqFdFJLhWdr8b-ELKc9rLJoj6L8s5+oC@mail.gmail.com>
Subject: Re: [PATCH 2/5] Support for adding UUID128 to extended inquiry
	response
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: ingas@codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, rshaffer@codeaurora.org,
	marcel@holtmann.org, johan.hedberg@gmail.com
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jul 27, 2010 at 11:08 PM,  <ingas@codeaurora.org> wrote:
> If you examine the patch closely, you might notice that the previous
> "check for duplicates" implementation was doing the following:
> - cycling through the list of so far accumulated UUIDs in EIR and
> comparing them to the current one. If duplicate is found, break out of
> this cycling loop. Notice, that in the case of a duplicate, (i <
> index)condition will be true, where index is the number of accumulated
> UUIDs.
> - the current implementation performs check for (i =3D=3D index -1). Well=
, we
> did not need to cycle through the whole array to cmpare to the last item
> :) But if my reading of the original intent is correct, we don't want to
> put a duplicate UUID in EIR, and, therefore, should go to next iteration
> if a duplicate is found. Hence, the check should be (i < index).

Yep, the check was already there before you touch it.

> Maybe it's a better idea to submit this fix separately.
>
> I do not disagree that it would be better to check for duplicate records
> elsewhere, but this =A0is outside the scope of this patch.

No problem, the other patches seems to be in good shape to be push
upstream, so lets try to do it this week.

--=20
Luiz Augusto von Dentz
Computer Engineer
