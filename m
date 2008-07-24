Return-Path: <cyrus@holtmann.org>
Message-ID: <3837d8b10807241234g2ae04118la17598d4fda4925@mail.gmail.com>
Date: Thu, 24 Jul 2008 14:34:27 -0500
From: "keith preston" <keithpre@gmail.com>
To: "Brad Midgley" <bmidgley@gmail.com>
Subject: Re: [PATCH] bluez a2dp alsa fix
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <d89ddf300807241229yb209730r71b77af2966ca60b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <3837d8b10807231531h36402a71g3ee5ac500a5dc45@mail.gmail.com>
	 <d89ddf300807241229yb209730r71b77af2966ca60b@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sorry I'll forward it on.   Someone should probably change this page:
http://www.bluez.org/development/lists/

To list all of the mailing lists.

Keith Preston


On Thu, Jul 24, 2008 at 2:29 PM, Brad Midgley <bmidgley@gmail.com> wrote:
> Keith
>
> I may be wrong but I thought this list was for kernel issues.
> bluez-devel might be better for userland.
>
> I guess we have a similar problem in bluetooth_hsp_write. I can't make
> the commit... when we're on git then everything will be good again.
>
> On Wed, Jul 23, 2008 at 4:31 PM, keith preston <keithpre@gmail.com> wrote:
>>  However in this case where we don't have a full block to encode in
>> SBC, we return basically return (incoming_buffer_size) %
>> (SBC_Encode_Block_size).   This is correct in the case where
>> (incoming_buffer_size) < (SBC_Encode_Block_size), however is wrong
>> when (incoming_buffer_size) > (SBC_Encode_Block_size), because this
>> statement ignores previously processed blocks.
>
> --
> Brad
>
