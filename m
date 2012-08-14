Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120814102812.GA8175@x220>
References: <CAJdJm_N6R5C_EPpK985mYajc7i+R=5T44AvTF_C7-5giR1Z8XQ@mail.gmail.com>
	<1344004954-2762-1-git-send-email-jprvita@openbossa.org>
	<20120814094010.GB5352@x220>
	<20120814102812.GA8175@x220>
Date: Tue, 14 Aug 2012 14:53:01 -0300
Message-ID: <CAAngNMYLQgBce2PPBm==vPpc-Cri3ve+tfZ7b0-+MaMTPpmgBg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] mgmt: print error message when start_discovery fails
From: Joao Paulo Rechi Vita <jprvita@openbossa.org>
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Aug 14, 2012 at 7:28 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi,
>
> On Tue, Aug 14, 2012, Johan Hedberg wrote:
>> On Fri, Aug 03, 2012, João Paulo Rechi Vita wrote:
>> > If we fail to communicate with the MGMT socket is better to print the
>> > error message on the mgmtops plugin, where it really happened, instead
>> > of leaving this job to its users.
>> > ---
>> >  src/adapter.c | 6 +-----
>> >  src/mgmt.c    | 7 +++++--
>> >  2 files changed, 6 insertions(+), 7 deletions(-)
>>
>> How do these two patches differ from patches 02/14 and 07/14 of the
>> patch set that was sent on July 27th? Why were these two patches resent
>> separately? A cover letter would have been quite useful here.
>
> Nevermind. I see that they reference the original thread and are
> probably updates based on received comments. Anyway, it would have been
> clearer if you'd have added "v2" to the subject and kept the xx/yy
> numbering.
>

Sorry, I thought that using "--in-reply-to <message_id>" was enough
for you to figure out what was going without problems. I've only
re-generated these two when re-sending, that's why they got a
different numbering. I'll be more caution next time.

-- 
João Paulo Rechi Vita
Openbossa Labs - INdT
