Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Dec 2010 10:47:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Change obex_service_driver put() signature
Message-ID: <20101209084745.GA20606@jh-x301>
References: <1291878480-14865-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1291878480-14865-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Dec 09, 2010, Slawomir Bochenski wrote:
> This API change is needed for implementing Message Access Profile, as
> MAP uses application parameters in puts also (for example
> SetMessageStatus function, see MAP specification, chapter 5.7) and in
> order to access application parameters headers, access to obex object
> is required.
> ---
>  plugins/ftp.c           |    3 ++-
>  plugins/opp.c           |    3 ++-
>  plugins/syncevolution.c |    3 ++-
>  src/obex.c              |    2 +-
>  src/service.h           |    3 ++-
>  5 files changed, 9 insertions(+), 5 deletions(-)

Pushed upstream. Thanks.

Johan
