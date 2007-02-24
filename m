Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <45DFE21E.7060000@blueyonder.co.uk>
Date: Sat, 24 Feb 2007 06:58:38 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <mailman.90030.1172233194.20110.bluez-users@lists.sourceforge.net>
In-Reply-To: <mailman.90030.1172233194.20110.bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez-users Digest, Vol 10, Issue 28
Reply-To: sboyce@blueyonder.co.uk,
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

bluez-users-request@lists.sourceforge.net wrote:


> 
> Message: 4
> Date: Fri, 23 Feb 2007 10:07:04 +0100
> From: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
> Subject: [Bluez-users] RE :  RE : modprobe snd-bt-sco
> To: "Asma Tebessi" <asma.tebessi@telnet.com.tn>
> Cc: bluez-users@lists.sourceforge.net
> Message-ID:
> 	<7FEBB30F0CE41B419B38295024A58EE3A10D48@oxygen.mail.telnet.tunis>
> Content-Type: text/plain; charset="iso-8859-1"
> 
> Hi all, 
> 
> I still have the same problem, I cannot modprobe snd-bt-sco. Here what I've got when compiling the btsco-0.5 :
> 
> 
> [root@ws12 btsco-0.5]# cd kernel/
> 
> [root@ws12 kernel]# make
> make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
>   Building modules, stage 2.
>   MODPOST
> *** Warning: "snd_hidden_kmalloc" [/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
> *** Warning: "snd_verbose_printk" [/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
> *** Warning: "snd_hidden_kfree" [/root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko] undefined!
> make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'
> 
2.6.12 is a very old kernel and from the above, btsco-0.5 is not 
compatible that kernel. The modules builds and installs, but can't be 
used. Either an updated kernel or an old version of btsco is needed. 
btsco-0.5 e.g gives similar errors on kernels 2.6.18 (I think), the cvs 
will work up to 2.6.19, but is no good at >=2.6.20.

> [root@ws12 kernel]# make install
> make[1]: Entering directory `/usr/src/linux-2.6.12-12mdk'
>   INSTALL /root/confhandsfree/btsco-0.5/kernel/snd-bt-sco.ko
> make[1]: Leaving directory `/usr/src/linux-2.6.12-12mdk'
> 

Installs fine, but is no good as those symbols are not part of the 
kernel at 2.6.12.
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Emeritus IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
