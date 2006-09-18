Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <3f5a9ba20609172100s5446aa0co42cbd0101fc488e2@mail.gmail.com>
Date: Mon, 18 Sep 2006 12:00:28 +0800
From: "Mingfan.Lu" <lucharse@gmail.com>
To: Bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] How to handle multiple L2cap Connection
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0431543227=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0431543227==
Content-Type: multipart/alternative;
	boundary="----=_Part_259215_8218470.1158552028193"

------=_Part_259215_8218470.1158552028193
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

============
opensuse linux 10.1
bluez 2.24
hcidump 1.29
============

Problem:
  My program's logic:
  (1) have 1 thread named sensor to discover other bluetooth devices
  (2) have at most 7 threads named workers, each worker will push a file to
the scheduled device.
  (3) have 1 thread to scheduler the found deivces to the workers.
the problem is,
   Each worker,
   first to search the obex service in its target device. (use sdp_connect
to create a connection, in fact a l2cap connect)
   if obex service found, then push the file by OPENOBEX. (use
Bt_TransportConnect to create a connection)

  For the coccurent workers, the l2cap connections are created coccurently.
  So there is some error occurs such like errcode 103, errorcode 113,
errcode 16,timeout

  In the former discusstion in the maillist, sem_t could be used to sync the
call of connect

  so, I use a sem_t conn_sem to sync, but I found that no improvement.

  Who can give me a nice suggestion?
-- 
With respects,
   Mingfan.Lu

------=_Part_259215_8218470.1158552028193
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&nbsp;</div>
<div>============</div>
<div>opensuse linux 10.1</div>
<div>bluez 2.24 </div>
<div>hcidump 1.29</div>
<div>============</div>
<div>&nbsp;</div>
<div>Problem:</div>
<div>&nbsp; My program's logic:</div>
<div>&nbsp; (1) have 1 thread named sensor to discover other bluetooth devices</div>
<div>&nbsp; (2) have at most 7 threads named workers, each worker will&nbsp;push a file to the scheduled device.</div>
<div>&nbsp; (3) have 1 thread to scheduler the found deivces to the workers.<br clear="all"></div>
<div>the problem is, </div>
<div>&nbsp;&nbsp; Each worker,</div>
<div>&nbsp;&nbsp; first to search the obex service in its target device. (use sdp_connect to create a connection, in fact a l2cap connect)</div>
<div>&nbsp;&nbsp; if obex service found, then push the file by OPENOBEX. (use Bt_TransportConnect to create a connection)</div>
<div>&nbsp;</div>
<div>&nbsp; For the coccurent workers, the l2cap connections are created coccurently.</div>
<div>&nbsp; So there is some error occurs such like errcode 103, errorcode 113, errcode 16,timeout</div>
<div>&nbsp;</div>
<div>&nbsp; In the former discusstion in the maillist, sem_t could be used to&nbsp;sync the call of connect</div>
<div>&nbsp;&nbsp; </div>
<div>&nbsp; so, I use a sem_t conn_sem to sync, but I found that no improvement.</div>
<div>&nbsp;</div>
<div>&nbsp; Who can give me a nice suggestion?<br>-- <br>With respects,<br>&nbsp;&nbsp; Mingfan.Lu </div>

------=_Part_259215_8218470.1158552028193--


--===============0431543227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0431543227==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0431543227==--
