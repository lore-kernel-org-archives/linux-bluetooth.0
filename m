Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Feb 2013 12:36:42 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: Re: [PATCH v2 6/6] Bluetooth: Remove redundant RFCOMM BT_CLOSED
 settings
Message-ID: <20130228153642.GA27428@joana>
References: <1362061318-30580-1-git-send-email-Dean_Jenkins@mentor.com>
 <1362061318-30580-7-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1362061318-30580-7-git-send-email-Dean_Jenkins@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dean,

* Dean Jenkins <Dean_Jenkins@mentor.com> [2013-02-28 14:21:58 +0000]:

> rfcomm_session_close() sets the RFCOMM session state to BT_CLOSED.
> However, in multiple places immediately before the function is
> called, the RFCOMM session is set to BT_CLOSED. Therefore,
> remove these unnecessary state settings.
> 
> Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
> Acked-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/rfcomm/core.c |    7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patches has been applied to bluetooth-next. Thanks for the nice work in
RFCOMM.

	Gustavo
