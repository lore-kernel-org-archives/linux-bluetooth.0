Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Andreas Gaufer <Andreas.Gaufer@blue-cell-networks.com>
To: Bluez Devel <bluez-devel@lists.sourceforge.net>
Message-Id: <20040628215642.516c0ff6.Andreas.Gaufer@blue-cell-networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Link interrupted/destroyed by CC on other hci device
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 28 Jun 2004 21:56:42 +0200

Hi,

I noticed that running OBEX Transfers on one hci device are interrupted
(L2CAP link is destroyed) by a CC that is issued on a different hci dev.


As far as i can see it only happens on T6xx Phones from SE but this is
not for sure now. Im will start digging on this phenomina now. 

I would greatly appreciate hints or thoughts why this could happen. 

Greetings

Andreas Gaufer

-- 
Blue Cell Networks GmbH
Industriestraﬂe 1b
96163 Gundelsheim

Tel.: 0951-700 42 891 | Fax.: 0951-700 42 887 


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
