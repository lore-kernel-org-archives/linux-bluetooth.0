Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 21:46:12 +0800 (CST)
From: KS H <kspam1234@yahoo.com.hk>
To: Bluez <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <341704.68311.qm@web53305.mail.yahoo.com>
Subject: [Bluez-users] pin code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0218206894=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0218206894==
Content-Type: multipart/alternative; boundary="0-1054544052-1169559972=:68311"
Content-Transfer-Encoding: 8bit

--0-1054544052-1169559972=:68311
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Dear

I cross compile the bluez3.8 and try to setup the bluetooth in arm. I connect the arm with CSR BC03 with BCSP configuration. I am able to make the Bluez discoverable and try to pair bluez. however i found that there is no pin respond from Bluez. So i try to configure bluez using hcid.

> hcid -n -f /etc/bluetooth/hcid.conf

it return

hcid[481]: Can't connect to system message bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:  No such file or directory
hcid[481]: Unable to get on D-Bus

My question
1. where can I found the missing file and what is that used for?
2. Is there any method to repsond the pin request other than using hcid

Regards
SH

 _______________________________________
 YM - 離線訊息
 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。
 http://messenger.yahoo.com.hk
--0-1054544052-1169559972=:68311
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

Dear<br><br>I cross compile the bluez3.8 and try to setup the bluetooth in arm. I connect the arm with CSR BC03 with BCSP configuration. I am able to make the Bluez discoverable and try to pair bluez. however i found that there is no pin respond from Bluez. So i try to configure bluez using hcid.<br><br>&gt; hcid -n -f /etc/bluetooth/hcid.conf<br><br>it return<br><br>hcid[481]: Can't connect to system message bus: Failed to connect to socket /usr/local/var/run/dbus/system_bus_socket:&nbsp; No such file or directory<br>hcid[481]: Unable to get on D-Bus<br><br>My question<br>1. where can I found the missing file and what is that used for?<br>2. Is there any method to repsond the pin request other than using hcid<br><br>Regards<br>SH<br><p>&#32;_______________________________________<br> YM - 離線訊息<br> 就算你沒有上網，你的朋友仍可以留下訊息給你，當你上網時就能立即看到，任何說話都冇走失。<br> http://messenger.yahoo.com.hk
--0-1054544052-1169559972=:68311--


--===============0218206894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0218206894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0218206894==--
