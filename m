Return-Path: <cyrus@holtmann.org>
Message-ID: <48B12B25.2080700@sssup.it>
Date: Sun, 24 Aug 2008 11:34:29 +0200
From: Ludovico Cavedon <cavedon@sssup.it>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <488CDD7C.40708@sssup.it>
	<19396E3B-AC04-4896-9435-F4BB61DA1075@gmail.com>
In-Reply-To: <19396E3B-AC04-4896-9435-F4BB61DA1075@gmail.com>
Subject: Re: [Bluez-devel] Why always disconnect the headset?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Johan,

Johan Hedberg wrote:
> On Jul 27, 2008, at 23:41, Ludovico Cavedon wrote:
>> I noticed that every time an application closes a SCO audio device, my
>> headset gets disconnected (HEADSET_STATE_DISCONNECTED). This means  
>> that
>> when the application reopens the device, it requires some seconds to  
>> get
>> the audio working.
>>
>> So, why is the headset disconnected and not just left in the state
>> HEADSET_STATE_CONNECTED? (i.e. the same stat that the headset enters
>> when I turn it on and pairs with my pc).
> 
> You didn't mention which version of BlueZ you use, but in recent  
> versions the logic is such that only implicitly created connections  
> are automatically disconnected (after a 3 second timeout) but  
> explicitly created connections stay up until you manually disconnect  
> them. An implicitly created connection would be one caused by an ALSA  
> application when it opens the audio device. Connections that fall into  
> the explicitly created category are those that happen when you turn  
> the headset on and it connects to the PC or when you call the  
> Headset.Connect() D-Bus method and the PC connects to the headset.

Sorry I forgot: I am using 3.26 provided with Ubuntu hardy.
Good news, I'll update my bluez version!

Thank you for your answer,
Ludovico

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
