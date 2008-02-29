Return-Path: <cyrus@holtmann.org>
Message-ID: <2d5cd43e0802290932s302ac8i8c7763062c174052@mail.gmail.com>
Date: Fri, 29 Feb 2008 23:02:59 +0530
From: "manuwela kanade" <manuwelak@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] Regarding Bluetooth Broadcast
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0316589595=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0316589595==
Content-Type: multipart/alternative;
	boundary="----=_Part_2207_30654700.1204306379521"

------=_Part_2207_30654700.1204306379521
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Sir,

We studied your thread on bluex-devel
'*Subject*: Re: broadcast and qos'
link: http://osdir.com/ml/linux.bluez.devel/2004-01/msg00154.html

We are trying to stream audio to the entire piconet simultaneously
(broadcast) over bluetooth. We studied the above mentioned link, and
understood most of the modifications. We have traced the bluez stack, and
have found path from 'connect' function call to 'hci_bcast_connect'. But we
are confused regarding the addresses to assign to the server and client
sockets. Where do we need to use the Broadcast address
(BDADDR_ACTIVEBCAST)?  If you could give us some  guidelines regarding the
usage of the new functions you have written for broadcasting. Thank you so
much. Awaiting your reply.

Thank you,
Manuwela

------=_Part_2207_30654700.1204306379521
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Dear Sir,<br><br>We studied your thread on bluex-devel <br>&#39;<strong>Subject</strong>: 

Re: broadcast and qos&#39;<br>link: <a href="http://osdir.com/ml/linux.bluez.devel/2004-01/msg00154.html">http://osdir.com/ml/linux.bluez.devel/2004-01/msg00154.html</a><br><br>We are trying to stream audio to the entire piconet simultaneously (broadcast) over bluetooth. We studied the above mentioned link, and understood most of the modifications. We have traced the bluez stack, and have found path from &#39;connect&#39; function call to &#39;hci_bcast_connect&#39;. But we are confused regarding the addresses to assign to the server and client sockets. Where do we need to use the Broadcast address (BDADDR_ACTIVEBCAST)?&nbsp; If you could give us some&nbsp; guidelines regarding the usage of the new functions you have written for broadcasting. Thank you so much. Awaiting your reply.<br>
<br>Thank you,<br>Manuwela<br>&nbsp;<br><br>

------=_Part_2207_30654700.1204306379521--


--===============0316589595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0316589595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0316589595==--
