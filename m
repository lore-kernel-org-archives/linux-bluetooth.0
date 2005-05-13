Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42847238.8020708@whitelabel.org>
From: Stefan Magdalinski <stefan@whitelabel.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Palm (clie) + bluetooth networking problem
References: <4280DFBD.9050507@whitelabel.org>
In-Reply-To: <4280DFBD.9050507@whitelabel.org>
Content-Type: multipart/mixed;
 boundary="------------010300060906000204020104"
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
Date: Fri, 13 May 2005 10:24:08 +0100

This is a multi-part message in MIME format.
--------------010300060906000204020104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stefan Magdalinski wrote:
> 
> Right, now I have my dialup working beautifully, the next stage is 
> getting my Palm connecting to the laptop so that hopefully I can sync 
> with evolution.
> 

I'm still getting absolutely nowhere with this. It just gets to 'signing 
on' on the palm, and then hangs.

weird thing is there's tons of traffic flowing, according to hcidump -X -V

I've attached some output in case it's useful.

many thanks for any clues

stef

> I've been following the instructions from
> 
> http://www.harbaum.org/till/palm/bluetooth/index.html
> 
> (from Marcel's bluetooth HOWTO list)
> 
> I can see the clie fine:
> 
> stefvaio:/etc/ppp# hcitool scan
> Scanning ...
>         08:00:46:EF:4B:F4       stefclie
>         00:12:62:DC:EA:63       Stefphone
> 
> I have successfully added the pc as a trusted device, sdpd is running, 
> and I've added the LAN service, as per the HOWTO
> 
> The clie networking all appears to be set up OK, but when I try and 
> connect,
> 
> it says 'initializing', then 'signing on', but then hangs there. at this 
> point, hcidump -X -V shows a continuous stream of ongoing traffic, but 
> the signing on never finishes.
> 
> /var/log/messages says
> 
> May 10 17:08:18 localhost pppd[16725]: pppd 2.4.2 started by root, uid 0
> May 10 17:08:18 localhost pppd[16725]: Using interface ppp0
> May 10 17:08:18 localhost pppd[16725]: Connect: ppp0 <--> /dev/rfcomm1
> 
> and then when I cancel the connection on the Clie
> 
> May 10 17:09:23 localhost pppd[16725]: LCP terminated by peer
> May 10 17:09:23 localhost pppd[16725]: Hangup (SIGHUP)
> May 10 17:09:23 localhost pppd[16725]: Modem hangup
> May 10 17:09:23 localhost pppd[16725]: Connection terminated.
> May 10 17:09:24 localhost pppd[16725]: Exit.
> 
> 
> I can't see an rfcommd running anywhere though, only a krfcommd, are 
> they the same thing?
> 
> ps aux |grep rfcommd
> root      8627  0.0  0.0      0     0 ?  S<   May09   0:00 [krfcommd]
> 
> Any other information I need to provide?
> 
> actually looking in more detail,
> 
> http://article.gmane.org/gmane.linux.bluez.user/5568/match=rfcommd
> 
> says that rfcommd is not used any more, but not what is, so I'm stuck.
> 
> stef
> 


-- 
/*
Stefan Magdalinski
+447769 666528 (telephone)
smagdali (IM/flickr.com/etc)
*/

--------------010300060906000204020104
Content-Type: application/x-gzip;
 name="palmdump.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="palmdump.txt.gz"

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
9tT/A5Qs+Ku/FgEA
--------------010300060906000204020104--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
