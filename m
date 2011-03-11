Return-Path: <cyrus@holtmann.org>
Date: Fri, 11 Mar 2011 13:13:13 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 4/4] Add detection of MAP function in OBEX requests
Message-ID: <20110311111313.GA20128@jh-x301>
References: <1299829612-3704-1-git-send-email-lkslawek@gmail.com>
 <1299829612-3704-4-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1299829612-3704-4-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Mar 11, 2011, Slawomir Bochenski wrote:
> There is also first part of mas.c <-> backend API. The mas_request
> structure will be used when calling backend functions.
> ---
>  plugins/mas.c      |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  plugins/messages.h |   15 +++++++++++++
>  2 files changed, 72 insertions(+), 0 deletions(-)

I've pushed 2/4 and 3/4 upstream, but there's at least issue one with
this last patch:

> +enum messages_function_id {
> +	MFID_INVALID = 0,
> +	MFID_SET_NOTIFICATION_REGISTRATION,
> +	MFID_GET_FOLDER_LISTING,
> +	MFID_GET_MESSAGES_LISTING,
> +	MFID_GET_MESSAGE,
> +	MFID_SET_MESSAGE_STATUS,
> +	MFID_PUSH_MESSAGE,
> +	MFID_UPDATE_INBOX,
> +};

Since "function" here doesn't seem to be referring to a C function but
to the type of request, could you call it e.g. request_type instead? Is
there a reason you you want to have this enum instead of e.g. storing
the original value of the type header?

Johan
