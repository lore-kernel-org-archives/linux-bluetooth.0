Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Apr 2012 11:28:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Slawomir Bochenski <lkslawek@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/3] MAP: Mark filter strings const
Message-ID: <20120410082820.GA5354@x220>
References: <1334005380-31302-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334005380-31302-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Mon, Apr 09, 2012, Slawomir Bochenski wrote:
> ---
>  plugins/messages.h |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)

It would be good if you could get into the habit of writing proper
commit messages. One-liners are only acceptable for extremely trivial
patches and even then I wont complain if they come with more verbose
messages.

E.g. in this case I'd at a minimum be expecting something like "These
variables should be marked as const because ...". Same goes for the rest
of the patches in this set. As far as the code changes are concerned I
didn't see anything obvious that needs fixing.

Johan
