Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Eric Vaandering <ewv@fnal.gov>
To: bluez-users@lists.sourceforge.net
Message-id: <42962705.9010902@fnal.gov>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-users] Problem with dund and LG 325 phone.
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
Date: Thu, 26 May 2005 14:44:05 -0500

I have an LG PM-325 which I am trying to get DUN working with. It works under
Windows, but I want to use linux.

I think the two devices are paired since I can do l2ping and get responses,
but I still seem to be a few steps away from being able to do DUN.

When I type this, I expect to get a success message back, right? Instead I get 
nothing:

[root@a122077 root]# dund -c 08:00:37:13:A1:C7 -n
dund[5586]: Bluetooth DUN daemon
dund[5586]: Searching for LAP on 08:00:37:13:A1:C7
[root@a122077 root]#

I don't have to do anything with rfcomm before this, right? I also don't need 
to run pand, right, since my device only supports DUN.

When I try to do a pppd call command, I get this in syslog:
May 26 14:43:02 a122077 kernel: PPP generic driver version 2.4.2
May 26 14:43:02 a122077 pppd[5708]: pppd 2.4.3 started by root, uid 0
May 26 14:43:03 a122077 hcid[3602]: link_key_request (sba=00:10:60:AA:5C:CE, 
dba=08:00:37:13:A1:C7)
May 26 14:43:03 a122077 pppd[5708]: Failed to open /dev/rfcomm0: Connection 
refused
May 26 14:43:03 a122077 pppd[5708]: Exit.

which isn't surprising.


Thanks for any help you can give,

Eric




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
