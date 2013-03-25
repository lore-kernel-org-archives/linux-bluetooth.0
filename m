Return-Path: <cyrus@holtmann.org>
Date: Mon, 25 Mar 2013 11:36:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ] test: Fix list-devices when there is more than one
 adapter
Message-ID: <20130325093636.GA10556@x220.ger.corp.intel.com>
References: <1363810704-21450-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1363810704-21450-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi João Paulo,

On Wed, Mar 20, 2013, João Paulo Rechi Vita wrote:
> ---
>  test/list-devices | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/test/list-devices b/test/list-devices
> index 0aac217..790b358 100755
> --- a/test/list-devices
> +++ b/test/list-devices
> @@ -31,9 +31,6 @@ def extract_uuids(uuid_list):
>  
>  objects = manager.GetManagedObjects()
>  
> -all_devices = (str(path) for path, interfaces in objects.iteritems() if
> -					"org.bluez.Device1" in interfaces.keys())
> -
>  for path, interfaces in objects.iteritems():
>  	if "org.bluez.Adapter1" not in interfaces.keys():
>  		continue
> @@ -49,6 +46,8 @@ for path, interfaces in objects.iteritems():
>  		else:
>  			print("    %s = %s" % (key, value))
>  
> +	all_devices = (str(path) for path, interfaces in objects.iteritems() if
> +					"org.bluez.Device1" in interfaces.keys())
>  	device_list = [d for d in all_devices if d.startswith(path + "/")]
>  
>  	for dev_path in device_list:

Your commit message should explain why the old code is wrong and how/why
your patch makes it right. In general the code above looks suspicious
since it's relying on a certain format for the object path (the adapter
path being a prefix to the device path) instead of properly looking for
devices whose "Adapter" property on the Device1 interface matches the
path of the adapter that's currently being processed.

Johan
