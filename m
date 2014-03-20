Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 16:24:31 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] core: Wait for services to be resolved before
 doing authorization
Message-ID: <20140320142431.GB14172@t440s.lan>
References: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395323451-31229-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Thu, Mar 20, 2014, Luiz Augusto von Dentz wrote:
> This makes btd_request_authorization to wait until services are resolved
> before proceeding with authorization, if the services could not be
> resolved it still proceeds with authorization since some profile may not
> have a record to be resolved.
> ---
>  src/adapter.c | 38 ++++++++++++++++++++++++++++++--------
>  1 file changed, 30 insertions(+), 8 deletions(-)

Both patches have been applied. Thanks.

Johan
