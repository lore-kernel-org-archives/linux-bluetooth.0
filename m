Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Tue, 5 Jul 2016 10:39:50 -0400
From: Don Zickus <dzickus@redhat.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
	mkasik@redhat.com
Subject: Re: [PATCH 0/3] obexd fixes
Message-ID: <20160705143950.GF90326@redhat.com>
References: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
 <CABBYNZJMpqUv1S7B1c1HGgPe7J5yMjjayws+rcXqd=Z-tceRLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CABBYNZJMpqUv1S7B1c1HGgPe7J5yMjjayws+rcXqd=Z-tceRLw@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jul 04, 2016 at 03:07:47PM +0300, Luiz Augusto von Dentz wrote:
> Hi Don,
> 
> On Fri, Jul 1, 2016 at 12:01 AM, Don Zickus <dzickus@redhat.com> wrote:
> > We started running some obexd tests to help mimic Fedora users passing info
> > from their phone to their laptop.  These tests uncovered some issues.
> >
> > Let me know if I need to fix these patches or try something different.
> >
> > Cheers,
> > Don
> >
> > Don Zickus (3):
> >   obexd: Allow CreateFolder to create a directory
> >   obexd: Return dummy_data instead of int in phonebook-dummy
> >   obexd: Add a detailed failure message for exchanging business cards
> >
> >  obexd/client/opp.c              |  2 +-
> >  obexd/plugins/ftp.c             |  2 ++
> >  obexd/plugins/phonebook-dummy.c | 11 +++++++----
> >  3 files changed, 10 insertions(+), 5 deletions(-)
> >
> > --
> > 1.8.3.1
> 
> Applied after fixing the following problems:
> 
> #36: FILE: obexd/plugins/phonebook-dummy.c:578:
> + dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,
> 
> obexd/plugins/phonebook-dummy.c:523:8: error: unused variable ‘ret’
> [-Werror=unused-variable]
>   guint ret;
>         ^~~
> obexd/plugins/phonebook-dummy.c:556:8: error: unused variable ‘ret’
> [-Werror=unused-variable]
>   guint ret;
>         ^~~

Awesome!  Thanks.  Sorry about the warning.

> 
> Ive also fixed the author of the patches so we don't have to add in
> the patch description.

Perfect.  Yeah, Marek should take full credit for those patches.

Cheers,
Don
