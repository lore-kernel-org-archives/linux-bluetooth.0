Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4280B62A.8040005@whitelabel.org>
From: Stefan Magdalinski <stefan@whitelabel.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] connection problems with pppd and 6630 over bluez
References: <427B5DB5.3080304@whitelabel.org>	 <1115381691.8862.2.camel@pegasus>  <427B7021.5050302@whitelabel.org> <1115386676.8862.7.camel@pegasus>
In-Reply-To: <1115386676.8862.7.camel@pegasus>
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
Date: Tue, 10 May 2005 14:24:58 +0100

Marcel Holtmann wrote:
> Hi Stefan,
> 
> 
>>>>I have pppd working over bluetooth, but have a strange problem; I only 
>>>>seem to be able to connect about 1/3 of attempts. If I retry it usually 
>>>>works, but some times it takes 5 or 6 goes.
>>>>
>>>>how can I diagnose and fix the problem. I'm running bluez-2.16
>>>
>>>use "hcidump -X -V" as root to see what happens on the Bluetooth side.
>>>If that looks fine then use pppdump to see what PPP is doing.
>>
>>I've attached the results of a two attempts to connect, the first 
>>failed, and the second succeeded. What am I looking for?
> 
> 
> this is not a Bluetooth problem. This is your dialer script. In the
> failure case you start PPP without getting the CONNECT response. You
> even start PPP and three frames later your receive an OK. Use a dialer
> like wvdial or check you logs for more details.

thanks for the tip. I've switched to using the wvdial scripts from

http://julian.coccia.com/blog/index.php?m=200503&more=1

and now everything's working fine.

well almost fine; despite setting noauth in /etc/ppp/peers/gprs, it 
still wouldn't work without a dummy username and password in
gprs-wvdial.conf

My provider, Orange, doesn't need authentication, but doesn't seem to 
mind if you stick some random entries in the file to keep the script happy.

stef
-- 
/*
Stefan Magdalinski
+447769 666528 (telephone)
smagdali (IM/flickr.com/etc)
*/


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
