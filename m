Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Luca Capello <luca@pca.it>
Subject: Re: [Bluez-devel] [btsco] configure/make errors
In-reply-to: <1106136920.8190.96.camel@pegasus>
To: bluez-devel@lists.sourceforge.net
Message-id: <41EE6C49.7090908@pca.it>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <41ED7E8D.8030709@pca.it> <1106136920.8190.96.camel@pegasus>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 19 Jan 2005 15:18:49 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Marcel,

on 01/19/2005 01:15 PM, Marcel Holtmann wrote:
>> after having solved the automake error, configure gave me another one
<cut>
> And again. The bootstrap thing is for making the developer happy,
> because he must call only one program/script for getting the repository
> ready. It is not for others ;)
I know this, but the problem here is that if someone like me (not a
developer, not really a newbie) wants to try his Bluetake BT420EX with
the bluetooth-alsa project, he should go with the CVS (no other released
versions). And so he has some problem, because there're no info about
the requirements (automake-1.7, the Audio Output libraries and the
Bluetooth libraries, even if the last one was my fault, it's quite
obvious that for a Bluetooth project you need the Bluetooth libraries).

So, IMHO also for developers, at least a 'required packages' section
should be added to the README.

BTW, with my patch there's still one program/script ;-)

> You can also use AM_PATH_BLUEZ. Since bluez-libs-2.13 it is also
> available now, because not all systems use pkg-config.
Ok, I'll add this ASAP, but ATM Debian unstable still has 2.11 and I
should prepare my own Debian bluez-2.13 packages.

Thx, bye,
Gismo / Luca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQFB7mxJVAp7Xm10JmkRAoecAJ9i3Uwbz9Cf5OcAIw54Si06BlWGLQCfUNrk
Cswut1XKBFQrwuQ1+04IiHA=
=QquH
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
