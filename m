Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 13:39:22 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [RFC v0 12/15] input: Add profile .disconnect
Message-ID: <20121025103922.GA30500@x220>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1350661172-18125-13-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350661172-18125-13-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Fri, Oct 19, 2012, Mikel Astiz wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
> 
> Add the disconnect hook to the btd_profile.
> ---
>  profiles/input/manager.c | 1 +
>  1 file changed, 1 insertion(+)

I've applied the patches up until this one with the exception of the
audio ones which I'll let Luiz to look at and sync up with the work he's
doing for audio right now. The last three will still need some
discussion as I'm not convinced that it's a good idea to have these
generic profile objects instead or Adapter.Connect/DisconnectProfile.

Johan
