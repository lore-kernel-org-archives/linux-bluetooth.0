Return-Path: <cyrus@holtmann.org>
Message-ID: <1349798898.27233.97.camel@aeonflux>
Subject: Re: [PATCH 0/7] Move adapter config file to ini-file format
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Oct 2012 18:08:18 +0200
In-Reply-To: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/adapter
> in ini-file format for BlueZ 5.
> If this file does not exist, we try to convert old config file to it.

since we are already using /config as file name, I propose we convert
this to /settings. I do not like the file name /adapter.

We need to make sure that once the new file exists, that we do not keep
converting over and over again.

I would also propose to add an extra entry to the old file that marks it
as converted. Then we can at some point in the future, start cleaning
out the leftovers.

Regards

Marcel


