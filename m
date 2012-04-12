Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 22:00:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd v3 1/3] MAP: Mark filter strings const
Message-ID: <20120412190031.GB29311@x220.P-661HNU-F1>
References: <1334256809-15052-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334256809-15052-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Thu, Apr 12, 2012, Slawomir Bochenski wrote:
> This structure is used for giving filters as input argument to
> messages_get_messages_listing(). There is no need for the string members
> to be modifiable in this context. And making them const plays well with
> map_ap_get_string(), from which the values of these members are going to
> be retrieved.
> 
> The string pointers here are simply references to data held in map_ap_t
> *inparams.
> ---
> v3: Add paragraph about pointers being references to data held in another data structure.
>  plugins/messages.h |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

All three patches have been applied. Thanks.

Johan
