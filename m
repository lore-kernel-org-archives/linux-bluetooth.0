Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <432850B5.1050302@comcast.net>
From: Noel Paz <noelpaz@comcast.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Best way to communicate with hidden devices
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
Date: Wed, 14 Sep 2005 10:32:53 -0600

I have a BT weight scale and I want to communicate to it. Problem is I 
think it is set to be un discoverable.  According to it's scant 
documentation it uses the BT serial protocol and a 128 bit encyrption 
and a PIN. - that it expects to start communication.  Supposedly, after 
it weighs something,  it tries to find an ACCESS point, see if the 
Access Point has the same PIN and if it does it transmits data packets 
which are very discrete

hcitool --scan and sdptool --browse cannot find it (yes I have made sure 
it can find other devices). I've turned hcidump too too make sure I can 
sniff it but to no avail

Honestly, I am new to BlueZ and have been devouring as much 
documentation as I can. My thoughts are setting up a PAN with an access 
point role using rfcomm. If anybody has worked on one way traffic 
bluetooth devices, let me know. I really have no way of knowing whether 
this weight scale  has a broken radio, although I can experiment with 
making my other devices undiscoverable with a PIN. Unfortunately their 
support is for Windoze only and require you to buy a container full of 
weight scales before their engineers will talk to you.

BTW there is a little sticker which seems to be the bdaddr.


Thanks

Noel


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
