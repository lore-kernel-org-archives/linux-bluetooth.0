Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Mar 2011 16:43:33 -0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: lkslawek@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix support for shells that do not have "+="
Message-ID: <20110304194333.GA31553@jh-x301>
References: <1298637272-21031-1-git-send-email-lkslawek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1298637272-21031-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Slawek,

On Fri, Feb 25, 2011, lkslawek@gmail.com wrote:
> From: Slawomir Bochenski <lkslawek@gmail.com>
> 
> This will make maintainer mode work on less advanced shells, the ones
> that do not support appending.
> ---
>  acinclude.m4 |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

Pushed upstream. Thanks. I also went ahead and pushed a similar patch
for BlueZ.

Johan
