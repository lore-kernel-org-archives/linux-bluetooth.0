Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] btsco: help with autoconf cleanup
From: David Woodhouse <dwmw2@infradead.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <4193B453.50005@xmission.com>
References: <4193B453.50005@xmission.com>
Content-Type: text/plain
Message-Id: <1100539910.8191.6949.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 15 Nov 2004 17:31:50 +0000

On Thu, 2004-11-11 at 11:49 -0700, Brad Midgley wrote:
> Hi
> 
> Can someone tell me which of these files shouldn't be in our btsco cvs 
> module?
> 
> acinclude.m4
> aclocal.m4
> config.status
> configure
> configure.in
> Makefile
> Makefile.am
> Makefile.in
> missing
> mkinstalldirs
> 
> I know some projects even make you generate "configure" but I'm not sure 
> I want to go that far.

Since you ask for opinions... all but 'Makefile' should be printed out
and ritually burned. Just write a proper Makefile. :)

Does btsco work only with headsets or should it also work with mobile
phones?

-- 
dwmw2



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel/listinfo/bluez-devel
