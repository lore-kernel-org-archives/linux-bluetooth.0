Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20090514145348.GA1977@piper.oerlikon.madduck.net>
References: <20090514145348.GA1977@piper.oerlikon.madduck.net>
Date: Thu, 14 May 2009 16:36:57 -0300
Message-ID: <2d5a2c100905141236r3f4b31b5n44ba213d0fee2a5b@mail.gmail.com>
Subject: Re: DUN functionality with 4.x
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux bluetooth mailinglist <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, May 14, 2009 at 11:53 AM, martin f krafft <madduck@madduck.net> wrote:
> Hi,
>
> we use the bluez-utils 3.x functionality provided by dund a lot:
> providing a dial-up endpoint with pppd to allow clients to "dial-in"
> to the bluetooth host.
>
> With 4.x, I cannot find this functionality anymore. PAN is still
> there, but where is DUN?
>
> Thanks for any pointers,


It is quite simple, try using test/test-serial you can pass 'dun'
which will give a port (/dev/rfcomm#) which you can pass to pppd. A
complete solution for dun is probably a job for either NetworkManager
or connman.


-- 
Luiz Augusto von Dentz
Engenheiro de Computação
