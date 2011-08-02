Return-Path: <cyrus@holtmann.org>
Date: Tue, 2 Aug 2011 13:14:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6 v3] Make use of g_slist_free_full when elements
 are dynamically-allocated
Message-ID: <20110802101414.GA6441@dell.ger.corp.intel.com>
References: <1312279206-15500-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312279206-15500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Aug 02, 2011, Luiz Augusto von Dentz wrote:
> This avoid having to iterate twice in the list to free its elements.
> ---
>  Makefile.am                 |    2 +-
>  configure.ac                |    4 ++++
>  plugins/bluetooth.c         |    9 ++++-----
>  plugins/pbap.c              |    8 +++++---
>  plugins/phonebook-dummy.c   |    4 ++--
>  plugins/phonebook-ebook.c   |    1 +
>  plugins/phonebook-tracker.c |    6 +++---
>  plugins/vcard.c             |   22 ++++++++++------------
>  src/glib-helper.h           |   30 ++++++++++++++++++++++++++++++
>  tools/test-server.c         |    2 ++
>  10 files changed, 62 insertions(+), 26 deletions(-)
>  create mode 100644 src/glib-helper.h

This and the other five patches have been pushed upstream. Thanks.

Johan
