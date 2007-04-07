Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4617D0EE.6060006@yahoo.com.au>
Date: Sat, 07 Apr 2007 19:12:14 +0200
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: "bluez-devel@lists.sourceforge.net \"Jim Carter - jimc@math.ucla.edu\"" <>
References: <45F18755.7040307@exon.dyndns.org> <45F1A3D5.7010801@xmission.com>
	<45F1B1D9.4080601@yahoo.com.au>
In-Reply-To: <45F1B1D9.4080601@yahoo.com.au>
Subject: Re: [Bluez-devel] a2dpd produces choppy audio with Digitus dongle,
	OK with D-Link
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Reviving an old thread of mine from March:

Mat wrote:
> Brad Midgley - bmidgley@xmission.com wrote:
>> hey
>>
>>> Does anyone know what causes the choppiness?
>>
>> did you try turning off all your other bluetooth equipment? if you 
>> have a headset or a pc that is switching between piconets then that 
>> comes through as gaps in the audio.
>>
>> i also had some similar trouble with the cvs code about 3 weeks ago 
>> but now it seems to be fine.
> 
> Oh.  There you go.  That fixed it.  I have a bluetooth mighty mouse: 
> switched it off and everything's coming through fine.  Thanks a lot!
> 
> So what's up with that?  That's not supposed to happen, right?  Is it a 
> software thing or a hardware thing?  I checked the a2dpd stuff out of 
> CVS only two days ago.  And the DBT-120 handles the mighty mouse and 
> A2DP no problems, I just unplugged one and plugged in the other.

Jim Carter writes with some more information:

Jim Carter - jimc@math.ucla.edu wrote:
> Sorry, I'm not subscribed to gmane.linux.bluez.devel (and am too lazy to do 
> so), so could you please post this reply back to the list for me?  
> 
> Your Digitus DN-3008M1 dongle is acting the same as my Linksys USBBT100. 
> I bought the wrong dongle.  Mine turns out to do Bluetooth v1.1.  I had
> the same symptoms as you; the phones were connecting, a few packets would 
> go through, and then the connection would be lost, whereupon the phones
> would connect again.  When I choked the bitpool down to 8 (yuck) I could
> maintain a connection but the fidelity was awful (guess why) and also it 
> sounded like popcorn in the phones because a lot of packets were being
> trashed by 802.11b competition.

Well, the DBT-120 works fine, and that too is only Bluetooth 1.1.  But 
I'm perfectly willing to believe that the "premium" dongle has 
something, somewhere in its design, that makes it perform above spec. 
As noted above, turning off my mouse seemed to fix the problem for me.

> Once I figured out the issues I got a Belkin Bluetooth USB +edr Adaptor 
> class 1 V2.0 (part # F8T012-1). (Probably should have gotten the class 2, 
> part # F8T013-1, since my headphones are class 2 and the extra range in the 
> dongle is useless.)  Starting with Bluetooth 1.2 there is error detection 
> and retransmission of trashed packets.  A2DP is officially supported only 
> in v1.2 and above. With this dongle I get reliable connections, good 
> fidelity and almost no lost packets (pops), with a bitpool of 53 as 
> indicated in the A2DP spec. The sample file that comes with a2dpd has a 
> bitpool of 32 and I'll try that also.

I was interested in what happens when you mix a class 1 dongle with a 
class 2 device, and my results appear to indicate that you do get longer 
range with a class 1 dongle than a class 2 dongle, even if the device is 
class 2.  I don't know what the precise relationship is, but I'd say the 
class 1 dongle is a good buy in any case (assuming you don't mind 
broadcasting to / interfering with your neighbours).  More details here:

http://sourceforge.net/mailarchive/message.php?msg_id=45F40969.7020201%40yahoo.com.au

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
