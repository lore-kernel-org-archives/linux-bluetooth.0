Return-Path: <cyrus@holtmann.org>
Date: Sat, 5 Apr 2014 09:50:17 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Petri Gynther <pgynther@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] input: Fix input.conf IdleTimeout handling
Message-ID: <20140405065017.GA3981@t440s.P-661HNU-F1>
References: <20140404230201.5A1BB1009F7@puck.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140404230201.5A1BB1009F7@puck.mtv.corp.google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Petri,

On Fri, Apr 04, 2014, Petri Gynther wrote:
> IdleTimeout is an optional config item in input.conf. Don't complain
> if it is not defined. Instead, do the opposite and show its value in
> debug logs only when it is defined.
> ---
>  profiles/input/manager.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Both patches have been applied. I also applied an extra patch to make
the is_connected functions use bool instead of int.

Johan
