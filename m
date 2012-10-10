Return-Path: <cyrus@holtmann.org>
Message-ID: <1349863391.27233.115.camel@aeonflux>
Subject: Re: [PATCH v2 0/7] Move adapter config file to ini-file format
From: Marcel Holtmann <marcel@holtmann.org>
To: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Wed, 10 Oct 2012 12:03:11 +0200
In-Reply-To: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Adapter saved configuration will be saved to /var/lib/bluetooth/<adapter address>/settings
> in ini-file format for BlueZ 5.
> If this file does not exist, we try to convert legacy config file to it.
> 
> Access to variables during run-time is performed in adapter structure which is populated by loading saved configuration during initialization.
> 
> First 6 patches remove access to config file from run-time.
> Last patch move to ini-file format style (load, save and convert).

I am fine with the first 6 patches (7 in the end). Lets have Johan a
second look at it.

For the actual change to the new format, can you first create a document
describing the new format. Something like doc/settings-storage.txt or
similar (if anyone can think of a better name).

Regards

Marcel


