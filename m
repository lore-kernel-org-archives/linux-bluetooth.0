Return-Path: <James@superbug.demon.co.uk>
Message-ID: <4039275F.5020802@superbug.demon.co.uk>
Date: Sun, 22 Feb 2004 22:04:15 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: =?ISO-8859-1?Q?Fred_Sch=E4ttgen?= <bluez-devel@schaettgen.de>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>,
   Simon Vogl <vogl@soft.uni-linz.ac.at>
Subject: Re: [Bluez-devel] sco link help needed
References: <4034CA08.50500@soft.uni-linz.ac.at>	 <200402191629.38846.bluez-devel@schaettgen.de>	 <40376D2B.1060904@superbug.demon.co.uk> <1077452836.2716.42.camel@pegasus>	 <403916CB.3060205@superbug.demon.co.uk> <1077485446.2832.14.camel@pegasus>
In-Reply-To: <1077485446.2832.14.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-ID: <bluez-devel.lists.sourceforge.net>

Marcel Holtmann wrote:
> Hi James,
> 
> 
>>A agree that we need a clearly defined interface for the bluetooth SCO.
>>For SCO connections the interface will HAVE to be a callback based 
>>interface. SCO is all about realtime data, and we must ensure minimal 
>>latency, so that requires a callback interface.
>>I.E. We set up the SCO connection, and get it to callback after every X 
>>frames received. The same for sending, callback saying I need X samples now!
> 
> 
> we already had this discussion and there is no need for such a callback
> stuff. If there is too much data, we simply have to drop some samples.

So you only want a basic read/write interface? No possibility for 
specifying low latency and setting accurate playback timing?
What would happen if the user wanted to use bluetooth headphones, and 
wanted sound to come out of the headphones, and the video from a DVD to 
be displayed on the computer screen. We need some way to ensure the two 
are in sync. A simple read/write interface cannot do that.
For playing a DVD, latency does not matter, what matters in accurate 
playback timing.
For Voice over IP, low latency is what matters.
I cannot see how your simple read/write interface can handle these 
options. The SCO interface should be able to handle all these.

> 
> 
>>For alsa to work well with bluetooth, we will need some special handling 
>>. The main use of alsa with bluetooth will be for headset communications 
>>and therefore use the bluetooth headset profile.
> 
> 
> That is wrong. Also Handsfree, Cordless Telephony and Intercom needs a
> SCO to audio device mapping. With eSCO we will also have a data link and
> maybe more profiles in the future.

Ok, so you only want alsa to interface PCM (alsa's term for an audio 
channel, where the audio samples go.) directly to a SCO channel.
So, what about an application that supports alsa now. How will it set 
volume and mic levels on a bluetooth headset? Will the user have to add 
special bluetooth support to their application?

Cheers
James
