Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
Date: Tue, 24 Jul 2012 23:20:56 +0300
Message-ID: <CABBYNZ+SQoX45XuQN9mEPTTSyFAiJ_a3Y_hQvH4YvcJE+5Yorg@mail.gmail.com>
Subject: Re: [PATCH 0/2] obexd: Fix bug in irmc phonebook and prevent to
 reintroduce it
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Harald Schmitt <linux@hschmitt.de>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Harald,

On Wed, Jul 18, 2012 at 5:53 PM, Harald Schmitt <linux@hschmitt.de> wrote:
> This patchset fixes a bug in irmc plugin the same way as it was sent
> today, but with a commit message. The second patch defines macros in
> phonebook.h for the well known phonbook folders and names and replaces
> those magic values.
>
> Harald Schmitt (2):
>   irmc: Fix phonebook contacts query
>   phonebook: Replace magic strings for phonebook names and folders
>
>  plugins/irmc.c              |    4 ++--
>  plugins/phonebook-ebook.c   |   14 ++++++-------
>  plugins/phonebook-tracker.c |   48 +++++++++++++++++++++----------------------
>  plugins/phonebook.h         |   13 ++++++++++++
>  4 files changed, 46 insertions(+), 33 deletions(-)
>
> --
> 1.7.9.5

I guess you should take a look at patch
4f48e26fa73217dde9916fe6e857b1de7fae33cc, not sure if is the same
issue though since this here it is used as type, but perhaps it is
worth making it similar so either pbap and sync does accept the path
in both absolute or relative format.


-- 
Luiz Augusto von Dentz
