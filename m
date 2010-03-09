Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth-next V2] bluetooth: hci_sysfs: use strict_strtoul
 instead of simple_strtoul
From: Marcel Holtmann <marcel@holtmann.org>
To: Tomas Winkler <tomas.winkler@intel.com>
Cc: linux-bluetooth@vger.kernel.org, guy.cohen@intel.com,
	ron.rindjunsky@intel.com
In-Reply-To: <1268163483-26181-1-git-send-email-tomas.winkler@intel.com>
References: <1268163483-26181-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 09 Mar 2010 12:41:54 -0800
Message-ID: <1268167314.3712.59.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tomas,

> use strict_strtoul as suggested by checkpatch.pl
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
> V2:
> 1. more verbose commit message
> 2. return the error code that was produced by strict_strtoul 

why do you bother actually. Reading the comment about struct_strtoul it
will only return -EINVAL or 0. So using my proposal would be just fine.
I also don't prefer to differ the return value to user space until it
actually makes sense. Invalid argument is just fine for all error cases.

Regards

Marcel


