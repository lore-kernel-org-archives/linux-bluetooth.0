Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <v04020a21be03b42174eb@[192.168.49.19]>
In-Reply-To: <1105032390.4299.92.camel@pegasus>
References: <v04020a1dbe030e257568@[192.168.49.19]>
 <v04020a1dbe030e257568@[192.168.49.19]>
To: bluez-devel@lists.sourceforge.net
From: Bob Gustafson <bobgus@rcn.com>
Subject: Re: [Bluez-devel] btsco under FC3
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
Date: Thu, 6 Jan 2005 21:43:43 -0600

OK, These are the steps to get btsco to work with the unhacked cvs files:

download libao-0.8.5.tar.gz and configure,make,make install

Add the line /usr/lib/ao/plugins-2 to /etc/ld.so.conf
run /sbin/ldconfig

then do the bootstrap, configure, make, make install of btsco

Builds on Fedora3 now.

May also need to do gob2 and openhbci too (I did a couple of days ago)

BobG


Marcel Holtmann wrote:
>Hi Bob,
>
>> OK, from scratch - get @AO.. problem
<snip>

>> ./configure: line 3249: XIPH_PATH_AO: command not found
>
>and again, the development files from the AO library are missing. Check
>your Fedora Core 3 distribution.
>
>Regards
>
>Marcel
>


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
