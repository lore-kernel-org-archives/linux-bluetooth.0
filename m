Return-Path: <cyrus@holtmann.org>
Message-ID: <1329749594.2172.2.camel@aeonflux>
Subject: Re: [RFCv6 00/14] Bluetooth: Change socket lock to l2cap_chan lock
From: Marcel Holtmann <marcel@holtmann.org>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Mon, 20 Feb 2012 15:53:14 +0100
In-Reply-To: <CAA37ikaRSnvSYXgDDh7mviFwSC2Ex=XoDLQ8JfBfNwEgwTxBaQ@mail.gmail.com>
References: <1329747685-4163-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1329748173.2172.0.camel@aeonflux> <20120220144453.GE27197@aemeltch-MOBL1>
	 <CAA37ikaRSnvSYXgDDh7mviFwSC2Ex=XoDLQ8JfBfNwEgwTxBaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ulisses,

> >> > Changing socket lock to L2CAP chan lock in L2CAP code. Needed for implementing
> >> > protocol above L2CAP without creating sockets.
> >> >
> >> > Changes:
> >> >     * RFCv6: Same code but patches 2,3 and 4 from RFCv5 are merged together
> >> >     following recommendations from review.
> >> >     * RFCv5: Fixed locking bug in l2cap_data_channel, added locks in
> >> >     l2cap_sock_shutdown function, fixed several styles issues.
> >> >     * RFCv4: Better split patches so they looks more clear and obvious,
> >> >     taking coments about naming change and delete unused vars. See diff change
> >> >     from the previous version below:
> >> >     * RFCv3: Split the big patch to several small (I believe logical) chunks,
> >> >     remove unneded locks from cleanup_listen, use the same arguments for
> >> >     locked/unlocked socket error functions.
> >> >     * RFCv2: Convert l2cap channel list back to mutex from RCU list.
> >>
> >> so what is the general status of this patch series. Are there still
> >> concerns or opens? Or should it be go for final review and be merged?
> >
> > The code looks now good enough for final review.
> 
> Marcel, the code looks good for final review and merge. The only thing
> concerns me is the change to chan->lock instead of sock lock seems to
> be split too much. I mean that we have this change done in a series of
> patches while it might be better to change everything at once. Not
> sure if worrying about intermediate states here is something you care
> or not, though, because I'm almost sure they'll be broken doing it in
> small pieces.

I am fine either way at this point.

> And IMO it'd be good if Padovan could take a look at the patches
> moving to chan->lock as well.

Then please add proper reviewed-by tags to the patches.

Regards

Marcel


