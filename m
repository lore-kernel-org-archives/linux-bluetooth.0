Return-Path: <cyrus@holtmann.org>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
From: Bastien Nocera <hadess@hadess.net>
To: Till Kamppeter <till.kamppeter@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
In-Reply-To: <4A8080DC.2010204@gmail.com>
References: <4A8080DC.2010204@gmail.com>
Content-Type: text/plain
Date: Tue, 11 Aug 2009 11:33:49 +0100
Message-Id: <1249986829.2022.17.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Till,

On Mon, 2009-08-10 at 22:19 +0200, Till Kamppeter wrote:
> Hi,
> 
> I am using Bluez 4.47, and I can set up a Bluetooth printer only 
> manually by running the "bluetooth" CUPS backend from the command line with
> 
> /usr/lib/cups/backend/bluetooth
> 
> and then pasting the URI into the field for individual URI input in 
> system-config-printer ("Others" in the device list). Then I also need to 
> choose manufacturer and model manually. My expectation is that I only 
> need to click the printer's make model name in the devices list and 
> choose "Bluetooth" under the connection types and then the driver gets 
> selected automatically as it is the case for the same printer on USB or 
> WLAN.
> 
> I have found out why it does not work.
> 
> First, the CUPS Bluetooth backend asks the bluez D-Bus service whether 
> there are printers available and which device ID they have. The access 
> permissions for the bluez D-Bus service do not permit the CUPS system 
> user "lp" to access, and exactly as this user the Bluetooth backend is 
> running. Therefore I have modified /etc/dbus-1/system.d/bluetooth.conf 
> to grant this permission.
> 
> I have added the following lines into the <busconfig> section:
> 
> 
>    <!-- allow users of lp group (printing subsystem) to communicate with 
> hcid -->
>    <policy group="lp">
>      <allow send_destination="org.bluez"/>
>    </policy>

Looks good. What about patching the upstream config file instead?

> Second, the output of the CUPS Bluetooth backend was not very good for 
> the printer setup tools doing the right thing. I have patched the 
> backend to let the device class of the Bluetooth printers to be "direct" 
> and not "network", as users expect a Bluetooth printer rather under the 
> local printers than under the network printers.

That seems like a good idea, but I don't know enough about the internals
of CUPS to know whether it changes anything but the classification of
the printer.

If it doesn't change the behaviour wrt. errors and retries, then I'm
fine with it.

>  I have also filled the 
> make-and-model field instead of putting a hard-coded "Unknown" there. 
> The change is here:

This part is broken. The backend man page says those are possible types
of output:
device-class scheme "Unknown" "device-info"
device-class device-uri "device-make-and-model" "device-info"
device-class device-uri "device-make-and-model" "device-info" "device-id"
device-class device-uri "device-make-and-model" "device-info" "device-id" "device-location"

So if you have the device-id, you must have a device-info. Your patch
removes the device-info even if we have a device-id.

<snip>
> See also my Ubuntu bug report:
> 
> https://bugs.launchpad.net/bugs/411610
> 
> I am very grateful if you could apply these changes to Bluez upstream, 
> as this makes the bluetooth CUPS backend just work.
> 
> Thank you very much in advance.

In the future, please attach the patches to your mail, and make sure
they apply to the upstream sources.

Cheers

