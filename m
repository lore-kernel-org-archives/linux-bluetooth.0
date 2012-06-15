Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120615101359.GA6586@x220.ger.corp.intel.com>
References: <20120525054425.GA10062@virgil.dodds.net> <20120530075503.GI6539@x220>
 <20120615101359.GA6586@x220.ger.corp.intel.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 15 Jun 2012 10:14:45 -0300
Message-ID: <CAMOw1v5TEXo8FV54m8Efpk8z9YOE4BJaui_ppU192vT=4dQTKg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Update tests to be compatible with gi and python3
To: Steve Langasek <steve.langasek@canonical.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 15, 2012 at 7:13 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Steve,
>
>> On Thu, May 24, 2012, Steve Langasek wrote:
>> > From: Steve Langasek <steve.langasek@canonical.com>
>> >
>> > This patch makes the python tests source-compatible with python 3, while
>> > leaving the interpreter at python 2 for now.
>> >
>> > The tradeoff is that this source is no longer compatible with python
>> > versions < 2.6, and requires gobject-introspection for the glib-based tests.
>> >
>> > Signed-off-by: Steve Langasek <steve.langasek@canonical.com>
>>
>> We don't use signed-off-by for user space patches so please leave it out
>> from the commit message.

Woww... very nice.

Now I can stop having to manually call python2 binary in Archlinux
(since they decided python3 to be the default interpreter for python)
:-)


Lucas De Marchi
