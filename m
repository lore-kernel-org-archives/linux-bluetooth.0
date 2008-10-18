Return-Path: <cyrus@holtmann.org>
Subject: Re: PBAP storage plugin API proposal
From: Marcel Holtmann <marcel@holtmann.org>
To: Zhao Forrest <forrest.zhao@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <ac8af0be0810081843i8bd6bd3g7282b11e3e9c8b1e@mail.gmail.com>
References: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
	 <1223457456.11272.254.camel@violet.holtmann.net>
	 <ac8af0be0810081843i8bd6bd3g7282b11e3e9c8b1e@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 18 Oct 2008 06:29:42 +0200
Message-Id: <1224304182.9386.14.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Forrest,

> > use the generic per plugin defines and its init and exit functions and
> > then provide methods to register and unregister the operations.
> >
> Yes. My proposed PBAP storage API follows this rule, but lacks the
> method to unregister the operations. Will add it later.

I put some prototype declarations into the obexd repository. The
important part is that we have to do this in an async way. We can't
block while retrieving the phonebook information.

> > Please keep in mind that in theory we can load more than one of these
> > phonebook "drivers".
> >
> Do you mean obexd could load multiple PBAP server plugin instances
> at the same time?

Only one instance of the plugin, but multiple different ones.

> Or one PBAP server instance could load multiple PBAP storage plugins
> at the same time?

Yes. That could be possible.

Regards

Marcel


