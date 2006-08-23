Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Mayank BATRA <mayank.batra@st.com>
To: "'BlueZ development'" <bluez-devel@lists.sourceforge.net>
Date: Wed, 23 Aug 2006 11:18:08 +0530
Message-ID: <001b01c6c677$b6a851d0$9d0cc70a@dlh.st.com>
MIME-Version: 1.0
In-Reply-To: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Ulisses,

> how about something like the attached patch? I've used some of
> Mayank's code and added some other parts. It's not complete and it's
> only compile-tested yet.

 	case OCF_HOST_BUFFER_SIZE:
 		status =3D *((__u8 *) skb->data);
-		if (status) {
+		if (!status) {
+			struct hci_cp_set_host_flow_ctl cp;
+
+			if (!(cp.host_flow_ctl =3D hdev->host_flow_ctl))
+				break;
+
+			hci_send_cmd(hdev, OGF_HOST_CTL,
+				     OCF_SET_HOST_FLOW_CTL, sizeof(cp),
&cp);
+		} else {
 			BT_DBG("%s OCF_BUFFER_SIZE failed %d", hdev->name,
status);
 			hci_req_complete(hdev, status);
 		}

If status =3D 0 it means that the command was success. But in the patch that
you sent, it=92s the other way round. Is it a mistake?

Regards,
Mayank


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
