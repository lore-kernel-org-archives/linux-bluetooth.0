Return-Path: <akmr2000@yahoo.com>
Message-ID: <20040604215717.30223.qmail@web52309.mail.yahoo.com>
Date: Fri, 4 Jun 2004 14:57:17 -0700 (PDT)
From: Aarti Kumar <akmr2000@yahoo.com>
Subject: Re: [Bluez-devel] Thoughts about AVDTP support
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1085900700.12117.106.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>


Hi Marcel,

The bluetooth avdtp specification is complex but the
if we are dealing with the basic functionality part
itself and it reduces a lot of complexities. 

What makes you think that avdtp is using Multiple
l2cap channels between same devices with same PSM - is
it beacuse of the siganlling link and data transfer
link ?

Using AVDTP as kernel module is good idea (much better
than using it at user space).

I think the connection oriented socket is required for
avdtp. Its also mentioned in the specification.

I would like to help with coding and testing if it
fine with you. I had started with the AVDTP
implementation, but it was at the user level only and
I have not much experience coding at kernel level.

Thats it for now. 

Aarti.

--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Folks,
> 
> I think one of the next major goals of BlueZ should
> be the support of
> the Audio/Video Distribution Transport Protocol
> (AVDTP). So I spent some
> time in reading the protocol specification. The
> specification is very
> complex and I think most of the products will only
> support the basic
> mode with signal and media channel. However it took
> me some time to
> realize that they are using multiple L2CAP channels
> between two devices
> with the same PSM. I never thought that this was
> possible, but our L2CAP
> core already supports such configuration. Now I
> asked myself, why HID
> and HCRP needed two different PSM values?
> 
> To be capable of handling multiple audio and video
> streams nicely, I
> think we need to implement AVDTP as a kernel module.
> In that case we can
> make use of two different interfaces to AVDTP. One
> for the A2DP support
> that is directly connected to ALSA and the second
> should be a simple
> socket interface. I am no audio/video streaming
> expert, so what socket
> type is the best for this case?
> 
> Before I start writing any source code, I would like
> to get my hands on
> a product that already uses AVDTP. I need to know
> what parts of this
> protocol are in use and how they handle it.
> Searching for an end user
> product I found one from Air2U (www.air2u.com.tw).
> The german reseller
> is Aiptek and they call it BT MusiCool 300
> 
> 
>
http://www.aiptek.de/index.php?mapid=31&katid1=4&detailid=11
> 
> I asked them to donate one of these to me, but they
> said no. Actually
> not a nice company. Searching a little bit more I
> found out that Amazon
> is selling it for 99 EUR. This is fair price for two
> Bluetooth devices
> (SNK and SRC), but I decided not to buy them. My
> conclusion was that if
> I should really start working on AVDTP, someone else
> should buy me an
> end user device for testing any of my code. However
> there is always the
> possibility to donate money
> (www.bluez.org/sponsors.html) which I can
> use to buy unsupported hardware.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
>
-------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the
> market... Oracle 10g. 
> Take an Oracle 10g class now, and we'll give you the
> exam FREE.
>
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-devel



	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
