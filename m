Return-Path: <cyrus@holtmann.org>
Date: Wed, 25 Aug 2010 14:28:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Colin Didier <didier@archos.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] An interrupted syscall is not an error when returning
 from poll() in audio/pcm_bluetooth.c
Message-ID: <20100825112831.GB23943@jh-x301>
References: <20100825085454.GB27072@cybione.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100825085454.GB27072@cybione.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

On Wed, Aug 25, 2010, Colin Didier wrote:
> An interrupted syscall is not an error when returning from poll() at
> line 240 of audio/pcm_bluetooth.c. So no need to freak out.
> 
> Here is a patch to fix this.

The patch itself seems fine, but the same comments apply for the commit
message as with your other patch. I.e. prepare with git format-patch and
make sure that you don't have overly long lines (e.g. the summary line
is much too long in this one).

Johan
