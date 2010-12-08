Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Dec 2010 17:18:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Changed obex_service_driver put() signature.
Message-ID: <20101208151845.GA28588@jh-x301>
References: <AANLkTikzUraZ9ac5qf9ePG8YKo0Sx0B2YZoKz8HoRTmn@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikzUraZ9ac5qf9ePG8YKo0Sx0B2YZoKz8HoRTmn@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Dec 08, 2010, Slawomir Bochenski wrote:
> This API change is needed for implementing Message Access Profile, as
> MAP uses application parameters in puts also (for example
> SetMessageStatus function, see MAP specification, chapter 5.7) and in
> order to access application parameters headers access to obex object
> is required.
> 
> ---
>  plugins/ftp.c           |    3 ++-
>  plugins/opp.c           |    3 ++-
>  plugins/syncevolution.c |    3 ++-
>  src/obex.c              |    2 +-
>  src/service.h           |    3 ++-
>  5 files changed, 9 insertions(+), 5 deletions(-)

The patch looks good, but I can't apply it with git am. I get the
following:

fatal: corrupt patch at line 14
Patch failed at 0001 Changed obex_service_driver put() signature.

Could you try recreating it with git format-patch and resending with git
send-email? Thanks.

Btw, summary line should start with "Change ..." instead of "Changed
..." and it shouldn't end with a .

Johan
