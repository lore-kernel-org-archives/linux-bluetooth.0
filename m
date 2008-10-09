Return-Path: <cyrus@holtmann.org>
Message-ID: <ac8af0be0810081843i8bd6bd3g7282b11e3e9c8b1e@mail.gmail.com>
Date: Thu, 9 Oct 2008 09:43:30 +0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Marcel Holtmann" <marcel@holtmann.org>
Subject: Re: PBAP storage plugin API proposal
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1223457456.11272.254.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <ac8af0be0810080159h712b0f8drdffa49dc57d7afb5@mail.gmail.com>
	 <1223457456.11272.254.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

>
> use the generic per plugin defines and its init and exit functions and
> then provide methods to register and unregister the operations.
>
Yes. My proposed PBAP storage API follows this rule, but lacks the
method to unregister the operations. Will add it later.

> Please keep in mind that in theory we can load more than one of these
> phonebook "drivers".
>
Do you mean obexd could load multiple PBAP server plugin instances
at the same time?
Or one PBAP server instance could load multiple PBAP storage plugins
at the same time?

Thanks,
Forrest
