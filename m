Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421AED37.7050703@hobbits.no>
From: "Vegard B. Havdal" <vegardh@hobbits.no>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Am stuck; HP laptop, Fedora
References: <4215A788.9070205@yahoo-inc.com> <1109027434.7626.28.camel@pegasus>
In-Reply-To: <1109027434.7626.28.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Tue, 22 Feb 2005 09:28:39 +0100


Marcel Holtmann wrote:
> from this report I can't tell you anything, but the Bluetooth device
> inside my NC4000 is working prefect and actually it is the same as in
> your laptop. What does "hciconfig -a" tells you?

It told me the device was down, whereafter I figured to try
hciconfig hci0 up whereafter everything worked, so that was the little 
drop of info I needed. Thanks!

Vegard :-)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
