Return-Path: <cyrus@holtmann.org>
Message-ID: <48268568.9080704@jlab.org>
Date: Sun, 11 May 2008 01:34:32 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <48171A58.8060200@powercraft.nl>	<482356E2.3050909@jlab.org>	<482413B0.4010900@powercraft.nl>	<48244A74.7080307@powercraft.nl>
	<482566B0.9020708@powercraft.nl>
In-Reply-To: <482566B0.9020708@powercraft.nl>
Subject: Re: [Bluez-users] step by step - how to get your bluetooth stereo
 headset fully working with the bluez software stack under linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Firstly, on a whim I picked up a new USB bluetooth dongle.

This one is an iogear class 2 bluetooth version 2.0 (EDR) model, while 
the previous one was class 1 version 1.2 and made by Linksys. Audio is 
much improved in that I can move my bluetooth mouse all I want without a 
single skip, but as soon as I touch the keyboard it still skips terribly.

I can see now that the headphones (again, the S805s) are bluetooth 2.0 
with EDR, which I assume is what makes them work better, but both 
keyboard and mouse are version 1.2. I wonder if everything would work if 
it was all 2.0.

Is there any way to adjust sbcbitpool for lower bandwidth? Such an 
option existed for the experimental alsa bluetooth stuff.


Jelle de Jong wrote:
> I bought an other new bt-2400p bluetooth adapter for testing, with 
> this adapter i cant get my devices manually in master mode:
>
> sudo hcitool con
> Connections:
>     < ACL 00:0D:FD:18:6E:3C handle 12 state 1 lm SLAVE ENCRYPT
>
> sudo hcitool sr 00:0D:FD:18:6E:3C master
> Switch role request failed: Input/output error

I learned the hard way that roles can only be switched with encryption off.
Try:
sudo hcitool enc 00:0D:FD:18:6E:3C off
sudo hcitool sr 00:0D:FD:18:6E:3C master

But more importantly, I used to have to manually set things to master 
until I cleaned up my hcid.conf file, adding the correct lp and lm 
lines. I believe you have already corrected yours but you might want to 
double check them again since this gave me automatic master. Here are 
all of the uncommented lines from my file:

options {
        autoinit yes;
        security user;
        pairing multi;
}

device {
        name "BlueZ (%d)";
        class 0x000100;
        iscan enable; pscan enable;
        lm accept,master;
        lp hold,sniff,park;
}



-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
