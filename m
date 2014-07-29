Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jul 2014 10:44:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] input/hog: Cleanup unnecessary code
Message-ID: <20140729074436.GA5465@t440s.lan>
References: <1406547566-23105-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1406547566-23105-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Mon, Jul 28, 2014, Luiz Augusto von Dentz wrote:
> The callback register by bt_uhid_register already contains the event type
> so there is no need to check for it again.
> ---
>  profiles/input/hog.c | 3 ---
>  1 file changed, 3 deletions(-)

Both patches have been applied. Thanks.

Johan
