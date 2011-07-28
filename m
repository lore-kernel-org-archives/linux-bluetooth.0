Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLk=CWKJHxb1yUv4Rg-=aHVn6rWr3VJ9990Ym6p63-g+Q@mail.gmail.com>
References: <1310995152-24121-1-git-send-email-luiz.dentz@gmail.com>
	<20110718205614.GA16958@dell.ger.corp.intel.com>
	<CABBYNZKcj1WA8j5VZYy1F=ettBh7gbPDe3xEX+_+HGfrdntQOQ@mail.gmail.com>
	<CABBYNZLk=CWKJHxb1yUv4Rg-=aHVn6rWr3VJ9990Ym6p63-g+Q@mail.gmail.com>
Date: Thu, 28 Jul 2011 07:57:04 +0200
Message-ID: <CA+i+Aw37=MF2=W7ynC0OVcXAo3aH-S38V+o=PgwY-9Q6VnR+NQ@mail.gmail.com>
Subject: Re: [PATCH obexd 1/6 v2] Make use of g_slist_free_full when elements
 are dynamically-allocated
From: Slawomir Bochenski <lkslawek@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Luiz!

On Wed, Jul 27, 2011 at 1:22 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Marcel,
>
> On Tue, Jul 19, 2011 at 12:04 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> This would work for whatever file that includes config.h which seems
>> to be the perfect place for wrappers like this, but it doesn't seems
>> common to have this type of macros inside configure.ac/config.h so
>> perhaps it is a bad idea.
>
> So it seems you didn't like the idea, so shall I create a
> glib-helper.h that implements g_slist_free_full? In the other hand we
> have to remember to always include this file when using glib functions
> that have wrappers, so Im not sure if in the end this make sense since
> it might complicates things a bit too much for so little.

I've seen that the glib team has gone with your proposal for
g_[s]list_free_full. As I had doubts about this change that I had
mentioned to you before, I did benchmark it and I've discussed results
with Matthias Classen from glib (who originally committed your
proposed changes). Actually version with loop is slower than what was
there before, both in single- and multithreaded applications. Changes
in glib have been already reverted.

So as the g_slist_free_full() will be still just wrapping those two
functions we are calling now, is there a need for complicating things
that much instead of postponing using this until it is decided to drop
compatibility with glib versions w/o g_slist_free_full()?

-- 
BR,
Slawomir Bochenski
