Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <434ACB1D.8010103@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] compiling btsco (a2play.o)
References: <200510102149.11567.michael.renner@gmx.de>
In-Reply-To: <200510102149.11567.michael.renner@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Mon, 10 Oct 2005 14:12:13 -0600

Michael,

I think I added the pthreads requirement in the code without specifying 
it properly in the autoconf stuff. Strangely, it works on my laptop as-is.

Try updating & configuring it again in a few minutes (I committed a fix)

Brad

Michael Renner wrote:
> Moin,
> 
> I just tried to compile the CVS version from yesterday. My machine is a debian 
> stable installation (gcc 3.3.5) running a self compiled vanilla 2.6.13 kernel 
> with its sources in /usr/src/linux.
> 
> As far as I see, every necessary package is installed in a current version.
> 
> Running configure gives one error:
> ./configure: line 4182: XIPH_PATH_AO: command not found
> 
> Trying to compile the package ends with an error:
> make[2]: Entering directory `/usr/src/btsco'
> gcc  -Wall -O2   -o a2play  a2play.o -lbluetooth -lbluetooth sbc/libsbc.a 
> -lbluetooth
> a2play.o(.text+0x189b): In function `main':
> : undefined reference to `pthread_create'
> a2play.o(.text+0x19e8): In function `main':
> : undefined reference to `pthread_join'
> collect2: ld returned 1 exit status
> 
> Whats wrong?
> 
> Thanks


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
