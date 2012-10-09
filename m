Return-Path: <cyrus@holtmann.org>
Message-ID: <50744EB5.90900@linux.intel.com>
Date: Tue, 09 Oct 2012 18:20:05 +0200
From: Frederic Danis <frederic.danis@linux.intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/7] Move adapter config file to ini-file format
References: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com> <1349798898.27233.97.camel@aeonflux>
In-Reply-To: <1349798898.27233.97.camel@aeonflux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Marcel,

On 09/10/2012 18:08, Marcel Holtmann wrote:
> Hi Fred,
>
>> Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/adapter
>> in ini-file format for BlueZ 5.
>> If this file does not exist, we try to convert old config file to it.
>
> since we are already using /config as file name, I propose we convert
> this to /settings. I do not like the file name /adapter.

OK, I will change it.

> We need to make sure that once the new file exists, that we do not keep
> converting over and over again.

/config file is converted only if loading of new /settings file failed.

> I would also propose to add an extra entry to the old file that marks it
> as converted. Then we can at some point in the future, start cleaning
> out the leftovers.

OK, I will add "converted yes" at end of /config file after conversion.

Btw, should not we remove /config file after conversion ?

Regards

Fred

-- 
Frederic Danis                            Open Source Technology Center
frederic.danis@intel.com                              Intel Corporation

