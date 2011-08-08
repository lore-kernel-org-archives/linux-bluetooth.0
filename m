Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Aug 2011 13:23:48 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] Fix error when proximity config file is missing
Message-ID: <20110808102348.GC14171@dell>
References: <1312382727-32709-1-git-send-email-claudio.takahasi@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312382727-32709-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Aug 03, 2011, Claudio Takahasi wrote:
> Adds checking to avoid the following GLib critical error:
> Parsing /etc/bluetooth/proximity.conf failed: No such file or directory
> GLib-CRITICAL **: g_key_file_get_string_list: assertion `key_file !=
> NULL' failed
> ---
>  proximity/manager.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)

This one has also been applied. Thanks.

Johan
