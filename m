Return-Path: <cyrus@holtmann.org>
Message-ID: <500F9DAC.8040509@hschmitt.de>
Date: Wed, 25 Jul 2012 09:18:04 +0200
From: Harald Schmitt <linux@hschmitt.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to reintroduce
 it
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de> <CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com>
In-Reply-To: <CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

Am 24.07.2012 22:20, schrieb Luiz Augusto von Dentz:
> Hi Harald,
> 
> On Wed, Jul 18, 2012 at 5:53 PM, Harald Schmitt <linux@hschmitt.de> wrote:
>> This patchset fixes a bug in irmc plugin the same way as it was sent
>> today, but with a commit message. The second patch defines macros in
>> phonebook.h for the well known phonbook folders and names and replaces
>> those magic values.
>>
>> Harald Schmitt (2):
>>   irmc: Fix phonebook contacts query
>>   phonebook: Replace magic strings for phonebook names and folders
>>
>>  plugins/irmc.c              |    4 ++--
>>  plugins/phonebook-ebook.c   |   14 ++++++-------
>>  plugins/phonebook-tracker.c |   48 +++++++++++++++++++++----------------------
>>  plugins/phonebook.h         |   13 ++++++++++++
>>  4 files changed, 46 insertions(+), 33 deletions(-)
>>
>> --
>> 1.7.9.5
> 
> I guess you should take a look at patch
> 4f48e26fa73217dde9916fe6e857b1de7fae33cc, not sure if is the same
> issue though since this here it is used as type, but perhaps it is
> worth making it similar so either pbap and sync does accept the path
> in both absolute or relative format.
> 
> 
This one is related to that. But I think your proposal should be a
separate patch since it is about the incomming paths from an irmc
client. This one is more about to what irmc converts the incomming paths
to query phonebook-ebook and phonebook-tracker for contacts and call lists.
At the  moment these well known paths in phonebook-*.c are designed to
match 1:1 with pbap spec and they are very similar to irmc, but there
could be a third implementation to query phonebook where this could be
different.
The patch 1/2 fixes irmc to query phonebook implementation for the well
known absolute path. This was changed in pbap.c with the patch you
stated, but forgot to change in irmc.c.
Patch 2/2 just replaces the well-known phonebook paths which
phoenbook-ebook.c and phonebook-tracker.c support with constants.
