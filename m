Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKcj1WA8j5VZYy1F=ettBh7gbPDe3xEX+_+HGfrdntQOQ@mail.gmail.com>
References: <1310995152-24121-1-git-send-email-luiz.dentz@gmail.com>
	<20110718205614.GA16958@dell.ger.corp.intel.com>
	<CABBYNZKcj1WA8j5VZYy1F=ettBh7gbPDe3xEX+_+HGfrdntQOQ@mail.gmail.com>
Date: Wed, 27 Jul 2011 14:22:45 +0300
Message-ID: <CABBYNZLk=CWKJHxb1yUv4Rg-=aHVn6rWr3VJ9990Ym6p63-g+Q@mail.gmail.com>
Subject: Re: [PATCH obexd 1/6 v2] Make use of g_slist_free_full when elements
 are dynamically-allocated
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, Jul 19, 2011 at 12:04 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> This would work for whatever file that includes config.h which seems
> to be the perfect place for wrappers like this, but it doesn't seems
> common to have this type of macros inside configure.ac/config.h so
> perhaps it is a bad idea.

So it seems you didn't like the idea, so shall I create a
glib-helper.h that implements g_slist_free_full? In the other hand we
have to remember to always include this file when using glib functions
that have wrappers, so Im not sure if in the end this make sense since
it might complicates things a bit too much for so little.

-- 
Luiz Augusto von Dentz
