Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <500F9DAC.8040509@hschmitt.de>
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
	<CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com>
	<500F9DAC.8040509@hschmitt.de>
Date: Wed, 25 Jul 2012 17:22:37 +0300
Message-ID: <CABBYNZJymF8bn0qyPZCtvJsFVWX7KqELf7FjBpRwxnYXoP0Hbw@mail.gmail.com>
Subject: Re: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to
 reintroduce it
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harald,

On Wed, Jul 25, 2012 at 10:18 AM, Harald Schmitt <linux@hschmitt.de> wrote:
> This one is related to that. But I think your proposal should be a
> separate patch since it is about the incomming paths from an irmc
> client. This one is more about to what irmc converts the incomming paths
> to query phonebook-ebook and phonebook-tracker for contacts and call lists.
> At the  moment these well known paths in phonebook-*.c are designed to
> match 1:1 with pbap spec and they are very similar to irmc, but there
> could be a third implementation to query phonebook where this could be
> different.

While the backend indeed take an absolute path this doesnt mean we
have to send as absolute path, not to mention it is not compatible
with mimetypes which is what TYPE header describes, even in case of
PBAP it is wrong to send absolute path in SETPATH.

To avoid this problems we send relative although we do accept
absolute, but to avoid problems with stack interpreting absolute path
as not valid as OBEX spec state we always send relative paths.

> The patch 1/2 fixes irmc to query phonebook implementation for the well
> known absolute path. This was changed in pbap.c with the patch you
> stated, but forgot to change in irmc.c.
> Patch 2/2 just replaces the well-known phonebook paths which
> phoenbook-ebook.c and phonebook-tracker.c support with constants.

Im fine with converting to constants, it is more the sending of
absolute path that Im not comfortable because of the potential
interoperability problems it could cause.

-- 
Luiz Augusto von Dentz
