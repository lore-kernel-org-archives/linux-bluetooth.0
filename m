Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Chris <usenet@chrissearle.org>
Message-ID: <lgpt7a931l.fsf@montgomery.empolis.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] sdptool - File descriptor in bad state
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
Date: Mon, 05 Jul 2004 12:11:34 +0200


Getting the following error when trying to use sdptool:

sdptool browse
Inquiring ...
Failed to connect to SDP server on <mybdaddr>: File descriptor in bad state

The mybdaddr is correctly the one for my T610.

hcitool can pick the phone up:

hcitool scan                  
Scanning ...
        <mybdaddr>       n/a

hcitool info <mybdaddr>
Requesting information ...
        BD Address:  <mybdaddr>
        Device Name: Chris Mobile
        LMP Version: 1.1 (0x1) LMP Subversion: 0x503
        Manufacturer: Ericsson Technology Licensing (0)
        Features: 0x04 0xca 0x31 0x00 0x00 0x00 0x00 0x00
                <encryption> <RSSI> <SCO link> <u-law log> <A-law log> <CVSD> 


Any idea what file descriptor is at fault here?

-- 
Chris



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
