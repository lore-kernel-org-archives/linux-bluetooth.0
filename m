Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: EricGandt@netscape.net (Eric Gandt)
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Message-ID: <0135FF90.5D970D71.0241D6B9@netscape.net>
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-devel] Setup of a Bluetooth mouse using software version 2.03
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
Date: Tue, 20 Jul 2004 21:26:17 -0400

I'm trying to setup my microsoft bluetooth mouse under Linux (SuSE 9.1 Pro) and have the base packages that come with SuSE installed these are:
bluez-bluefw: 1.0-202
bluez-libs: 2.5.43
bluez-pan: 1.1-109
bluez-sdp: 1.5-59
bluez-utils: 2.4.65

With the given software installed and running I can find the mouse id: 00:50:F2:7F:XX:XX without issue, but can not discover any way to connect the device to a serial port so that I may use the mouse.  All of the information I can find on setting up a mouse requires the use of bthid or hcidd I have neither of these as they appear to be part of version 2.08, however my attempts to install 2.08, after removing all old SuSE 9.1 BT related software frist, results in my being unable to install bluez-util as it can not find a few needed links in the lbluebooth libary, however I also can not build bluez-util againist the version 2.5 that comes with SuSE so I'm out of luck with that as well.  Thus I want to use what I have and configure my mouse can it be done?  Has anyone actaully got it to work.

Thanks,
-- 
Eric Gandt


__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
