Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <411649EB.9020407@patbert.com>
From: Patrick <patbert@patbert.com>
Reply-To: patbert@patbert.com
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple bluetooth keyboard fun...
References: <4115A5E3.8000107@patbert.com> <1091959881.2773.6.camel@pegasus>
In-Reply-To: <1091959881.2773.6.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 08 Aug 2004 11:42:35 -0400

Alright I got libz, utils, and pin 2.9. I had to install dbus to get 
bluez-pin to compile.

Now I have to do hciconfig hci0 up to get the adaptor to wake up...

Now whenever I try to connect with hidd it always times out.

Ah yes and I am using a 2.6.8-rc3 colonel now.

2.7 was a package from my distro, I had to do 2.9 by hand. I guess there 
is a chance I missed something but it all seemed to go over without a 
hitch installation wise.

Thanks for everyones replies!

Patrick


Marcel Holtmann wrote:
> Hi Patrick,
> 
> 
>>I have had my apple bt keyboard working in linux for some time on my old
>>pc. I now have a new pc and I can't get the damn thing going...
>>
>>I am using the same bluetooth adaptor from the old pc and as far as I
>>can tell the same kernel config (as relates to bluetooth) as the old pc. 
>>This is with bluez-libs and utils 2.7.
> 
> 
> use bluez-libs-2.9 and bluez-utils-2.9 and kernel 2.6.8-rc3.
> 
> Regards
> 
> Marcel


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
