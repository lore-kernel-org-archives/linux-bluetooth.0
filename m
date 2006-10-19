Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <20061019140002.EBD9A216219@mrelay1.st2.lyceu.net>
References: <20061019140002.EBD9A216219@mrelay1.st2.lyceu.net>
Date: Thu, 19 Oct 2006 16:17:30 +0200
Message-Id: <1161267450.27710.47.camel@localhost>
Mime-Version: 1.0
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

Hi Monica,

> I have tried to find where the error "file exists" arises debugging the
> source code, and I have found it in this function of bnep.c when trying to
> send the ioctl command "bnepconnadd":
> 
> 
> static int bnep_connadd(int sk, uint16_t role, char *dev)
> {
> 	struct bnep_connadd_req req;
> 
> 	strcpy(req.device, dev);
> 	req.sock = sk;
> 	req.role = role;
> 	if (ioctl(ctl, bnepconnadd, &req))
> 		return -1;
> 	strcpy(dev, req.device);
> 	return 0;
> } 

please check the getsockname() and getpeername() output for sk in that
call.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
