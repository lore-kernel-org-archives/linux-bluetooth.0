Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 16:06:49 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: check L2CAP info_rsp ident and state
Message-ID: <20110329190359.GA8336@joana>
References: <1301045501-3346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1301045501-3346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-03-25 11:31:41 +0200]:

> From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
> 
> Information requests/responses are unbound to L2CAP channel. Patch
> fixes issue arising when two devices connects at the same time to
> each other. This way we do not process out of the context messages.
> We are safe dropping info_rsp since info_timer is left running.
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Patch has been applied. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
