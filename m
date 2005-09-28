Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth filesystem integration
From: Charles Bueche <charles@bueche.ch>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <1127865130.15926.18.camel@panic>
References: <1127865130.15926.18.camel@panic>
Content-Type: text/plain
Message-Id: <1127899309.14281.7.camel@bluez.bueche.ch>
Mime-Version: 1.0
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
Date: Wed, 28 Sep 2005 11:21:49 +0200

On mar, 2005-09-27 at 16:52 -0700, Collin R. Mulliner wrote:
> Hi All,
> 
> Marcel and I have decided to include btfs into the bluez-utils. Btfs is
> for integrating some kind of bluetooth services into the filesystem, so
> you could mount an obexftp "share" into your local filesytem. The whole
> idea is based on some work I did some time ago
> (http://mulliner.org/bluetooth/btfs.php). The system will be based on
> FUSE (Filesystem in Userspace).
> 
> So this post is basically to anounce btfs and to gether some ideas on
> what you guys think is need and useful.

That will be great, eg to automatically rsync new pictures taken from my
phone to a local dir. I know there is a kbluetoothd plugin, but
rsync/btfs seems much more "UNIX-like" to me.

What would be great is to see phone contacts as virtual VCard files (one
file per contact). Not sure if it is possible, but you asked for
ideas :-)

Seeing my Palm T5 agenda as iCal file would be the top... OK, I stop
dreaming :-/

thanks anyway for you great work.

Charles
-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
