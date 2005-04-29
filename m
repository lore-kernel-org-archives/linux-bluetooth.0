Return-Path: <bluez-devel-admin@lists.sourceforge.net>
In-Reply-To: <4271D1F8.4000307@impulsesoft.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <OF5C52ED3B.10742397-ON48256FF2.00247A80-48256FF2.0024A1CF@zte.com.cn>
From: gao.yingbin@zte.com.cn
Content-Type: multipart/alternative; boundary="=_alternative 0024A1C948256FF2_="
Subject: [Bluez-devel] =?GB2312?B?tPC4tDogW0JsdWV6LWRldmVsXSBIZWxwIHdpdGggTDJDQVAgc29ja2V0cw==?=
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 29 Apr 2005 14:46:12 +0800

This is a multipart message in MIME format.
--=_alternative 0024A1C948256FF2_=
Content-Type: text/plain; charset="US-ASCII"

Hi, I don't agree that your problem is L2CAP socket's bug. you can see my 
debug messages of remote device disconnect:
hci_recv_frame: hci0 type 2 len 16
hci_rx_task: hci0
hci_send_to_sock: hdev 81a83a08 len 16
hci_rx_task: hci0 ACL data packet
hci_acldata_packet: hci0 len 12 handle 0x7 flags 0x2
l2cap_recv_acldata: conn 81a45960 len 12 flags 0x2
l2cap_recv_frame: len 8, cid 0x0001
l2cap_raw_recv: conn 81a45960
l2cap_sig_channel: code 0x06 len 4 id 0x03
l2cap_disconnect_req: scid 0x0045 dcid 0x0040
l2cap_build_cmd: conn 81a45960, code 0x07, ident 0x03, len 4
l2cap_send_rsp: code 0x07
hci_send_acl: hci0 conn 814c3d60 flags 0x0
hci_send_acl: hci0 nonfrag skb 8191d9a0 len 16
l2cap_sock_clear_timer: sock 80718980 state 1
l2cap_chan_del: sk 80718980, conn 81a45960, err 131
hci_tx_task: hci0 acl 10 sco 0
hci_sched_acl: hci0
hci_low_sent: conn 814c3d60 quote 10
hci_sched_acl: skb 8191d9a0 len 16
hci_send_frame: hci0 type 2 len 16
hci_send_to_sock: hdev 81a83a08 len 16
hci_low_sent: conn 00000000 quote 0
hci_sched_sco: hci0
bluez_sock_poll: sock 8070db18, sk 80718680
hci_recv_frame: hci0 type 4 len 7
hci_rx_task: hci0
hci_send_to_sock: hdev 81a83a08 len 7
hci_event_packet: hci0 evt 0x13
hci_num_comp_pkts_evt: hci0 num_hndl 1
hci_tx_task: hci0 acl 10 sco 0
hci_sched_acl: hci0
hci_low_sent: conn 00000000 quote 0
hci_sched_sco: hci0
bluez_sock_poll: sock 8070dcf8, sk 80718380
bluez_sock_poll: sock 80f71b38, sk 80718980
prbluez_sock_recvmsg: sock 80f71b38 sk 80718980 len 512
ocl2cap_sock_release: sock 80f71b38, sk 80718980
hci_recv_frame: hci0 type 4 len 8
hci_rx_task: hci0
hci_send_to_sock: hdev 81a83a08 len 8
hci_event_packet: hci0 evt 0x14
hci_recv_frame: hci0 type 4 len 6
hci_rx_task: hci0
hci_send_to_sock: hdev 81a83a08 len 6
hci_event_packet: hci0 evt 0x5
hci_disconn_complete_evt: hci0 status 0
l2cap_disconn_ind: hcon 814c3d60 reason 19
l2cap_conn_del: hcon 814c3d60 conn 81a45960, err 131
sco_disconn_ind: hcon 814c3d60 reason 19
hci_conn_del: hci0 conn 814c3d60 handle 7
l2cap_sock_shutdown: sock 80f71b38, sk 80718980
l2cap_sock_kill: sk 80718980 state 9
l2cap_sock_destruct: sk 80718980
bluez_sock_poll: sock 8070db18, sk 80718680
bluez_sock_poll: sock 8070dcf8, sk 80718380
*******************the end *************************************

