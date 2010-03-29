Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Mar 2010 00:52:39 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Francisco Alecrim <francisco.alecrim@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Emit Adapter.PropertyChanged when UUIDs change
Message-ID: <20100329215239.GA3748@jh-x301>
References: <1269644076-10544-1-git-send-email-francisco.alecrim@openbossa.org>
 <1269644076-10544-2-git-send-email-francisco.alecrim@openbossa.org>
 <20100329074539.GA20839@jh-x301>
 <1269851341.11714.203.camel@localhost.localdomain>
 <2d5a2c101003291148u1836742w1222097fb865ef61@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <2d5a2c101003291148u1836742w1222097fb865ef61@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Mar 29, 2010, Luiz Augusto von Dentz wrote:
> On Mon, Mar 29, 2010 at 11:29 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> > Hi Johan,
> >
> >> > Emitting Adapter.PropertyChanged signal when UUIDs change. D-Bus message
> >> > to inform that adapter properties changed.
> >> > ---
> >> >  src/adapter.c       |   75 ++++++++++++++++++++++++++++++++++++++++++++------
> >> >  src/adapter.h       |    1 +
> >> >  src/sdpd-database.c |    3 ++
> >> >  3 files changed, 70 insertions(+), 9 deletions(-)
> >>
> >> Thanks for the patches. In principle they look good, but I haven't
> >> applied them yet due to one thing that looks a bit strange: both the SDP
> >> server record UUID (0x1000) as well as the public browse group UUID
> >> (0x1001) always show up in the UUIDs list. I wonder if there'd be any
> >> clean way to avoid getting them into the list. Marcel, do you have any
> >> idea about this or is it even a problem that these UUIDs are always in
> >> the list?
> >
> > these UUIDs are always in the server, but not in the public browse group
> > and we skip them on purpose. The only reason why they are always present
> > is that the specification requires it.
> 
> IMO, it should be the same list as we export in extended inquiry
> response, so perhaps we could use the data from
> create_ext_inquiry_response which already filter those away. Perhaps
> some refactoring could also be done since this code seems to be called
> multiple times in case of new services because it also changes class
> which then triggers create_ext_inquiry_response again.

That makes quite a lot sense, and is actually what I was chatting with
Marcel about earlier today on irc. The EIR UUIDs list does have a few
restrictions though that the Adapter UUIDs property doesn't have, such
as a maximum limit on the amount of UUIDs (since EIR data is quite
limited in size), so the lists will not always be exactly the same.

You can see the creation of the EIR list in the for-loop of the
create_ext_inquiry_response function in sdpd-service.c. The most
important part for the Adapter UUIDs property would be the following
code snippet which also answers the original question I had about how to
best get rid of the unnecessary UUIDs:

       if (rec->svclass.value.uuid16 < 0x1100)
               continue;
       if (rec->svclass.value.uuid16 == PNP_INFO_SVCLASS_ID)
               continue;

In addition those there's also the duplicate UUID check which I think
the original patch was missing. So, if the same code could somehow be
reused for EIR and the Adapter UUIDs property it'd be great. However, if
it's too messy, the above two filters and the duplicate UUID check
should at least be applied to the Adapter UUIDs property.

Johan
