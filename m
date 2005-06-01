Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: RE: [Bluez-users] Linking to BlueZ from non-GPL code
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <EFCD68F7BFDB06468769D4D9EAAA93870774B827@scsmsx401.amr.corp.intel.com>
References: 
	 <EFCD68F7BFDB06468769D4D9EAAA93870774B827@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Message-Id: <1117666086.31350.46.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 02 Jun 2005 00:48:06 +0200

Hi Trevor,

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

from my interpretation this is only ok if the include files are under
LGPL. This is normally done by having extra include files for the
userspace. Remember that we don't include kernel headers from userspace
programs. If you include *.h files that are under GPL then your program
becomes GPL, because you include GPL code. In the case of BlueZ you
can't include the kernel header files, because they are not compatible.
So you need to use the *.h files from bluez-libs and these are GPL. This
means you have to rewrite them from scratch and from my view this is not
possible, because you will create derived work. However I am not a
lawyer and if you think (or your lawyer do) you are safe then go ahead,
but done blame me afterwards that I haven't warned you.

And btw don't get me wrong. I will try to make the BlueZ library LGPL as
soon as I got the permission from Qualcomm. Without it we don't really
need to think or talk about it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
