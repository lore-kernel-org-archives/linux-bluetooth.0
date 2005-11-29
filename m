Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <438BF5FF.9080402@core.kaist.ac.kr>
From: Youngwoo Park <ywpark@core.kaist.ac.kr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=EUC-KR
Subject: [Bluez-devel] simultaneous SDP connection
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
Date: Tue, 29 Nov 2005 15:32:31 +0900

Hi ~

It seems that spd_connection() is blocking operation now

If I change sdp_connection() as non-blocking function
Is it possible to connect several SDP servers at the same time?
If then, the total connection time is decreased?

I don't know whether the multiple connection(paging) is possible
physically or not..

Regards
Park


-- 
Youngwoo Park

M.S. Student
CORE(COmputer engineering REsearch) Lab
Dept. EECS, KAIST, Daejeon 305-701, Korea
Phone: +82-42-869-5425 Fax: +82-42-8695425
e-mail: ywpark@core.kaist.ac.kr

--




















-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
