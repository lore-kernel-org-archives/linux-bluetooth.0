Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Cloudshang" <zhixiang_deng@yahoo.com.cn>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Message-ID: <E1Cf95k-0000r1-SE@sc8-sf-mx1.sourceforge.net>
Subject: [Bluez-users] PAN pboblems
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 17 Dec 2004 11:38:2 +0800

 Hello,
    I have several questions.
    First ,a bluetooth device was expected to act as GN with the command "pand  --listen --role GN".But the GN could be connected by only two PANUs.The third PANU cannot conect to the GN any more. Why? And how to set the maximal user numbers of a GN?
    Second ,I used some bluetooth devices to form a simple adhoc network based on BNEP protocol, which can be shown as the following figure:
     PANU1--->GN<---PANU2
    When GN was only conncted by PANU1,the data transmitting rate could reach about 50kbps.However ,when the GN is connected by both PANU1 and PANU2 ,the data rate reduced to about 8kbps.Why? What can I do to solve this problem?
    Thanks a lot!
                                                  													Cloudshang
					




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
