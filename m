Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Jul 2011 11:16:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Syam Sidhardhan <syamsidhardh@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd] Remove redundant copy of GSlist* from functions
Message-ID: <20110713081626.GA15147@dell.ger.corp.intel.com>
References: <1308960870-17615-1-git-send-email-syamsidhardh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1308960870-17615-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

On Sat, Jun 25, 2011, Syam Sidhardhan wrote:
> Local copy of the pointer to list is not required, because these
> functions already has a copy, through the arguments.
> ---
>  gdbus/object.c              |    6 ++----
>  plugins/phonebook-tracker.c |   23 ++++++++---------------
>  src/service.c               |    6 ++----
>  3 files changed, 12 insertions(+), 23 deletions(-)

I still prefer l/list as the iterator variable for lists (just like "i"
is intuitive as an integer iterator). Since the gain (one less stack
variable) is not significant here while the readability is somewhat made
worse, I'd rather not apply this patch.

Johan
