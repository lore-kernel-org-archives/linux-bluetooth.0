Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAMOw1v5GdFxwmNJX9U+9HTmSRi-FkOhLaSFSU0YQ9WKeosvvMw@mail.gmail.com>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
	<1368073016-28434-5-git-send-email-lucas.demarchi@profusion.mobi>
	<CAJdJm_MaTBC+bT-aTbKPPDQrziq4WJArow_ERbzRiq54pp+ZJg@mail.gmail.com>
	<CAMOw1v5GdFxwmNJX9U+9HTmSRi-FkOhLaSFSU0YQ9WKeosvvMw@mail.gmail.com>
Date: Thu, 9 May 2013 08:31:02 -0400
Message-ID: <CAJdJm_O3SnM67RbEHcpCZMnhyObmFcx5nCzLMhsY-rz2QaXWaQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 05/26] attrib: Get rid of guint* types
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, May 9, 2013 at 8:15 AM, Lucas De Marchi
<lucas.demarchi@profusion.mobi> wrote:
>> We used to avoid adding includes into headers, and instead add them on
>> the .c files only. (The existing include above is a unfortunate
>> exception). Not sure if this convention has changed since.
>
> Sure, but when you use a certain type in header you need the header
> (or if it's a pointer you have the option to do a forward declaration,
> but it's not the case here). If you don't do this you depend on the
> include order in each .c, risking to break the build, which is way
> worse.

My point is, I know of all these aspects of not having self-contained
headers, and I am personally okay with it. But there was a tendency in
BlueZ to explicitly add #include's to each .c where it was needed and
keep headers free from #include's. Maybe I just misinterpreted this
convention, but I wanted to have it noted (and maybe Johan/Marcel
could clarify whether this is relevant).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
