Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41E0AA3D.5010107@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Missing sndmagic.h for btsco kernel patch
References: <20050108192216.D6A50416118@ws5-2.us4.outblaze.com> <1105222194.27527.12.camel@linux.site>
In-Reply-To: <1105222194.27527.12.camel@linux.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Date: Sat, 08 Jan 2005 20:51:25 -0700

Christopher,

We are now working with v2.6.10 and a kernel module you can get from 
cvs. We don't patch the kernel under the current scheme. see 
bluetooth-alsa.sf.net

Unfortunately, using a vendor kernel is difficult with btsco. We're 
having to track fairly recent kernels because things keep changing in 
the (stable!) kernel releases and we don't have the resources to 
maintain for multiple kernels :(

Brad

Christopher Bergström wrote:
> Trying to get my bluetooth headset to work and so I'm going through the 
> steps..
> 
> I applied the kernel-2.6.7-8.24-08-04.patch for the btsco driver, but I 
> realized I'm missing sndmagic.h file.  I'm running Suse 9.2 with the 
> alsa-devel installed..  I think I noticed that RH/Fedora had a rpm 
> alsa-lib-devel that included this file, but wasn't sure if I could just 
> ignore this missing file, most likely not, or if I should give rpm in 
> the RH/Fedora a shot.  Or is this something simple like copying the 
> missing file?  First post and help is appreciated.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
