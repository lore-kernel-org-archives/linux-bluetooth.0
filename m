Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Mathieu Doidy <mdoidy@roulaize.net>
Message-ID: <c8n1bg$gc5$1@sea.gmane.org>
Subject: [Bluez-users] Service Record registration failing and sdpd exiting
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
Date: Sat, 22 May 2004 08:00:48 +0000 (UTC)

Hi,

I have a problem with service registration with sdptool
When I do a "sdptool add --channel=10 OPUSH", the sdpd -n I had started
exits with the following error message :
sdpd: relocation error: sdpd: undefined symbol: sdp_print_service_attr

and the sdptool fails with this error :
Service Record registration failed

Any help would be appreciated

Here is my configuration :
bluetooth equipment : 
   USB dongle D-Link DBT-120 rev B4 and a Nokia 6230
bluez : 
   bluez-hcidump 1.8 
   bluez-libs 2.6 
   bluez-pan 1.1 
   bluez-sdp 1.5 
   bluez-utils 2.6 
kernel :
   2.6.6-mh1

Thanks in advance,

  Mathieu



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
