Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Mar 2009 11:49:21 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Nick Pelly <npelly@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Null pointer check on cb in finalize_resume()
Message-ID: <20090327094921.GA2711@jh-x301>
References: <35c90d960903261650s7d4031a4v764682e2d7ea953c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <35c90d960903261650s7d4031a4v764682e2d7ea953c@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Nick,

Thanks for the patches. All of them, except for this one, seemed fine.

On Thu, Mar 26, 2009, Nick Pelly wrote:
> From: Nick Pelly <npelly@google.com>
> Date: Thu, 26 Mar 2009 15:22:32 -0700
> Subject: [PATCH] Null pointer check on cb in finalize_resume().
> 
> Fix a null pointer crash that occured when resuming A2DP streaming after
> making an outgoing call.

This looks like it's covering up for another bug where we've added a NULL
element into the list. I went through the current code and there are two places
where elements are added to the list. Both of these places use g_new0 which
will never return NULL (the default GLib behavior or to call abort() in the
case of an allocation failure) so most likely this added NULL check is
unnecessary with the current code base (but of course doesn't really hurt
either).

Johan
