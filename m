Return-Path: <James@superbug.demon.co.uk>
Message-ID: <403916CB.3060205@superbug.demon.co.uk>
Date: Sun, 22 Feb 2004 20:53:31 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: =?ISO-8859-1?Q?Fred_Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at>	 <200402191629.38846.bluez-devel@schaettgen.de>	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>
In-Reply-To: <1077452836.2716.42.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>For those interested, I am planning to write an alsa driver for 
>>bluetooth headsets.
>>The alsa driver module would load into kernel, but not present any sound 
>>devices.
>>Once a pairing had been set up (a small tool will be used for the 
>>pairing), the alsa driver module would then dynamically add a sound card 
>>to the kernel device list, and this sound card would work just like any 
>>other sound device in linux.
>>The alsa driver would handle both iso and rfcomm connections, iso for 
>>the sound, rfcomm for mixer volume etc.
> 
> 
> we don't need a kernel module that implements the headset profile as an
> audio device. What we need is a generic SCO kernel module with a well
> defined interface that is between the Bluetooth HCI SCO traffic and the
> ALSA sound layer. This means that if a SCO connection is created the
> driver must set up a new sound device, but the mixer stuff is profile
> stuff and must be done by a userspace application.
> 
> Regards
> 
> Marcel
> 
> 

A agree that we need a clearly defined interface for the bluetooth SCO.
For SCO connections the interface will HAVE to be a callback based 
interface. SCO is all about realtime data, and we must ensure minimal 
latency, so that requires a callback interface.
I.E. We set up the SCO connection, and get it to callback after every X 
frames received. The same for sending, callback saying I need X samples now!

It will be up to the layer above, what is does in each callback function.

The interface between bluetooth SCO and upper layers will have to be 
able to work in both kernel and user space.
alsa has all it's low level drivers in kernal space.
The low level drivers provide the direct access to the hardware.
E.g. Output/input of samples, IRQ handling, Interface to mixer hardware.
The alsa driver can dynamically add and remove what is visable to the 
user space. I.E. One plugs in a USB sound card, the card automatically 
appears for use to the user.

For alsa to work well with bluetooth, we will need some special handling 
. The main use of alsa with bluetooth will be for headset communications 
and therefore use the bluetooth headset profile.
Problems to overcome: -
1) Pairing. Provide a method to pair a bluetooth headset, so that if the 
headset tried to open the connection. bluez will link to alsa only for 
that paired device. So, we will need to be able to register alsa as a 
pairing handler to bluez. Does the concept of a pairing handler even 
exist yet in bluez?
2) There is currently no method in alsa, for alsa to tell the 
application "I am here now, listen to me!". So, if the headset initiates 
the connection, there is currently no way to use alsa to inform the 
application that the headset wishes to do such a thing. Maybe we could 
implement this with an alsa mixer element that is present all the time 
the pairing is present. And the application could poll the mixer 
element, and if the mixer element changed state, we would open the PCM 
to receive the audio. A sort of on/off hook indication.

3) The headset profile consists of a RFCOMM connection for setting 
volume levels etc. and also a SCO connection for passing audio samples.
The alsa driver will implement the headset profile when working with 
bluez. We might be able to expand that to the hands-free profile later.
The RFCOMM will therefore interface with the alsa mixer. the SCO 
connection will interface with the alsa PCM.

Summary: -
1) The alsa driver for bluetooth will be a kernel mode implementation of 
the bluetooth headset profile.

2) A userspace tool will be used to configure the bluetooth pairing and 
configure the alsa-bluez link.

3) We will need to be able to implement bluetooth profiles in kernel 
modules as well as user space applications.

4) The bluez SCO interface should be changed to a callback interface.

That is currently what I think would need to happen.
Any comments?

Cheers
James