Why do you use the system call "select()" to do it ? I always use it and 
have never encountered your problems.


***********************************************
信息安全声明：本邮件包含信息归ZTE所有，
ZTE对该邮件拥有所有权利。请接收者注意
保密，未经发件人书面许可，不得向任何第
三方组织和个人透露本邮件所含信息的全部
或部分。以上声明仅适用于工作邮件。
Information Security  Notice：
The information contained in this mail is
solely property of  ZTE Corporation. 
This mail communication is confidential.
Recipients named above are obligated to
maintain secrecy and are not permitted to
disclose the contents of this communication
to others.
***********************************************

--=_alternative 0024A1C948256FF2_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hi, I don't agree that your problem
is L2CAP socket's bug. you can see my debug messages of remote device disconnect:</font>
<br><font size=2 face="sans-serif">hci_recv_frame: hci0 type 2 len 16</font>
<br><font size=2 face="sans-serif">hci_rx_task: hci0</font>
<br><font size=2 face="sans-serif">hci_send_to_sock: hdev 81a83a08 len
16</font>
<br><font size=2 face="sans-serif">hci_rx_task: hci0 ACL data packet</font>
<br><font size=2 face="sans-serif">hci_acldata_packet: hci0 len 12 handle
0x7 flags 0x2</font>
<br><font size=2 face="sans-serif">l2cap_recv_acldata: conn 81a45960 len
12 flags 0x2</font>
<br><font size=2 face="sans-serif">l2cap_recv_frame: len 8, cid 0x0001</font>
<br><font size=2 face="sans-serif">l2cap_raw_recv: conn 81a45960</font>
<br><font size=2 face="sans-serif">l2cap_sig_channel: code 0x06 len 4 id
0x03</font>
<br><font size=2 face="sans-serif">l2cap_disconnect_req: scid 0x0045 dcid
0x0040</font>
<br><font size=2 face="sans-serif">l2cap_build_cmd: conn 81a45960, code
0x07, ident 0x03, len 4</font>
<br><font size=2 face="sans-serif">l2cap_send_rsp: code 0x07</font>
<br><font size=2 face="sans-serif">hci_send_acl: hci0 conn 814c3d60 flags
0x0</font>
<br><font size=2 face="sans-serif">hci_send_acl: hci0 nonfrag skb 8191d9a0
len 16</font>
<br><font size=2 face="sans-serif">l2cap_sock_clear_timer: sock 80718980
state 1</font>
<br><font size=2 face="sans-serif">l2cap_chan_del: sk 80718980, conn 81a45960,
err 131</font>
<br><font size=2 face="sans-serif">hci_tx_task: hci0 acl 10 sco 0</font>
<br><font size=2 face="sans-serif">hci_sched_acl: hci0</font>
<br><font size=2 face="sans-serif">hci_low_sent: conn 814c3d60 quote 10</font>
<br><font size=2 face="sans-serif">hci_sched_acl: skb 8191d9a0 len 16</font>
<br><font size=2 face="sans-serif">hci_send_frame: hci0 type 2 len 16</font>
<br><font size=2 face="sans-serif">hci_send_to_sock: hdev 81a83a08 len
16</font>
<br><font size=2 face="sans-serif">hci_low_sent: conn 00000000 quote 0</font>
<br><font size=2 face="sans-serif">hci_sched_sco: hci0</font>
<br><font size=2 face="sans-serif">bluez_sock_poll: sock 8070db18, sk 80718680</font>
<br><font size=2 face="sans-serif">hci_recv_frame: hci0 type 4 len 7</font>
<br><font size=2 face="sans-serif">hci_rx_task: hci0</font>
<br><font size=2 face="sans-serif">hci_send_to_sock: hdev 81a83a08 len
7</font>
<br><font size=2 face="sans-serif">hci_event_packet: hci0 evt 0x13</font>
<br><font size=2 face="sans-serif">hci_num_comp_pkts_evt: hci0 num_hndl
1</font>
<br><font size=2 face="sans-serif">hci_tx_task: hci0 acl 10 sco 0</font>
<br><font size=2 face="sans-serif">hci_sched_acl: hci0</font>
<br><font size=2 face="sans-serif">hci_low_sent: conn 00000000 quote 0</font>
<br><font size=2 face="sans-serif">hci_sched_sco: hci0</font>
<br><font size=2 face="sans-serif">bluez_sock_poll: sock 8070dcf8, sk 80718380</font>
<br><font size=2 face="sans-serif">bluez_sock_poll: sock 80f71b38, sk 80718980</font>
<br><font size=2 face="sans-serif">prbluez_sock_recvmsg: sock 80f71b38
sk 80718980 len 512</font>
<br><font size=2 face="sans-serif">ocl2cap_sock_release: sock 80f71b38,
sk 80718980</font>
<br><font size=2 face="sans-serif">hci_recv_frame: hci0 type 4 len 8</font>
<br><font size=2 face="sans-serif">hci_rx_task: hci0</font>
<br><font size=2 face="sans-serif">hci_send_to_sock: hdev 81a83a08 len
8</font>
<br><font size=2 face="sans-serif">hci_event_packet: hci0 evt 0x14</font>
<br><font size=2 face="sans-serif">hci_recv_frame: hci0 type 4 len 6</font>
<br><font size=2 face="sans-serif">hci_rx_task: hci0</font>
<br><font size=2 face="sans-serif">hci_send_to_sock: hdev 81a83a08 len
6</font>
<br><font size=2 face="sans-serif">hci_event_packet: hci0 evt 0x5</font>
<br><font size=2 face="sans-serif">hci_disconn_complete_evt: hci0 status
0</font>
<br><font size=2 face="sans-serif">l2cap_disconn_ind: hcon 814c3d60 reason
19</font>
<br><font size=2 face="sans-serif">l2cap_conn_del: hcon 814c3d60 conn 81a45960,
err 131</font>
<br><font size=2 face="sans-serif">sco_disconn_ind: hcon 814c3d60 reason
19</font>
<br><font size=2 face="sans-serif">hci_conn_del: hci0 conn 814c3d60 handle
7</font>
<br><font size=2 face="sans-serif">l2cap_sock_shutdown: sock 80f71b38,
sk 80718980</font>
<br><font size=2 face="sans-serif">l2cap_sock_kill: sk 80718980 state 9</font>
<br><font size=2 face="sans-serif">l2cap_sock_destruct: sk 80718980</font>
<br><font size=2 face="sans-serif">bluez_sock_poll: sock 8070db18, sk 80718680</font>
<br><font size=2 face="sans-serif">bluez_sock_poll: sock 8070dcf8, sk 80718380</font>
<br><font size=2 face="sans-serif">*******************the end *************************************</font>
<br>
<br><font size=2 face="sans-serif">Why do you use the system call &quot;select()&quot;
to do it ? I always use it and have never encountered your problems.</font><br><br><br>
***********************************************<br>
信息安全声明：本邮件包含信息归ZTE所有，<br>
ZTE对该邮件拥有所有权利。请接收者注意<br>
保密，未经发件人书面许可，不得向任何第<br>
三方组织和个人透露本邮件所含信息的全部<br>
或部分。以上声明仅适用于工作邮件。<br>
Information&nbsp;Security&nbsp;&nbsp;Notice：<br>
The&nbsp;information&nbsp;contained&nbsp;in&nbsp;this&nbsp;mail&nbsp;is<br>
solely&nbsp;property&nbsp;of&nbsp;&nbsp;ZTE&nbsp;Corporation.&nbsp;<br>
This&nbsp;mail&nbsp;communication&nbsp;is&nbsp;confidential.<br>
Recipients&nbsp;named&nbsp;above&nbsp;are&nbsp;obligated&nbsp;to<br>
maintain&nbsp;secrecy&nbsp;and&nbsp;are&nbsp;not&nbsp;permitted&nbsp;to<br>
disclose&nbsp;the&nbsp;contents&nbsp;of&nbsp;this&nbsp;communication<br>
to&nbsp;others.<br>
***********************************************<br>

--=_alternative 0024A1C948256FF2_=--


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
