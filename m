Return-Path: <cyrus@holtmann.org>
Date: Mon, 18 Jul 2011 23:56:14 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/6 v2] Make use of g_slist_free_full when elements
 are dynamically-allocated
Message-ID: <20110718205614.GA16958@dell.ger.corp.intel.com>
References: <1310995152-24121-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1310995152-24121-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jul 18, 2011, Luiz Augusto von Dentz wrote:
> This avoid having to iterate twice in the list to free its elements.
> ---
>  configure.ac                |    3 +++
>  plugins/bluetooth.c         |    8 +++-----
>  plugins/pbap.c              |    7 ++++---
>  plugins/phonebook-dummy.c   |    3 +--
>  plugins/phonebook-tracker.c |    5 ++---
>  plugins/vcard.c             |   18 ++++++------------
>  src/obex.h                  |    8 ++++++++
>  7 files changed, 27 insertions(+), 25 deletions(-)

Doesn't compile:

  CC     plugins/vcard.o
In file included from plugins/vcard.c:33:0:
./src/obex.h:66:51: error: unknown type name ‘obex_object_t’
./src/obex.h:68:48: error: unknown type name ‘obex_object_t’
make[1]: *** [plugins/vcard.o] Error 1

Please fix and resend.

Johan
