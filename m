Return-Path: <cyrus@holtmann.org>
Date: Thu, 19 May 2011 19:27:22 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: fix shutdown on SCO sockets
Message-ID: <20110519222722.GB4888@joana>
References: <1305187995-5780-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1305187995-5780-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

* Luiz Augusto von Dentz <luiz.dentz@gmail.com> [2011-05-12 11:13:15 +0300]:

> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> 
> shutdown should wait for SCO link to be properly disconnected before
> detroying the socket, otherwise an application using the socket may
> assume link is properly disconnected before it really happens which
> can be a problem when e.g synchronizing profile switch.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
> ---
>  net/bluetooth/sco.c |   13 ++++++++++++-
>  1 files changed, 12 insertions(+), 1 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
