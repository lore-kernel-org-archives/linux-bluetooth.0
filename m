Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120327115931.GK14481@x220>
References: <1332778374-15320-1-git-send-email-anderson.lizardo@openbossa.org>
	<20120327115931.GK14481@x220>
Date: Tue, 27 Mar 2012 08:13:20 -0400
Message-ID: <CAJdJm_PA3n3A5g1_KObMcPTvOixuzZMZeMc8AGtuKCce7ig6VA@mail.gmail.com>
Subject: Re: [RFC PATCH BlueZ] doc: Revert "Small API update"
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Mar 27, 2012 at 7:59 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Lizardo,
>
> On Mon, Mar 26, 2012, Anderson Lizardo wrote:
>> This reverts commit fd1ac97806d4531cb54523b3d694899afce281e7. It seems
>> the "entered" param is not used anymore.
>> ---
>>  doc/agent-api.txt |    8 +-------
>>  1 files changed, 1 insertions(+), 7 deletions(-)
>
> Why do you want to remove this? How else can we relay key press
> notifications to the user? Like with your other patch the fact that some
> code is not used doesn't necessarily mean that it should be removed but
> that something needs to be added to make it useful.

That's the reason I sent as RFC. I needed input like this :) Usually
patches are more visible here than abstract questions. It also shows
specifically where the "dangling part" is.

Also note that these two places lacked some sort of TODO/FIXME
comment. I could simply ask, but just sending this RFC patch seemed
more effective.

> Also, it seems we've forgotten this part from the mgmt API as there's no
> event specified for it at the moment.

Will you take care of this for mgmtops? If so, I can just fix the
dev_class patch, which I think has the kernel side in place already.

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
