Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F1B1D9.4080601@yahoo.com.au>
Date: Fri, 09 Mar 2007 20:13:29 +0100
From: bluez.mexon@spamgourmet.com
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <45F18755.7040307@exon.dyndns.org> <45F1A3D5.7010801@xmission.com>
In-Reply-To: <45F1A3D5.7010801@xmission.com>
Subject: Re: [Bluez-devel] a2dpd produces choppy audio with Digitus dongle,
 (bluez: message 14 of 20) OK with D-Link
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

Brad Midgley - bmidgley@xmission.com wrote:
> hey
> 
>> Does anyone know what causes the choppiness?
> 
> did you try turning off all your other bluetooth equipment? if you have 
> a headset or a pc that is switching between piconets then that comes 
> through as gaps in the audio.
> 
> i also had some similar trouble with the cvs code about 3 weeks ago but 
> now it seems to be fine.

Oh.  There you go.  That fixed it.  I have a bluetooth mighty mouse: 
switched it off and everything's coming through fine.  Thanks a lot!

So what's up with that?  That's not supposed to happen, right?  Is it a 
software thing or a hardware thing?  I checked the a2dpd stuff out of 
CVS only two days ago.  And the DBT-120 handles the mighty mouse and 
A2DP no problems, I just unplugged one and plugged in the other.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
