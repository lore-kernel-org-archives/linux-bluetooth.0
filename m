Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Steffen Schwientek <schwientek@web.de>
Message-ID: <1r2er1-pr7.ln1@ID-90813.users.dfncis.de>
References: <amsbr1-glo.ln1@ID-90813.users.dfncis.de> <20040701094518.GB4505@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] Re: headset$
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
Date: Thu, 01 Jul 2004 20:47:27 +0200

Nicholas A. Preyss schrieb:

> On  0, Steffen Schwientek <schwientek@web.de> wrote:
>> I want to use my plantronics M9000 headset. Since it?s my only bluetooth
>> part, I can?t figure out, if bluetooth works. Connecting the USB dongle,
>> the kernel (2.6.6) reports:
> 
> Better use 2.6.7 or apply the latest -mh patch to 2.6.6.

OK, I have upgraded to 2.6.7 now. Now I´m ask for a pin. Here is the output
of /car/log/syslog:

Jul  1 20:07:29 schwientek hcid[8586]: pin_code_request
(sba=85:0F:41:72:02:00, dba=0F:E2:46:89:03:00)
Jul  1 20:07:36 schwientek hcid[8586]: link_key_notify
(sba=85:0F:41:72:02:00)
Jul  1 20:07:36 schwientek hcid[8586]: Saving link key 00:02:72:41:0F:85
00:03:89:46:E2:0F

Fine. But how can I use the headset? kbluetoothd also shows the the
headset-profile and an unknown profile. 
> 
> Did you pair Headset and Computer? Normally you have to switch the
> headset in pairing mode (-> Manual) and then insert the pin on the
> computer. (you can also specifiy pin in a file?) This should happen
> transparently, when  a program tries to connect to a remote device 

Hmm, how can I tell kphone  to connect and use the remote device? I think,
kphone needs an an sounddriver for this task.But there is no sound-driver
in the 

Steffen




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
