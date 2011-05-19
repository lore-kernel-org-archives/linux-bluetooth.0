Return-Path: <cyrus@holtmann.org>
From: Alan <alanbluetooth@AiAware.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: Does any one recognise this protocol? is it RF_COMM
Date: Thu, 19 May 2011 13:13:29 +1000
References: <201105171715.47064.alanbluetooth@aiaware.com> <BANLkTinCkT1wXAUiuQz2jmgfGCHwmvhonw@mail.gmail.com>
In-Reply-To: <BANLkTinCkT1wXAUiuQz2jmgfGCHwmvhonw@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <201105191313.29238.alanbluetooth@aiaware.com>
Content-Type: Text/Plain;
  charset="windows-1252"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Status my problems are solved for now...
>From here on down the turtles appear to be all mine. Weeee.... 

On Wednesday 18 May 2011 03:30:53 you wrote:
> On 17 May 2011 12:45, Alan <alanbluetooth@aiaware.com> wrote:
> > What protocol is this?   Can it be RF_COMM ?
> 
> It looks like it is RFCOMM yes (at least it looks sane from my mental
> parser).
> 
> > Im pretty sure the   2b 20 20 00  is is L2CAP  [size and channel ID].
> Yes
> 
> > Does anyone recognise a protocol runnign on L2CAP that looks like this
> Yes - it's RFCOMM

You got no idea how good it is to be sure of at least one or two things.
Those few bytes were always a gulf between what I was coding against and the 
last thing I new for sure. I had a fundamental problem with attempting to 
interperet any protocol when a few of the preceding bytes meant? and changed 
from time to time. 

Armed with that certainty I have determiend that my actual sticking point
was that the connect sequence from windows was examining via SDP what servies 
were offered and that I had to emulate to some degree the proprietary service 
as advertised.... I guessed and tried a plain old serial service, which was 
superficially similar to thers and it works fine (so far).  

Im beginning to like my physical device manufacturer more and more as so far 
I've not run into anything that was seemingly utterly borked as was situatiion 
normal at the last telco I worked for, and in the OS that shall not be named.
Even this SDP requirement appears to only test "does it advertsie the protocol 
I want to talk?" (yeah Im new to bt Id never seen an advertisement or sdptool 
browse) (it took me awhile to find "hciconfig hci0 class" as well.)



> I assume you mean the "extra" 00 in the "outbound packet" you
> mentioned above?  
yes extra in the windows packet which is what Im trying to emulate so its 
missing in my packets when I try to send the same data from linux.
 (sorry if my befuddlement was leaking)
> If so then don't worry, that is the "credits" field
> when RFCOMM is operating with credit based flow control - it's present
> when the poll bit (0x10) is set in the control field for a UIH
> (control field = 0xef).
Now that sounds gnarly.

Ta. I will check that out. 
A quick google (now that i have the right keywords) seemed to say that "credit 
based flow control" is negotiated. Ive looked at  the HCI dump of that connect 
negotiation.  ouch. gnarly in hex. In my observation the extra byte is only 
sent one way which seems odd but then again the data coming back from the 
device is much larger than the questions. The device appears to never sends 
any "credits" field back to the windows software.

Its either credits or weird ignored extra leading bytes in the proprietary 
protocol. I have tested and I can stuff extra bytes into the front of the 
packets (before 7E) that I send to the Physical device. It appears to ignore 
them up to the leading 7E. Its plausible that older versions of the device 
used an extra byte to route packets to internal susbsystems, ... but Im 
guessing pretty hard here.

If I really am about to today get my (facade based) emulation of the device 
going I can test and be certain which it is, as I will either get the zeros 
delivered by RFCOMM as data or they will be eaten as part of the header.
 
> The RFCOMM specification gives a basic introduction, but the headers
> can be quite gnarly since they are quite "packed"
I've worked with snmp, SS7 signalling protocol and worse..., the RFCOMM 
packing isnt tooo gnarly, but I admit storing an extension flag in the lsb and 
length*2 in the higher bits tricked me for bit. Im sure it makes sense in a 
circuit. I had stared at those 3 bytes for ages looking a length and missed it 
entirely.

> overview for the regular frames (Figure 5.1) and credit based flow
> control frames (Figure 6.1) though 
More good key words for google. Yummy.
> Otherwise TS 07.10 - you can find it on 3GPP.

	Alan
