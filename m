Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41EB422B.3040603@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] btsco compile fail
References: <41EA83D3.9060204@tootai.net>
In-Reply-To: <41EA83D3.9060204@tootai.net>
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
Date: Sun, 16 Jan 2005 21:42:19 -0700

hi

i don't know if this is the best answer, but you could try updating 
automake, autoconf, etc from debian testing. it does look alsa specific 
though, so check that you have -dev packages (try libasound2-dev and 
maybe libalsaplayer-devm, libmikmod2-dev, liby-dev to flush out whatever 
package you need)

brad

administrator tootai wrote:
> Hi,
> 
> I want co compile btsco from CVS and get following error:
> 
> aclocal: configure.in: 21: macro `AM_PATH_ALSA' not found in library
> nomade:/usr/src/btsco#
> I'm running a Debian 2.6.8 kernel.
> 
> Thanks for hint.
> 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
