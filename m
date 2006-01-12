Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43C6DBA0.9050002@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] headset wont work <sdp?>
References: <43C581DE.6030205@cs.bgu.ac.il> <43C69CA3.1060606@cs.bgu.ac.il>
In-Reply-To: <43C69CA3.1060606@cs.bgu.ac.il>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 13 Jan 2006 00:43:44 +0200

sorry for postting so much, its just that I am putting an effort to 
resolve it by myself.
I am at the point of suspecting the headset aint pairing right:
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:02:72:E1:03:6A
 > ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0041 result 3 status 0
      Connection refused - security block
 > HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x13
    Reason: Remote User Terminated Connection

I deleted all content of /var/lib/bluetooth/<dongle addr
 >/  and I also turned auth and encrypt off in hcid.conf

when I reset /etc/init.d/bluetooth I see:
* Starting Bluetooth ...
 *     Starting hcid 
...                                                  [ !! ]
 *     Starting sdpd 
...                                                  [ ok ]
 *     Starting rfcomm 
...                                                [ ok ]

I have already uninstall and reinstall all bluez as well as 
bluetooth-alsa to the latest version
:-(
Niv


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
