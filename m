Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 29 Nov 2006 20:42:16 +0800
From: amateur <ztl.post@gmail.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061129124216.GC3364@163.com>
References: <12311.89646.qm@web30509.mail.mud.yahoo.com>
MIME-Version: 1.0
In-Reply-To: <12311.89646.qm@web30509.mail.mud.yahoo.com>
Subject: Re: [Bluez-users] USB dongle failed to pair with headset
Reply-To: amateur <ztl.post@gmail.com>,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

On Wed, Nov 29, 2006 at 01:39:46AM -0800, gary ng wrote:
> Hi,
> 
> I just got a no name dongle(CSR chipset) which I
> failed to pair with my headset. I have no problem
> pairing the headset with my t68i and I have no problem
> pairing with the t68i using the dongle.

Sometime ago, I have the same problem with my headset and usb
bluetooth dongle. I solved that by force Security Mode 3 on my usb
dongle which can be reached by using 
	hciconfig hci0 auth
	hciconfig hci0 encrypt
maybe you can try it. Or you can give the result of
	hcidump -x -V
when you do 
	hcitool cc ...
this list has lots of expert here.

> 
> I can see the headset but "hcitool info" or "hcitool
> cc" would both fail.
> 
> Does the dongle(i.e. firmware on it) play a role in
> whether it can pair with a headset ?
> 
> When issuing "hciconfig -a", I don't see the Audio
> service class which I have no idea if it matters or
> not.
> 


-- 
You will soon meet a person who will play an important role in your life.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
