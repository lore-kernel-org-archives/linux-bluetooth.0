Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <430E9192.1010609@core.kaist.ac.kr>
From: Youngwoo Park <ywpark@core.kaist.ac.kr>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Re: Re: Bluetooth SCO message sending	(sco_send_frame)
Content-Type: text/plain; charset=EUC-KR
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
Date: Fri, 26 Aug 2005 12:50:42 +0900



I used the "btsco" program.
Do you think that "btsco' program is changed to solve my problem?

I think btsco program read data from bluetooth h4 device, and just write
data to bluetooth.
Also, Application has no information about socket and MTU size.
Is it hard to handling data fragmentation in application program?

I think framgmentation is handled by kernel if we need.
Otherwise h4 device driver must guarantee that data frame size is
smaller than MTU.


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
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
