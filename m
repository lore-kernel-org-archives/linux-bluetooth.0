Return-Path: <cyrus@holtmann.org>
Subject: Re: dun profile
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
References: <2d5a2c100910141815l3300ee34p12fbbac2dd6a96b6@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Thu, 15 Oct 2009 10:38:57 +0100
Message-Id: <1255599537.3797.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2009-10-14 at 22:15 -0300, Luiz Augusto von Dentz wrote:
> Hi List,
> 
> Im trying to put an end to this problem of detecting rfcomm port
> properly, so what seems to be missing is to associate the profile to
> the port so that udev can properly announce it as modem in case of dun
> profile. I don't know of any mechanism to attach any profile
> information to the port itself, but in theory we could identify the
> port by name, so instead of using rfcomm# for all ports created by
> Serial interface we could name it dun# for instance, so how about
> that? Also we probably want to make this persistent so once this is
> configured this will be restored in the next boot.

Same questions as Stefan I'm afraid.

In any case, I think the front-ends should be creating the port
themselves, so they would know which one to handle.

See the recent (and less recent) work done in NetworkManager for DUN
support.

Cheers

