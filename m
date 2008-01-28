Return-Path: <cyrus@holtmann.org>
Message-ID: <479D1BC0.6030306@gmail.com>
Date: Mon, 28 Jan 2008 10:03:12 +1000
From: Eugene <it.had.even@gmail.com>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <8CA2D771C11F4F5-14EC-2263@FRR1-L19.sis.aol.com>
In-Reply-To: <8CA2D771C11F4F5-14EC-2263@FRR1-L19.sis.aol.com>
Content-Type: multipart/mixed; boundary="------------050202010100050305060008"
Subject: Re: [Bluez-users] Error cross compiling bluez-utils 3.9 ARM S3C2410
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050202010100050305060008
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

laurent-z@neuf.fr пишет:
> Hello,
>  
> I’m having trouble cross-compiling bluez-utils 3.9 using this command 
> line:
> # ./configure –host=arm-linux –prefix=/opt/bluez_build 
> –with-bluez-libs=/opt/bluez_build /lib 
> –with-bluez-include=/opt/bluez_build /include
>  
> (I use gcc-arm-3.4.1 cross compiler and /opt/bluez_build is the 
> destination folder)
>  
> and I get this message:
>  
> checking for BLUEZ... no
> configure: error: Bluez library is required
>  
> I successfully compiled and installed bluez-libs3.9 with the following 
> command:
>  
> # ./configure –host=arm-linux –prefix=/opt/bluez_build
>  
> I also successfully compiled and installed dbus-1.0.2 in case.
>  
> My point is I tried bluez-2.5 with the same method and everything went 
> well and I was able to use my Bluetooth dongle.
>  
> I checked the mailing list and I’m not the only one facing this 
> problem, but I don’t see any replies providing the solution to my problem.
>  
> Is anybody able to get this thing to work? Please help!
>  
> Thanks
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   
Hello,
This error shows that you have no /usr/lib/pkgconfig/bluez.pc file.
Here is a corresponding part of ./configure :
    pkg_cv_BLUEZ_CFLAGS=`$PKG_CONFIG --cflags "bluez" 2>/dev/null`

    What pkg-config does (man):
       pkg-config retrieves information about packages from  special  
metadata
       files. These files are named after the package, with the 
extension .pc.
       By default, pkg-config looks in the directory 
prefix/lib/pkgconfig  for
       these  files;  it  will  also  look in the colon-separated (on 
Windows,
       semicolon-separated) list of  directories  specified  by  the  
PKG_CON‐
       FIG_PATH environment variable.

This file is included in libbluetooth-dev package (in case of Ubuntu), 
or anyway it is
obtained when compliling and installing bluez-libs.
So check if you compiled and installed bluez-libs first.

Regards,
Eugene

--------------050202010100050305060008
Content-Type: text/x-vcard; charset=utf-8;
 name="it_had_even.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="it_had_even.vcf"

YmVnaW46dmNhcmQNCmZuOkV1Z2VuZQ0Kbjo7RXVnZW5lDQp2ZXJzaW9uOjIuMQ0KZW5kOnZj
YXJkDQoNCg==
--------------050202010100050305060008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--------------050202010100050305060008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--------------050202010100050305060008--
