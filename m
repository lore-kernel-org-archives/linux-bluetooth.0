Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 8 Dec 2006 16:45:08 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users <bluez-users@lists.sourceforge.net>
Message-ID: <20061208084508.GA3317@163.com>
MIME-Version: 1.0
Cc: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-users] How to setup a reliable RFCOMM connection
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
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
List-ID: <bluez-devel.lists.sourceforge.net>

How to setup a reliable RFCOMM connection, that is, a connection with
infinite flush timeout. I find the RFCOMM_LM_RELIABLE option in the
example program l2test.c. It compiles, but at runtime setsockopt with
RFCOMM_LM give me an error. I'm using kernel-2.4.21 patched by
patch-2.4.21-mh10. So what's the problem. Doesn't kernel-2.4.21-mh10
support RFCOMM_LM? If so, how can I setup a reliable RFCOMM connection?

-- 
AWAKE! FEAR! FIRE! FOES! AWAKE!
	FEAR! FIRE! FOES!
		AWAKE! AWAKE!
		-- J. R. R. Tolkien

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
