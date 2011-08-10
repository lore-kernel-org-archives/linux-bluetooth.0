Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Aug 2011 12:30:29 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/2] Fix memory issues in EDS PBAP
Message-ID: <20110810093029.GA21443@dell>
References: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312931140-9143-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Wed, Aug 10, 2011, Bartosz Szatkowski wrote:
> ---
>  plugins/phonebook-ebook.c |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)

Both patches have been applied. Thanks.

I additionally pushed a cleanup patch to phonebook-ebook.c since there
were quite a lot of coding style issues in it as well as GError misuse
(you always need to initialize them to NULL).

Johan
