Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43CC4968.6070003@cs.bgu.ac.il>
From: Niv <nivv@cs.bgu.ac.il>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Can't find device
References: <43CBB6AE.4020007@cs.bgu.ac.il>
In-Reply-To: <43CBB6AE.4020007@cs.bgu.ac.il>
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
Date: Tue, 17 Jan 2006 03:33:28 +0200

OK I am certain now. bluetooth-alsa cant work when using alsa-driver. 
Even when SND_HWDEP is included.


I cant use BT-alsa when I compile alsa as modules in the kernel.

I dont understand the difference.

Is it to do with new alsa-driver ?


Niv






Niv wrote:

> Problem:  $ btsco -v 00:0D:44:33:E1:63
> btsco v0.41
> Error: control open (hw:4): No such device
> Error: Can't find device. Bail
>
>
> diagnoz:
>
> Worked fine yesterday. I switched to alsa modules aka alsa-driver.
>
> snd-bt-sco modprobe loads fine
>
> I even compiled the emu10k1, which has a function that is used.
>
>
> $ cat /proc/asound/cards
> 0 [V8237          ]: VIA8237 - VIA 8237
>                      VIA 8237 with CMI9761 at 0xe800, irq 10
> 1 [Bt878          ]: Bt87x - Brooktree Bt878
>                      Brooktree Bt878 at 0xe8101000, irq 11
> 2 [Audio          ]: USB-Audio - USB Audio
>                      C-Media INC. USB Audio at usb-0000:00:10.3-2, 
> full speed
> 3 [Headset        ]: Bluetooth SCO - BT Headset
>                      BT Headset 1
>
>
>
> l2ping 00:0D:44:33:E1:63
> Ping: 00:0D:44:33:E1:63 from 00:10:60:A8:86:A3 (data size 44) ...
> 44 bytes from 00:0D:44:33:E1:63 id 0 time 42.46ms
> 44 bytes from 00:0D:44:33:E1:63 id 1 time 41.56ms
> 44 bytes from 00:0D:44:33:E1:63 id 2 time 34.55ms
> 44 bytes from 00:0D:44:33:E1:63 id 3 time 50.53ms
> 44 bytes from 00:0D:44:33:E1:63 id 4 time 49.51ms
> 5 sent, 5 received, 0% loss
>
>
> Niv
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log 
> files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
