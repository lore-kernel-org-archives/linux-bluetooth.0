Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Sat, 19 Aug 2006 07:51:39 +0100
Message-ID: <04ED5B65E3B4A64B97C16E22E0DF16D5184947@mh23ex03.informatica.com>
From: "Deiters, Michael" <mdeiters@Informatica.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] BT connection hangs above a certain speed - help
	needed
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

> Hello everybody,
> 
> I am currently stuck with BlueZ Version 3.2 and seek help by posting to this list.
> 
> Technical environment:
> - Several 3G Mobile Phones
> - Sharp Zaurus 2.4.18 Kernel, Nokia DTL4
> - Dell Laptop, 2.6.xx  (SuSE 10.1) 3Com BT Card.
> 
> Synthom:
> - Connection between paired devices hangs - no transfer after a while.
> 
> Description:
> a) pair the Zaurus via DTL4 Card with the 3G Mobile Phone. Use pppd to initiate an internet connection. Works fine.
> After transfering an arbitrary amount of data, the connection finally "hangs". Happens only if 3G Mode (UMTS) is used. Never hangs in GPRS Mode.
> Hangs occur with any 3G fone used. After an amount of abt. 0.5 ... 2 MB the transfer stops. pppd times out. L2PING to the fone will no longer be replied. Using the slower GPRS Mode results in no hangs at all (but the transfer is very slow and not the preferred solution...)
> 
> b) Same setup as a).  Same results. Checked with 3 different 3G fones and with the DTL4 as well as with the 3Com BT Card.
> 
> c) pair the Zaurus with the 3Com card driven by SuSE 10.1 on Laptop. There, a modem emulator is used as a "landing point" for a "calling-in" pppd from the Zaurus. Thus, the both pppd's (one on Zaurus and second on the SuSE Laptop) are representing a dial-up connection via BT resulting in a TCP/IP connection.
> Same behaviour as in a) and b).  After a certain amount of fast transfered data, the connection hangs and l2ping gets no replies.
> 
> a)...c) are using rfcomm to attach the pppd's to Bluetooth via /dev/rfcommX
> 
> I observe, the problem has to do with transfer speeds. Above a speed of around 5..6 kB / sec the "hang" will be unavoidable.
> 
> To re-initiate the environment, the BT card(s) has to be ejected and re-inserted (Modules re-load?). A simple disconnect and re-connect (pairing) will not work after a prior "hang".
> 
> I posted (in German) recently that problem in one of the Zaurus forums and it appears, that other users have the same problem.
> 
> I need some hints where to start searching for the reasons of that.  As I am not a BT developer, maybe some of you guys have some ideas th share with me or the community resp.
> 
> Thanks for reading!!  Please "cc" michael@deiters.net in case of answers. Thanks.
> 
> Kind regards
> Mike
> 
> 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
