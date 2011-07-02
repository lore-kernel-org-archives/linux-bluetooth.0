Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309578619.21109.0.camel@aeonflux>
References: <1309577712-3828-1-git-send-email-lucas.demarchi@profusion.mobi> <1309578619.21109.0.camel@aeonflux>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Sat, 2 Jul 2011 00:53:53 -0300
Message-ID: <BANLkTimNzRw5R7URWJf9CU-F71RoOvj1aQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] build: Rename configfiles option to datafiles
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


On Sat, Jul 2, 2011 at 12:50 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Lucas,
>
>> Instead of passing --[disable|enable]-configfiles, now we use
>> --[disable|enable]-datafiles as not all of the files are installed for
>> configuration but are rather data files.
>> ---
>>  Makefile.am    |    6 +++---
>>  Makefile.tools |    2 +-
>>  acinclude.m4   |    8 ++++----
>>  3 files changed, 8 insertions(+), 8 deletions(-)
>
> patch has been applied, but you forgot bootstrap-configure. I fixed that
> one for you.

Ohh, right. I ran all the possible tests and forgot the most basic one :-)

Thanks a lot.

regards,

Lucas De Marchi
