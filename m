Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] a2play and Toshiba SR-1 Bluetooth Headset
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Cc: Henryk =?ISO-8859-1?Q?Pl=F6tz?= <henryk@ploetzli.ch>
In-Reply-To: <20041125105615.GA19821@snoopy.src.ricoh.co.jp>
References: <20041125091124.GA19805@snoopy.src.ricoh.co.jp>
	 <20041125112509.75347786.henryk@ploetzli.ch>
	 <20041125105615.GA19821@snoopy.src.ricoh.co.jp>
Content-Type: text/plain
Message-Id: <1101440449.6465.64.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 26 Nov 2004 04:40:49 +0100

Hi Alain,

> actually I was just about to send a new mail to the mailing list.
> Just looking at the BlueZ page, I saw that there is a new hcidump 
> package so after updating I clearly saw the bitpool thing. I just
> replaced the two hardcoded bitpool min and max by the one supported
> by my headset and I got .....
> 
> hum ... weird sound :-(
> 
> well I can recognize my music but sometimes it's going faster, slower
> then faster again .... 
> 
> seems also right and left channel are not same ... well can't be sure
> about that because the sound is very weird ... 
> 
> I don't know what I can do else ... just let me know.
> 
> did you made any other modification to the CVS ? Just got it few hours ago 
> so I think except this min/max thing nothing has changed.

actually the discover shows more than one endpoint:

      AVDTP(s): Discover rsp: transaction 0
        ACP SEID 1 - Audio Sink
        ACP SEID 3 - Audio Sink
        ACP SEID 4 - Audio Source

But we only request information about the first SEID. We need to change
the code to actually request the capabilities of all endpoints so that
they at least show up in a hcidump.

You can try to hack the a2play.c to use SEID 3 instead of 1 and see what
the audio sink on SEID 3 offers you. Run the hcidump 1.15.

However the capabilities of SEID 1 shows the content protection:

      AVDTP(s): Capabilities rsp: transaction 1
        Media Transport
        Media Codec - SBC
          44.1kHz 48kHz 
          Mono DualChannel Stereo JointStereo 
          4 8 12 16 Blocks
          4 8 Subbands
          SNR Loudness 
          Bitpool Range 4-64
        Content Protection
          02 00 

For me it is not clear if we have to set them, ignore them or what to do
with them. Do we have to insert the content protection header in the
media payload if these capability is present?

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
