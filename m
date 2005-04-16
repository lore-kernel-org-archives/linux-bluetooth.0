Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <313624802.29794@eyou.net>
From: "Jin Pu" <jpu@emails.bjpu.edu.cn>
To: "bluez-users@lists.sourceforge.ne" <bluez-users@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
      charset="GB2312"
Subject: [Bluez-users] inquiry,connect and connect timeout
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
Date: Sat, 16 Apr 2005 12:9:34 +0800

hello,
   
    I'm programming with BlueZ,but now there are three questions.
    1.How to inquiry with CoD?
      I use  hci_inquiry(...) to achieve the inquiry procedure ,and now I want to filter the inquiry responses with CoD directly,instead of by the return value of inquiry_info. 
    2.How to connect with clock offset?
      I use the RFCOMM socket to connect the remote device,and I have gotten the remote clock offset through the previous inquiry procedure.I want to accelerate the connect procedure, but I don't know  where I should cache the clock offset so that the later connect procedure will use it automatically . In a word, I would like to know the correct methods to accelerate the connect procedure.
   3. timeout of the connect procedure.
      I want to make it clear What the default value of timeout is, when I use  the connect(...) of RFCOMM socket to setup connection with the remote device.What's more , I want to know whether I could modify the value of timeout and how.
      
      Thanks in advance.
      Jin Pu

















	






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
