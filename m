Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <449BA939.6050705@stfw.eu>
Date: Fri, 23 Jun 2006 09:41:29 +0100
From: Zhares <ml-sourceforge@stfw.eu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <bf1d6e70606212208r7ed5e33ak5895b61024c36850@mail.gmail.com>	<1150959776.13991.5.camel@localhost>	<bf1d6e70606220431j541afa88j65850d163fa30989@mail.gmail.com>	<1150976005.13991.45.camel@localhost>
	<bf1d6e70606222233v5d582126k2adc22fd748ba4db@mail.gmail.com>
In-Reply-To: <bf1d6e70606222233v5d582126k2adc22fd748ba4db@mail.gmail.com>
Subject: Re: [Bluez-users] bluez installation
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Lavanya Jagan wrote:
> Hi,
> 
> i tried intallin dbus-devel.. n i get such errors :(
> 
> [lavanya@rise24 fry_bluez]$ rpm -ivh dbus-devel-0.33-3.i386.rpm
> warning: dbus-devel-0.33-3.i386.rpm: V3 DSA signature: NOKEY, key ID
> 4f2a6fd2
> error: Failed dependencies:
>        dbus = 0.33-3 is needed by dbus-devel-0.33-3
> 
Hi,
You have to install dbus-0.33-3 first. You may have a similar error 
doing it, in that case, you have to manually install all the other 
packages in the 'failed dependencies' listed in the error.

-- 

     Zhares

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
