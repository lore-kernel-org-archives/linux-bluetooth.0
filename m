Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Nov 2013 15:06:08 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv6 02/19] android/socket: Handling rfcomm sockets
Message-ID: <20131120130608.GA28347@x220.p-661hnu-f1>
References: <1384943077-5366-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1384943077-5366-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1384943077-5366-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Wed, Nov 20, 2013, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Implement functions creating and destroying rfcomm_socket structures.
> ---
>  android/socket.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 63 insertions(+), 1 deletion(-)

I've applied the first patch, but this one doesn't compile:

android/socket.c:81:13: error: ‘cleanup_rfsock’ defined but not used [-Werror=unused-function]
 static void cleanup_rfsock(struct rfcomm_sock *rfsock)

Johan
