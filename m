Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40C0C5FC.1070504@libero.it>
From: Paolo Arcagni <paolo.arcagni@libero.it>
MIME-Version: 1.0
To: axs203dd@excite.com
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Linux audio gateway and headset feature
References: <20040604172724.1BFDC394E@xprdmailfe9.nwk.excite.com>
In-Reply-To: <20040604172724.1BFDC394E@xprdmailfe9.nwk.excite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 04 Jun 2004 20:57:00 +0200

Thanks for your help:

now I can start hsmicro on channel 12 or 13 and the phone sees an 
headset connected, but on the linux console I get the error message

---
./hsmicro  00:02:EE:0D:47:5F 12
Voice setting: 0x0060
RFCOMM channel connected
Can't connect SCO audio channel: Connection refused
---

any idea on that ?

Thanks again


mr wrote:
> Hi,
> 
> 
>>The question is: which is the right procedure to use the laptop 
>>multimedia subsystem as an headset for the phone ? On windows2000 this 
>>kind of setup worked fine....
> 
> 
>>I can obtain a connection with the command
> 
> 
>>rfcomm conn 0 xx:xx:xx:xx:xx:xx 12
> 
> 
> The command 'rfcomm con...' does not transfer any audio signal itself, so do not use it at all yet. From the laptop side you need to do:
> 
> # hsmicro xx:xx:xx:xx:xx:xx 12
>   or
> # hsmicro xx:xx:xx:xx:xx:xx 13
> 
> where xx:xx:xx:xx:xx:xx is the address of nokia. Then try to make a phonecall and you should be able to listen from the laptop speakers. I have try this and worked fine. I haven;t tried to send audio from the pc's microphone to the mobile yet, however I am quite convinced that this is a one-way audio transmission.
> 
> _______________________________________________
> Join Excite! - http://www.excite.com
> The most personalized portal on the Web!
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by the new InstallShield X.
>>>From Windows to Linux, servers to mobile, InstallShield X is the one
> installation-authoring solution that does it all. Learn more and
> evaluate today! http://www.installshield.com/Dev2Dev/0504
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
