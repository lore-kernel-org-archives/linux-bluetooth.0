Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTi=vSPvd7nFb=aus4Gpkkp3MFdiDv=HwndhYdUvB@mail.gmail.com>
References: <1293447745-8697-1-git-send-email-michal.labedzki@tieto.com>
	<1293447745-8697-2-git-send-email-michal.labedzki@tieto.com>
	<AANLkTik-sV2+k8_j6xt5F1MAPb-7t9K8JTEzm12f--c4@mail.gmail.com>
	<E50901D4F2CF69428D43141B7C8586790B4B2D056C@EXMB03.eu.tieto.com>
	<AANLkTi=vSPvd7nFb=aus4Gpkkp3MFdiDv=HwndhYdUvB@mail.gmail.com>
Date: Mon, 27 Dec 2010 10:41:45 -0400
Message-ID: <AANLkTi==TysBDUUXrDYy4bizr+3Nz20nn2fyc_g2g__U@mail.gmail.com>
Subject: Re: [PATCH 2/4] Two merges very similar functions in bluetooth.c
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Michal.Labedzki@tieto.com
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Dec 27, 2010 at 10:39 AM, Anderson Lizardo
<anderson.lizardo@openbossa.org> wrote:
> Hi,
>
> On Mon, Dec 27, 2010 at 10:35 AM,  <Michal.Labedzki@tieto.com> wrote:
>> On Mon, Dec 27, 2010, Anderson Lizardo wrote:
>>> IMHO, you should keep str2ba and drop the few occurrences of
>>> strtoba(). Same applies to ba2str/batostr.
>>
>>> strtoba() allocates memory by itself, so if you use it instead, you
>>> need to deallocate memory. str2ba(), on the other hand, uses a buffer
>>> given as argument.
>>
>> These function are similar, but not the same. ba2str/str2ba reverse bdaddr, but
>> batostr/strtoba not. I wrote relevant documentation comments, because names look
>> similar, code look similar, but results are different.
>
> Ok, I confess the function names are confusing. One has to look at
> their implementation to make sure which one to use...

Just one more comment: on your commit description, it may appear that
you are merging the functions, while in fact you are just factoring
out common code. I suggest rewording the message so it makes clear you
are factoring out code.

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
