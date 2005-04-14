Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <425E195F.9050601@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] compilation errors for btsco
References: <E73D9A5BC4A2D711BBC600065BF3595F1C66D026@il06exm10>
In-Reply-To: <E73D9A5BC4A2D711BBC600065BF3595F1C66D026@il06exm10>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Thu, 14 Apr 2005 01:18:55 -0600

Hey

I think others have had trouble with fedora but I haven't heard any 
success stories. See the bluetooth-alsa bug list/support lists on 
sourceforge to see if anyone has followed up with any tips.

Brad

Mandalia Hiren-AHM047 wrote:
> Hello,
> 
> I'm trying to compile btsco on a FC3 (Kernel 2.6.10). I think I have all the packages that I need. 
> 
> The alsa packages I have are:
> 
> alsa-lib-devel-1.0.6-7.FC3
> alsa-utils-1.0.6-3
> alsa-lib-1.0.6-7.FC3
> 
> I have already installed the bluez-libs-2.15 package so that should take care about libbluetooth-dev (correct me if I'm wrong here)
> 
> when I do a 
> %./bootstrap
> aclocal: configure.in 21: macro 'AM_PATH_ALSA' not found in library
> 
> I was reading the archives which made me check if I had the file /usr/share/aclocal/alsa.m4 and I do have that file. I don't know why do I get this error. Will renaming of packages help? If yes how do I rename them? Please help..
> 
> Regards,
> Hiren
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> alsa-lib-devel-1.0.6-7.FC3
> alsa-utils-1.0.6-3
> alsa-lib-1.0.6-7.FC3


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
