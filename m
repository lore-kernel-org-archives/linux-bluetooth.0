Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] core: add startup option to provide different
 configuration file
References: <1442382751-25315-1-git-send-email-simon.fels@canonical.com>
To: linux-bluetooth@vger.kernel.org
From: Simon Fels <simon.fels@canonical.com>
Message-ID: <55FA4AD0.50401@canonical.com>
Date: Thu, 17 Sep 2015 07:08:32 +0200
MIME-Version: 1.0
In-Reply-To: <1442382751-25315-1-git-send-email-simon.fels@canonical.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 16.09.2015 07:52, Simon Fels wrote:
> In some cases it's needed to select a different configuration file
> at runtime than the one we load by default from a statically
> configured path. This adds an optional argument to the daemon
> startup which will enable us to load another a configuration file
> from a different path.
> ---
>   src/main.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)


For a better understanding, our use case for this is the following:

On Ubuntu we create set of packages out of the BlueZ source which are 
used across all devices we support. We don't want to put any device 
specifics in these and use the same binaries (per architecture) on 
different device types (laptops, phones, ...). By default we ship the 
main.conf file coming with the BlueZ sources. For different device types 
we now need different settings as we need to specify different settings 
for class of device field for example. At the moment there is an 
additional package only used for phones which ships a modified 
configuration file which can't replace the one provided by the bluez 
package and is then passed to bluetoothd in an .override upstart job.

regards,
Simon

