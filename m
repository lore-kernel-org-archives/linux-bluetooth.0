Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120508201855.GA7204@x220.hpllc.com>
References: <1336083713-8417-1-git-send-email-teg@jklm.no> <20120508201855.GA7204@x220.hpllc.com>
From: Tom Gundersen <teg@jklm.no>
Date: Tue, 8 May 2012 22:31:44 +0200
Message-ID: <CAG-2HqXpFV57Bfz=TY-L_NQ9z1FAkn8CPN0Wm1XjoXQ0JnA8SA@mail.gmail.com>
Subject: Re: [PATCH 1/2] systemd: don't order against syslog.target
To: Tom Gundersen <teg@jklm.no>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, May 8, 2012 at 10:18 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Tom,
>
> On Fri, May 04, 2012, Tom Gundersen wrote:
>> This was only needed in old versions of systemd. All messages are logged
>> by default to the journal now, no ordering required.
>>
>> Signed-off-by: Tom Gundersen <teg@jklm.no>
>> ---
>>  src/bluetooth.service.in |    2 --
>>  1 file changed, 2 deletions(-)
>
> Both patches have been pushed upstream. Thanks.

Cool.

> Btw, I had to remove the Signed-off-by stuff since we don't use that for
> user space patches.

Ok, I'll keep that in mind for the future.

Cheers,

Tom
