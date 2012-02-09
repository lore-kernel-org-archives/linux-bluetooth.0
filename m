Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Feb 2012 12:53:23 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Ulisses Furquim <ulisses@profusion.mobi>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Peter Krystad <pkrystad@codeaurora.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: Getting L2CAP ERTM support into better upstream state
Message-ID: <20120209105321.GA22374@aemeltch-MOBL1>
References: <1328678855.28848.6.camel@aeonflux>
 <20120208090945.GB5917@aemeltch-MOBL1>
 <CABBYNZ+v5fjUXML7Yq=Xxs_37yOcdPhgr2eLWgPKOyY=LqEQwA@mail.gmail.com>
 <CAA37ikYNVFdWf_ZAGCfY6rrYeO7054n3y_uwn5f04Xzz9g0Mpw@mail.gmail.com>
 <alpine.DEB.2.02.1202081221280.25089@mathewm-linux>
 <CAA37ikb5n0PmR7FAZ2-HDRRoKaMEL=_nniuN9Yzm1pCjUk1kPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAA37ikb5n0PmR7FAZ2-HDRRoKaMEL=_nniuN9Yzm1pCjUk1kPw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

On Wed, Feb 08, 2012 at 11:01:16PM -0200, Ulisses Furquim wrote:
...
> >> Marcel mentioned the separation of L2CAP channel and socket. That is a
> >> work in progress by Andrei and judging by what you said, Marcel, you
> >> want that merged before we change ERTM, is that it?
> >
> > Andrei and Marcel, let's figure out this order now.  It doesn't make sense
> > for one of us to have a bunch of changes staged, only to have major
> > merge/rebase conflicts when another far-reaching patch set gets merged.
> 
> I'd say we add your changes and then Andrei's when he's ready with
> them. Right now I have the feeling your changes are more mature and
> can be easily merged.

I believe that those mentioned state changes should not affect lock
separation patches.

Locking is done when receiving data packet in l2cap_data_channel and the
changes shall come to functions surrounded by those locks. The same with
sending packet functionality.

...
> > Thanks for the feedback, everyone.  Please let me know if you have
> > preferences for how to structure this patch set.  I'll work on the issues
> > mentioned in this thread and start splitting up the changes.
> 
> We need to hear from Marcel and Padovan if they agree with us. I do
> think you can introduce new stuff with small commits and then have one
> commit to add the bulk of it with the module option to enable it. Then
> we test that and make it default later.

Thanks Mat for work you have done. I am generally agree with Ulisses about
small logical commits (better if they compile without warnings). But if
there are changes that might be applied as is (like the patch Luiz has
sent concerning tx_window) that would be even better.

Best regards 
Andrei Emeltchenko 
