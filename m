Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Sumeet VERMA <sumeet.verma@st.com>
To: <bluez-users@lists.sf.net>
Date: Mon, 6 Aug 2007 13:08:58 +0530
Message-ID: <006d01c7d7fc$df2c2090$0102a8c0@dlh.st.com>
MIME-Version: 1.0
Subject: [Bluez-users] A2dp on ARM9- Quality not good
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi 
I have cross compiled the bluez stack-3.11 and btsco-0.42 for ARM9 platform. The audio streaming is working using the a2play application but the voice quality is not good. There are lot of breaks. The same setup is working fine on the PC.

I think the problem is due to the MIPS available for SBC encoding. ARM9 is running at 133 MHz. 
Can you please suggest some optimizations which would help me improve the audio quality?

Thanks and Regards,
Sumeet 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
