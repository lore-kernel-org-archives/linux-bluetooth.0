Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <34A116F6-E7C6-11D8-B421-000A959E26AE@ermy.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: bluez-devel@lists.sourceforge.net
From: Mark Thompson <lists@ermy.net>
Subject: [Bluez-devel] L2CAP_CONN_TIMEOUT without recompiling kernel?
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
Date: Fri, 6 Aug 2004 17:32:27 +0100

Hi,

	Is there any way to change (specifically - drastically shorten) the 
amount of time a call to connect() blocks for whilst attempting to 
connect to a remote device?

Hunting through the source, I've traced the delay back to 
${KERNELSRC}/net/bluetooth/l2cap.c, specifically L2CAP_CONN_TIMEOUT, 
which is defined as being 40 seconds in 
/usr/include/bluetooth/bluetooth.h.

Ideally I'd like a sockopt available to tune that parameter on a 
per-app basis.  The application we're developing seeks to determine the 
presence of a 'bunch' of devices by trying to connect and then sending 
an L2CAP echo request packet before waiting for a valid response.

Moving to non-blocking connect() calls really isn't an option - the 
problem isn't detecting multiple devices, it's the amount of time it 
takes to ascertain whether a known device is present or not.

If I'm barking in the wrong forest, please feel free to boot me 
elsewhere :-)


I'm using gentoo 2004.0 with linux-2.6.3-gentoo-r1 on x86.

Thanks in advance,

--
Mark Thompson/



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
