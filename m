Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
References: <1467320489-127890-1-git-send-email-dzickus@redhat.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Jul 2016 15:07:47 +0300
Message-ID: <CABBYNZJMpqUv1S7B1c1HGgPe7J5yMjjayws+rcXqd=Z-tceRLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] obexd fixes
To: Don Zickus <dzickus@redhat.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
	mkasik@redhat.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Don,

On Fri, Jul 1, 2016 at 12:01 AM, Don Zickus <dzickus@redhat.com> wrote:
> We started running some obexd tests to help mimic Fedora users passing info
> from their phone to their laptop.  These tests uncovered some issues.
>
> Let me know if I need to fix these patches or try something different.
>
> Cheers,
> Don
>
> Don Zickus (3):
>   obexd: Allow CreateFolder to create a directory
>   obexd: Return dummy_data instead of int in phonebook-dummy
>   obexd: Add a detailed failure message for exchanging business cards
>
>  obexd/client/opp.c              |  2 +-
>  obexd/plugins/ftp.c             |  2 ++
>  obexd/plugins/phonebook-dummy.c | 11 +++++++----
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> --
> 1.8.3.1

Applied after fixing the following problems:

#36: FILE: obexd/plugins/phonebook-dummy.c:578:
+ dummy->id = g_idle_add_full(G_PRIORITY_DEFAULT_IDLE, create_cache, query,

obexd/plugins/phonebook-dummy.c:523:8: error: unused variable ‘ret’
[-Werror=unused-variable]
  guint ret;
        ^~~
obexd/plugins/phonebook-dummy.c:556:8: error: unused variable ‘ret’
[-Werror=unused-variable]
  guint ret;
        ^~~

Ive also fixed the author of the patches so we don't have to add in
the patch description.

-- 
Luiz Augusto von Dentz
