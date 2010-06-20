Return-Path: <cyrus@holtmann.org>
Date: Sun, 20 Jun 2010 01:14:59 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Update sec_level and auth_type for already
 existing connections
Message-ID: <20100620041459.GB32372@vigoh>
References: <1276606565-4381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1276606565-4381-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2010-06-15 15:56:05 +0300]:

> From: Ville Tervo <ville.tervo@nokia.com>
> 
> Update auth level for already existing connections if it is lower
> than required by new connection.
> 
> Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> Reviewed-by: Emeltchenko Andrei <andrei.emeltchenko@nokia.com>
> Signed-off-by: Luciano Coelho <luciano.coelho@nokia.com>
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> ---
>  net/bluetooth/hci_conn.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)

What's the use case here? i.e., how do I test your patch?

-- 
Gustavo F. Padovan
http://padovan.org
