Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <429ED8DF.7040602@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Linking to BlueZ from non-GPL code
References: <EFCD68F7BFDB06468769D4D9EAAA93870774B827@scsmsx401.amr.corp.intel.com>
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA93870774B827@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 02 Jun 2005 12:01:03 +0200

if he doesn't answer, you might reach him over his company:
maxk@qualcomm.com

regards
Marco


Pering, Trevor wrote:
> Max (do you read this list still?) -- is there any update to plans to
> release the BlueZ *libraries* under LGPL? Or, is there an intended way
> for non-GPL programs to interface with BlueZ?
> 
> As for the non-GPL use of the kernel, I was referring to: (from
> http://www.kernel.org/pub/linux/kernel/COPYING)
> 
> "NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal use
>  of the kernel, and does *not* fall under the heading of "derived work".
>  Also note that the GPL below is copyrighted by the Free Software
>  Foundation, but the instance of code that it refers to (the linux
>  kernel) is copyrighted by me and others who actually wrote it."
> 
> But I'm not sure if by "disagree" you meant disagree with the
> interpretation, or the intent behind it...  I have been advised by our
> lawyers that this does allow simple use of *.h files to include kernel
> constants and things like that -- but would not extend to user-land
> libraries.
> 
> Cheers,
> 	Trevor
> 
> 
> 
> 
> -----Original Message-----
> From: bluez-users-admin@lists.sourceforge.net
> [mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
> Holtmann
> Sent: Wednesday, June 01, 2005 2:45 PM
> To: bluez-users@lists.sourceforge.net
> Subject: Re: [Bluez-users] Linking to BlueZ from non-GPL code
> 
> Hi Trevor,
> 
> 
>>I have a question about linking non-GPL code to BlueZ.  This is
>>very much along the lines of the previous conversation at 
>>http://thread.gmane.org/gmane.linux.bluez.devel/2444 -- the quick
>>summary of which is: 
>> 
>>Marcel: Date: 2004-06-28 14:48:48 GMT: "For the BlueZ library and the
>>utilities we can talk about it. Some time ago people asked for a LGPL
>>version of the library and actually I tend to agree with that. However
>>this can't be decided by me alone, because part of the code is
> 
> copyright
> 
>>by Qualcomm and also by Maxim Krasnyansky himself. For the utilities I
>>don't see any need for a different license. I believe in the GPL and
>>from my view releasing the Linux Bluetooth library under LGPL is the
>>only step I wanna make forward to allow closed source products based
> 
> on
> 
>>BlueZ."
>>
>>Is this still the current status of GPL/LGPL for the BlueZ libraries
>>(libbluetooth.so) -- or has there been an update (I haven't found
>>anything more recent on the mailing list about this).
> 
> 
> nothing has changed at the moment. Ask Max for an update of changing the
> BlueZ library from GPL to LGPL.
> 
> 
>>What is the recommended way to write a non-GPL application on top of
>>BlueZ, or is this not currently allowed...? My understanding is that
> 
> it
> 
>>is OK to use the linux kernel syscall interface from non-GPL code, but
>>that this would not extend to libbluetooth.so...
> 
> 
> Actually I disagree with the non-GPL use of the syscall interface, but I
> am not lawyer. From my understanding all the bluetooth/*.h include files
> are GPL and you need them for your application. You can't replace them
> without ending up in derived work.
> 
> Regards
> 
> Marcel
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit
> http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=fad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
