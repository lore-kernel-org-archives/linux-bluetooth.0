Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20111003085145.GC8956@fusion.localdomain>
References: <1317236492-13064-1-git-send-email-anderson.lizardo@openbossa.org>
	<20111003085145.GC8956@fusion.localdomain>
Date: Tue, 4 Oct 2011 00:59:08 +0200
Message-ID: <CAJdJm_NHQJgKQ8Oec0F_zHfWtxfNia1jhddmocVwTO_dWKx1pg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Fix memory corruption when decoding Read Response PDU
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Cc: Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Mon, Oct 3, 2011 at 10:51 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Wed, Sep 28, 2011, Anderson Lizardo wrote:
>> A bogus (or hostile) Proximity Reporter device may send a TX Power value
>> bigger than the buffer used. Therefore, create a temporary buffer with
>> the maximum size, and check for the length before using the value.
>>
>> Note that all other current users of the dec_read_resp() already do
>> this. Another option would be to change dec_read_resp() to accept a
>> buffer length, but this would break external code, so it is avoided for
>> now.
>> ---
>>  proximity/monitor.c |   11 ++++++++---
>>  1 files changed, 8 insertions(+), 3 deletions(-)
>
> Applied. Thanks.
>
> Have you considered changing the API so that the caller could tell the
> function the size of the supplied buffer?

Yes. I even mentioned on the last paragraph :) I was afraid it was too
late to change this, but if you thing it is not an issue for
external/third party code to break now, we can change this now.

> Another thing (though unrelated to this patch) I noticed: whenever you
> have variables that denote some kind of size and are not directly bound
> to fixed-length fields in PDU's, please use size_t or ssize_t. Feel free
> to send patches to fix such issues in your code.

This can be fixed, I think. We used "int" and guint* types at some
parts, but I don't remember if there was any rationale.

Claudio, Vinicius: can we get this easily fixed on attrib/* code?

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
