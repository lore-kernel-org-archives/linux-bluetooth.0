Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Mar 2011 18:08:13 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/3 v2] Fix uninitialized variables warnings
Message-ID: <20110329150813.GA13062@jh-x301>
References: <1301406464-3404-1-git-send-email-luiz.dentz@gmail.com>
 <1301406464-3404-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1301406464-3404-2-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Mar 29, 2011, luiz.dentz@gmail.com wrote:
> src/attrib-server.c: In function ‘channel_handler’:
> src/attrib-server.c:297:21: error: ‘cur’ may be used uninitialized in this function
> src/attrib-server.c:502:10: error: ‘format’ may be used uninitialized in this function
> src/attrib-server.c:503:11: error: ‘length’ may be used uninitialized in this function
> make[1]: *** [src/attrib-server.o] Error 1
> ---
>  src/attrib-server.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)

All three patches (v2 of 2/3 & 3/3) have been pushed upstream. Thanks.

Johan
