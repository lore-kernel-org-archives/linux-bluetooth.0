Return-Path: <cyrus@holtmann.org>
Date: Thu, 10 Mar 2011 13:58:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/4] Add skeleton for Message Access Profile plugin
Message-ID: <20110310115828.GB18256@jh-x301>
References: <1299755065-4816-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299755065-4816-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Mar 10, 2011, lkslawek@gmail.com wrote:
> This patch introduces skeleton of a plugin supporting server role side
> of Bluetooth SIG profile defining procedures for exchanging message
> objects.
> 
> The plugin can be compiled with different backends used for accessing
> message repository. This can be selected during configure:
> 
> 	./configure --with-messages=backend_name
> 
> When no backend is specified, the default dummy is chosen.
> 
> There is also a new command line option to obexd needed to start Message
> Access service:
> 
> 	obexd [...] --mas
> ---
> v2: fix copyright declarations
> 
>  .gitignore               |    1 +
>  Makefile.am              |   10 +++++++++-
>  configure.ac             |   12 ++++++++++++
>  plugins/mas.c            |   42 ++++++++++++++++++++++++++++++++++++++++++
>  plugins/messages-dummy.c |   28 ++++++++++++++++++++++++++++
>  plugins/messages.h       |   22 ++++++++++++++++++++++
>  src/main.c               |   11 +++++++++--
>  src/obex.h               |    1 +
>  8 files changed, 124 insertions(+), 3 deletions(-)
>  create mode 100644 plugins/mas.c
>  create mode 100644 plugins/messages-dummy.c
>  create mode 100644 plugins/messages.h

This patch has been pushed upstream, however I'll wait until we reach a
consensus on the coding style issues for the other patches before
proceeding with them.

Johan
