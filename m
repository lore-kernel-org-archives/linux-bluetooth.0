Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <20041027124534.8266.qmail@web40622.mail.yahoo.com>
From: Paolino paperino <vonzoltan@yahoo.it>
Subject: Re: [Bluez-devel] err corridge in sdp.c
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <F162D20C428AB34E9E4491C6CF5F8B9A02A1813B@posthoorn.intra.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Wed, 27 Oct 2004 14:45:34 +0200 (CEST)

Hi,
 there is an inconsosistence in the doc comments of
the function sdp_service_search_req between sdp.c and
sdp.h (bluez_libs_2.8 and 2.9). With more precison, in
sdp.c are documented a parameter (lenght of response
list) that the function prototipe doesn't define...i
think
Regards
 Andrea S.



		
___________________________________ 
Nuovo Yahoo! Messenger: E' molto più divertente: Audibles, Avatar, Webcam, Giochi, Rubrica… Scaricalo ora! 
http://it.messenger.yahoo.it


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
