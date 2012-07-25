Return-Path: <cyrus@holtmann.org>
Message-ID: <50100AB5.8050203@hschmitt.de>
Date: Wed, 25 Jul 2012 17:03:17 +0200
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to reintroduce
 it
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de> <CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com> <500F9DAC.8040509@hschmitt.de> <CABBYNZJymF8bn0qyPZCtvJsFVWX7KqELf7FjBpRwxnYXoP0Hbw@mail.gmail.com>
In-Reply-To: <CABBYNZJymF8bn0qyPZCtvJsFVWX7KqELf7FjBpRwxnYXoP0Hbw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
Am 25.07.2012 16:22, schrieb Luiz Augusto von Dentz:
> Hi Harald,
> 
> On Wed, Jul 25, 2012 at 10:18 AM, Harald Schmitt <linux@hschmitt.de> wrote:
>> This one is related to that. But I think your proposal should be a
>> separate patch since it is about the incomming paths from an irmc
>> client. This one is more about to what irmc converts the incomming paths
>> to query phonebook-ebook and phonebook-tracker for contacts and call lists.
>> At the  moment these well known paths in phonebook-*.c are designed to
>> match 1:1 with pbap spec and they are very similar to irmc, but there
>> could be a third implementation to query phonebook where this could be
>> different.
> 
> While the backend indeed take an absolute path this doesnt mean we
> have to send as absolute path, not to mention it is not compatible
> with mimetypes which is what TYPE header describes, even in case of
> PBAP it is wrong to send absolute path in SETPATH.

Patch 1/2 only changes the way phonebook_pull is called (with absolute
path). It has nothing changed about the path resolution/interpretation
that is asked from the client. Sorry for my bad explanations.
> 
> To avoid this problems we send relative although we do accept
> absolute, but to avoid problems with stack interpreting absolute path
> as not valid as OBEX spec state we always send relative paths.

In fact irmc implementation at the moment only accepts relative paths
and I did not change this.
> 
>> The patch 1/2 fixes irmc to query phonebook implementation for the well
>> known absolute path. This was changed in pbap.c with the patch you
>> stated, but forgot to change in irmc.c.
>> Patch 2/2 just replaces the well-known phonebook paths which
>> phoenbook-ebook.c and phonebook-tracker.c support with constants.
> 
> Im fine with converting to constants, it is more the sending of
> absolute path that Im not comfortable because of the potential
> interoperability problems it could cause.

I probably used the wrong term "well known" what I meant by well known
are the paths that phonebook-tracker and phonebook-ebook knows that it
should fetch the contacts, etc. and these are absolute paths. It is not
about the "well known" paths from the pbap spec

