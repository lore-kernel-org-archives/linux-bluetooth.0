Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Robert Wlaschin <robertw@healthhero.com>
Date: Wed, 28 Jun 2006 17:07:12 +0000 (UTC)
Message-ID: <loom.20060628T185219-52@post.gmane.org>
References: <loom.20060628T033626-329@post.gmane.org>
	<6297d67c0606272053xff3b84dwf59410cce7bc658b@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] cross-compiling bluez-utils.3.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Mayank Batra <mayankbatra <at> gmail.com> writes:

> 
> 
> Hi Robert,
> On 6/28/06, Robert Wlaschin <robertw <at> healthhero.com> wrote:
> I seem to be having problems with the latest version of bluez-utils.  It
> seemsthat dbus is a required component of the 
> 3.1 release; which isn't cross-compilefriendly (the dbus build complains about
> cross-compiling) -- a previous versionof bluez-utils (2.21) is.  In the 2.21
> release there was an option to compilewithout dbus, is there a work around for
> the 3.1/if so, how?  If not, anysuggestions about cross-compiling the stock
> bluez-utils.3.1 (including dbus asnecessary) for an ARM processor?Robert
>  
> Actually the latest bluez-utils are not even compiling on PC. It complains
> that dbus package is not present.
>  
> Regards,
> Mayank
> 
> 
> 
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> 
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel <at> lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 

Mayank,

Thanks for the response.  There are some posts in the forum about problems with
cross-compiling.  

To get past the dbus problem, if you don't already have the dbus source you'll
need to get it from http://www.freedesktop.org/wiki/Software/dbus, after that
you'll need to get a new version of bluez-utils-3.1/acinclude.m4 from the bluez
CVS -- there is a bug in this file that looks for the incorrect dbus libs.  
After you have updated that file follow the instructions in INSTALL for 
rebuilding the configuration script.

As a side note you may need to add PKG_CONFIG_PATH=$(BLUEZ_LIBS_BUILD_DIR) to
your command-line when running ./configuration (BLUEZ_LIBS_BUILD_DIR is a make
variable that needs to point to your bluez-libs-3.1 directory).

Please search the group for more information concerning this issue.  I hope this
helps.

Robert



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
