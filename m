Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Mark RISON" <mrison@hotmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY8-F97aHyJBu3pQBo0002a6ce@hotmail.com>
Subject: [Bluez-users] PAN and security mode 3
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 30 Jan 2004 19:41:01 +0000

I wish to access files on laptop A from laptop B, using PAN.  I am
security-paranoid, however, so I want to make sure no-one else will be
able to access my precious files or snoop on my precious files as I
access them.

So what I want is for security mode 3 with authentication, encryption
and authorisation (although I might be prepared to consider security
mode 2 to allow SDP (only) to be accessible without security).

I've tried to RTFM, but I can't find any FM to R.  There seems to be
nothing (manpages, howtos, whatever) about the hcid.conf file, or
about the BlueZ security model.

Here are my questions, then.  If any of them are in a FM I've missed,
then I'd be happy just to be pointed at it.

- If in the "device" part of hcid.conf I put "auth enable" and
"encrypt enable", does this enforce security mode 3 for all (incoming
and outgoing) connections, or do I need to make sure appropriate
settings are specified in other files/utilities (and if so, which?)?

- If I only start the PAN daemon, does this guarantee that no other
profiles will be running (i.e. only PAN will allow access to the
laptop)?

- Can "auth enable" and "encrypt enable" in hcid.conf be overwritten
by command-line utility/daemon arguments, or is this a bullet-proof
way to enfore security mode 3 irrespective of "user error"?

- How does authorisation work in BlueZ?  Ideally I'd like to be able
to specify a list of BD_ADDRs to (exclusively) authorise for PAN, but
if it's necessary for all connection requests to be manually
authorised, that's better than nothing.

- /etc/bluetooth/link_keys appears to be where link keys resulting
from pairing are stored.  Is this correct, and if so, what is the
format, and will deleting this file remove all pairing information (or
do I need to delete something else somewhere else?)?

- Is there anything else I need to know about secure use of PAN/BlueZ?

Thanks in advance!

Mark

--
CPC/IP - A TCP/IP stack for Amstrad CPCs
-- http://www.nenie.org/cpcip/
"Z88 vs CPC? Christ. How did we miss that platform war?"
-- http://www.ntk.net/index.cgi?back=archive00/now0128.txt&line=110#l

_________________________________________________________________
There are now three new levels of MSN Hotmail Extra Storage!  Learn more. 
http://join.msn.com/?pgmarket=en-us&page=hotmail/es2&ST=1



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
