Return-Path: <cyrus@holtmann.org>
Message-ID: <5189A417.503@asianux.com>
Date: Wed, 08 May 2013 09:02:15 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: David Herrmann <dh.herrmann@gmail.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 Gustavo Padovan <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 David Miller <davem@davemloft.net>,
 Jiri Kosina <jkosina@suse.cz>, andrei.emeltchenko@intel.com,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hidp: using strlcpy or strcpy instead of strncpy
References: <518906A8.7060708@asianux.com> <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com>
In-Reply-To: <CANq1E4SmY+CD0uf53_b6GeFkQ-LYnpdxsDGSRMWdn2i1mnb6WQ@mail.gmail.com>
Content-Type: text/plain; charset=GB2312
List-ID: <linux-bluetooth.vger.kernel.org>

On 2013Äê05ÔÂ08ÈÕ 03:31, David Herrmann wrote:
> On Tue, May 7, 2013 at 3:50 PM, Chen Gang <gang.chen@asianux.com> wrote:
>> >
>> > For NUL terminated string, need always let it ended by zero.
>> >
>> > Since have already called memcpy() to initialize 'ci', so need not
>> > redundent initializations.
>> >
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> > ---
>> >  net/bluetooth/hidp/core.c |   10 +++-------
>> >  1 files changed, 3 insertions(+), 7 deletions(-)
>> >
>> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
>> > index 940f5ac..9a8ae63 100644
>> > --- a/net/bluetooth/hidp/core.c
>> > +++ b/net/bluetooth/hidp/core.c
>> > @@ -76,25 +76,21 @@ static void hidp_copy_session(struct hidp_session *session, struct hidp_conninfo
>> >         ci->flags = session->flags;
>> >         ci->state = BT_CONNECTED;
>> >
>> > -       ci->vendor  = 0x0000;
>> > -       ci->product = 0x0000;
>> > -       ci->version = 0x0000;
>> > -
>> >         if (session->input) {
>> >                 ci->vendor  = session->input->id.vendor;
>> >                 ci->product = session->input->id.product;
>> >                 ci->version = session->input->id.version;
>> >                 if (session->input->name)
>> > -                       strncpy(ci->name, session->input->name, 128);
>> > +                       strlcpy(ci->name, session->input->name, 128);
>> >                 else
>> > -                       strncpy(ci->name, "HID Boot Device", 128);
>> > +                       strcpy(ci->name, "HID Boot Device");
> I'd actually prefer strlcpy() here, too (better be safe). Other than
> that the patch looks fine.

OK, thanks. I will send patch v2.

-- 
Chen Gang

Asianux Corporation
