Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <422F4208.8070706@ul.ie>
From: Joe Sloan <joe.sloan@ul.ie>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Is there authenticate only incoming mode
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
Date: Wed, 09 Mar 2005 18:35:52 +0000

Hi,

Is it possible to configure hcid so that authentication (i.e. PIN 
challenge) is only invoked on incoming connections. I'd like to make a 
PIN request only if some other device tries to use my PC (e.g. object 
push) but it is not required if I want to send to them (and my PC 
initiates the connection). I'm not too bothered about encryption at this 
stage..

I've searched the newslist and tried configuring hcid.conf but haven't 
been able to get it working. Guess it is not intended to  work that way.

Joe




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
