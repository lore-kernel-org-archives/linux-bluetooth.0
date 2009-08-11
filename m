Return-Path: <cyrus@holtmann.org>
Message-ID: <4A8153D9.4020008@gmail.com>
Date: Tue, 11 Aug 2009 13:19:53 +0200
From: Till Kamppeter <till.kamppeter@gmail.com>
MIME-Version: 1.0
To: Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org, Tim Waugh <twaugh@redhat.com>
Subject: Re: PATCHES: Device discovery of the "bluetooth" CUPS backend does
 not work
References: <4A8080DC.2010204@gmail.com> <1249986829.2022.17.camel@localhost.localdomain>
In-Reply-To: <1249986829.2022.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bastien Nocera wrote:
>> Therefore I have modified /etc/dbus-1/system.d/bluetooth.conf 
>> to grant this permission.
>>
>> I have added the following lines into the <busconfig> section:
>>
>>
>>    <!-- allow users of lp group (printing subsystem) to communicate with 
>> hcid -->
>>    <policy group="lp">
>>      <allow send_destination="org.bluez"/>
>>    </policy>
> 
> Looks good. What about patching the upstream config file instead?
> 

This is my intention, is it another file than 
/etc/dbus-1/system.d/bluetooth.conf? I simply want nothing more than 
that the access permission for "lp" is there out-of-the-box.

>> Second, the output of the CUPS Bluetooth backend was not very good for 
>> the printer setup tools doing the right thing. I have patched the 
>> backend to let the device class of the Bluetooth printers to be "direct" 
>> and not "network", as users expect a Bluetooth printer rather under the 
>> local printers than under the network printers.
> 
> That seems like a good idea, but I don't know enough about the internals
> of CUPS to know whether it changes anything but the classification of
> the printer.
> 
> If it doesn't change the behaviour wrt. errors and retries, then I'm
> fine with it.
>

The device class only appears in the output of the backends in discovery 
mode. It does not enter anywhere into the configuration of the print 
queue. So it seems only to server for separating local and network 
printers in the listing of detected printers in a printer setup tool.

A Bluetooth printer has to get paired with a computer before the 
Bluetooth CUPS backend can find it. This makes it getting assigned to 
one single computer, whereas a network printer (Ethernet or WLAN) gets 
discovered by all computers in the network and all computers can have a 
working queue accessing to the same network printer. Therefore a 
Bluetooth printer has more the characteristics of a local printer.


>>  I have also filled the 
>> make-and-model field instead of putting a hard-coded "Unknown" there. 
>> The change is here:
> 
> This part is broken. The backend man page says those are possible types
> of output:
> device-class scheme "Unknown" "device-info"
> device-class device-uri "device-make-and-model" "device-info"
> device-class device-uri "device-make-and-model" "device-info" "device-id"
> device-class device-uri "device-make-and-model" "device-info" "device-id" "device-location"
> 
> So if you have the device-id, you must have a device-info. Your patch
> removes the device-info even if we have a device-id.
> 

Really? What I did is replacing the "Unknown" by "%s" and adding a 
second "expanded" for the additional "%s". I have tested it and it works 
as expected.

This is the output with my patch:

direct bluetooth://001A0E1769AA "Officejet H470" "Officejet H470 
(Bluetooth)" "MFG:HP;MDL:Officejet 
H470_BT;CMD:PCL,DW-PCL,DESKJET,DYN;CLS:PRINTER;DES:CB028A;"

It has exactly the 5 items as the second last line of the output schemes 
which you show above shows.

> 
> In the future, please attach the patches to your mail, and make sure
> they apply to the upstream sources.

Sorry, was my first patch submission to this project.

Do you have a bug/feature request tracking system?

    Till
