Return-Path: <cyrus@holtmann.org>
Date: Fri, 21 Jan 2011 12:26:41 +0530
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Fix uninitialized struct sockaddr_hci memory passed to
 bind()
Message-ID: <20110121065641.GC1789@jh-x301>
References: <1295557368-9737-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1295557368-9737-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jan 20, 2011, Anderson Lizardo wrote:
> The bind() call in open_socket() was passing a struct sockaddr_hci to
> bind() with two uninitialized bytes. This caused "Invalid argument" errors
> on kernels which do strict checks of struct sockaddr_hci fields.
> ---
>  src/hcidump.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Pushed upstream. Thanks.

Johan
