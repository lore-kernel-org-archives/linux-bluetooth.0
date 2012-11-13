Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <6569845.L3ZsFuOrP2@uw000953>
References: <1352754221-29672-1-git-send-email-anderson.lizardo@openbossa.org>
	<CAMOw1v4h9wfcFLL-j5+fmEUNF=ShHZryw93aOC+_8d2NsbMFag@mail.gmail.com>
	<CAJdJm_NsCEmcjhtfSNh8mN5keoLzTtJsdN4+bpmdtJVzPgf4-Q@mail.gmail.com>
	<6569845.L3ZsFuOrP2@uw000953>
Date: Tue, 13 Nov 2012 09:06:55 -0400
Message-ID: <CAJdJm_NQXFgoicAmTTT7JVZSbOt2xcpGj0Jhxeb_n2z2GwSJBw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] build: Fix make distcheck for input plugin
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Tue, Nov 13, 2012 at 8:57 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>> I agree it is not the best solution. Actually, I think we can overcome
>> the problem completely by getting rid of symlinks for "drivers" (like
>> sap-{u8500,dummy}.c, suspend-dummy.c,
>> telephony-{dummy,maemo5,maemo6,ofono}.c) and having everything
>> built-in and enabled/disabled based on which D-Bus services are
>> running on the system (or, if not possible, by using config options).
>> This would also help with spotting build breakages, since all BlueZ
>> code could be compiled by a single "./bootstrap-configure && make"
>> call.
>
> All code is compiled, it is just not linked.

Sorry, I meant "linked" instead of "compiled" on my explanation. See
the original thread where this was first brought up:

http://thread.gmane.org/gmane.linux.bluez.kernel/30175/focus=30190

It is easier for testing code if it can be enabled/disabled at
runtime, instead of rebuilding with different configure options.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
