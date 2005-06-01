Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-users] Linking to BlueZ from non-GPL code
Message-ID: <EFCD68F7BFDB06468769D4D9EAAA9387077868B0@scsmsx401.amr.corp.intel.com>
From: "Pering, Trevor" <trevor.pering@intel.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Wed, 1 Jun 2005 16:43:19 -0700

Ok, then it sounds like we (me and the lawyers and you) are all in
agreement -- what it comes down to is the source of the *.h files.  If
they come from the kernel (which wouldn't make sense for BlueZ), then
things would be ok.  However, trying to use BlueZ user-level *.h files
with not-GPL would not be allowed.  (I'm just reiterating this for the
benefit of clarity and consensus).

Cheers,
	Trevor

=20

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Wednesday, June 01, 2005 3:48 PM
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] Linking to BlueZ from non-GPL code

Hi Trevor,

> As for the non-GPL use of the kernel, I was referring to: (from
> http://www.kernel.org/pub/linux/kernel/COPYING)
>=20
> "NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal
use
>  of the kernel, and does *not* fall under the heading of "derived
work".
>  Also note that the GPL below is copyrighted by the Free Software
>  Foundation, but the instance of code that it refers to (the linux
>  kernel) is copyrighted by me and others who actually wrote it."
>=20
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
Applications - visit
http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
