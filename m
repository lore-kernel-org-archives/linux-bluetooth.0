Return-Path: <cyrus@holtmann.org>
Message-ID: <d89ddf300807241229yb209730r71b77af2966ca60b@mail.gmail.com>
Date: Thu, 24 Jul 2008 13:29:03 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "keith preston" <keithpre@gmail.com>
Subject: Re: [PATCH] bluez a2dp alsa fix
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <3837d8b10807231531h36402a71g3ee5ac500a5dc45@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3837d8b10807231531h36402a71g3ee5ac500a5dc45@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Keith

I may be wrong but I thought this list was for kernel issues.
bluez-devel might be better for userland.

I guess we have a similar problem in bluetooth_hsp_write. I can't make
the commit... when we're on git then everything will be good again.

On Wed, Jul 23, 2008 at 4:31 PM, keith preston <keithpre@gmail.com> wrote:
>  However in this case where we don't have a full block to encode in
> SBC, we return basically return (incoming_buffer_size) %
> (SBC_Encode_Block_size).   This is correct in the case where
> (incoming_buffer_size) < (SBC_Encode_Block_size), however is wrong
> when (incoming_buffer_size) > (SBC_Encode_Block_size), because this
> statement ignores previously processed blocks.

-- 
Brad
