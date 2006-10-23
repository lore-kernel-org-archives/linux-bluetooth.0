Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: "Delgado, Monica (ERZIA)" <monica.delgado@erzia.com>
To: <bluez-users@lists.sourceforge.net>
Date: Mon, 23 Oct 2006 16:44:14 +0200
MIME-Version: 1.0
In-Reply-To: <mailman.21307.1161333525.22397.bluez-users@lists.sourceforge.net>
Message-Id: <20061023144102.7D3D3217EF7@mrelay1.st2.lyceu.net>
Subject: [Bluez-users] PAND Network
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


I have been looking for the error "file exists" more deeply and I think I
have finally found it in the file ../linux-2.6.11/net/bluetooth/bnep/core.c
, in the function bnep_add_connection, which is used to create the bnep
module:



int bnep_add_connection(struct bnep_connadd_req *req, struct socket *sock)
{
	struct net_device *dev;
	struct bnep_session *s, *ss;
	u8 dst[ETH_ALEN], src[ETH_ALEN];
	int err;

	BT_DBG("");

	baswap((void *) dst, &bt_sk(sock->sk)->dst);
	baswap((void *) src, &bt_sk(sock->sk)->src);

	/* session struct allocated as private part of net_device */
	dev = alloc_netdev(sizeof(struct bnep_session),
			   (*req->device) ? req->device : "bnep%d",
			   bnep_net_setup);
	if (!dev) 
		return ENOMEM;


	down_write(&bnep_session_sem);

	ss = __bnep_get_session(dst);
	if (ss && ss->state == BT_CONNECTED) {
		err = -EEXIST;
		goto failed;
	}


(............more source code...)


	failed:
	up_write(&bnep_session_sem);
	free_netdev(dev);
	return err;
}



As I can see, when trying to create a bnep connection, in this function the
destination address of the socket is used to discover if there is another
bnep session established with that destination address, and if that session
is in the state BT_CONNECTED, it exits with the error EEXIST ("file
exists"). I don't know if this is the way it should work or this is a bug in
the source code, but according to this, it's not possible to establish two
bnep connections from the same PC to the same destination address. Please
Marcel, could you confirm me if I'm right?



Thank you and best regards,

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
