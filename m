Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Fri, 20 Oct 2006 10:12:52 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.17263.1161267550.22397.bluez-users@lists.sourceforge.net>
Message-Id: <20061020080951.CDF54215457@mrelay1.st2.lyceu.net>
Subject: Re: [Bluez-users] PAND Network
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



Hi Marcel,

>> I have tried to find where the error "file exists" arises debugging the
>> source code, and I have found it in this function of bnep.c when trying
>>to
>> send the ioctl command "bnepconnadd":
>> 
>> 
>> static int bnep_connadd(int sk, uint16_t role, char *dev)
>> {
>> 	struct bnep_connadd_req req;
>> 
>> 	strcpy(req.device, dev);
>> 	req.sock = sk;
>> 	req.role = role;
>> 	if (ioctl(ctl, bnepconnadd, &req))
>> 		return -1;
>> 	strcpy(dev, req.device);
>> 	return 0;
>> } 

>please check the getsockname() and getpeername() output for sk in that
>call.

 I have checked the local address and the remote address of the socket "sk"
in the bnep_connadd function with getsockname() and getpeername() and they
are correct in both bnep connections. The local address is in the first
connection is 00:10:60:B3:5A:C9  and 00:07:80:80:4B:04 in the second one,
and the remote address is in both connections 00:80:5A:20:EA:13.

Regards,

Monica





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
