Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <41E9B493.5050102@dark-reality.de>
From: Lars Grunewaldt <lgw@dark-reality.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] how do I disconnect btsco when the headset is gone/down
 ?
References: <pan.2005.01.15.17.32.11.742730@yahoo.com>
In-Reply-To: <pan.2005.01.15.17.32.11.742730@yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Sun, 16 Jan 2005 01:25:55 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul Ionescu wrote:
| Hi all,
| Even if the headset is disconnected, the btsco program does not sense this
| fact and is still using the resources.
| I have to manually Ctrl-C or kill it.
|
| Is it only my case, or this is how is behaving right now ?

Yes, that is how it behaves. Maybe the socket wait should be changed so
it notices the RFCOMM disconnect properly?

regards,
~  Lars


- --
Lars Grunewaldt
* software development
* multimedia design
skills: C/C++/Java/PHP/(X)HTML/Flash/audio/video
web: http://www.dark-reality.de
mail: lgw@dark-reality.de
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB6bSTQWC6DTWkDAoRAt7HAJ97txy6TegDufC4WC8VZ3EP5dZFVACfUYti
/xHDBYS1NmnKF2lTFcVk4To=
=Htga
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
