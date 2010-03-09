Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth-next] bluetooth: hci_sysfs: use strict_strtoul
 instead of simple_strtoul
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com
In-Reply-To: <1266843933-28802-2-git-send-email-tomas.winkler@intel.com>
References: <1266843933-28802-1-git-send-email-tomas.winkler@intel.com>
	 <1266843933-28802-2-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Mar 2010 17:03:59 -0800
Message-ID: <1268096639.3712.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  net/bluetooth/hci_sysfs.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)

can you please explain the rational behind this change. What is the
benefit? I just fail to see it right away.

Regards

Marcel


