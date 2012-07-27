Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <50100AB5.8050203@hschmitt.de>
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
	<CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com>
	<500F9DAC.8040509@hschmitt.de>
	<CABBYNZJymF8bn0qyPZCtvJsFVWX7KqELf7FjBpRwxnYXoP0Hbw@mail.gmail.com>
	<50100AB5.8050203@hschmitt.de>
Date: Fri, 27 Jul 2012 16:40:42 +0300
Message-ID: <CABBYNZ+9qc4v3kW1gLVo4SHb924z+WXT8V8wTFAvW3hT6gZhYQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to
 reintroduce it
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harald,

On Wed, Jul 25, 2012 at 6:03 PM, Harald Schmitt <linux@hschmitt.de> wrote:

>> While the backend indeed take an absolute path this doesnt mean we
>> have to send as absolute path, not to mention it is not compatible
>> with mimetypes which is what TYPE header describes, even in case of
>> PBAP it is wrong to send absolute path in SETPATH.
>
> Patch 1/2 only changes the way phonebook_pull is called (with absolute
> path). It has nothing changed about the path resolution/interpretation
> that is asked from the client. Sorry for my bad explanations.

Yep, only now I realized that this is not the client side, so it is
probably fine.

>>
>> To avoid this problems we send relative although we do accept
>> absolute, but to avoid problems with stack interpreting absolute path
>> as not valid as OBEX spec state we always send relative paths.
>
> In fact irmc implementation at the moment only accepts relative paths
> and I did not change this.

No problem, I will make it less strict to follow PBAP in another patch.

>>
>>> The patch 1/2 fixes irmc to query phonebook implementation for the well
>>> known absolute path. This was changed in pbap.c with the patch you
>>> stated, but forgot to change in irmc.c.
>>> Patch 2/2 just replaces the well-known phonebook paths which
>>> phoenbook-ebook.c and phonebook-tracker.c support with constants.
>>
>> Im fine with converting to constants, it is more the sending of
>> absolute path that Im not comfortable because of the potential
>> interoperability problems it could cause.
>
> I probably used the wrong term "well known" what I meant by well known
> are the paths that phonebook-tracker and phonebook-ebook knows that it
> should fetch the contacts, etc. and these are absolute paths. It is not
> about the "well known" paths from the pbap spec

No problem, I should have looked what the code was doing before
drawing any conclusion, anyway I will apply this patches asap.


-- 
Luiz Augusto von Dentz
