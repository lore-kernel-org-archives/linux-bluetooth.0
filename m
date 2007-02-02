Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5b9417770702012120g79d28364vcf5f7c01fb68c40f@mail.gmail.com>
Date: Thu, 1 Feb 2007 23:20:50 -0600
From: "John H." <mistamaila@gmail.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <5b9417770702011934l7874d0d3ma50369b2c06a6fdc@mail.gmail.com>
MIME-Version: 1.0
References: <5b9417770702011934l7874d0d3ma50369b2c06a6fdc@mail.gmail.com>
Subject: Re: [Bluez-users] can't get rfcomm connect to not "host is down"
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

l2ping 00:1A:77:ED:D1:97
Ping: 00:1A:77:ED:D1:97 from 00:02:72:81:AB:C4 (data size 44) ...
44 bytes from 00:1A:77:ED:D1:97 id 0 time 39.71ms
44 bytes from 00:1A:77:ED:D1:97 id 1 time 28.50ms
44 bytes from 00:1A:77:ED:D1:97 id 2 time 22.61ms
44 bytes from 00:1A:77:ED:D1:97 id 3 time 25.26ms
44 bytes from 00:1A:77:ED:D1:97 id 4 time 18.21ms
44 bytes from 00:1A:77:ED:D1:97 id 5 time 35.58ms
44 bytes from 00:1A:77:ED:D1:97 id 6 time 38.45ms
44 bytes from 00:1A:77:ED:D1:97 id 7 time 29.56ms
44 bytes from 00:1A:77:ED:D1:97 id 8 time 34.96ms
44 bytes from 00:1A:77:ED:D1:97 id 9 time 34.42ms
44 bytes from 00:1A:77:ED:D1:97 id 10 time 29.79ms
44 bytes from 00:1A:77:ED:D1:97 id 11 time 15.19ms
44 bytes from 00:1A:77:ED:D1:97 id 12 time 23.28ms
44 bytes from 00:1A:77:ED:D1:97 id 13 time 59.65ms
44 bytes from 00:1A:77:ED:D1:97 id 14 time 37.51ms
44 bytes from 00:1A:77:ED:D1:97 id 15 time 37.50ms
44 bytes from 00:1A:77:ED:D1:97 id 16 time 37.37ms
17 sent, 17 received, 0% loss


On 2/1/07, John H. <mistamaila@gmail.com> wrote:
> Moto Q
>
> hcitool inq
> Inquiring ...
>         00:1A:77:ED:D1:97       clock offset: 0x46b5    class: 0x72020c
>
>
> rfcomm connect 00:1A:77:ED:D1:97 1
> Can't connect RFCOMM socket: Host is down
>
>
> can't connect happens after about 10 seconds.
>
> What to do?
>

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
