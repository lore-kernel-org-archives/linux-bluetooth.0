Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <5256d0b05010622066dac1296@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] btsco under FC3
In-Reply-To: <v04020a21be03b42174eb@192.168.49.19>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <v04020a1dbe030e257568@192.168.49.19>
	 <1105032390.4299.92.camel@pegasus>
	 <v04020a21be03b42174eb@192.168.49.19>
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
Date: Fri, 7 Jan 2005 14:06:42 +0800

> OK, These are the steps to get btsco to work with the unhacked cvs files:
> 
> download libao-0.8.5.tar.gz and configure,make,make install
> 
> Add the line /usr/lib/ao/plugins-2 to /etc/ld.so.conf
> run /sbin/ldconfig
> 
> then do the bootstrap, configure, make, make install of btsco
> 
> Builds on Fedora3 now.
> 
> May also need to do gob2 and openhbci too (I did a couple of days ago)

I got it all compiles and installed using standard libao on FC3. As
soon as I installed the libao-devel pacakge and reran bootstrap etc it
all compiled fine.

Pete


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
